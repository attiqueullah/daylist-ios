import Foundation

/// The two top-level flows. Switching between them dissolves (nav spec: Welcome/Sign in → Home).
nonisolated enum AppFlow: Hashable, Sendable {
    case onboarding
    case main
}

/// Screens pushed on the onboarding stack, after Welcome.
nonisolated enum OnboardingRoute: Hashable, Sendable {
    case signIn
    case emailSignIn
}

/// Screens pushed on the Home stack (push left / back pushes right).
nonisolated enum HomeRoute: Hashable, Sendable {
    case smartList(SmartListKind)
    case list(id: UUID)
}

/// Modals that slide up over Home.
nonisolated enum ModalRoute: String, Identifiable, Hashable, Sendable {
    case settings
    case newList

    var id: String { rawValue }
}

/// Smart lists shown as tiles on Home (Figma frame "Home", section 02).
nonisolated enum SmartListKind: String, CaseIterable, Hashable, Sendable {
    case myDay
    case important
    case planned
    case assignedToMe
    case completed

    var title: String {
        switch self {
        case .myDay: "My Day"
        case .important: "Important"
        case .planned: "Planned"
        case .assignedToMe: "Assigned to me"
        case .completed: "Completed"
        }
    }
}
