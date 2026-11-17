# Architecture

Daylist uses **MVVM with a router**. SwiftUI views are thin; `@Observable` view models hold state and
logic; a single `AppRouter` owns navigation; repositories own data.

```
            AppEnvironment (composition root)
           /        |          \
   AppRouter   Repositories   LaunchOptions
        ^           ^
        |           |
   XxxViewModel ----+          (@Observable, no SwiftUI import)
        ^
        |  @State private var viewModel
     XxxView                   (layout only)
```

## Layers

| Layer | Folder | Rules |
| --- | --- | --- |
| App | `Daylist/App` | Entry point, `AppEnvironment` (builds view models), `RootView`, launch options |
| Core | `Daylist/Core` | App-wide infrastructure: navigation (`AppRouter`, routes). Later: networking, storage |
| Design system | `Daylist/DesignSystem` | Tokens (colour, type, spacing, radius, elevation) and shared components |
| Data | `Daylist/Data` | Models, repository protocols, mock and API implementations |
| Features | `Daylist/Features/<Area>/<Screen>` | `XxxView.swift` + `XxxViewModel.swift` per screen; one flow view per area |

## Screen pattern

```swift
@Observable
final class WelcomeViewModel {
    private let router: AppRouter
    init(router: AppRouter) { self.router = router }
    func getStarted() { router.push(.signIn) }
}

struct WelcomeView: View {
    @State private var viewModel: WelcomeViewModel
    init(viewModel: WelcomeViewModel) { _viewModel = State(initialValue: viewModel) }
    var body: some View { /* reads viewModel state, calls viewModel intents */ }
}
```

The flow view builds the screen with the composition root:
`WelcomeView(viewModel: environment.makeWelcomeViewModel())`.
`@State` keeps the first instance for the life of the view, so a rebuilt flow view does not reset it.

## Navigation

- `AppFlow` switches between onboarding and main with a dissolve.
- Each flow has one `NavigationStack` bound to a typed path (`[OnboardingRoute]`, `[HomeRoute]`).
- Sheets use `ModalRoute`; Search uses a dissolve overlay (`isSearchPresented`).
- View models call router intents; they never hold `NavigationPath` or `Binding`s.

## Localization

The app is multi-language from the start:

- `Core/Localization/L10n.swift` holds every user-facing string as a typed `LocalizedStringResource`
  (`key`, English `defaultValue`, translator `comment`). Views and view models only use these.
- `Resources/Localizable.xcstrings` is the String Catalog. Xcode extracts new keys on each build;
  adding a language is Project ▸ Info ▸ Localizations ▸ +, then translating in the catalog.
- Values go through functions so translators can move them (`"Mock data set: %@"`); plurals use catalog
  plural variations; dates and numbers use `FormatStyle`.
- Test with Edit Scheme ▸ Run ▸ Options ▸ App Language: *Double-Length Pseudolanguage* and
  *Right-to-Left Pseudolanguage*.

## Testing

Swift Testing in `DaylistTests`, mirroring the app folders. View models are tested with a real `AppRouter`
(it is a plain observable object) and mock repositories, so tests need no UI.

## Launch arguments

`-mockData default|empty` picks the mock data set; `-skipOnboarding YES` starts on Home.
They are read once through `LaunchOptions.current`.
