# Agent Skills

A collection of skills for AI coding agents. Skills are packaged instructions and references that extend agent capabilities.

Skills follow the [Agent Skills](https://agentskills.io/) format.

## Available Skills

### bulletproof-react-components

Nine patterns for building React components that survive real-world conditions — SSR, hydration, concurrent rendering, portals, transitions, and future React changes. Based on [Shu Ding's guide](https://shud.in/thoughts/build-bulletproof-react-components).

**Use when:**

- Writing reusable React components
- Fixing hydration mismatches
- Handling SSR edge cases
- Building component libraries

**Patterns covered:**

- Server-Proof (Critical) - no browser APIs during render
- Hydration-Proof (Critical) - inline scripts before hydration
- Instance-Proof (High) - `useId()` over hardcoded IDs
- Concurrent-Proof (High) - `React.cache()` deduplication
- Composition-Proof (High) - Context over `cloneElement`
- Portal-Proof (Medium) - `ownerDocument.defaultView` for listeners
- Transition-Proof (Medium) - `startTransition()` for View Transitions
- Activity-Proof (Medium) - `useLayoutEffect` for `<Activity>` visibility
- Future-Proof (Medium) - `useState` initializer for stable values

### josh-comeau-frontend

A source-linked frontend skill covering all 88 entries in Josh W. Comeau's RSS
snapshot retrieved September 19, 2026. Includes CSS layout and modern features,
React and JavaScript, SSR/hydration, animation, SVG, accessibility, tooling, and
task-relevant engineering/career guidance.

**Use when:**

- Diagnosing CSS sizing, alignment, stacking, or responsive behavior
- Building polished, accessible interactions and SVG effects
- Debugging React state, rendering, performance, or hydration
- Applying the articles' techniques without blindly copying historical APIs

The compact entrypoint routes to 12 focused guides. Every article has an individual
application note, caveat, and verification prompt. Offline lookup and a live/offline
RSS audit help find guidance and detect feed drift. A separate current-platform
baseline records stable-release and primary-documentation checks from September 19,
2026; implementation advice uses current APIs rather than article-era recipes.
The RSS audit does not check platform freshness. Research used section-level
excerpts and targeted longer passages from full-page fetches, not a word-for-word
reading or an exhaustive interactive-demo audit. Article bodies are not redistributed.

```bash
npx skills add CodeWithShreyans/skills --skill josh-comeau-frontend
```

See `skills/josh-comeau-frontend/SKILL.md`.

## Installation

```bash
npx skills add CodeWithShreyans/skills
```

## Usage

Skills are automatically available once installed. The agent will use them when relevant tasks are detected.

**Examples:**

```
Review this component for bulletproof patterns
```

```
Make this component SSR-safe
```

```
Check this component for hydration issues
```

## Skill Structure

Each skill contains:

- `SKILL.md` - Instructions for the agent
- `references/` - Supporting documentation loaded on demand
- `scripts/` - Executable helpers, when included

## License

MIT
