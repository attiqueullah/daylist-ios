import SwiftUI

struct OnboardingFlowView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.onboardingPath) {
            WelcomeView()
                .navigationDestination(for: OnboardingRoute.self) { route in
                    switch route {
                    case .signIn: SignInView()
                    case .emailSignIn: EmailSignInView()
                    }
                }
        }
    }
}
