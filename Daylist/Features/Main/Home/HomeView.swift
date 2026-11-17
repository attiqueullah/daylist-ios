import SwiftUI

/// Stage 1 placeholder. Stage 6 builds the Figma "Home" and "Home First Run" frames.
struct HomeView: View {
    @State private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        PlaceholderScreen(
            title: L10n.Home.title,
            note: viewModel.dataSourceDescription,
            actions: [
                PlaceholderAction(L10n.Home.open(SmartListKind.myDay.title)) { viewModel.open(.myDay) },
                PlaceholderAction(L10n.Home.settings) { viewModel.openSettings() },
            ]
        )
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(router: AppRouter(startsSignedIn: true), dataSource: .mockDefault))
}
