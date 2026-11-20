import SwiftUI

@main
struct DaylistApp: App {
    @State private var environment = AppEnvironment()

    init() {
        FontRegistrar.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(environment)
                .environment(environment.router)
        }
    }
}
