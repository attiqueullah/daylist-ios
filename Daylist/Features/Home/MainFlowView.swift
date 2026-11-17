import SwiftUI

struct MainFlowView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.homePath) {
            HomeView()
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .smartList(let kind):
                        PlaceholderScreen(title: kind.title, note: "Smart list screen comes in M3.")
                    case .list:
                        PlaceholderScreen(title: "List", note: "List screen comes in M2.")
                    }
                }
        }
        .sheet(item: $router.modal) { modal in
            switch modal {
            case .settings:
                PlaceholderScreen(
                    title: "Settings",
                    note: "Settings comes in M3.",
                    actions: [
                        PlaceholderAction("Done") { router.dismissModal() },
                        PlaceholderAction("Sign out") { router.signOut() },
                    ]
                )
            case .newList:
                PlaceholderScreen(
                    title: "New list",
                    note: "New list comes in M2.",
                    actions: [PlaceholderAction("Cancel") { router.dismissModal() }]
                )
            }
        }
    }
}
