import Observation

/// App-wide dependencies, created once in `DaylistApp` and passed down through the SwiftUI environment.
///
/// Stage 4 adds the repositories here (mock for M1–M3, API from M4), so screens never
/// construct their own data sources.
@Observable
final class AppEnvironment {
    let options: LaunchOptions
    let router: AppRouter

    init(options: LaunchOptions = .current, router: AppRouter? = nil) {
        self.options = options
        self.router = router ?? AppRouter(startsSignedIn: options.skipOnboarding)
    }
}
