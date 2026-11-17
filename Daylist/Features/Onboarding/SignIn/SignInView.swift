import SwiftUI

/// Stage 1 placeholder. Stage 5 builds the Figma "Sign In" frame.
struct SignInView: View {
    @State private var viewModel: SignInViewModel

    init(viewModel: SignInViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        PlaceholderScreen(
            title: L10n.SignIn.title,
            actions: [
                PlaceholderAction(L10n.SignIn.continueWithEmail) { viewModel.continueWithEmail() },
                PlaceholderAction(L10n.SignIn.continueWithoutAccount) { viewModel.continueWithoutAccount() },
            ]
        )
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel(router: AppRouter()))
}
