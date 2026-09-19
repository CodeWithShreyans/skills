# Current-platform baseline

Verified on **September 19, 2026** against publisher release metadata and primary
documentation. This is a dated compatibility review, not a promise that these
versions will remain latest. The articles supply attribution and mental models;
current platform documentation governs implementation details.

## Release checks

These are the versions returned by each publisher's npm `latest` endpoint, not
minimum versions to impose on a project or dependencies to install together.
Peer declarations were inspected; complete cross-library runtime combinations
were not integration-tested. Check Node engines and actual peer dependencies
before changing an application's dependencies.

| Package | Verified stable release | Publisher metadata |
| --- | --- | --- |
| React | 19.3.0 | https://registry.npmjs.org/react/latest |
| React DOM | 19.3.0 | https://registry.npmjs.org/react-dom/latest |
| Next.js | 16.3.5 | https://registry.npmjs.org/next/latest |
| styled-components | 6.5.3 | https://registry.npmjs.org/styled-components/latest |
| Motion | 13.4.0 | https://registry.npmjs.org/motion/latest |
| React Spring web | 10.1.2 | https://registry.npmjs.org/@react-spring/web/latest |
| Sandpack React | 2.20.0 | https://registry.npmjs.org/@codesandbox/sandpack-react/latest |
| MJML | 5.4.1 | https://registry.npmjs.org/mjml/latest |
| Faire MJML React | 4.0.1 | https://registry.npmjs.org/@faire/mjml-react/latest |
| use-sound | 5.0.0 | https://registry.npmjs.org/use-sound/latest |
| Howler | 2.2.4 | https://registry.npmjs.org/howler/latest |
| MDX React | 3.1.1 | https://registry.npmjs.org/@mdx-js/react/latest |
| next-mdx-remote | 6.0.0 | https://registry.npmjs.org/next-mdx-remote/latest |
| Linaria React | 8.2.0 | https://registry.npmjs.org/@linaria/react/latest |

The React release artifact was also checked for its `ViewTransition` export, and
the styled-components artifact for `stylisPluginRSC`. Do not take a future-version
example from a mixed-version documentation page as an API in the stable release.

## React: S024, S038, S039, S072, S080, S088

- The compiler is optional build tooling, not automatically enabled by upgrading
  React. Prefer compiler-generated memoization in compiled code; manual memoization
  remains a supported optimization for appropriate cases.
- Use an external-store subscription for shared browser-backed preferences, with
  consistent server/hydration snapshots. A local client-only preference does not
  need to become an external store merely to be “modern”.
- React View Transitions are an available current API, but snapshot transitions are
  not equivalent to every interactive layout-animation use case. Respect reduced
  motion. Current Next.js App Router integrates them without configuration; do not
  add the old experimental flag or install a separate React canary to enable them.

Primary references:

- https://react.dev/learn/react-compiler/introduction
- https://react.dev/reference/react/memo
- https://react.dev/reference/react/useDeferredValue
- https://react.dev/reference/react/useSyncExternalStore
- https://react.dev/reference/react/ViewTransition
- https://nextjs.org/docs/app/guides/view-transitions
- https://developer.mozilla.org/en-US/docs/Web/API/Window/storage_event

## Next.js: S029, S062, S074, S079

Use App Router APIs for new App Router work. Refreshing the route and invalidating
cached data are separate operations. Choose Server Action read-your-own-writes,
stale-while-revalidate, or path invalidation based on the actual data flow; avoid
single-argument `revalidateTag`. Do not treat every fetch as cached or force Cache
Components configuration without inspecting the application.

The Pages Router is still supported; its recipes were removed from the skill's
recommended implementation path, not declared removed from Next.js. Do not migrate
an existing application without a user requirement.

Primary references:

- https://nextjs.org/docs/app/getting-started/caching
- https://nextjs.org/docs/app/api-reference/functions/use-router
- https://nextjs.org/docs/app/api-reference/functions/refresh
- https://nextjs.org/docs/app/api-reference/functions/updateTag
- https://nextjs.org/docs/app/api-reference/functions/revalidateTag
- https://nextjs.org/docs/app/api-reference/functions/revalidatePath
- https://nextjs.org/docs/pages

## Styling: S025, S054, S060

Use the stable styled-components RSC integration, distinguish it from collecting
Client Component styles during SSR, and account for inline style-tag effects on
child-index selectors. RSC theming uses custom properties rather than React context.
Do not prescribe migration to Linaria, a different compiler, or a different styling
system merely to obtain server rendering.

Primary references:

- https://styled-components.com/docs/advanced#react-server-components
- https://nextjs.org/docs/app/guides/css-in-js

## CSS: S001, S009, S019, S026, S048, S075

There is no single “latest CSS” release with a uniform browser implementation.
Check the actual feature and target engines. Block `align-content` is available;
do not repeat the article-era claim that it is only a future centering option.
Likewise, prefer native markers, gradient interpolation, and typed custom properties
where they solve the task. Do not add a polyfill merely because an old article did.

Keep fallbacks for features that still differ across supported engines. Anchor
positioning subfeatures, scroll timelines, and keyword-size interpolation require
their own support checks; one successful feature query does not establish all of them.

Primary references:

- https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/align-content
- https://developer.mozilla.org/en-US/docs/Web/CSS/Guides/Anchor_positioning
- https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@starting-style
- https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@property
- https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/interpolate-size

## Animation and sound: S002, S004, S064, S068, S077, S082

When a library is already chosen, use its current entry points: Motion's React
bindings use `motion/react`; React Spring's DOM bindings use `@react-spring/web`.
Do not install both to reproduce a blog example. Keep current use-sound/Howler
behavior behind an accessible sound preference. No library choice guarantees that
every property runs off the main thread.

Primary references:

- https://github.com/motiondivision/motion/blob/main/README.md
- https://github.com/pmndrs/react-spring/blob/next/README.md
- https://github.com/joshwcomeau/use-sound/blob/master/README.md

The Motion and React Spring documentation sites rejected automated requests during
this review; their maintainers' READMEs and published package metadata were used
instead. Version-specific behavior beyond those sources still needs verification.

## Content, playgrounds, and email: S021, S037, S041, S055

Keep MDX authoring and server rendering separate from client playgrounds. Use the
App Router MDX convention or the selected library's RSC entry point, not a copied
Pages Router serialization workflow. Preserve the trust boundary around executable MDX.

For React-authored MJML, the maintained binding is `@faire/mjml-react`; compile its
MJML output with the current asynchronous MJML API. Do not transplant the old
unscoped package's render helper. Check email-client rendering separately from
React/package compatibility.

Primary references:

- https://nextjs.org/docs/app/guides/mdx
- https://github.com/hashicorp/next-mdx-remote#react-server-components-rsc--nextjs-app-directory-support
- https://sandpack.codesandbox.io/docs/getting-started
- https://github.com/Faire/mjml-react/blob/main/README.md
- https://github.com/mjmlio/mjml/blob/master/README.md

## Keeping the recommendations current

Recheck official stable releases and the relevant API docs before version-sensitive
implementation. Remove or replace advice that is deprecated, removed, incompatible,
or tied to an obsolete integration. Keep older APIs that remain appropriate and
supported; novelty alone is not a migration reason. If support cannot be verified,
omit the version-dependent recommendation and explain the uncertainty.

The RSS audit does not validate any of these platform versions or APIs. Refresh this
baseline and the affected notes separately.
