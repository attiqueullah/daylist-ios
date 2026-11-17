import SwiftUI

/// Stage 1 placeholder. Stage 5 builds the Figma "Welcome" frame.
struct WelcomeView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        PlaceholderScreen(
            title: "Welcome",
            actions: [PlaceholderAction("Get started") { router.push(.signIn) }]
        )
    }
}
