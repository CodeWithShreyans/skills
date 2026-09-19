# Accessibility: validate the experience, not a checkbox

Use this alongside the guide for the feature being implemented. The engineering
checks below extend the source examples; they are not a claim that the articles
constitute a complete accessibility standard or compliance assessment.

- Preserve native control semantics, labels, expected keyboard behavior, and visible
  focus. A decorative effect must not become the only signal of status.
- Test zoom separately from increased browser default font size. Exercise long text
  and user text-spacing overrides; avoid clipping meaningful content.
- Provide a static usable baseline. Apply nonessential motion only when the user
  has not requested reduced motion; also stop JS-driven timers/simulations as needed.
- Keep overlays, duplicated visual assets, and decorative SVG from blocking input
  or repeating content in the accessibility tree.
- Test alternate inputs where relevant and feasible. A clickable element is not
  necessarily keyboard- or voice-operable.

## S042 — The Surprising Truth About Pixels and Accessibility

Source: https://www.joshwcomeau.com/css/surprising-truth-about-pixels-and-accessibility/

**Use:** Choose units by whether a dimension should scale with text. `rem` respects
the root font-size relationship; fixed visual details can still reasonably use
pixels. Font-relative layout thresholds can adapt when users enlarge default text.

**Watch:** Page zoom and browser default-font preferences are different tests.
Hardcoding the root font size can defeat the intended relationship. Fixed heights
can clip enlarged content, while indiscriminately scaling every dimension can also
produce poor layouts.

**Check:** Default font sizes such as 32px and 48px, narrow viewports, input text,
wrapping, and button/sidebar sizing. Avoid a universal “all pixels” or “all rems” rule.

## S066 — Hands-Free Coding

Source: https://www.joshwcomeau.com/blog/hands-free-coding/

**Use:** Take alternative input seriously: speech commands, dictation, and eye
tracking expose assumptions hidden by mouse-and-keyboard testing. Favor clear
controls, meaningful names, discoverable actions, and efficient correction paths.

**Watch:** This is a personal account of adapting a workflow, not medical advice
or a current equipment-buying guide. Do not prescribe the author's devices,
ergonomics, or working hours as a universal solution.

**Check:** Whether important actions require hovering, precise dragging, rapid
clicking, or unlabeled icons. When recommending tools, verify current platform
compatibility and ask about the person's constraints.

## S072 — Accessible Animations in React

Source: https://www.joshwcomeau.com/react/prefers-reduced-motion/

**Use:** Gate optional CSS motion with `prefers-reduced-motion: no-preference`.
For JavaScript motion in React, subscribe to `matchMedia` with `useSyncExternalStore`
and stop motion or apply final states immediately when the preference changes.
Use the animation library's maintained reduced-motion hook if it already meets
the application's SSR requirements.

**Watch:** SSR cannot read the browser media query. Supply a conservative
`getServerSnapshot` that also matches hydration, a stable browser snapshot getter,
and a subscription that removes its listener on cleanup.
Blanket near-zero duration overrides can break behavior dependent on animation
events and may miss JS-driven motion.

**Check:** Preference enabled before load and changed during use, hydration,
mount/unmount, and meaningful state feedback without spatial movement.
