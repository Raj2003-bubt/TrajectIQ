# TrajectIQ upstream integration audit — 20 November 2026

## Scope and release state

Review branch: `feat/upstream-react-integration-20261120`. Production release is pending explicit owner approval and deployment verification. The original team repository and deployment are read-only sources in this task.

Authenticated GitHub identity: `Raj2003-bubt`; repository pull/push/admin permission was verified. Existing documentation branch `docs/team-project-presentation-20261120` had no README difference from main and no open TrajectIQ PR was found at task start.

## History and migration strategy

- Portfolio baseline: `fb6bfbf72badc6974d547d63ba76916e973de081`.
- Team baseline: `3bfe390c028e909d492c34fc09fbd4eb80f1ea51`.
- Common ancestor: `a925ad86317ea0f336c8656de6650ff3849aa27b`.
- Divergence: 11 portfolio-only and 97 upstream-only commits.
- Source comparison: 353 changed files; 29,544 inserted and 589 deleted text lines (binary changes counted separately by Git).
- Remote safety checkpoint: `safety/pre-upstream-update-20261120`, exactly at the portfolio baseline.

A normal two-parent merge is appropriate because the portfolio-specific code changes were limited to CI and the Node engine declaration; application source still matched the common ancestor. Only README, package.json and CI conflicted. The merge retains all upstream contributor history and the existing portfolio documentation. No force-push, history replacement, repository recreation or upstream mutation is used.

## Architecture and functionality comparison

| Area | Previous portfolio main | Reviewed upstream / integration |
|---|---|---|
| UI and build | Vanilla ES modules, static dist/, no npm dependency install | React 19/Vite 8, Zustand, Motion, CSS modules; lockfile install; generated site/ |
| Destinations | Moon, Mars | Moon, Mars, Earth, Mercury, Venus, Vesta, Ceres, Europa |
| Scenarios | Earlier Moon/Mars presets | Ten named mission scenarios, three difficulties, Solo/Crew/Sandbox |
| Mission engine | v5 mission loop and fixed lunar eclipse | Expanded body catalogue, computed eclipse, schedule and launch/orbit checks, crew decisions, weighted score/replay |
| Rendering | Native schematic WebGL/SVG | Persistent Three.js/R3F/Drei scene, local textures, adaptive quality, SVG fallback |
| Assistant | Local deterministic rules | Expanded local assistant plus optional same-origin serverless Gemini backup |
| Storage | Legacy browser checkpoint | Validated legacy-save migration, React state, mission codes and local archive |
| Offline | Legacy single-file build and worker | New React standalone with SVG, hashed hosted assets, generated precache worker; archived legacy standalone retained |
| Responsive/accessibility | Prior CSS and modal guards | Responsive shell/hangar, theme and motion preferences, dialog/focus primitives; device verification remains distinct |
| Deployment | outputDirectory dist; static | outputDirectory site; npm ci; optional api/assist.js and server-only key |
| Tests | 281 historical tests | 396 Node + 374 Vitest checks in the fresh local run |
| Attribution | NASA/JPL references and original source history | Expanded body/mission provenance, NASA textures, OFL font notices and original source history |

The source's declared npm version is still 6.0.0 although documentation uses v7/v8 feature labels; no version number was invented. Older reports contain superseded dependency counts, team placeholders and verification totals, and are preserved as historical records.

## Integration changes beyond upstream

1. Rewrite the portfolio README for current commands, team identity, architecture, source credit and honest validation scope.
2. Preserve portfolio audit, deployment and provenance records; append the new checkpoint.
3. Fix `npm start`, `npm run standalone` and the Windows launcher to target the current React edition rather than silently opening the legacy app.
4. Extend read-only CI to integration branches, Linux Node 22/24 and Windows Node 24; disable persisted checkout credentials and avoid duplicate artifact names.
5. Correct an outdated AI client comment that claimed requests were only button-triggered; actual upstream behavior includes automatic fallback when enabled.

No unnecessary engine rewrite or dependency substitution was performed. Upstream pins and lockfile installed successfully and returned zero reported vulnerabilities, so they were retained.

## Validation evidence

Runtime: Linux, Node 24.22.3, npm 11.19.1. Both the pristine upstream worktree and merged worktree were checked independently.

| Check | Result |
|---|---|
| npm ci --ignore-scripts | PASS in both worktrees |
| npm run build | PASS: hosted app, worker, current standalone |
| npm test | PASS in both worktrees: 396 Node and 374 Vitest tests |
| npm audit --json | PASS: zero reported vulnerabilities in the audited lockfile |
| Legacy standalone equality | PASS: retained upstream archived artifact unchanged |
| Git diff whitespace check | PASS |
| Browser end-to-end command | NOT CONFIGURED in upstream; scripts/e2e.mjs exits nonzero rather than claiming a pass |
| Live provider response | NOT TESTED; no key configured or paid API call made |
| Physical mobile/Safari/screen reader | NOT TESTED |

Build warnings: the renderer chunk exceeds the 700 KB advisory threshold. Total hosted JavaScript is approximately 2,008 KB raw / 617 KB gzip; total CSS approximately 130 KB raw / 26 KB gzip; current standalone approximately 1,346 KB. These are all emitted JS files together, not measured initial transfer or a performance benchmark. jsdom emits expected canvas-not-implemented notices; component tests cannot establish working WebGL.

