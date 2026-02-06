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

## Installation

```bash
npx skills add shreyans/skills
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

## License

MIT
