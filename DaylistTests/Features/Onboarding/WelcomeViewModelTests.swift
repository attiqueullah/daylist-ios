import Testing

@testable import Daylist

struct WelcomeViewModelTests {
    @Test func getStartedOpensSignIn() {
        let router = AppRouter()
        WelcomeViewModel(router: router).getStarted()
        #expect(router.onboardingPath == [.signIn])
    }
}
