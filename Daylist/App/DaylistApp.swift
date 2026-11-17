import SwiftUI

@main
struct DaylistApp: App {
    @State private var environment = AppEnvironment()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(environment)
                .environment(environment.router)
        }
    }
}
