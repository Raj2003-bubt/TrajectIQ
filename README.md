# TrajectIQ — Space Mission Design Game

**Design a spacecraft. Operate the mission. Understand the trade-offs.**

[![Build and regression tests](https://github.com/Raj2003-bubt/TrajectIQ/actions/workflows/ci.yml/badge.svg)](https://github.com/Raj2003-bubt/TrajectIQ/actions/workflows/ci.yml)

An educational browser game developed in the NASA Space Apps Challenge 2026 project context. TrajectIQ connects spacecraft subsystem choices to consequences for energy, propulsion, data return, and mission objectives through Moon and Mars scenarios.

[Play TrajectIQ](https://trajectiq-raj2003.vercel.app/) · [Developer guide](docs/DEVELOPER_V5.md) · [Scientific model](docs/SCIENTIFIC_VALIDATION_V5.md) · [Audit](docs/PORTFOLIO_AUDIT.md)

This portfolio deployment is owned by Vercel account `raj2003-bubt` and built from this repository's `main` branch. The [original demo](https://trajectiq-omega.vercel.app/) remains independently maintained and was not modified. See the [portfolio deployment record](docs/PORTFOLIO_DEPLOYMENT.md).

## Problem and motivation

Spacecraft subsystems are often taught separately, but a mission depends on their interactions. A more capable instrument also needs power, storage, communication bandwidth, mass allowance, and budget. TrajectIQ makes these dependencies visible: build a design, inspect margins, encounter consequences, and make a targeted revision.

The teaching loop combines design validation, deterministic operations, crisis decisions, and a causal debrief. Players can compare choices under the same simulation policy. Learning gains have not been measured in a user study.

## Verified features

- Moon/Mars presets with destination-specific constants and engineering constraints.
- Seven subsystem categories, component choices, and fuel/orbit/array/battery/instrument customization.
- Live cost, mass, power, battery, storage, communication, and propulsion margins.
- Launch-readiness validation and a deterministic mission lifecycle.
- Mission events, resource-gated recovery choices, and returned-science scoring.
- Causal debrief, run comparison, and targeted redesign previews.
- State-aware offline assistant with bounded what-if experiments and explicit apply actions.
- Browser-local autosave and paused resume, including unresolved crises.
- Seeded robustness sampling with progress/cancellation and disclosed assumptions.
- Schematic WebGL spacecraft view with an SVG fallback.
- Standalone HTML, hosted offline caching after initial installation, and JSON report export.

## Moon and Mars gameplay

| Scenario | Environment and scope |
|---|---|
| Moon | 100 km Balanced starter orbit, lunar radius/GM, 1,361 W/m² reference sunlight, fixed teaching eclipse |
| Mars | 400 km starter orbit, Mars radius/GM, 586.2 W/m² reference sunlight, destination-specific altitude limits, simplified derived eclipse |

Both are simplified arrival/orbital mapping scenarios. Transport is pre-arranged and compressed. Mars gameplay does not simulate an Earth–Mars cruise, launch window, or landing.

1. Accept the mission and start with **Moon / Balanced**.
2. Change a subsystem and inspect cost, mass, power, and data margins.
3. Open **Launch readiness**, resolve blockers, and authorize launch.
4. Advance to events, choose enabled recovery actions, and resume.
5. Return at least **520 science units** while retaining battery energy; observations left onboard do not count as returned.
6. Read the debrief, preview a targeted redesign, and compare another run.

The budget is 150 fictional credits and the target is 650 game science units, with success at 80%. These values are teaching choices.

## Technology and architecture

**JavaScript ES modules · HTML/CSS · Native WebGL/SVG · Service Worker · Node.js test runner · Static Vercel hosting**

No npm runtime dependencies, backend services, accounts, API keys, or external AI calls are required.

| Module | Responsibility |
|---|---|
| `dist/data/` | NASA/JPL snapshots, provenance, fictional components, and presets |
| `dist/engine/model.js` | Normalization, constraints, model equations, events, scoring, debrief, and seeded experiments |
| `dist/engine/copilot.js`, `assistant.js` | Bounded intent parsing, grounded explanations, and engine-backed comparisons |
| `dist/ui/` | Navigation, guarded edits, checkpoints, modals, and schematic rendering |
| `dist/sw.js` | Versioned hosted offline shell |
| `scripts/build-standalone.mjs` | Self-contained HTML built from the same modules |
| `tests/` | Engine, physics, assistant, UI/GPU adapters, cache, and standalone checks |

The engine is separate from rendering. The maintained modules live in `dist` alongside the generated standalone HTML; edit modules and rebuild rather than editing the generated file.

## Offline mission assistant

The assistant is deterministic and rule-based. It uses actual design/flight state and the mission engine, rather than a general-purpose generative AI model.

Try `Review my design`, `What if fuel = 45 kg?`, `What if battery size = 125%?`, or `Compare presets`. Experiments preview original/proposed values before applying changes. Unsupported or ambiguous questions receive a limitation or clarification. English, Bangla, and common Banglish inputs are supported; the whole interface is not fully translated.

## Scientific sources and assumptions

| Category | Examples |
|---|---|
| Bundled NASA/JPL references | Body radius, GM, reference irradiance, illustrative distance ranges |
| Mathematical relations | Circular two-body period, ideal rocket equation, energy integration, unit conversion, light-time |
| Educational approximations | Contact schedules, central-shadow eclipse geometry, simplified link scaling, capture penalties |
| Fictional game parameters | Components, hardware specifications, credits, science units, event triggers, uncertainty ranges |

Snapshots are not live telemetry or current ephemerides. Mars's 225-million-km link reference is a chosen normalization, not a measured average. The robustness index measures seeded game outcomes under assumed perturbations; it is not a real spacecraft survival probability.

References: [JPL physical parameters](https://ssd.jpl.nasa.gov/sats/phys_par/sep.html), [NASA Moon Fact Sheet](https://nssdc.gsfc.nasa.gov/planetary/factsheet/moonfact.html), [NASA Mars Fact Sheet](https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html), [NASA Mars Relay Network](https://science.nasa.gov/mars/mars-relay-network/), and [NASA Glenn rocket equation](https://www1.grc.nasa.gov/beginners-guide-to-aeronautics/ideal-rocket-equation/). Equations, units, numerical cases, and omitted dynamics are in [scientific validation](docs/SCIENTIFIC_VALIDATION_V5.md).

## Run locally

For immediate desktop play, open **`dist/TRAJECTIQ_Play.html`** or use **`START_GAME.bat`** on Windows. Mobile file-preview apps may not execute HTML; use the HTTPS demo.

For development, install **Node.js 22+** and optionally **Python 3** for the local server:

```bash
git clone https://github.com/Raj2003-bubt/TrajectIQ.git
cd TrajectIQ
npm run build
npm test
npm start
```

Open `http://localhost:3000`. On Windows without `python3`, use `py -m http.server 3000 --directory dist`. No npm installation step is needed.

## Build and verification

The independent local audit passed the build and **281 tests with zero failures/skips** on Node.js 24.19.0. The history-migration workflow also passed build/tests. Regular GitHub Actions CI has been observed successful and repeats the build and regression suite on **Node.js 22 and 24**, including committed standalone-file consistency. See [the actual workflow runs](https://github.com/Raj2003-bubt/TrajectIQ/actions/workflows/ci.yml).

Production smoke testing on 18 October 2026 completed both Moon (751 returned science units) and Mars (669 units) campaigns, including launch readiness, a recovery choice, debrief, and source-linked English/Bangla assistant answers. The cloud browser used the working SVG fallback; this does not establish WebGL or real-device coverage.

Coverage includes analytic physical-model cases, energy/data conservation, duplicate-action guards, checkpoint continuity, assistant behavior, renderer lifecycle, and offline-cache contracts. Mocked UI/GPU checks do not establish complete browser, mobile, or accessibility compatibility.

## Saving, offline use, and limitations

- Saves belong to the current browser, device, and origin. Clearing site data or storage restrictions can lose/prevent saves; no cloud sync exists.
- Reload restores valid active-flight checkpoints paused. Incompatible/corrupt data is retained for explicit export/discard.
- JSON reports are read-only exports, not restore/import files.
- Hosted offline use requires a successful initial load and service-worker installation; external references need internet.
- Close all game tabs and reopen to activate cached updates; active flights are not forcibly replaced.
- The model omits n-body dynamics, complete RF budgets, realistic contact geometry, landing, and thermal/radiation effects. It is not a flight-design or flight-certified tool.
- Real-device, full visual/accessibility, and offline-update lifecycle checks remain incomplete. No flawless cross-device claim is made.

## Screenshots

Actual game screenshots are not yet committed. The live demo is linked above; no generated artwork is presented as an application capture.

## Documentation and future work

[Developer guide](docs/DEVELOPER_V5.md) · [Scientific validation](docs/SCIENTIFIC_VALIDATION_V5.md) · [Historical QA](docs/QA_V5.md) · [Requirements](docs/REQUIREMENTS.md) · [Demo paths](docs/DEMO_V5.md) · [Release notes](docs/RELEASE_NOTES_V5.md) · [Original deployment record](docs/DEPLOYMENT_V5.md)

Potential extensions include real-device verification, full localization, validated report import, history-aware navigation, and measured usability/learning studies. These are possibilities rather than completed features.

## Provenance and licensing

Republished with the owner's confirmation of permission from the original rightsholders. Original source: [Pranto-404/Trajectiq](https://github.com/Pranto-404/Trajectiq), baseline `a925ad86317ea0f336c8656de6650ff3849aa27b`. Original commit authors, history, attribution, and documentation are preserved. See [provenance](docs/PROVENANCE.md) and the [historical source README](docs/HISTORICAL_SOURCE_README.md).

Implementation includes Codex assistance. NASA/JPL sources are credited; no NASA endorsement, competition award, or publication is claimed. No new blanket code license is asserted because the reviewed source contains no license grant. Republication permission does not itself grant downstream reuse rights.