## Findings and release gates

| Severity | Finding | Disposition |
|---|---|---|
| High release blocker | Vercel default scope resolves to the old prantom team and returns 403; an explicit personal-ID lookup also returned 403 | Do not authorize the unrelated team. Correct-account identity is verified, but project settings/source/deployment must be verified before production release |
| High release blocker | Architecture requires site/ output, current lockfile install and valid Node version | Repository config updated; confirm project-level overrides and exact source commit at release |
| Medium | Upstream start/standalone/Windows launcher lead to legacy edition | Fixed in this branch |
| Medium | Browser e2e script is a placeholder | Disclosed; no automated browser result invented |
| Medium | AI backup may send unanswered prompts and short context automatically | Accurately disclosed; no credentials added; generated answers remain labelled |
| Medium | In-memory AI limiter is per-instance, not a global quota | Documented; provider quota/spend controls required before enabling public paid use |
| Medium | Heavy renderer bundle and incomplete real-device matrix | Recorded; avoid claiming broad device compatibility |
| Low | Upstream README mixes historical and current claims | Replaced with a current portfolio README, retaining historical documents |
| Decision | No blanket source-code license | Existing notices retained; no new license assigned |

## Deployment checklist after approval

1. Review and approve this PR; check its exact head and successful CI runs.
2. Verify account `raj2003-bubt`, project `trajectiq-raj2003` (`prj_TbBFdc1jr9AczsLH8dJyBckdTbyZ`) and source `Raj2003-bubt/TrajectIQ`.
3. Verify the production branch is main, output is site, install is npm ci --ignore-scripts and supported Node is selected. Resolve any project-level overrides.
4. Review any available preview, including launch/crisis/debrief, save/reload, desktop/mobile, fallback and service-worker upgrade.
5. Merge only after explicit release approval; verify deployment metadata points to the approved commit and the existing production domain.
6. Keep AI backup unconfigured unless separately enabled with server-only credentials and an appropriate provider quota.
7. If needed, roll back through Vercel to the prior known deployment or a normal Git revert; retain the safety branch.

This report records integration evidence, not production-release completion.

## Publication follow-up — 21 November 2026

Application review: [draft PR #2](https://github.com/Raj2003-bubt/TrajectIQ/pull/2). Main remains at `fb6bfbf72badc6974d547d63ba76916e973de081`. No main merge or manual production deployment was performed.

The owner explicitly approved the one-time branch-publication workflow. The first run passed validation but GitHub rejected its push because the Actions token cannot change workflow files. The revised run [44749920293](https://github.com/Raj2003-bubt/TrajectIQ/actions/runs/44749920293) passed and published application history with baseline CI unchanged. The connected GitHub account then restored the reviewed read-only CI. Application commit `136e753700b3b4c4a7e8868510622f0d7c19a437` has tree `c2a29545404b2f878ae670b789295ee1a0999358`, exactly matching the locally reviewed source. Its merge ancestor retains the original portfolio and team parents.

[PR CI run 44750288537](https://github.com/Raj2003-bubt/TrajectIQ/actions/runs/44750288537) and [push CI run 44750241415](https://github.com/Raj2003-bubt/TrajectIQ/actions/runs/44750241415) succeeded at that application commit. The PR matrix passed Linux Node 22, Linux Node 24 and Windows Node 24. Windows CI is not a physical Windows browser or GPU test.

The documentation follow-up incorporates the genuine screenshots from PR #1, keeps the React README and corrects clone instructions to select the review branch. Its tree intentionally differs by documentation and image files; application and CI source are unchanged. The original documentation branch remains available as historical evidence.

### Public browser observations

The original team deployment exposed eight destinations and ten scenarios. A Lunar Polar mission completed with 602/650 science, 278 MB data, 86% battery and grade A (847/1000). Reloading and reopening the report preserved the result. The local design assistant ran 22 candidate simulations and recommended CompactBus. SVG fallback was observed; no live AI provider call or real WebGL result is claimed.

The screenshots distinguish the original team React deployment from the user's previous portfolio edition. The exact deployed team commit was not authenticated; these images do not validate this exact candidate. Mobile/Safari, physical GPU, offline cold-start/cache-upgrade and provider-response checks remain outstanding.

### Vercel status and access

GitHub reports a successful Vercel deployment for application commit `136e753700b3b4c4a7e8868510622f0d7c19a437`, linking to [deployment 8wt3Qf3vFj7EcV3bAeJ4AWpVM6TL](https://vercel.com/vercel-deployment-connected-prantom/trajectiq-raj2003/8wt3Qf3vFj7EcV3bAeJ4AWpVM6TL). The link uses the `vercel-deployment-connected-prantom` scope. The user's Vercel connection returned 403 when inspecting that deployment and reported no accessible teams. The PR's preview link also led to a Vercel sign-in page.

This status alone does not establish the intended workspace ownership, preview behavior, source settings or production target. The old team scope was not authorized and the other connected Vercel account was not used. Verify ownership/access to the intended personal project before candidate preview review or release.

The GitHub connection temporarily selected another account with read-only access, so the first documentation consolidation attempt made no changes. After the owner reconnected `Raj2003-bubt`, identity and repository push/admin permission were verified before this update.
