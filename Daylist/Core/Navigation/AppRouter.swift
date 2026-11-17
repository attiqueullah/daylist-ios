import Observation

/// Owns all navigation state. View models call its intent methods; only flow views read its state.
///
/// One `NavigationStack` per flow, each bound to its own typed path. Transitions follow
/// `claude/navigation-spec.md`: pushes for drill-ins, a sheet for Settings and New list,
/// and a dissolve when the flow changes.
@Observable
final class AppRouter {
    private(set) var flow: AppFlow
    var onboardingPath: [OnboardingRoute] = []
    var homePath: [HomeRoute] = []
    var modal: ModalRoute?
    /// Search opens with a dissolve over Home rather than a push (nav spec).
    var isSearchPresented = false

    init(startsSignedIn: Bool = false) {
        flow = startsSignedIn ? .main : .onboarding
    }

    // MARK: Onboarding

    func push(_ route: OnboardingRoute) {
        onboardingPath.append(route)
    }

    /// Any sign-in path (Apple, Google, email, or no account) lands on Home.
    func finishOnboarding() {
        onboardingPath.removeAll()
        flow = .main
    }

    // MARK: Main

    func push(_ route: HomeRoute) {
        homePath.append(route)
    }

    func present(_ modal: ModalRoute) {
        self.modal = modal
    }

    func dismissModal() {
        modal = nil
    }

    func showSearch() {
        isSearchPresented = true
    }

    func hideSearch() {
        isSearchPresented = false
    }

    // MARK: Shared

    /// Back: pops the active flow's stack.
    func pop() {
        switch flow {
        case .onboarding: _ = onboardingPath.popLast()
        case .main: _ = homePath.popLast()
        }
    }

    func popToRoot() {
        switch flow {
        case .onboarding: onboardingPath.removeAll()
        case .main: homePath.removeAll()
        }
    }

    func signOut() {
        homePath.removeAll()
        modal = nil
        isSearchPresented = false
        flow = .onboarding
    }
}
