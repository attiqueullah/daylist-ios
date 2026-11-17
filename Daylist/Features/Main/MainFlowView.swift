import SwiftUI

/// Hosts the signed-in `NavigationStack` (Home and everything pushed from it) and its sheets.
struct MainFlowView: View {
    @Environment(AppEnvironment.self) private var environment
    @Environment(AppRouter.self) private var router

    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.homePath) {
            HomeView(viewModel: environment.makeHomeViewModel())
                .navigationDestination(for: HomeRoute.self, destination: destination)
        }
        .sheet(item: $router.modal, content: modalContent)
    }

    /// Placeholders until M2 (lists) and M3 (smart lists) build these screens with their own view models.
    @ViewBuilder
    private func destination(for route: HomeRoute) -> some View {
        switch route {
        case .smartList(let kind):
            PlaceholderScreen(title: kind.title, note: L10n.Placeholder.comesInM3)
        case .list:
            PlaceholderScreen(title: L10n.TaskList.title, note: L10n.Placeholder.comesInM2)
        }
    }

    /// Placeholders until M2 (New list) and M3 (Settings) build these screens with their own view models.
    @ViewBuilder
    private func modalContent(for route: ModalRoute) -> some View {
        switch route {
        case .settings:
            PlaceholderScreen(
                title: L10n.Settings.title,
                note: L10n.Placeholder.comesInM3,
                actions: [
                    PlaceholderAction(L10n.Common.done) { router.dismissModal() },
                    PlaceholderAction(L10n.Settings.signOut) { router.signOut() },
                ]
            )
        case .newList:
            PlaceholderScreen(
                title: L10n.NewList.title,
                note: L10n.Placeholder.comesInM2,
                actions: [PlaceholderAction(L10n.Common.cancel) { router.dismissModal() }]
            )
        }
    }
}
