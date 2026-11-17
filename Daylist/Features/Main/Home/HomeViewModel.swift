import Foundation
import Observation

@Observable
final class HomeViewModel {
    let dataSource: LaunchOptions.DataSource
    private let router: AppRouter

    init(router: AppRouter, dataSource: LaunchOptions.DataSource) {
        self.router = router
        self.dataSource = dataSource
    }

    var dataSourceDescription: LocalizedStringResource {
        L10n.Home.mockDataSet(dataSource.rawValue)
    }

    func open(_ smartList: SmartListKind) {
        router.push(.smartList(smartList))
    }

    func openSettings() {
        router.present(.settings)
    }
}
