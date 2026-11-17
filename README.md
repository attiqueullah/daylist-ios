# Daylist iOS

SwiftUI client for Daylist (a Microsoft To Do–style task app). The backend lives in
[daylist-backend](https://github.com/attiqueullah/daylist-backend).

- iOS 17+, Swift 6, Xcode 26
- `@Observable` view models, `NavigationStack` with a typed `AppRouter`
- Repository protocols: mock implementations for M1–M3, API from M4

## Run

1. Open `Daylist.xcodeproj`.
2. Pick the **Daylist** scheme and an iPhone simulator, then Run (⌘R). Tests: ⌘U.
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
  App/            entry point, environment, launch options
  Navigation/     routes, AppRouter, RootView
  DesignSystem/   tokens and shared components (stages 2–3)
  Data/           models and repositories (stage 4)
  Features/       one folder per area: Onboarding, Home, …
  Resources/      asset catalog, fonts
DaylistTests/     Swift Testing unit tests
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
