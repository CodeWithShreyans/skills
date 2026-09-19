# Rendering and styling: separate execution environments

Before editing, identify CSR/SSR/static rendering, the framework router, and which
modules cross a server/client boundary. Distinguish generating HTML, producing a
Server Component payload, loading client code, hydrating, and subsequent updates.
Use the current-platforms baseline for version-sensitive APIs. The Next.js guidance
below targets the App Router; it does not prescribe migrating an existing router.

Additional implementation safeguards: preserve valid HTML, keep secrets out of
client props/bundles, use framework-supported style/script integration, respect CSP,
and never interpolate untrusted values into executable inline scripts.

## S025 — CSS in React Server Components

Source: https://www.joshwcomeau.com/react/css-in-rsc/

**Use:** Current styled-components supports styling Server Components without adding
`'use client'` or an RSC registry. Use CSS custom properties for RSC theming;
`ThemeProvider` cannot supply React context there. Client Component styles during
SSR still need the documented registry integration. Keep dynamic values scoped.

**Watch:** Inline RSC style tags affect child-index selectors. Follow the stable
release's `stylisPluginRSC` integration when those selectors are necessary, rather
than copying a future-version plugin API. Runtime CSS-in-JS is not categorically
incompatible with RSC; extracted CSS is an option, not a required migration.

**Check:** Installed-version documentation, build-tool compatibility, streamed SSR,
style ordering, and dynamic props before recommending any library change.

## S029 — Making Sense of React Server Components

Source: https://www.joshwcomeau.com/react/server-components/

**Use:** Keep server-only work in Server Components and introduce client boundaries
where state, effects, or browser interaction are needed. Compose server-produced
content into client wrappers through props/children when appropriate.

**Watch:** A client boundary follows the module dependency graph, not simply visual
DOM ancestry. Client Components can still participate in initial server rendering.
SSR and RSC solve related but different problems. RSC support is a framework and
library integration question, not permission to use arbitrary client APIs on the server.

**Check:** Imports crossing the boundary, serializable values where required, browser
APIs during render, server-only dependencies, and independently paced data/loading states.

## S054 — Demystifying styled-components

Source: https://www.joshwcomeau.com/react/demystifying-styled-components/

**Use:** Component factories connect class names, processed CSS, and dynamic values;
style delivery depends on client, SSR, or RSC execution. A styled custom component
must carry its supplied `className` to the intended DOM element. Keep dynamic
per-instance values in custom properties where that avoids excessive generated rules.

**Watch:** The simplified implementation is educational, not production-ready.
Composed wrappers must retain existing classes. Highly variable values can be better
expressed as custom properties than as an unbounded set of generated rules.

**Check:** Class forwarding, styling composition, and current SSR/RSC integration.
Do not turn the article's toy runtime into a production injection system.

## S060 — The styled-components Happy Path

Source: https://www.joshwcomeau.com/css/styled-components/

**Use:** Keep a component responsible for its styles, expose dynamic values through
custom properties where useful, and intentionally encapsulate internal stacking.
Contextual styling should be explicit rather than a scattered collection of overrides.

**Watch:** Polymorphic `as` changes the rendered tag, not the behavioral contract:
links navigate and buttons act. Specificity escalation is a targeted escape hatch,
not the default architecture. Use the current framework/compiler integration;
do not revive removed macro entry points or Create React App-specific setup.

**Check:** DOM semantics, forwarded props/classes, nested contexts, and whether the
project already has an equally coherent different styling convention.

## S062 — Refreshing Server-Side Props

Source: https://www.joshwcomeau.com/nextjs/refreshing-server-side-props/

**Use:** In the App Router, call `router.refresh()` from `next/navigation` for a new
Server Component payload, or `refresh()` from `next/cache` inside a Server Action.
Invalidate cached data separately when needed: `updateTag(tag)` for read-your-own-writes
inside a Server Action, `revalidateTag(tag, 'max')` for stale-while-revalidate, or
`revalidatePath(path)` for path-scoped invalidation.

**Watch:** Refreshing alone does not invalidate server caches. Tags must already be
attached to cached data. `updateTag` and server `refresh` are not Route Handler APIs.
Do not use the deprecated single-argument `revalidateTag(tag)` signature or the
article's same-route replacement recipe. Initial props do not continuously own local state.

**Check:** Mutation/refresh failures, stale data, pending UI, and preservation of
unsaved edits. Choose invalidation semantics rather than calling every API together.

## S074 — The Quest for the Perfect Dark Mode

Source: https://www.joshwcomeau.com/react/dark-mode/

**Use:** Resolve explicit user choice, then system preference, then a safe default.
Set theme tokens before the first visible paint when the framework supports it;
initialize interactive state from the same resolved theme rather than independently
guessing. Keep a useful no-JavaScript palette.

**Watch:** Browser-only storage is unavailable on the server. A post-mount effect
alone can flash the wrong theme. Prefer the project's current theme integration;
otherwise place a minimal pre-paint script through supported document/layout APIs,
with CSP and hydration handled intentionally—not Gatsby-specific SSR hooks.

**Check:** Reload with each stored/system combination, blocked storage, system changes,
first paint, and whether the toggle ever announces the wrong state.

## S079 — The Perils of Hydration

Source: https://www.joshwcomeau.com/react/the-perils-of-rehydration/

**Use:** Make the first client render match the server output. For truly client-only
information, either provide a consistent server-known snapshot or keep a stable
placeholder until after mounting. Limit two-pass rendering to the region that needs it.

**Watch:** `typeof window` prevents an exception but does not make different output
hydration-safe. Randomness, time, invalid HTML, and client storage can all create
divergence. Suppressing a warning is not a structural repair.

**Check:** Production SSR, console warnings, initial markup, slow hydration, and layout
shift. Do not hide the whole application merely to avoid a local mismatch.
