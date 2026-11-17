import SwiftUI

/// Stage 1 placeholder. Stage 5 builds the Figma "Welcome" frame.
struct WelcomeView: View {
    @State private var viewModel: WelcomeViewModel

    init(viewModel: WelcomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        PlaceholderScreen(
            title: L10n.Welcome.title,
            actions: [PlaceholderAction(L10n.Welcome.getStarted) { viewModel.getStarted() }]
        )
    }
}

#Preview {
    WelcomeView(viewModel: WelcomeViewModel(router: AppRouter()))
}
