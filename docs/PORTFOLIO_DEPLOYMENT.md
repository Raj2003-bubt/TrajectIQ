# Portfolio deployment — 18 October 2026

## Ownership and source

- Production URL: https://trajectiq-raj2003.vercel.app/
- Authorized Vercel account: `raj2003-bubt`, Hobby plan. Creator user ID: `CL8WtEcIpk9peWj4e2AKdXY7`.
- Independent project: `trajectiq-raj2003` (`prj_TbBFdc1jr9AczsLH8dJyBckdTbyZ`).
- Source: `Raj2003-bubt/TrajectIQ`, branch `main`.
- Initial production commit: `89e08d11f8e884cb902bcf29a995228bf3da6573`.
- Initial production deployment: `dpl_8XxLsUgDayJji4jmTXrSnJrWX7VL`, observed **READY** with no alias error.
- Build: `npm run build && npm test`; output: `dist`; framework: Other; Node.js 24.x. Existing security-header configuration is retained.

The original `Pranto-404/Trajectiq` repository and its Vercel deployment were not modified or disconnected. This deployment has its own browser storage origin; saves do not automatically transfer from the original demo.

## Production browser verification

A cloud Chromium browser loaded the public production URL without a sign-in wall. The initial game showed the Moon starter hangar.

| Check | Observed result |
|---|---|
| Moon campaign | Launch readiness passed; entered flight, acquired Moon orbit, compared crisis choices, reallocated link resources, and reached debrief with 751/650 returned science units; objective achieved |
| Mars campaign | Destination switch loaded 400 km starter orbit and destination-specific power constraints; launch, Mars orbit, recovery and debrief completed with 669/650 science units; objective achieved |
| Assistant | Context changed to Mars correctly; source-linked NASA explanations answered in English and Bangla, with explicit educational-model and no-live-telemetry limitations |
| Unsupported question | A non-matching free-text telemetry question received a bounded unsupported-answer response instead of an invented claim; the suggested NASA-data question supplied the supported explanation |
| Renderer | Browser reported SVG/2D fallback, with gameplay available; WebGL rendering was not established |

These observations supplement the earlier 281-test local and GitHub CI runs. They do not establish full mobile/Safari, accessibility, WebGL, microphone-device, or offline-update lifecycle coverage. The Bangla interface remains partly translated.

## Deployment access and remaining work

The personal-account API path successfully created this Git-linked project and its production deployment. Separate team metadata and build-log endpoints returned 403; no log contents were fabricated. Deployment status, exact Git commit metadata, assigned production domain and live browser behavior were independently observed.

Actual game screenshots still need to be committed. Real-device testing and offline lifecycle checks remain open.
