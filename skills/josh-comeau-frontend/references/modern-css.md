# Modern CSS: capability plus fallback

Build the essential narrow/static experience first, then add the enhancement.
Evaluate three things together: fallback quality, the actual audience's browsers,
and the harm caused by failure. Feature queries establish syntax support, not the
absence of engine bugs. Check the particular subfeature and behavior you use.

## S001 — Getting Started with Anchor Positioning

Source: https://www.joshwcomeau.com/css/anchor-positioning/

**Use:** Connect an anchor's dashed `anchor-name` to an absolute/fixed target's
`position-anchor`, then choose `position-area` and fallback positions. Keep the target
flexibly sized so collision handling has room to work.

**Watch:** The containing block still determines overflow behavior; `fixed` can track
an anchor while remaining viewport-contained. `flip-block` can also flip directional
margins. Anchored container queries for alternate caret styling are a separate,
newer capability, not implied by basic anchor-positioning support.

**Check:** Every viewport edge, scrolling, repeated instances with distinct anchors,
and fallback usability. Positioning alone supplies neither tooltip semantics nor
focus/dismissal behavior.

## S009 — The Big Gotcha With @starting-style

Source: https://www.joshwcomeau.com/css/starting-style/

**Use:** Supply a before-change style for entry transitions when an element has no
previous rendered style. Keep starting and resting declarations in a compatible
cascade; pass dynamic coordinates as custom properties instead of inline transforms.

**Watch:** `@starting-style` does not outrank inline styles. Source order matters at
equal specificity. Partial keyframes can be a simpler entry effect, but the article's
later correction highlights a difference: transitions can reverse gracefully when
entry is interrupted by exit.

**Check:** Insert, remove, reopen midway, dynamic endpoints, and the no-enhancement
state. Do not add `!important` before understanding the cascade conflict.

## S017 — Container Queries Unleashed

Source: https://www.joshwcomeau.com/css/container-queries-unleashed/

**Use:** Combine page-level media queries with component-level container queries.
A component may gain space when a two-column page becomes one column, so its own
layout should respond to available width rather than assuming smaller viewport
always means less room.

**Watch:** Unnamed queries use an eligible ancestor, not a globally chosen wrapper.
Name containers when nested layouts must target a particular boundary.

**Check:** Resize through the page's column-collapse breakpoint, and render the same
component in a sidebar, full-width section, and nested container.

## S019 — A Framework for Evaluating Browser Support

Source: https://www.joshwcomeau.com/css/browser-support/

**Use:** Judge the unsupported experience, audience-specific exposure, and consequences
of failure together. A missing flourish and an inaccessible essential form have
different costs even at the same support percentage.

**Watch:** The article's percentages are dated observations, not launch thresholds.
Supply fallback declarations before enhanced ones or use precise `@supports` rules.
Property support does not necessarily prove support in every layout context.

**Check:** Disable the enhancement and complete the user's task. Prefer usable narrow
base styles with additive min-width queries over a wide-only baseline that depends
on unsupported queries to become usable.

## S020 — A Friendly Introduction to Container Queries

Source: https://www.joshwcomeau.com/css/container-queries-introduction/

**Use:** Establish an ancestor with `container-type: inline-size`, then query its
inline dimension to style descendants. Containment breaks the circular dependency
between a child's styling and the queried container's content-derived size.

**Watch:** A queried element does not use its own size query to style itself.
Inline-size containment affects intrinsic sizing; full size containment also stops
children determining block size and may collapse an unconstrained wrapper.

**Check:** Intrinsically sized parents, empty containers, nested query selection, and
unavailable-query behavior. CSS nesting support is independent of container queries.

## S022 — The Undeniable Utility Of CSS :has

Source: https://www.joshwcomeau.com/css/has/

**Use:** Express relationships already present in the DOM—focus within a card,
checked controls, or contextual styling—without duplicating that visual state in
JavaScript. Scope selectors to the relevant region.

**Watch:** A fallback must retain focus indication. If `:has()` moves the outline to
a parent, remove the child's outline only inside the same supported enhancement.
Complex app state and dynamic categories can still be clearer in JavaScript.

**Check:** `@supports selector(:has(*))`, keyboard focus, unchecked and checked states,
and whether broader matching affects unrelated components. Scroll locking alone
does not implement an accessible modal.

## S048 — A Modern CSS Reset

Source: https://www.joshwcomeau.com/css/custom-css-reset/

**Use:** Own a small baseline suited to the project: predictable box sizing,
intentional margins, responsive media, inherited form typography, readable line
height, wrapping, and an intentional root stacking boundary.

**Watch:** This reset changes over time; older copies contain different rules.
Do not paste it on top of an existing reset or erase useful native semantics and
focus styles. New keyword-size interpolation and text wrapping are enhancements,
not assumptions every target engine satisfies.

**Check:** Native controls, inline images/icons, oversized decorative media, portal
layers, large text, and reduced motion. Review each global declaration independently.

## S076 — Styling Ordered Lists with CSS Counters

Source: https://www.joshwcomeau.com/css/styling-ordered-lists-with-css-counters/

**Use:** Keep semantic ordered lists. Start with `::marker` for simple marker styling;
use counters for custom sequences or hierarchical labels such as `2.3.1`.

**Watch:** The article now explicitly points to `::marker` as the simpler option for
many cases. `counter()` reads a level; `counters()` combines nested levels with a
separator. Custom pseudo-content is not a substitute for meaningful list structure.

**Check:** Nested lists, resets, start/reversed numbering requirements, and assistive
technology behavior if native markers are suppressed.
