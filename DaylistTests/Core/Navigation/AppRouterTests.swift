import Testing

@testable import Daylist

struct AppRouterTests {
    @Test func startsInOnboardingByDefault() {
        #expect(AppRouter().flow == .onboarding)
    }

    @Test func skipOnboardingStartsOnHome() {
        #expect(AppRouter(startsSignedIn: true).flow == .main)
    }

    @Test func finishOnboardingClearsStackAndShowsHome() {
        let router = AppRouter()
        router.push(.signIn)
        router.push(.emailSignIn)
        router.finishOnboarding()
        #expect(router.flow == .main)
        #expect(router.onboardingPath.isEmpty)
    }

    @Test func backPopsOnlyTheActiveFlow() {
        let router = AppRouter()
        router.push(.signIn)
        router.push(.emailSignIn)
        router.pop()
        #expect(router.onboardingPath == [.signIn])

        router.finishOnboarding()
        router.push(.smartList(.myDay))
        router.push(.smartList(.important))
        router.pop()
        #expect(router.homePath == [.smartList(.myDay)])
    }

    @Test func modalPresentsAndDismisses() {
        let router = AppRouter(startsSignedIn: true)
        router.present(.settings)
        #expect(router.modal == .settings)
        router.dismissModal()
        #expect(router.modal == nil)
    }

    @Test func signOutResetsEverything() {
        let router = AppRouter(startsSignedIn: true)
        router.push(.smartList(.planned))
        router.present(.settings)
        router.showSearch()
        router.signOut()
        #expect(router.flow == .onboarding)
        #expect(router.homePath.isEmpty)
        #expect(router.modal == nil)
        #expect(router.isSearchPresented == false)
    }
}
