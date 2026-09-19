# Engineering practice: readable, evidence-based decisions

Use these lessons to support the user's task, not to expand its scope. Preserve
existing product choices and authorized boundaries. Opinions and personal
experiences inform trade-offs; they are not proofs about all teams or forecasts
about present labor markets.

## S015 — The Post-Developer Era

Source: https://www.joshwcomeau.com/blog/the-post-developer-era/

**Use:** Treat AI output as something to understand, review, and test. Compare
observable delivery quality and elapsed work with the subjective feeling of speed.
Separate generating code from owning the complete product problem.

**Watch:** This is a dated argument about AI and employment, not a current hiring
dataset or a guarantee of future demand. Productivity studies and anecdotes have
different scopes and limitations.

**Check:** Can the developer explain the generated solution, reproduce its behavior,
and detect incorrect assumptions? Verify current claims independently if the user
asks about today's tools, studies, or job market.

## S032 — The End of Front-End Development

Source: https://www.joshwcomeau.com/blog/the-end-of-frontend-development/

**Use:** Distinguish a convincing isolated demo from maintaining a real application
with product constraints. Use AI to ask questions and explore ideas without skipping
the understanding required to assess its answers.

**Watch:** The author's augmentation-versus-replacement thesis is an opinion from
its publication context. Do not turn it into a promise about employment or use old
model capabilities to characterize current systems.

**Check:** Explain generated code, deliberately test edge cases, and verify uncertain
technical claims against primary sources rather than trusting confident output.

## S043 — You Don’t Need a UI Framework

Source: https://www.smashingmagazine.com/2022/05/you-dont-need-ui-framework/

**Use:** Compare the cost of adapting a styled component framework with the product's
need for a distinctive design. Accessible headless primitives can provide complex
interaction behavior without imposing all visual choices.

**Watch:** The argument includes exceptions such as internal tools and team
familiarity. It is not permission to replace an existing framework, hand-roll an
inaccessible complex control, or copy another product's branding and assets.

**Check:** Design divergence, customization effort, accessibility ownership, and
team expertise. Use reference designs to study principles while creating original work.

## S053 — How To Learn Stuff Quickly

Source: https://www.joshwcomeau.com/blog/how-to-learn-stuff-quickly/

**Use:** Alternate guided study with independent construction. Predict what a
change will do, deliberately remove or alter part of an example, and explain the
observed outcome. Extend a tutorial, then build a related project without its script.

**Watch:** Repeatedly following instructions can feel fluent without building
retrieval or problem-solving ability. Daily habits, spaced repetition, and public
artifacts are options, not moral requirements or assumptions about available time.

**Check:** Can the learner rebuild the mechanism, debug an intentional defect,
and transfer the idea to a different problem?

## S057 — The Importance of Learning CSS

Source: https://www.joshwcomeau.com/css/the-importance-of-learning-css/

**Use:** Invest in CSS mechanisms alongside JavaScript: layout, stacking,
containment, and the cascade often determine whether a UI can be implemented
confidently. Turn surprising behavior into an experiment rather than a snippet hunt.

**Watch:** A framework or styling abstraction does not remove the browser's layout
rules. Career benefits described in the article are motivational observations,
not guaranteed outcomes.

**Check:** Can the agent explain why a fix works without naming only the declaration
it changed? Reproduce the mechanism with fewer elements before generalizing it.

## S073 — Why My Blog is Closed-Source

Source: https://www.joshwcomeau.com/blog/why-my-blog-is-closed-source/

**Use:** Respect the boundary between publicly shared techniques and a private
product implementation. Publication decisions include draft privacy, maintenance
cost, contextual assumptions, and unwanted copying.

**Watch:** Public access is not blanket permission to republish articles or assets.
Do not imply endorsement or recreate a private codebase from visible output.
Closed source is also not a substitute for security controls; that is an engineering
qualification, not an inference that the source advocates omitting them.

**Check:** Attribution, applicable asset/code permissions, excluded drafts/secrets,
and whether original explanatory notes suffice instead of copying source material.

## S081 — Effective Collaboration with Product and Design

Source: https://www.joshwcomeau.com/career/effective-collaboration/

**Use:** Surface implementation constraints early and offer concrete alternatives
that preserve the underlying user outcome. Discuss scope, staffing, and time as
trade-offs. Treat design details as intentional work rather than dismissing them
as “nits”.

**Watch:** An elegant technical workaround can solve the wrong problem if the
requirement was never clarified. Collaboration is not authorization for hidden
scope expansion or unapproved production changes.

**Check:** Shared acceptance criteria, explicit trade-offs, designer review where
available, and communication about deviations before investing in a costly workaround.

## S085 — Clever Code Considered Harmful

Source: https://www.joshwcomeau.com/career/clever-code-considered-harmful/

**Use:** Optimize for the next maintainer's understanding. Prefer straightforward
control flow and well-named intermediate values when a clever abstraction saves
characters but obscures intent. Isolate necessary complexity behind a clear API.

**Watch:** Brevity is not the same as simplicity, and duplication removal is not
automatically a net benefit. Conversely, familiar abstractions can be clearer than
repeating low-level mechanics; the point is comprehensibility, not banning techniques.

**Check:** Could a less-experienced teammate trace the happy path, failure path,
and modification point without reconstructing an elaborate mental model?
