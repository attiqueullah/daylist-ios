import Testing

@testable import Daylist

struct EmailSignInViewModelTests {
    @Test func signInShowsHome() {
        let router = AppRouter()
        router.push(.signIn)
        router.push(.emailSignIn)
        EmailSignInViewModel(router: router).signIn()
        #expect(router.flow == .main)
        #expect(router.onboardingPath.isEmpty)
    }
}
