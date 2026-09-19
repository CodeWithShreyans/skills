# Tooling: preserve the local workflow

Inspect repository scripts, lockfiles, framework versions, content trust boundaries,
and existing organization before introducing tools. Extract the useful architecture
from a historical stack description; do not recreate that stack by default.

Additional safeguards: treat MDX as executable trusted content, validate identifiers
before filesystem access, keep live playground code isolated from application
credentials, and obtain authorization before exposing a local service publicly.

## S021 — How I Built My Blog (newer rebuild)

Source: https://www.joshwcomeau.com/blog/how-i-built-my-blog-v2/

**Use:** Separate authoring, static code highlighting, interactive playgrounds,
widgets, and dynamic data. Perform deterministic processing during the build where
possible; use runtime interactivity where it benefits the reader.

**Watch:** This is an account of a highly customized product, not a recommended
starter template. Styling integration costs, router changes, and animation-library
preferences reflect that project's history. Cross-component visual cohesion needs
an intentional API, not arbitrary deep overrides.

**Check:** Content compilation, shipped JavaScript, snippet/playground loading,
accessible responsive widgets, and whether the chosen integration is maintained
for the installed toolchain.

## S037 — A World-Class Code Playground with Sandpack

Source: https://www.joshwcomeau.com/react/next-level-playground/

**Use:** Start with a template and files; move to provider/editor/preview primitives
and hooks only when custom layout or controls need them. Choose a lightweight static
preview for examples that do not require a module bundler. In an App Router app,
isolate interactive Sandpack components behind a client boundary rather than
making the entire article a Client Component.

**Watch:** Executed playground code belongs behind a security boundary. Self-hosting
must not accidentally place arbitrary code on the main application's credentialed
origin. The bundler, editor, and preview are distinct pieces.

**Check:** Network/CSP restrictions, keyboard access, iframe isolation, reset behavior,
multiple playgrounds, and mobile editing without making the whole article depend
on the playground loading.

## S041 — My Wonderful HTML Email Workflow

Source: https://www.joshwcomeau.com/react/wonderful-emails-with-mjml-and-mdx/

**Use:** Keep composition ergonomic with trusted MDX and reusable components. For
the React/MJML pattern, use the maintained `@faire/mjml-react` bindings and their
`renderToMjml` utility, then await MJML's HTML compilation. Produce email-safe HTML
and a web reading version through their appropriate rendering pipelines.

**Watch:** Email is not an ordinary browser target: JavaScript, modern layout, and
CSS support differ. Do not copy the old unscoped `mjml-react` rendering API or assume
MJML compilation is synchronous. Inspect compiler errors, validate content IDs,
and avoid unchecked filesystem paths. Raw HTML/provider wrappers can undermine
email compatibility.

**Check:** Representative mail clients, images disabled, plain-text alternative,
links, narrow layouts, and provider-added markup. The article is an architectural
tour, not a complete secure production implementation.

## S044 — The Front-End Developer's Guide to the Terminal

Source: https://www.joshwcomeau.com/javascript/terminal-for-js-devs/

**Use:** Establish the working directory, inspect available scripts, and understand
arguments, flags, foreground processes, and command exit status. Use completion,
history, and separate sessions to reduce repetitive work.

**Watch:** The shell is not JavaScript, and quoting/platform conventions differ.
Recursive deletion is not a harmless “reset” step. Use the repository's package
manager and lockfile rather than automatically running a different installer.

**Check:** Paths before destructive actions, processes before terminating them, and
success before chaining dependent commands. Do not expose secrets through commands
or logs while troubleshooting.

## S046 — Delightful React File/Directory Structure

Source: https://www.joshwcomeau.com/react/file-structure/

**Use:** Co-locate component-specific files; promote genuinely reused helpers/hooks
only when reuse exists. Keep public entry points clear and implementation details
near their owner. Distinguish domain helpers from generic utilities.

**Watch:** Folder-by-component is a preference, not a reason to reorganize an existing
feature-oriented repository. Barrel exports, aliases, and server/client boundaries
can affect tooling and dependency graphs. Framework route folders have their own rules.

**Check:** Import clarity, circular dependencies, actual bundler behavior, and whether
a new abstraction reduces navigation rather than merely adding boilerplate.

## S055 — How I Built My Blog (earlier architecture)

Source: https://www.joshwcomeau.com/blog/how-i-built-my-blog/

**Use:** MDX can combine prose with purpose-built interactive components. Separate
frontmatter, content loading, index generation, and build artifacts such as RSS,
sitemaps, and social images. For Next.js App Router, use its documented MDX setup
and `mdx-components.tsx`; use `next-mdx-remote/rsc` for trusted remote MDX when that
library is already the chosen integration.

**Watch:** Keep interactive widgets behind narrow client boundaries. Do not copy
Pages Router data-loading helpers into App Router pages or assume React-context MDX
providers work in Server Components. MDX evaluates code: untrusted content is not safe
merely because it looks like Markdown.

**Check:** Unpublished content exclusion, metadata correctness, lazy loading, and
build reproducibility. The author's personal testing choices are not a general
recommendation to omit tests.

## S069 — Local Testing on an iPhone

Source: https://www.joshwcomeau.com/blog/local-testing-on-an-iphone/

**Use:** Reproduce mobile issues on the real device and inspect them with the
platform's debugging tools. A reachable local-network dev server or an authorized
tunnel can connect the phone to the development build.

**Watch:** Desktop viewport emulation cannot establish device performance or every
browser behavior. Public tunnels expose a service; protect credentials/data and
close the tunnel afterward. The article's commands, menu paths, hardware, and
platform-policy claims must be checked against current tools.

**Check:** Touch, overflow, virtual keyboard, viewport changes, network conditions,
and device performance rather than only a screenshot at mobile width.
