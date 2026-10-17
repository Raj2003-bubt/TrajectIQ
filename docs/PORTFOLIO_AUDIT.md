# Portfolio engineering audit — 17–18 October 2026

## Baseline and migration

- Source: `Pranto-404/Trajectiq`, main `a925ad86317ea0f336c8656de6650ff3849aa27b`.
- Source tree: `910eb1911246059537221ef73b8add5d429448c2`; three original commits and 52 tracked files.
- Target: existing public `Raj2003-bubt/TrajectIQ`, repository ID `1423535532`, initially empty.
- Import merge: `5366d5141ad5757b74e07399fb6e5e2e8746b40b`; both bootstrap and original-source parents retained.
- One-time migration workflow run `39056665170`: **success**. It compared the exact source head/tree, verified file equality except its own helper, built the standalone game, ran 281 tests, and pushed without force.
- An independent local Git fetch confirmed the original source head is an ancestor of target main and that the imported source files have no unintended differences.
- Original source and the original Vercel project were not modified. The writable migration helper was replaced by read-only CI.

## Newly executed checks

| Check | Result |
|---|---|
| Local `npm run build` | Passed; standalone regeneration has no baseline diff |
| Local `npm test` | 281 passed; zero failed/cancelled/skipped, Node.js 24.19.0 on Linux |
| GitHub migration build/tests | Passed in run 39056665170 |
| Regular CI | Node.js 22/24 build, regression suite, and committed-generated-file check configured with read-only permissions and pinned actions |
| Scientific source recheck | Bundled Moon/Mars radius, GM, reference sunlight, and distance examples agree with retrieved NASA/JPL references |

These are independently executed results, separate from historical QA logs. Model tests check stated equations and assumptions, not flight-prediction accuracy. Mocked browser/GPU checks do not establish real-device compatibility, full accessibility compliance, or mission reliability.

## Portfolio maintenance

The README now explains the problem, architecture, verified features, setup, deterministic assistant, scientific categories, and limitations. The original README and historical attribution are preserved. Node.js >=22 is declared. Gameplay, physics, assistant logic, save schema, and Vercel configuration were not changed.

Actual game screenshots are not yet committed. Expanded real-device, visual/accessibility, and offline-update lifecycle checks remain open. A separate Vercel production project has not been created; its owning account/team requires explicit approval. The linked existing demo remains independent.

## Primary references rechecked

- https://ssd.jpl.nasa.gov/sats/phys_par/sep.html — Moon radius/GM and Mars MAR097 GM.
- https://nssdc.gsfc.nasa.gov/planetary/factsheet/moonfact.html — lunar reference sunlight and distances.
- https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html — Mars radius and sunlight.
- https://science.nasa.gov/mars/mars-relay-network/ — illustrative near/far Earth–Mars distances.
- https://www1.grc.nasa.gov/beginners-guide-to-aeronautics/ideal-rocket-equation/ — ideal rocket equation.

The 225-million-km Mars normalization and fictional hardware/schedules/scoring remain explicit teaching assumptions. No physical constants or uncertainty ranges were silently replaced.
