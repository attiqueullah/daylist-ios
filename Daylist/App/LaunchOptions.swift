import Foundation

/// Launch-time switches, read from the scheme's launch arguments.
///
/// Arguments of the form `-key value` land in `UserDefaults`' argument domain, so
/// `-mockData empty` and `-skipOnboarding YES` need no parsing of their own.
/// Edit them in Product ▸ Scheme ▸ Edit Scheme ▸ Run ▸ Arguments.
nonisolated struct LaunchOptions: Equatable, Sendable {
    /// Which data the repositories serve. M1–M3 only use the mock sets; M4 adds `.api`.
    nonisolated enum DataSource: String, Equatable, Sendable {
        /// Sample lists, groups and tasks (Groceries, Bills, Work group…).
        case mockDefault = "default"
        /// No lists and no tasks: shows Home First Run.
        case mockEmpty = "empty"
    }

    var dataSource: DataSource
    var skipOnboarding: Bool

    init(dataSource: DataSource = .mockDefault, skipOnboarding: Bool = false) {
        self.dataSource = dataSource
        self.skipOnboarding = skipOnboarding
    }

    /// Builds options from any key → raw value lookup.
    ///
    /// Tests pass a dictionary here. The argument domain always wins inside `UserDefaults`,
    /// even for a custom suite, so a suite can't override the scheme's `-mockData` in tests.
    init(value: (String) -> String?) {
        self.dataSource = value(Keys.mockData).flatMap(DataSource.init(rawValue:)) ?? .mockDefault
        self.skipOnboarding = value(Keys.skipOnboarding).map(Self.isTrue) ?? false
    }

    static var current: LaunchOptions {
        LaunchOptions { UserDefaults.standard.string(forKey: $0) }
    }

    private static func isTrue(_ raw: String) -> Bool {
        ["yes", "true", "1"].contains(raw.lowercased())
    }

    nonisolated enum Keys {
        static let mockData = "mockData"
        static let skipOnboarding = "skipOnboarding"
    }
}
