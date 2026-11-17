import SwiftUI

struct RootView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        ZStack {
            switch router.flow {
            case .onboarding:
                OnboardingFlowView()
                    .transition(.opacity)
            case .main:
                MainFlowView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: router.flow)
    }
}

#Preview("Onboarding") {
    let environment = AppEnvironment(options: LaunchOptions())
    RootView()
        .environment(environment)
        .environment(environment.router)
}

#Preview("Signed in") {
    let environment = AppEnvironment(options: LaunchOptions(skipOnboarding: true))
    RootView()
        .environment(environment)
        .environment(environment.router)
}
