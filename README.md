# Daylist iOS

SwiftUI client for Daylist (a Microsoft To Do–style task app). The backend lives in
[daylist-backend](https://github.com/attiqueullah/daylist-backend).

- iOS 17+, Swift 6, Xcode 26
- MVVM: SwiftUI views + `@Observable` view models, `NavigationStack` with a typed `AppRouter`
  (see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md))
- Repository protocols: mock implementations for M1–M3, API from M4
- Multi-language: all UI text in `L10n` + String Catalog (`Localizable.xcstrings`), no hardcoded strings
- SwiftLint on every build through the [SwiftLintPlugins](https://github.com/SimplyDanny/SwiftLintPlugins)
  package (`.swiftlint.yml`); the build must have 0 warnings

## Run

1. Open `Daylist.xcodeproj`.
2. Pick the **Daylist** scheme and an iPhone simulator, then Run (⌘R). Tests: ⌘U.
   On the first build Xcode asks you to **Trust & Enable** the SwiftLint plugin.
3. For a device, set your team under Signing & Capabilities.

Folders under `Daylist/` and `DaylistTests/` are synced: files added on disk appear in Xcode automatically.

## Launch arguments (Edit Scheme ▸ Run ▸ Arguments)

| Argument | Effect |
| --- | --- |
| `-mockData default` | Sample lists and tasks (on by default) |
| `-mockData empty` | No lists: shows Home First Run |
| `-skipOnboarding YES` | Start on Home |

## Layout

```
Daylist/
  App/            entry point, AppEnvironment (builds view models), RootView, launch options
  Core/           app-wide infrastructure: Navigation (AppRouter, routes), Localization (L10n)
  DesignSystem/   tokens and shared components (stages 2–3)
  Data/           models and repositories (stage 4)
  Features/       <Area>/<Screen>/XxxView + XxxViewModel, one flow view per area
  Resources/      asset catalog, Localizable.xcstrings, fonts
DaylistTests/     Swift Testing unit tests, mirroring the app folders
docs/             ARCHITECTURE.md
```

## Milestone 1 stages

| Stage | Scope | QA |
| --- | --- | --- |
| 1 | Project scaffold, router, launch options | TC-001 |
| 2 | Design system tokens | TC-002, TC-004 |
| 3 | Shared components + gallery | TC-003 |
| 4 | Models and mock data | TC-005 |
| 5 | Welcome, Sign In, Email Sign In | TC-006–009 |
| 6 | Home, First Run, navigation | TC-010–015 |
