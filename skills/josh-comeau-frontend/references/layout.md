# Layout: diagnose the algorithm

First identify the element's own layout mode, its parent's formatting context, its
containing block, and the ancestor imposing a size or stacking boundary. Inspect
computed styles and the Grid/Flex overlays. Remove one suspected constraint at a
time in a minimal reproduction, then test realistic content before keeping the fix.

## S007 — Brand New Layouts with CSS Subgrid

Source: https://www.joshwcomeau.com/css/subgrid/

**Use:** Extend selected parent tracks through semantic wrappers with `display: grid`
and `grid-template-rows` or `grid-template-columns: subgrid`. Explicitly reserve the
child's row/column span; the inherited axis cannot invent unlimited extra tracks.
This lets sibling cards align internal headings, content, and actions without flattening HTML.

**Watch:** Line numbers restart inside the subgrid. The article's oversized row-span
trick accumulates empty space if gaps are present. Its multi-track card example cannot
simply swap to `auto-fit`; that is not a universal incompatibility between fluid grids
and subgrid.

**Check:** Unequal text, variable list lengths, missing fields, local line assignments,
and the non-subgrid fallback.

## S014 — The Height Enigma

Source: https://www.joshwcomeau.com/css/height-enigma/

**Use:** Trace percentage heights to a definite containing-block height. In normal
flow, an auto-height parent depends on its children, so a child's percentage height
cannot generally determine that same parent's height.

**Watch:** A parent's `min-height` is not interchangeable with a definite `height`.
An unbroken percentage chain can work from the root, but usually Grid stretching or
Flexbox growth expresses “fill available space while accommodating content” better.

**Check:** Remove intermediate fixed heights, add long text, and confirm the layout
can grow. Do not turn a fill problem into clipped content by hardcoding a height.

## S026 — How To Center a Div

Source: https://www.joshwcomeau.com/css/center-a-div/

**Use:** Match centering to context: inline content uses `text-align`; a constrained
block uses auto inline margins; Flexbox aligns items; Grid can align tracks or items;
positioned elements can use insets and auto margins with suitable dimensions.
Current block layout also supports `align-content: center` for block-axis alignment
when the container has spare block space; Flexbox/Grid is not required just for that.

**Watch:** `place-content` aligns the grid's tracks, whereas `place-items` aligns
items inside their areas. They are not interchangeable for percentage-sized children.
Centering a box does not center its text. `align-content` has no effect on a
single-line non-wrapping flex container; use `align-items` in that case.

**Check:** Unknown dimensions, multiple children, multiline text, and content larger
than the available viewport.

## S027 — An Interactive Guide to CSS Grid

Source: https://www.joshwcomeau.com/css/interactive-guide-to-grid/

**Use:** Model tracks, lines, areas, and explicit versus implicit placement separately.
`fr` distributes remaining space; intrinsic minimums can still make a track overflow.
Use spans and named areas to express relationships instead of fixed coordinates.

**Watch:** Visual rearrangement does not normally rearrange DOM or keyboard order.
`minmax(0, 1fr)` permits a track to shrink but still requires a wrapping/overflow policy
for its content. Treat newer reading-order APIs as independently support-sensitive,
not permission to ignore logical source order.

**Check:** Long unbreakable strings, extra implicit rows, zoom, and keyboard traversal
at each layout breakpoint.

## S036 — An Interactive Guide to Flexbox

Source: https://www.joshwcomeau.com/css/interactive-guide-to-flexbox/

**Use:** Identify main and cross axes first. Treat `flex-basis` as the starting main-axis
size, growth as distribution of spare space, and shrink as distribution of a deficit.
Shrinking is weighted by base size, not just by each item's `flex-shrink` number.

**Watch:** Automatic minimum sizes can prevent shrinking. Apply `min-inline-size: 0`
only with a deliberate content policy; use `flex-shrink: 0` for an item that must keep
its size. Wrapped lines distribute space independently; use Grid for shared columns.

**Check:** Longer labels, changing direction, narrow widths, and whether auto margins
are consuming the space expected by alignment properties.

## S045 — Understanding Layout Algorithms

Source: https://www.joshwcomeau.com/css/understanding-layout-algorithms/

**Use:** Explain a declaration through its active algorithm. A width participates in
Flexbox sizing differently from normal flow; absolutely positioned children leave
normal flex distribution. A parent's layout mode and a child's inner layout are
distinct concerns.

**Watch:** The gap below an inline image often belongs to the line box's baseline
space, not margin or padding. Making the image block-level or intentionally changing
its formatting context addresses the cause.

**Check:** Inspect participating children and line boxes before applying offsets or
overflow clipping to hide an unexplained discrepancy.

## S058 — What The Heck, z-index??

Source: https://www.joshwcomeau.com/css/stacking-contexts/

**Use:** Compare the relevant ancestor stacking contexts before comparing descendant
`z-index` values. Inspect triggers such as transforms, opacity, filters, isolation,
and applicable positioned or flex/grid items.

**Watch:** A huge descendant number cannot escape a lower ancestor context. Flex/grid
items need not be positioned for `z-index` to apply. Use `isolation: isolate` when
encapsulating a component's internal layers is intentional, not as a random fix.

**Check:** Overlay versus header, nested animated elements, and existing portal or
top-layer architecture. Fix the boundary or placement rather than escalating numbers.

## S061 — Let's Bring Spacer GIFs Back!

Source: https://www.joshwcomeau.com/react/modern-spacer-gif/

**Use:** Treat the proposed Spacer as a component-API experiment: spacing can belong
to the relationship between siblings rather than either sibling. If a spacer is
useful in an existing component system, give it clear axis and sizing semantics.

**Watch:** This is not a recommendation to fetch GIFs or add empty nodes everywhere.
Prefer native `gap` for ordinary flex/grid relationships. A spacer in flex layout
can itself shrink; invalid HTML nesting remains invalid regardless of CSS display.

**Check:** Responsive spacing, inline text behavior, and whether one container rule
would solve the problem with less markup.

## S063 — The Rules of Margin Collapse

Source: https://www.joshwcomeau.com/css/rules-of-margin-collapse/

**Use:** In the relevant normal-flow block layout, adjoining margins can combine
across siblings and parent/child boundaries. A collapsing group uses the largest
positive margin plus the most negative margin, treating an absent sign as zero.

**Watch:** Padding, borders, formatting contexts, and intervening content change
which margins adjoin. Margins between flex/grid items do not collapse, though their
normal-flow descendants can still have collapsing margins. Do not generalize every
`overflow` value into an identical containment rule.

**Check:** Nested empty blocks, mixed negative/positive margins, and the effect of
switching a container from flow to Grid.

## S067 — Full-Bleed Layout Using CSS Grid

Source: https://www.joshwcomeau.com/css/full-bleed/

**Use:** Place ordinary article content in a capped center track with flexible side
tracks; let designated media span `1 / -1`. Keep readable text measure independent
of the width available to illustrations or demos.

**Watch:** Grid children lose ordinary sibling margin collapse. Account explicitly
for gutters and full-bleed exceptions; `100vw` shortcuts can create scrollbar-width
overflow. A full-width image may still need a cap on very wide displays.

**Check:** Narrow phones, scrollbars, long text, nested media, and whether full-bleed
content actually reaches the intended edge without horizontal scrolling.
