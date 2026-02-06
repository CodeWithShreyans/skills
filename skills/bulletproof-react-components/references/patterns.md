# Bulletproof React Patterns — Code Examples

Detailed bad/good code examples for each of the nine patterns.

---

## 1. Server-Proof

Browser APIs crash during SSR. Move them into `useEffect`.

```tsx
// BAD - crashes on server
const theme = localStorage.getItem('theme')

// GOOD - safe for SSR
const [theme, setTheme] = useState('light')
useEffect(() => {
  setTheme(localStorage.getItem('theme') || 'light')
}, [])
```

---

## 2. Hydration-Proof

Server renders initial state, client hydrates with different values, causing visual flashes. Inject a synchronous inline script that sets the correct value before React hydration.

```tsx
// Inline script runs before React hydration — no flash
<script dangerouslySetInnerHTML={{
  __html: `document.documentElement.dataset.theme = localStorage.getItem('theme') || 'light'`
}} />
```

This avoids the flash-of-wrong-content that happens when `useEffect` corrects the value after paint.

---

## 3. Instance-Proof

Multiple instances with hardcoded IDs conflict. Use `useId()`.

```tsx
// BAD - breaks with multiple instances
const id = 'my-tooltip'

// GOOD - unique per instance, stable across server/client
const id = useId()

return (
  <>
    <button aria-describedby={id}>Hover me</button>
    <div id={id} role="tooltip">Tooltip content</div>
  </>
)
```

---

## 4. Concurrent-Proof

Server Components fetched multiple times cause duplicate queries. Wrap in `React.cache()`.

```tsx
import { cache } from 'react'

// Deduplicated across all Server Components in the same request
const getUser = cache(async (id: string) => {
  return await db.user.findUnique({ where: { id } })
})

// Both components call getUser('123') but only one DB query executes
async function UserProfile({ id }: { id: string }) {
  const user = await getUser(id)
  return <h1>{user.name}</h1>
}

async function UserAvatar({ id }: { id: string }) {
  const user = await getUser(id)
  return <img src={user.avatar} />
}
```

---

## 5. Composition-Proof

`React.cloneElement()` fails with Server Components, lazy-loaded components, or memo. Use Context.

```tsx
// BAD - breaks with Server Components, React.lazy, React.memo
React.Children.map(children, child =>
  React.cloneElement(child, { active: true })
)

// GOOD - works with any child type
const TabContext = createContext({ activeIndex: 0 })

function Tabs({ children, activeIndex }: Props) {
  return (
    <TabContext.Provider value={{ activeIndex }}>
      {children}
    </TabContext.Provider>
  )
}

function Tab({ index, children }: TabProps) {
  const { activeIndex } = useContext(TabContext)
  return <div data-active={index === activeIndex}>{children}</div>
}
```

---

## 6. Portal-Proof

Event listeners on `window` fail in portals, iframes, pop-out windows. Use the component's actual window via its DOM ref.

```tsx
// BAD - only works in the main window
useEffect(() => {
  window.addEventListener('keydown', handler)
  return () => window.removeEventListener('keydown', handler)
}, [])

// GOOD - works in portals, iframes, pop-out windows
const ref = useRef<HTMLDivElement>(null)

useEffect(() => {
  const win = ref.current?.ownerDocument.defaultView || window
  win.addEventListener('keydown', handler)
  return () => win.removeEventListener('keydown', handler)
}, [])

return <div ref={ref}>...</div>
```

---

## 7. Transition-Proof

View Transitions don't animate without `startTransition()`.

```tsx
import { startTransition } from 'react'

function handleNavigate() {
  // Enables View Transition API animation
  startTransition(() => {
    setCurrentPage(nextPage)
  })
}
```

---

## 8. Activity-Proof

DOM-level side effects (like `<style>` tags) persist globally even when hidden by `<Activity>`. Use `useLayoutEffect` to disable them.

```tsx
const ref = useRef<HTMLStyleElement>(null)

// Cleanup runs when Activity hides; re-runs when visible
useLayoutEffect(() => {
  if (ref.current) {
    ref.current.media = 'all' // Enable styles when visible
  }
  return () => {
    if (ref.current) {
      ref.current.media = 'not all' // Disable styles when hidden
    }
  }
}, [])

return <style ref={ref}>{css}</style>
```

---

## 9. Future-Proof

`useMemo` is only a performance hint — React may discard cached values. Use `useState` with an initializer for values that must persist.

```tsx
// BAD - React may discard this at any time
const stableId = useMemo(() => crypto.randomUUID(), [])

// GOOD - useState guarantees persistence for the component's lifetime
const [stableId] = useState(() => crypto.randomUUID())
```

**When to use which:**
- `useMemo`: Recomputable values where recalculation is just expensive (derived data, filtered lists)
- `useState` initializer: Values where identity/stability matters (IDs, subscriptions, one-time setup)
