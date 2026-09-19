# SVG: reason in drawing coordinates

Choose simple shape primitives before paths. Establish a stable `viewBox`, decide
whether strokes scale, and keep geometry separate from event/state management.
Applied safeguards: hide decorative graphics from assistive technology; provide
meaningful labeling when the graphic conveys information; give interactive handles
keyboard operation; translate pointer coordinates into SVG coordinates rather than
assuming CSS pixels equal drawing units.

## S011 — An Interactive Guide to SVG Paths

Source: https://www.joshwcomeau.com/svg/interactive-guide-to-paths/

**Use:** Read `d` as sequential drawing instructions: move, line, quadratic/cubic
curve, elliptical arc, and close. Uppercase commands use absolute coordinates;
lowercase commands are relative. Curve control points shape tangents rather than
marking points the path must pass through.

**Watch:** Arc radii, rotation, large-arc flag, and sweep flag select among different
valid arcs. `Z` closes the contour and influences joins. Smooth shorthand reflects
the previous appropriate control point, so preceding commands matter.

**Check:** Degenerate geometry, open versus closed paths, stroke joins, scale changes,
and compatible command structures before attempting a path morph.

## S012 — A Friendly Introduction to SVG

Source: https://www.joshwcomeau.com/svg/friendly-introduction-to-svg/

**Use:** Work with native lines, rectangles, circles, ellipses, and polygons in the
SVG coordinate system. A `viewBox` decouples drawing coordinates from rendered
dimensions. Fill and stroke are separate visual controls.

**Watch:** Zero-sized shapes may disappear rather than render a useful line.
Dash patterns and offsets follow the path; `pathLength` can normalize values for
draw-on effects. CSS overrides of presentation attributes still follow the cascade.

**Check:** Aspect-ratio behavior, clipping at edges, stroke width, normalized dash
endpoints, and static accessibility before adding animation.

## S087 — Dynamic Bézier Curves

Source: https://www.joshwcomeau.com/animation/dynamic-bezier-curves/

**Use:** Derive path coordinates from normalized interaction progress. For a curve
that flattens on scroll, map progress to its control-point displacement and keep
the scroll measurement separate from the SVG drawing.

**Watch:** Normalize against the actual scrollable region, account for offsets, and
clamp progress when appropriate. The source's class components are historical;
preserve the geometry rather than copying old lifecycle wiring. A small React
update may be acceptable—measure before bypassing React.

**Check:** Resize, nested scrolling, zero scroll range, pointer-to-SVG mapping,
listener cleanup, and reduced-motion behavior.
