#!/bin/bash
set -euo pipefail

if (( $# > 2 )); then
  printf '%s\n' '{"error":"Usage: find-guidance.sh [query] [limit]"}'
  exit 1
fi

skill_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
output_file="$(mktemp)"
trap 'rm -f -- "$output_file"' EXIT
echo "Searching packaged article guidance..." >&2

if python3 - "$skill_dir" "${1-}" "${2-5}" > "$output_file" <<'PY'
import json
from pathlib import Path
import re
import sys

try:
    root = Path(sys.argv[1])
    query = sys.argv[2].strip()
    limit = int(sys.argv[3])
    if not 1 <= limit <= 100:
        raise ValueError("limit must be between 1 and 100")
    manifest = json.loads((root / "references/sources.json").read_text())
    sources = manifest["sources"]
    if not query:
        topics = sorted({source["topic"] for source in sources})
        print(json.dumps({"source_count": len(sources), "topics": topics}, indent=2))
        sys.exit(0)
    terms = list(dict.fromkeys(re.findall(r"[\w-]+", query.casefold())))
    if not terms:
        raise ValueError("query must contain a word or source ID")
    matches = []
    documents = {}
    for source in sources:
        reference = source["reference"]
        if reference not in documents:
            documents[reference] = (root / reference).read_text()
        document = documents[reference]
        marker = "## " + source["id"] + " — "
        section = document.split(marker, 1)[1].split("\n## ", 1)[0].strip()
        searchable = (source["topic"] + " " + source["id"] + " " + section).casefold()
        score = sum(
            1 for term in terms
            if re.search(r"(?<!\w)" + re.escape(term) + r"(?!\w)", searchable)
        )
        if score < (len(terms) + 1) // 2:
            continue
        score += 5 if query.casefold() == source["id"].casefold() else 0
        title_match = re.search(
            r"(?<!\w)" + re.escape(query.casefold()) + r"(?!\w)",
            source["title"].casefold(),
        )
        score += 2 if title_match else 0
        matches.append((score, {
            "id": source["id"],
            "title": source["title"],
            "url": source["url"],
            "reference": reference,
            "guidance": "## " + source["id"] + " — " + section,
        }))
    matches.sort(key=lambda item: (-item[0], item[1]["id"]))
    print(json.dumps({
        "query": query,
        "total_matches": len(matches),
        "results": [result for score, result in matches[:limit]],
    }, indent=2, ensure_ascii=False))
except (OSError, ValueError, KeyError, IndexError) as error:
    print(json.dumps({"error": str(error)}))
    sys.exit(1)
PY
then
  cat -- "$output_file"
else
  status=$?
  cat -- "$output_file"
  exit "$status"
fi
