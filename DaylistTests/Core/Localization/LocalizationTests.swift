import Foundation
import Testing

@testable import Daylist

struct LocalizationTests {
    @Test func smartListTitlesAreDistinct() {
        let titles = SmartListKind.allCases.map { String(localized: $0.title) }
        #expect(Set(titles).count == titles.count)
    }

    @Test func argumentsAreInsertedIntoTheText() {
        #expect(String(localized: L10n.Home.open(L10n.SmartList.myDay)) == "Open My Day")
        #expect(String(localized: L10n.Home.mockDataSet("empty")) == "Mock data set: empty")
    }
}
