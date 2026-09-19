# Motion recipes: tasteful, bounded enhancements

Use these only when they fit the requested design. Pick the smallest effect that
communicates feedback or character. A decorative layer should be hidden from the
accessibility tree when appropriate and must not capture input. Preserve native
controls and their labels beneath custom visuals.

Applied safeguards beyond the demos: bound particle counts; stop offscreen/background
work where appropriate; clean up timers/listeners/audio; make the first SSR and client
render deterministic; provide a reduced-motion/static variant. Test multiple instances.

## S004 — Squash and Stretch

Source: https://www.joshwcomeau.com/animation/squash-and-stretch/

**Use:** Coordinate deformation with travel to communicate acceleration or impact.
Stretching an arrow can include a narrower arrowhead, not merely a longer shaft.
For a bouncing shape, put the transform origin where contact should remain stable.

**Watch:** SVG path morphs need compatible path structure or a capable interpolator.
CSS `d: path()` and a library's path interpolation have different support and
execution characteristics. A transient trigger can feel better than a held hover state.

**Check:** Keyboard and pointer triggers, interruption, compatible endpoints, and a
non-deforming reduced-motion alternative.

## S006 — Sprites on the Web

Source: https://www.joshwcomeau.com/animation/sprites/

**Use:** Show discrete frames from a sprite sheet for artwork that is naturally
frame-based. Match image sizing, crop, position range, and `steps()` semantics to
the actual number of frames.

**Watch:** Endpoint treatment matters: a continuously looping animation may never
display a terminal frame with the wrong jump mode. Sprites trade procedural
variation and smooth interruption for pre-rendered art, file size, and texture cost.

**Check:** First/last frame, wraparound, retina sizing, network cost, pause/replay, and
a meaningful still image. Do not assume a sprite is faster than a small procedural effect.

## S010 — Color Shifting in CSS

Source: https://www.joshwcomeau.com/animation/color-shifting/

**Use:** Animate an actual hue parameter or filter when the goal is travel around
the color wheel. Equivalent endpoint colors, such as hues a full turn apart, do
not by themselves communicate that travel to a color transition.

**Watch:** `hue-rotate()` is not identical to changing HSL hue and can alter apparent
brightness. A registered angle custom property can drive hue explicitly but may
repaint the element. Twinkle and fade animations sharing opacity need deliberate
ordering and endpoint behavior.

**Check:** Contrast, oversaturated/dark phases, concurrent animations, and the cost of
many independently animated particles.

## S016 — A Million Little Secrets

Source: https://www.joshwcomeau.com/blog/whimsical-animations/

**Use:** Treat the landing-page tour as a toolbox: polar coordinates constrain a
particle burst, sprite atlases package artwork, and varied or paired audio samples
can reinforce tactile interaction. Separate simulation from presentation.

**Watch:** These are optional product-specific flourishes, not requirements for every
site. Randomness, sound, physics, and layered filters create cumulative complexity.
Do not reproduce the author's branded assets or entire page.

**Check:** Bounded work, predictable core controls, mute/reduced-motion preferences,
and whether each flourish improves the user's task. Validate asset licenses separately.

## S030 — Animated Pride Flags

Source: https://www.joshwcomeau.com/animation/pride-flags/

**Use:** Divide a flag into narrow columns with matching hard-stop color bands,
then stagger vertical oscillation to suggest a wave. Negative delays initialize a
loop partway through rather than revealing sequential startup.

**Watch:** Fractional column widths can expose seams. Billow magnitude and phase can
vary independently; doubling animation direction changes the effective full cycle.
Keep the flag's meaning available without relying on motion.

**Check:** Several flag palettes, column counts, device-pixel ratios, responsive
widths, and a still reduced-motion rendering.

## S056 — Building a Magical 3D Button

Source: https://www.joshwcomeau.com/animation/3d-button/

**Use:** Keep a native button as the stable hit target; move its visible front layer
above an edge and shadow. Use quick press feedback and a more expressive release,
while leaving an in-flow layer to determine dimensions.

**Watch:** Styling away focus or tap feedback is safe only if an effective replacement
remains. Hover, focus, active, and disabled are different states. Dramatic depth
is not automatically appropriate for every product.

**Check:** Space/Enter activation, pointer cancellation, long labels, touch, repeated
presses, visible focus, and reduced motion.

## S064 — Boop!

Source: https://www.joshwcomeau.com/react/boop/

**Use:** Separate the event trigger from the animated target so hovering a button
can briefly nudge its icon. A reusable hook can own timing and spring values while
the component owns semantics and placement.

**Watch:** Clean up the reset timer and use the animation library's appropriate
animated element. Decide whether repeated triggers restart, overlap, or are ignored;
do not let stale timers reset a newer interaction unexpectedly.

**Check:** Rapid re-entry, unmount mid-boop, multiple instances, keyboard alternatives,
and suppressed transforms under reduced motion.

## S070 — Animated Sparkles in React

Source: https://www.joshwcomeau.com/react/animated-sparkles-in-react/

**Use:** Generate short-lived particles around content, then let CSS animate their
scale and rotation. Separate transform responsibilities across wrappers when needed,
and remove expired particles rather than accumulating invisible DOM nodes.

**Watch:** Random render-time values can mismatch during hydration. Use deterministic
initial content or introduce decoration after mount. Avoid a wrapper that changes
the semantic importance of arbitrary children merely to make them sparkle.

**Check:** Timer cleanup, particle ceilings, inline wrapping, offscreen suspension,
pointer access, and static decoration for reduced motion.

## S077 — Announcing “use-sound”, a React Hook for Sound Effects

Source: https://www.joshwcomeau.com/react/announcing-use-sound-react-hook/

**Use:** Attach subtle, user-triggered feedback to existing interactions. Prepare
samples for prompt onset and suitable volume; choose interruption or overlap
deliberately. Audio sprites can organize multiple samples.

**Watch:** All information and actions must remain available silently. Provide an
accessible persistent sound preference, respect playback restrictions, and avoid
autoplay surprises. Audio sample licensing is independent of library licensing.

**Check:** Muted behavior, rapid triggers, stop/pause, loading failure, keyboard
activation, and persistence when browser storage is unavailable.

## S082 — Magical Rainbow Gradients

Source: https://www.joshwcomeau.com/react/rainbow-button/

**Use:** Animate typed custom-property color stops rather than sliding an oversized
background or assuming arbitrary gradient images interpolate. Keep the color
generator separate from the component that consumes the colors.

**Watch:** Property registration is global. Avoid accidental name collisions or
duplicate-registration failures, especially across instances and development mounts.
An animated gradient is paint work, not automatically a compositor-only effect.

**Check:** Feature detection, small bounded repaint regions, timer cleanup, multiple
buttons, and a static reduced-motion/unsupported-browser palette.

## S086 — Folding the DOM

Source: https://www.joshwcomeau.com/react/folding-the-dom/

**Use:** Build a fold illusion from aligned clipped surfaces, a hinge origin,
perspective, and coordinated front/back faces. Add shading only after the geometry
and alignment work.

**Watch:** Repeated visual copies should not repeat the accessible content.
`backface-visibility`, 3D preservation, clipping, and tiny depth offsets interact;
this is a specialized illusion, not a general layout primitive.

**Check:** Open, closed, edge-on, resizing, image loading, stacking, one meaningful
accessible image, and a readable non-animated alternative.
