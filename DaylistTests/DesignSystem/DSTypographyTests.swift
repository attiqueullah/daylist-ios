@testable import Daylist
import Testing
import UIKit

/// Checks the bundled fonts and the 18 text styles against Figma (TC-004).
struct DSTypographyTests {
    private nonisolated struct Expected: Sendable, CustomTestStringConvertible {
        let style: DSTextStyle
        let face: DSFontFace
        let size: CGFloat
        let lineHeight: CGFloat
        let tracking: CGFloat

        var testDescription: String { String(describing: style) }
    }

    private nonisolated static let styles: [Expected] = [
        Expected(style: .display, face: .spaceGroteskBold, size: 34, lineHeight: 1.10, tracking: -0.02),
        Expected(style: .titleLarge, face: .spaceGroteskBold, size: 28, lineHeight: 1.15, tracking: -0.02),
        Expected(style: .title, face: .spaceGroteskMedium, size: 22, lineHeight: 1.25, tracking: 0),
        Expected(style: .titleSmall, face: .spaceGroteskMedium, size: 18, lineHeight: 1.25, tracking: 0),
        Expected(style: .brand, face: .spaceGroteskBold, size: 18, lineHeight: 1.20, tracking: 0),
        Expected(style: .headline, face: .interSemiBold, size: 17, lineHeight: 1.30, tracking: 0),
        Expected(style: .body, face: .interMedium, size: 16, lineHeight: 1.35, tracking: 0),
        Expected(style: .bodyLong, face: .interRegular, size: 16, lineHeight: 1.50, tracking: 0),
        Expected(style: .bodyStrong, face: .interBold, size: 16, lineHeight: 1.30, tracking: 0),
        Expected(style: .button, face: .interSemiBold, size: 16, lineHeight: 1.20, tracking: 0),
        Expected(style: .subhead, face: .interMedium, size: 15, lineHeight: 1.35, tracking: 0),
        Expected(style: .subheadStrong, face: .interSemiBold, size: 15, lineHeight: 1.35, tracking: 0),
        Expected(style: .callout, face: .interMedium, size: 14, lineHeight: 1.35, tracking: 0),
        Expected(style: .calloutStrong, face: .interSemiBold, size: 14, lineHeight: 1.35, tracking: 0),
        Expected(style: .caption, face: .interRegular, size: 13, lineHeight: 1.40, tracking: 0),
        Expected(style: .label, face: .interSemiBold, size: 13, lineHeight: 1.30, tracking: 0.04),
        Expected(style: .meta, face: .interMedium, size: 12, lineHeight: 1.30, tracking: 0),
        Expected(style: .footnote, face: .interSemiBold, size: 12, lineHeight: 1.30, tracking: 0),
    ]

    @Test @MainActor func allSixFontFilesAreBundledAndRegistered() {
        #expect(FontRegistrar.registerAll() == DSFontFace.allCases.count)
        for face in DSFontFace.allCases {
            #expect(UIFont(name: face.rawValue, size: 16) != nil, "\(face.rawValue) did not load")
        }
    }

    @Test @MainActor func registeringTwiceIsHarmless() {
        FontRegistrar.registerAll()
        #expect(FontRegistrar.registerAll() == DSFontFace.allCases.count)
    }

    @Test func thereAreEighteenTextStyles() {
        #expect(DSTextStyle.allCases.count == 18)
        #expect(Self.styles.count == 18)
    }

    @Test("Text style matches Figma", arguments: styles)
    private func styleMatchesFigma(_ expected: Expected) {
        let spec = expected.style.spec
        #expect(spec.face == expected.face)
        #expect(spec.size == expected.size)
        #expect(spec.lineHeight == expected.lineHeight)
        #expect(spec.tracking == expected.tracking)
    }

    @Test func headingsUseSpaceGroteskAndTextUsesInter() {
        let headings: [DSTextStyle] = [.display, .titleLarge, .title, .titleSmall, .brand]
        for style in DSTextStyle.allCases {
            let isSpaceGrotesk = style.spec.face.rawValue.hasPrefix("SpaceGrotesk")
            #expect(isSpaceGrotesk == headings.contains(style))
        }
    }
}
