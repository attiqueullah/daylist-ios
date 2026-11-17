import Testing

@testable import Daylist

struct SignInViewModelTests {
    @Test func continueWithEmailOpensEmailSignIn() {
        let router = AppRouter()
        router.push(.signIn)
        SignInViewModel(router: router).continueWithEmail()
        #expect(router.onboardingPath == [.signIn, .emailSignIn])
    }

    @Test func continueWithoutAccountShowsHome() {
        let router = AppRouter()
        router.push(.signIn)
        SignInViewModel(router: router).continueWithoutAccount()
        #expect(router.flow == .main)
        #expect(router.onboardingPath.isEmpty)
    }
}
