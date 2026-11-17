import Foundation
import Testing

@testable import Daylist

struct HomeViewModelTests {
    private let router = AppRouter(startsSignedIn: true)

    @Test(arguments: SmartListKind.allCases)
    func openPushesSmartList(_ kind: SmartListKind) {
        HomeViewModel(router: router, dataSource: .mockDefault).open(kind)
        #expect(router.homePath == [.smartList(kind)])
    }

    @Test func openSettingsPresentsSettings() {
        HomeViewModel(router: router, dataSource: .mockDefault).openSettings()
        #expect(router.modal == .settings)
    }

    @Test func describesTheMockDataSet() {
        let viewModel = HomeViewModel(router: router, dataSource: .mockEmpty)
        #expect(String(localized: viewModel.dataSourceDescription) == "Mock data set: empty")
    }
}
