# React and JavaScript: ownership before optimization

Trace the update from its event or asynchronous source to the owning state, then
through the rendered subtree. Establish correctness before optimizing: identity,
immutable updates, controlled-field invariants, and lifecycle cleanup. Distinguish
render cost from committed DOM work and browser rendering cost.

Applied safeguards beyond illustrative examples: reject stale asynchronous results,
handle storage/network failure, test repeated mounting, and check whether the
project uses compiler-assisted memoization before adding manual caching everywhere.

## S023 — Promises From The Ground Up

Source: https://www.joshwcomeau.com/javascript/promises/

**Use:** Model a Promise as one eventual settlement, not a recurring event stream.
Return values or Promises from a chain to preserve sequencing. `await` suspends the
async function's continuation; it does not synchronously block the JavaScript thread.

**Watch:** `fetch` resolving does not imply an HTTP success; check `response.ok`.
Thrown errors and rejected Promises need deliberate handling. Wrapping synchronous
CPU work in a Promise does not move it off the main thread.

**Check:** Rejection, non-success HTTP status, JSON parsing failure, cancellation,
and races between requests. Use independent concurrency only when ordering permits it.

## S024 — Snappy UI Optimization with useDeferredValue

Source: https://www.joshwcomeau.com/react/use-deferred-value/

**Use:** Keep urgent input current while a slower subtree uses a deferred value.
Ensure it can skip the urgent render: use compiler-provided memoization when that
subtree is compiled, or `memo` when manual memoization is needed. Show a stale
indicator when appropriate. `useDeferredValue(value, initialValue)` can also defer
the initial render; without that argument, the first render uses `value`.

**Watch:** This schedules interruptible React work; it is not fixed-time debounce,
network rate limiting, or a worker. Expensive synchronous work performed before the
deferred boundary still blocks. Unstable object props can defeat skipping.

**Check:** Profile urgent and background renders under CPU load. Verify prop stability,
compiler coverage, and result freshness rather than mandating manual wrappers.

## S028 — Understanding the JavaScript Modulo Operator

Source: https://www.joshwcomeau.com/javascript/modulo-operator/

**Use:** Wrap a non-negative index through a finite set, such as cycling colors or
carousel positions, using the remainder after division by the set length.

**Watch:** JavaScript `%` is a remainder operator. As an applied extension to the
article's positive-number examples, normalize negative indices with
`((index % count) + count) % count` when `count` is positive. An empty collection
must be handled before calculating the remainder.

**Check:** Zero, exact multiples, backward steps, and empty/single-item collections.
Keep time-based progression distinct from frame-count progression.

## S031 — The “const” Deception

Source: https://www.joshwcomeau.com/javascript/the-const-deception/

**Use:** Distinguish a binding from the object it references. `const` prevents
rebinding; it does not prohibit mutating an object or array. Primitive values are
immutable, while shared object references can expose mutations elsewhere.

**Watch:** `Object.freeze()` is shallow. TypeScript `as const` changes static typing,
not runtime mutability. Neither replaces a correct immutable state-update strategy
for nested React state.

**Check:** Shared references, nested mutation, equality comparisons, and whether an
update creates new references along the changed path without cloning unrelated data.

## S033 — Common Beginner Mistakes with React

Source: https://www.joshwcomeau.com/react/common-beginner-mistakes/

**Use:** Check for numeric `&&` rendering, mutated state, unstable/missing keys,
missing JSX whitespace, stale state snapshots, invalid multiple-root returns,
controlled/uncontrolled switches, malformed style objects, and async effect callbacks.

**Watch:** Generate persistent IDs when data is created, not each render; prefer
stable source IDs when available. State setters schedule a new snapshot, not an
in-place change to the current handler's variable. An effect must not return a Promise.

**Check:** Empty arrays, reordering, rapid updates, initial undefined values, and
unmount during a fetch. Async work inside an effect still needs cleanup/race handling.

## S034 — Data Binding in React

Source: https://www.joshwcomeau.com/react/data-binding/

**Use:** Pair controlled text/select values with change handlers; pair checkboxes
with `checked`. A radio group shares a selection value and name, while each option
has its own value, checked comparison, and associated label.

**Watch:** Start controlled text fields with strings and checkbox fields with booleans.
Do not accidentally compare a shadowed radio variable to itself. Browser input values
are often strings even when the UI represents a number; empty numeric input needs
an intentional policy.

**Check:** Multiple component instances with unique label IDs, keyboard selection,
reset behavior, and submitted values. `useId` is for relationships, not list identity.

## S038 — Understanding useMemo and useCallback

Source: https://www.joshwcomeau.com/react/usememo-and-usecallback/

**Use:** In compiler-enabled code, let React Compiler supply automatic memoization
first. Use `useMemo`, `useCallback`, or `memo` for a measured need in uncompiled code
or an explicit compiler escape hatch—not as boilerplate around every hook/provider.
`useCallback` preserves a function reference, not its execution result. State
colocation can eliminate unrelated work without caching.

**Watch:** Fresh objects/functions defeat shallow prop comparisons. Dependencies
must reflect captured values; omitting them to stabilize identity creates stale
closures. Memoization is an optimization, not a correctness or permanent-storage contract.

**Check:** A measured bottleneck, compiler configuration/coverage, and correct
dependencies. Installing current React does not by itself enable the compiler;
manual memoization remains supported where it is useful.

## S039 — Why React Re-Renders

Source: https://www.joshwcomeau.com/react/why-react-re-renders/

**Use:** Follow state ownership: an update normally renders its component and the
subtree it produces, not only children whose props visibly changed. Rendering
calculates the next UI; reconciliation may commit few or no DOM changes.

**Watch:** `memo` can skip unchanged props but does not block the component's own
state or consumed context updates. Stable children/composition can change which
elements are recreated. React Compiler can supply these skips automatically;
the unoptimized render model does not promise every compiled child executes.
Development behavior is not a production performance benchmark.

**Check:** React profiling, actual commit costs, context value identity, and browser
layout/paint on slower hardware before diagnosing “too many renders”.

## S040 — Statements Vs. Expressions

Source: https://www.joshwcomeau.com/javascript/statements-vs-expressions/

**Use:** Recognize value-producing expression positions in JSX, arguments, and
initializers. Use a ternary, a computed variable, or a helper result where a value
is needed; use statements for control flow outside that expression position.

**Watch:** A standalone expression can be wrapped in an expression statement.
Syntactic validity is separate from runtime correctness. Do not force complex
branching into nested ternaries just because JSX accepts expressions.

**Check:** Both conditional branches, returned values, and whether a small named
helper communicates intent more clearly than a compact inline expression.

## S080 — Persisting React State in localStorage

Source: https://www.joshwcomeau.com/react/persisting-react-state-in-localstorage/

**Use:** For local state in a genuinely client-only render, lazy initialization and
an effect remain valid. For a shared browser-backed preference, use an external-store
subscription with `useSyncExternalStore`, a stable snapshot, and a matching
`getServerSnapshot` when server-rendered. Keep persistence behind a focused API.

**Watch:** A Next.js Client Component can still render on the server. Do not read
storage during that render. Handle unavailable storage, malformed data, and changed
keys. Same-tab writes need their own subscriber notification; the browser's storage
event does not notify the document that made the change.

**Check:** Read-before-write ordering, missing/corrupt data, reload, and changed keys.
If initialization is deferred, do not overwrite existing storage with defaults first.
