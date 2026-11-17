import Observation

@Observable
final class SignInViewModel {
    private let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }

    func continueWithEmail() {
        router.push(.emailSignIn)
    }

    /// Local-only mode: lists stay on this iPhone until the user signs in (M4 stores the choice).
    func continueWithoutAccount() {
        router.finishOnboarding()
    }
}
