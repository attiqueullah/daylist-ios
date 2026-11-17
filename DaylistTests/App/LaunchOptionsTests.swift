import Testing

@testable import Daylist

struct LaunchOptionsTests {
    private func options(_ values: [String: String]) -> LaunchOptions {
        LaunchOptions { values[$0] }
    }

    @Test func defaultsToSampleDataAndOnboarding() {
        #expect(options([:]) == LaunchOptions(dataSource: .mockDefault, skipOnboarding: false))
    }

    @Test func readsEmptyDataSetAndSkipOnboarding() {
        let result = options(["mockData": "empty", "skipOnboarding": "YES"])
        #expect(result.dataSource == .mockEmpty)
        #expect(result.skipOnboarding)
    }

    @Test(arguments: ["YES", "yes", "true", "1"])
    func acceptsCommonTrueSpellings(_ raw: String) {
        #expect(options(["skipOnboarding": raw]).skipOnboarding)
    }

    @Test(arguments: ["NO", "false", "0", "maybe"])
    func treatsOtherValuesAsFalse(_ raw: String) {
        #expect(options(["skipOnboarding": raw]).skipOnboarding == false)
    }

    @Test func unknownDataSetFallsBackToDefault() {
        #expect(options(["mockData": "nonsense"]).dataSource == .mockDefault)
    }
}
