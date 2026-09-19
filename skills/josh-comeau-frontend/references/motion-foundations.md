# Motion foundations: state, time, and rendering cost

Before choosing a library, identify the trigger, property, timeline, interruption
behavior, and static result. Use a transition for a state change, keyframes for a
sequence, a scroll/view timeline for scroll-linked progress, and a physics engine
when continuing velocity matters. These are choices, not a hierarchy of goodness.

Applied safeguards: keep essential actions independent of animation completion;
cancel obsolete work on unmount; test rapid reversals; honor reduced motion; inspect
layout, paint, and compositing under representative load. Do not assume all CSS,
WAAPI, SVG, or library animations run on the compositor.

## S002 — CSS vs. JavaScript

Source: https://www.joshwcomeau.com/animation/css-vs-javascript/

**Use:** Distinguish a JavaScript frame loop from JavaScript that delegates animation
to browser facilities. Execution thread and the animated property matter more than
the language used to declare the effect. Prefer CSS for effects it expresses well.

**Watch:** Layout/paint-heavy properties remain costly even with native animation.
Library clocks may handle blocked frames differently; elapsed-time fidelity and
visual smoothness are separate requirements. Library behavior is version-specific.

**Check:** Introduce main-thread load, compare completion timing, inspect paint/layout,
and verify actual library delegation before claiming an off-main-thread benefit.

## S003 — Scroll-Driven Animations

Source: https://www.joshwcomeau.com/animation/scroll-driven-animations/

**Use:** Map keyframes to progress rather than elapsed time: `scroll()` tracks a
scroll container; `view()` tracks an element passing through a scrollport. Set
`animation-range` deliberately, and use named timelines/scope for linked elements.

**Watch:** Entry, exit, cover, and contain describe different geometry. Fill behavior
affects the period outside the active range. Set timeline longhands after an
`animation` shorthand that could reset them. A scroll-triggered playback is not the
same as continuous scroll-linked progress.

**Check:** Short and tall elements, reverse scrolling, the actual scrolling ancestor,
reduced motion, and visibility when timelines or a polyfill are unavailable.

## S008 — Springs and Bounces in Native CSS

Source: https://www.joshwcomeau.com/animation/linear-timing-function/

**Use:** Approximate complex easing with `linear()` sample points. Reuse a small set
of motion tokens pairing each sampled curve with an appropriate duration, and keep
a simpler timing-function fallback.

**Watch:** A sampled spring is still duration-based. It does not preserve physical
velocity when retargeted; CSS transition reversal can shorten its duration and
distort the intended physics. Overshoot values outside zero-to-one can be intentional.

**Check:** Fast repeated toggles, truncated transitions, token reuse, and stylesheet
size. Choose actual spring integration when interaction depends on momentum.

## S013 — Partial Keyframes

Source: https://www.joshwcomeau.com/animation/partial-keyframes/

**Use:** Omit an endpoint when the element's underlying style should supply it.
A fade-in can start at zero and end at the element's own resting opacity rather
than forcing every element to become fully opaque.

**Watch:** An omitted value is not simply zero or a copied initial constant.
Multiple animations can influence the underlying value; animation order and which
properties each animation supplies matter. Custom properties can parameterize one
shared keyframe definition.

**Check:** Different resting styles, simultaneous animations, start/end fill behavior,
and whether the final style remains correct after removing the animation.

## S051 — An Interactive Guide to Keyframe Animations

Source: https://www.joshwcomeau.com/animation/keyframe-animations/

**Use:** Separate the keyframe definition from duration, easing, delay, iteration,
direction, and fill. Use `alternate` for a reversing loop and semantic custom
properties for per-instance amplitude or timing.

**Watch:** Easing applies between keyframe stops. `backwards` covers the delay with
the appropriate starting frame; `forwards` retains the final sampled state, not an
ordinary permanent rewrite of the stylesheet. Alternate directions affect which
frame is final.

**Check:** Initial-delay flashes, duplicate keyframe names, interrupted/remounted
elements, and a usable static state without the animation.

## S052 — The World of CSS Transforms

Source: https://www.joshwcomeau.com/css/transforms/

**Use:** Transform the visual box without asking surrounding normal-flow content to
relayout. Translation percentages relate to the transform reference box; origin and
function order determine the resulting geometry.

**Watch:** Scaling also scales rendered content. Ordinary non-replaced inline boxes
do not behave like transformable blocks. Transforms can introduce stacking and
containing-block consequences; visual displacement does not reserve layout space.

**Check:** Overflow, neighboring content, hit targets, transformed ancestors, and
composed operations. Use separate wrappers or individual transform properties when
independent effects would otherwise overwrite one another.

## S059 — An Interactive Guide to CSS Transitions

Source: https://www.joshwcomeau.com/animation/css-transitions/

**Use:** Animate a meaningful state change and choose easing for the action: entry,
exit, or continuous movement. Separate enter/leave duration and delay when that makes
the interaction more forgiving.

**Watch:** Moving the hovered element out from under the pointer can repeatedly
toggle hover. Keep a stable interactive wrapper and animate its child. Prefer named
transition properties over an indiscriminate `all`; use `will-change` only when
profiling justifies the resource cost.

**Check:** Slow pointer entry at edges, keyboard activation, touch, interrupted state
changes, and reduced-motion behavior.

## S068 — A Friendly Introduction to Spring Physics

Source: https://www.joshwcomeau.com/animation/a-friendly-introduction-to-spring-physics/

**Use:** Tune mass, stiffness/tension, and damping/friction instead of guessing a
duration. A spring can feel responsive without visibly bouncing; damping controls
how oscillation settles.

**Watch:** Parameter names and units vary between libraries. A stronger spring is
not simply “a shorter CSS transition”. Native sampled easing covers some use cases
but is not a continuously simulated spring.

**Check:** Large versus small displacements, interactive retargeting, settlement time,
and whether the motion is suitable for the product rather than merely impressive.

## S088 — Animating the Unanimatable

Source: https://www.joshwcomeau.com/react/animating-the-unanimatable/

**Use:** Prefer current React `<ViewTransition>` or the project's maintained layout
animation integration when it fits the interaction and framework. For custom FLIP,
record old bounds, update layout, measure new bounds, invert with a transform, then
animate to the natural position. Stable identity connects the measurements.

**Watch:** React View Transitions activate for supported transition/Suspense updates,
not arbitrary synchronous state changes. Current Next.js App Router needs no
experimental flag or manual `react@canary` install. For manual FLIP, use explicit DOM
refs and pre-paint layout effects—not removed `findDOMNode`, string refs, or legacy
lifecycles. Batch measurements and writes.

**Check:** Reorders, insertion/removal, scrolling, resizing, interrupted animations,
and focus preservation. Skip the visual movement when reduced motion is requested.
