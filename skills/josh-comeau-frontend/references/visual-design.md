# Visual design: coherent systems, not isolated effects

Start with the product's existing typography, spacing, color, and elevation tokens.
Compare visual output at a fixed viewport before changing details. Keep the layout
solution separate from optical corrections, and test decoration against real text
and controls rather than only a pristine demo.

## S005 — Sneaky Header Blocker Trick

Source: https://www.joshwcomeau.com/css/header-blockers/

**Use:** A transparent fixed header can appear to change background using separately
colored sticky blockers within underlying sections. Layer content, blocker, decorative
boundary shapes, and header deliberately rather than measuring scroll every frame.

**Watch:** Blockers need physical space when they are not covering content. This is
a layout-dependent illusion, not a drop-in replacement for every sticky header.

**Check:** Fast scrolling in both directions, section boundaries, enlarged text,
header-height changes, and pointer access beneath decorative blockers.

## S018 — Next-level frosted glass with backdrop-filter

Source: https://www.joshwcomeau.com/css/backdrop-filter/

**Use:** Extend the blur layer beyond the visible glass region so nearby backdrop
pixels contribute, then mask the result. Separate the visual layer from interactive
header content and use a tint to preserve contrast.

**Watch:** Masked-out pixels do not remove the element's hit area; use
`pointer-events: none` on decoration. Expanded layers change where rounded edges
land. The source documents engine-specific sticky/overflow and overscroll issues,
which require reproduction rather than unconditional workarounds.

**Check:** Click and scroll under the masked region, abrupt top-edge changes, light
and dark content, and a readable fallback without blur.

## S035 — Color Formats in CSS

Source: https://www.joshwcomeau.com/css/color-formats/

**Use:** Choose a representation that makes the intended adjustment legible: RGB for
channels, HSL for intuitive hue/saturation/lightness controls, and perceptual or
wide-gamut formats when their properties matter. Keep semantic tokens separate from
their numerical representation.

**Watch:** HSL lightness is not perceptual uniformity; two equally light HSL colors
need not have equal contrast. Changing syntax alone does not enlarge a display's
gamut. The article's “too early to adopt” judgments are time-dependent.

**Check:** Real text contrast, fallback colors, alpha compositing, and display gamut
before replacing the project's palette wholesale.

## S047 — Make Beautiful Gradients

Source: https://www.joshwcomeau.com/css/make-beautiful-gradients/

**Use:** Inspect interpolation, not only endpoint colors, when a gradient develops a
dull midpoint. Choose an appropriate interpolation space or generate intermediate
stops; use an ordinary fallback before an enhanced gradient declaration.

**Watch:** Merely spelling endpoints in HSL does not select HSL interpolation.
Perceptual spaces and hue paths produce different results; none is universally best.
The source has been updated to include native color-space interpolation.

**Check:** Midpoint saturation, banding, text contrast across the full surface, and
the unsupported-syntax fallback.

## S049 — Introducing “Shadow Palette Generator”

Source: https://www.joshwcomeau.com/css/introducing-shadow-palette-generator/

**Use:** Create a coordinated elevation palette instead of tuning every shadow in
isolation. Expose a few semantic levels and adapt the tint to the surrounding surface.

**Watch:** A derived custom property is resolved where it is defined. Overriding only
a color variable on a descendant may not recompute an inherited shadow token;
redeclare the dependent value at the appropriate scope.

**Check:** Nested surfaces, dark/light themes, and elevation hierarchy. Treat the
generator's output as a starting palette, not a required runtime dependency or
guarantee of suitable contrast.

## S050 — Designing Beautiful Shadows in CSS

Source: https://www.joshwcomeau.com/css/designing-shadows/

**Use:** Maintain a consistent imagined light source. Coordinate offset, blur, and
opacity with elevation; layer modest shadows and tint them toward the surface rather
than applying generic black everywhere.

**Watch:** More layers add rendering work. `box-shadow` follows the box, whereas
`drop-shadow()` follows rendered alpha; they solve different shape problems and can
introduce different compositing behavior.

**Check:** Small and large elevations, transparent assets, dark backgrounds, and
performance when many shadowed elements move simultaneously.

## S065 — Chasing the Pixel-Perfect Dream

Source: https://www.joshwcomeau.com/css/pixel-perfection/

**Use:** Aim for faithful visual relationships, including spacing, type rhythm, and
optical alignment. Compare screenshots and actual browser boxes; design-tool
measurements can include different font metrics or line-box assumptions.

**Watch:** Cross-platform rasterization makes literal pixel identity unrealistic.
Small transforms can correct optical imbalance but should not disguise broken
layout, depend on one particular label, or change the intended interaction area.

**Check:** The correct font and weights, multiline content, browser differences, and
designer agreement on intentional deviations. Treat polish requests respectfully.

## S075 — CSS Variables for React Devs

Source: https://www.joshwcomeau.com/css/css-variables-for-react-devs/

**Use:** Pass dynamic values through custom properties while CSS owns responsive
rules and visual relationships. Local overrides, inherited tokens, and pre-hydration
theme updates can avoid unnecessary React-mediated styling work.

**Watch:** Custom properties are runtime cascading values, not textual JavaScript
substitution; they cannot be inserted into ordinary media-query conditions. Untyped
custom properties do not gain smooth interpolation merely by using `transition`.

**Check:** Scope, computed-value dependencies, fallbacks, units supplied by React,
and property registration when animating a value. Keep the project's existing styling
tool unless there is a concrete migration requirement.
