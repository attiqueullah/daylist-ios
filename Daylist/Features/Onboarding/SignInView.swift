import SwiftUI

/// Stage 1 placeholder. Stage 5 builds the Figma "Sign In" frame.
struct SignInView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        PlaceholderScreen(
            title: "Sign In",
            actions: [
                PlaceholderAction("Continue with email") { router.push(.emailSignIn) },
                PlaceholderAction("Continue without an account") { router.finishOnboarding() },
            ]
        )
    }
}
