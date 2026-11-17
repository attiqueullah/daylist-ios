import SwiftUI

/// Stage 1 placeholder. Stage 5 builds the Figma "Email Sign In" frame.
struct EmailSignInView: View {
    @State private var viewModel: EmailSignInViewModel

    init(viewModel: EmailSignInViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        PlaceholderScreen(
            title: L10n.EmailSignIn.title,
            actions: [PlaceholderAction(L10n.EmailSignIn.signIn) { viewModel.signIn() }]
        )
    }
}

#Preview {
    EmailSignInView(viewModel: EmailSignInViewModel(router: AppRouter()))
}
