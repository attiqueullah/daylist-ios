import Observation

@Observable
final class EmailSignInViewModel {
    private let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }

    /// Mock sign-in for M1; M4 calls `AuthRepository` and handles errors.
    func signIn() {
        router.finishOnboarding()
    }
}
