import SwiftUI

/// Hosts the onboarding `NavigationStack`: Welcome → Sign In → Email Sign In.
struct OnboardingFlowView: View {
    @Environment(AppEnvironment.self) private var environment
    @Environment(AppRouter.self) private var router

    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.onboardingPath) {
            WelcomeView(viewModel: environment.makeWelcomeViewModel())
                .navigationDestination(for: OnboardingRoute.self, destination: destination)
        }
    }

    @ViewBuilder
    private func destination(for route: OnboardingRoute) -> some View {
        switch route {
        case .signIn:
            SignInView(viewModel: environment.makeSignInViewModel())
        case .emailSignIn:
            EmailSignInView(viewModel: environment.makeEmailSignInViewModel())
        }
    }
}
