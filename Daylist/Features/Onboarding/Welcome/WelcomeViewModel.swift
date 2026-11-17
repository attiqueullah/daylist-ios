import Observation

@Observable
final class WelcomeViewModel {
    private let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }

    func getStarted() {
        router.push(.signIn)
    }
}
