import SwiftUI

/// Stage 1 placeholder. Stage 6 builds the Figma "Home" and "Home First Run" frames.
struct HomeView: View {
    @Environment(AppEnvironment.self) private var environment
    @Environment(AppRouter.self) private var router

    var body: some View {
        PlaceholderScreen(
            title: "Home",
            note: "Mock data set: \(environment.options.dataSource.rawValue)",
            actions: [
                PlaceholderAction("Open My Day") { router.push(.smartList(.myDay)) },
                PlaceholderAction("Settings") { router.present(.settings) },
            ]
        )
    }
}
