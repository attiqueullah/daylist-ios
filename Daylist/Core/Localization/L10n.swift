import Foundation

/// Every user-facing string in the app.
///
/// Views and view models never use string literals for UI text (SwiftLint rule `no_hardcoded_ui_strings`).
/// Keys are stable `area.screen.element` names and the English text is the default value. On build, Xcode
/// extracts every entry into `Resources/Localizable.xcstrings`, where translators add other languages.
/// Strings with values use a static function so the catalog gets a `%@`/`%lld` placeholder.
nonisolated enum L10n {
    nonisolated enum Common {
        static let done = LocalizedStringResource(
            "common.done",
            defaultValue: "Done",
            comment: "Button that closes a sheet or modal"
        )
        static let cancel = LocalizedStringResource(
            "common.cancel",
            defaultValue: "Cancel",
            comment: "Button that dismisses a sheet without saving"
        )
    }

    nonisolated enum Welcome {
        static let title = LocalizedStringResource(
            "welcome.title",
            defaultValue: "Welcome",
            comment: "Title of the first onboarding screen (placeholder until stage 5)"
        )
        static let getStarted = LocalizedStringResource(
            "welcome.getStarted",
            defaultValue: "Get started",
            comment: "Primary button on the Welcome screen"
        )
    }

    nonisolated enum SignIn {
        static let title = LocalizedStringResource(
            "signIn.title",
            defaultValue: "Sign In",
            comment: "Title of the sign-in screen (placeholder until stage 5)"
        )
        static let continueWithEmail = LocalizedStringResource(
            "signIn.continueWithEmail",
            defaultValue: "Continue with email",
            comment: "Button that opens email sign-in"
        )
        static let continueWithoutAccount = LocalizedStringResource(
            "signIn.continueWithoutAccount",
            defaultValue: "Continue without an account",
            comment: "Button that skips sign-in and keeps lists on this device"
        )
    }

    nonisolated enum EmailSignIn {
        static let title = LocalizedStringResource(
            "emailSignIn.title",
            defaultValue: "Email Sign In",
            comment: "Title of the email sign-in screen (placeholder until stage 5)"
        )
        static let signIn = LocalizedStringResource(
            "emailSignIn.signIn",
            defaultValue: "Sign in",
            comment: "Primary button that signs in with email and password"
        )
    }

    nonisolated enum Home {
        static let title = LocalizedStringResource(
            "home.title",
            defaultValue: "Home",
            comment: "Title of the Home screen (placeholder until stage 6)"
        )
        static let settings = LocalizedStringResource(
            "home.settings",
            defaultValue: "Settings",
            comment: "Button that opens Settings from Home"
        )

        static func open(_ smartList: LocalizedStringResource) -> LocalizedStringResource {
            LocalizedStringResource(
                "home.openSmartList",
                defaultValue: "Open \(String(localized: smartList))",
                comment: "Button that opens a smart list from Home. Argument: smart list name, e.g. My Day"
            )
        }

        static func mockDataSet(_ name: String) -> LocalizedStringResource {
            LocalizedStringResource(
                "home.mockDataSet",
                defaultValue: "Mock data set: \(name)",
                comment: "Developer note on Home showing which mock data is loaded. Argument: default or empty"
            )
        }
    }

    nonisolated enum SmartList {
        static let myDay = LocalizedStringResource(
            "smartList.myDay",
            defaultValue: "My Day",
            comment: "Smart list: tasks the user picked for today"
        )
        static let important = LocalizedStringResource(
            "smartList.important",
            defaultValue: "Important",
            comment: "Smart list: starred tasks"
        )
        static let planned = LocalizedStringResource(
            "smartList.planned",
            defaultValue: "Planned",
            comment: "Smart list: tasks with a due date or reminder"
        )
        static let assignedToMe = LocalizedStringResource(
            "smartList.assignedToMe",
            defaultValue: "Assigned to me",
            comment: "Smart list: tasks other members assigned to the user"
        )
        static let completed = LocalizedStringResource(
            "smartList.completed",
            defaultValue: "Completed",
            comment: "Smart list: finished tasks"
        )
    }

    nonisolated enum Settings {
        static let title = LocalizedStringResource(
            "settings.title",
            defaultValue: "Settings",
            comment: "Title of the Settings screen"
        )
        static let signOut = LocalizedStringResource(
            "settings.signOut",
            defaultValue: "Sign out",
            comment: "Button in Settings that signs the user out"
        )
    }

    nonisolated enum NewList {
        static let title = LocalizedStringResource(
            "newList.title",
            defaultValue: "New list",
            comment: "Title of the screen that creates a list"
        )
    }

    nonisolated enum TaskList {
        static let title = LocalizedStringResource(
            "taskList.title",
            defaultValue: "List",
            comment: "Generic title for a task list screen (placeholder until M2)"
        )
    }

    /// Notes shown on screens that a later stage or milestone replaces. Removed with `PlaceholderScreen`.
    nonisolated enum Placeholder {
        static let laterStage = LocalizedStringResource(
            "placeholder.laterStage",
            defaultValue: "Placeholder, built in a later stage.",
            comment: "Developer note on unfinished screens"
        )
        static let comesInM2 = LocalizedStringResource(
            "placeholder.comesInM2",
            defaultValue: "This screen comes in milestone 2.",
            comment: "Developer note on unfinished screens"
        )
        static let comesInM3 = LocalizedStringResource(
            "placeholder.comesInM3",
            defaultValue: "This screen comes in milestone 3.",
            comment: "Developer note on unfinished screens"
        )
    }
}
