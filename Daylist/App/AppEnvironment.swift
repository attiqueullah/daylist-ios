import Observation

/// Composition root: owns app-wide dependencies and builds every view model.
///
/// Created once in `DaylistApp` and passed down through the SwiftUI environment. Screens never
/// construct their own dependencies; flow views ask this type for a ready view model instead.
/// Stage 4 adds the repositories here (mock for M1–M3, API from M4).
@Observable
final class AppEnvironment {
    let options: LaunchOptions
    let router: AppRouter

    init(options: LaunchOptions = .current, router: AppRouter? = nil) {
        self.options = options
        self.router = router ?? AppRouter(startsSignedIn: options.skipOnboarding)
    }

    // MARK: - Onboarding

    func makeWelcomeViewModel() -> WelcomeViewModel {
        WelcomeViewModel(router: router)
    }

    func makeSignInViewModel() -> SignInViewModel {
        SignInViewModel(router: router)
    }

    func makeEmailSignInViewModel() -> EmailSignInViewModel {
        EmailSignInViewModel(router: router)
    }

    // MARK: - Main

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(router: router, dataSource: options.dataSource)
    }
}
