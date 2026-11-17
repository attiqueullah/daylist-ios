import SwiftUI

/// Stage 1 placeholder. Stage 5 builds the Figma "Email Sign In" frame.
struct EmailSignInView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        PlaceholderScreen(
            title: "Email Sign In",
            actions: [PlaceholderAction("Sign in (mock)") { router.finishOnboarding() }]
        )
    }
}
