# Daylist iOS — rules for coding agents

Read `docs/ARCHITECTURE.md` before changing code. These rules apply to every change.

## Architecture: MVVM + router
- One screen = `XxxView` (SwiftUI, layout only) + `XxxViewModel` (`@Observable final class`, state and logic).
- A view owns its view model as `@State private var viewModel` and gets it from `init(viewModel:)`.
- View models never import SwiftUI. They get dependencies (router, repositories) through `init`.
- `AppEnvironment` is the composition root: it builds every view model (`makeXxxViewModel()`).
- Navigation goes through `AppRouter` intents (`push`, `present`, `finishOnboarding`…), called from view models.
  Only flow views (`OnboardingFlowView`, `MainFlowView`) read router state to drive `NavigationStack`s and sheets.
- Data comes from repository protocols; M1–M3 use mock repositories, M4+ API ones. Views never touch data.
- Plain value types (models, routes, options) are `nonisolated` and `Sendable`. Everything else is MainActor
  by default (`SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`).

## Code style
- SwiftLint runs on every build (SwiftLintPlugins, config `.swiftlint.yml`). A change is done only with
  **0 errors and 0 SwiftLint warnings**. Do not add `swiftlint:disable` without a comment explaining why.
- No force unwraps, no implicitly unwrapped optionals, no `print` left in code.
- Colours, fonts, spacing and radii come from the design system (stage 2+), never literals in views.
- Every view model gets Swift Testing tests in `DaylistTests/`, mirroring the app folder layout.

## Localization (multi-language from day one)
- No hardcoded user-facing text. Every string shown to the user, including accessibility labels and hints,
  is a `LocalizedStringResource` in `Daylist/Core/Localization/L10n.swift` with a stable
  `area.screen.element` key, English default value and a translator comment. Views use `Text(L10n.Home.title)`.
- Strings with values are static functions (`L10n.Home.mockDataSet(name)`); never concatenate localized pieces.
- Translations live in `Daylist/Resources/Localizable.xcstrings` (Xcode fills new keys on build).
  Plurals use the catalog's plural variations, not `if count == 1`.
- Dates, numbers and lists are formatted with `FormatStyle` (`.formatted()`), never fixed formats.
- Layout must work right-to-left and with long text: use leading/trailing (never left/right), no fixed text widths.
- SwiftLint custom rules `no_hardcoded_ui_strings` / `no_literal_ui_argument` flag literals in Features and DesignSystem.

## Workflow
- Xcode keeps the project open: write files with the Xcode MCP (`XcodeWrite`), not by editing on disk,
  or Xcode may save an old editor buffer over the change.
- Build and run all tests through the Xcode MCP before handing work over.
- Git rules are in `docs/GIT_WORKFLOW.md`: one branch per stage, Conventional Commits, PR squash-merged so `main`
  gets one commit per stage (`M1 Stage N: …`). Never commit to `main` directly; push only after Attique approves it in Xcode.

## Sources of truth
- Figma: https://www.figma.com/design/4CoExzZhXhhZzOQngZJDk4
- QA sheet (test cases by milestone): https://claude.ai/artifact/M8oUSbfDA851gPNxz7nZTn
- Backend: https://github.com/attiqueullah/daylist-backend (`/api/v1`)
