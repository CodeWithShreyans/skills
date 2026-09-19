#!/bin/bash
set -euo pipefail

if (( $# > 1 )); then
  printf '%s\n' '{"error":"Usage: audit-feed.sh [rss-file]"}'
  exit 1
fi

skill_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
temp_dir="$(mktemp -d)"
trap 'rm -rf -- "$temp_dir"' EXIT

if (( $# == 1 )); then
  feed_file="$1"
  echo "Auditing the supplied RSS snapshot..." >&2
else
  feed_file="$temp_dir/rss.xml"
  echo "Fetching Josh W. Comeau's RSS feed..." >&2
  if ! curl --fail --silent --show-error --location --proto '=https' \
    --proto-redir '=https' --connect-timeout 15 --max-time 60 \
    --max-filesize 5242880 'https://www.joshwcomeau.com/rss.xml' -o "$feed_file"; then
    printf '%s\n' '{"status":"error","error":"RSS fetch failed; coverage was not checked"}'
    exit 1
  fi
fi

if python3 - "$skill_dir/references/sources.json" "$feed_file" > "$temp_dir/result.json" <<'PY'
from collections import Counter
from datetime import datetime, timezone
import json
from pathlib import Path
import sys
import xml.etree.ElementTree as ET

try:
    manifest = json.loads(Path(sys.argv[1]).read_text())
    raw = Path(sys.argv[2]).read_bytes()
    if len(raw) > 5242880:
        raise ValueError("RSS exceeds the 5 MiB audit limit")
    root = ET.fromstring(raw)
    items = root.findall("./channel/item") if root.tag == "rss" else []
    if not items:
        raise ValueError("Expected a nonempty RSS channel with item entries")
    entries = []
    for item in items:
        title = (item.findtext("title") or "").strip()
        url = (item.findtext("link") or "").strip()
        published = (item.findtext("pubDate") or "").strip()
        if not title or not url.startswith(("https://", "http://")):
            raise ValueError("Every RSS item must have a title and absolute HTTP(S) link")
        entries.append({"title": title, "url": url, "published": published})
    counts = Counter(entry["url"] for entry in entries)
    duplicates = sorted(url for url, count in counts.items() if count > 1)
    known = {source["url"]: source for source in manifest["sources"]}
    current = {entry["url"]: entry for entry in entries}
    added = [current[url] for url in sorted(current.keys() - known.keys())]
    removed = [known[url]["id"] for url in sorted(known.keys() - current.keys())]
    changed = []
    for url in sorted(known.keys() & current.keys()):
        fields = [field for field in ("title", "published") if known[url][field] != current[url][field]]
        if fields:
            changed.append({"id": known[url]["id"], "url": url, "fields": fields})
    drift = bool(added or removed or changed or duplicates)
    result = {
        "status": "drift" if drift else "in-sync",
        "audited_at": datetime.now(timezone.utc).isoformat(),
        "snapshot_date": manifest["retrieved_on"],
        "snapshot_count": len(known),
        "feed_count": len(entries),
        "added": added,
        "removed": removed,
        "changed": changed,
        "duplicates": duplicates,
        "limitation": "Compares feed membership, titles, and publication dates only; article bodies, package releases, and API documentation are not rechecked.",
    }
    print(json.dumps(result, indent=2, ensure_ascii=False))
    sys.exit(2 if drift else 0)
except (OSError, ValueError, KeyError, ET.ParseError) as error:
    print(json.dumps({"status": "error", "error": str(error)}))
    sys.exit(1)
PY
then
  cat -- "$temp_dir/result.json"
else
  status=$?
  cat -- "$temp_dir/result.json"
  exit "$status"
fi
