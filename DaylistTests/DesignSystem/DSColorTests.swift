@testable import Daylist
import SwiftUI
import Testing
import UIKit

/// Checks every colour token against the values in the Figma variables (TC-002, TC-004).
struct DSColorTests {
    private nonisolated struct Expected: Sendable, CustomTestStringConvertible {
        let name: String
        let color: Color
        let light: UInt32
        let dark: UInt32

        var testDescription: String { name }
    }

    private nonisolated static let roles: [Expected] = [
        Expected(name: "bg/canvas", color: DSColor.canvas, light: 0xF4F2FB, dark: 0x121019),
        Expected(name: "bg/surface", color: DSColor.surface, light: 0xFFFFFF, dark: 0x1E1B29),
        Expected(name: "bg/sunken", color: DSColor.sunken, light: 0xF1EEF8, dark: 0x2A2638),
        Expected(name: "bg/scrim", color: DSColor.scrim, light: 0x17142B, dark: 0x000000),
        Expected(name: "text/primary", color: DSColor.textPrimary, light: 0x17142B, dark: 0xF4F2FB),
        Expected(name: "text/secondary", color: DSColor.textSecondary, light: 0x5A5670, dark: 0xB3AEC6),
        Expected(name: "text/on-color", color: DSColor.textOnColor, light: 0xFFFFFF, dark: 0xFFFFFF),
        Expected(name: "text/on-light", color: DSColor.textOnLight, light: 0x17142B, dark: 0x17142B),
        Expected(name: "text/danger", color: DSColor.textDanger, light: 0xA3241A, dark: 0xFF8A7A),
        Expected(name: "text/accent", color: DSColor.textAccent, light: 0x5B3DF5, dark: 0xA99BFF),
        Expected(name: "line/hairline", color: DSColor.hairline, light: 0xE3E0EE, dark: 0x353047),
        Expected(name: "control/off", color: DSColor.controlOff, light: 0x958FAB, dark: 0x6A6480),
        Expected(name: "brand/primary", color: DSColor.brandPrimary, light: 0x5B3DF5, dark: 0x6E55FF),
        Expected(name: "brand/primary-soft", color: DSColor.brandPrimarySoft, light: 0xECE8FF, dark: 0x2C2550),
        Expected(name: "brand/primary-deep", color: DSColor.brandPrimaryDeep, light: 0x3A22B8, dark: 0xC9BEFF),
    ]

    @Test("Colour role matches Figma in light and dark", arguments: roles)
    private func roleMatchesFigma(_ role: Expected) {
        #expect(Self.hex(role.color, .light) == role.light)
        #expect(Self.hex(role.color, .dark) == role.dark)
    }

    private nonisolated struct ThemeExpected: Sendable, CustomTestStringConvertible {
        let theme: AppTheme
        let strong: (light: UInt32, dark: UInt32)
        let soft: (light: UInt32, dark: UInt32)
        let deep: (light: UInt32, dark: UInt32)

        var testDescription: String { theme.rawValue }
    }

    private nonisolated static let themes: [ThemeExpected] = [
        ThemeExpected(
            theme: .violet,
            strong: (0x5B3DF5, 0x6E55FF),
            soft: (0xECE8FF, 0x2C2550),
            deep: (0x3A22B8, 0xC9BEFF)
        ),
        ThemeExpected(
            theme: .marigold,
            strong: (0xF59E0B, 0xF59E0B),
            soft: (0xFEF1D6, 0x3A2A0A),
            deep: (0x7A4A00, 0xFFD58A)
        ),
        ThemeExpected(
            theme: .coral,
            strong: (0xD63A20, 0xD63A20),
            soft: (0xFDE3DD, 0x3D1A14),
            deep: (0xA3241A, 0xFFB4A6)
        ),
        ThemeExpected(
            theme: .moss,
            strong: (0x22804F, 0x22804F),
            soft: (0xDCF2E5, 0x12301F),
            deep: (0x14583A, 0x9EE0B8)
        ),
        ThemeExpected(
            theme: .lagoon,
            strong: (0x0B7F79, 0x0B7F79),
            soft: (0xD8F3F1, 0x0C2E2C),
            deep: (0x075A55, 0x8EE3DB)
        ),
        ThemeExpected(
            theme: .berry,
            strong: (0xD02670, 0xD02670),
            soft: (0xFCE1EC, 0x3A1027),
            deep: (0x8E1049, 0xFFA8CC)
        ),
        ThemeExpected(
            theme: .sky,
            strong: (0x2563EB, 0x2563EB),
            soft: (0xE0EAFD, 0x13264A),
            deep: (0x1A47AE, 0xA9C6FF)
        ),
        ThemeExpected(
            theme: .clay,
            strong: (0xC2552B, 0xC2552B),
            soft: (0xF9E3D9, 0x3A2016),
            deep: (0x86361A, 0xFFC2A8)
        ),
    ]

    @Test("Theme colours match Figma in light and dark", arguments: themes)
    private func themeMatchesFigma(_ expected: ThemeExpected) {
        let theme = expected.theme
        #expect(Self.hex(theme.strong, .light) == expected.strong.light)
        #expect(Self.hex(theme.strong, .dark) == expected.strong.dark)
        #expect(Self.hex(theme.soft, .light) == expected.soft.light)
        #expect(Self.hex(theme.soft, .dark) == expected.soft.dark)
        #expect(Self.hex(theme.deep, .light) == expected.deep.light)
        #expect(Self.hex(theme.deep, .dark) == expected.deep.dark)
    }

    @Test func thereAreEightThemesAndVioletIsTheBrand() {
        #expect(AppTheme.allCases.count == 8)
        #expect(AppTheme.violet.swatch.strong == ColorPair(0x5B3DF5, 0x6E55FF))
    }

    @Test func everyThemeHasADistinctName() {
        let names = AppTheme.allCases.map { String(localized: $0.title) }
        #expect(Set(names).count == 8)
        #expect(names.allSatisfy { !$0.isEmpty })
    }

    private static func hex(_ color: Color, _ style: UIUserInterfaceStyle) -> UInt32 {
        let resolved = UIColor(color).resolvedColor(with: UITraitCollection(userInterfaceStyle: style))
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        resolved.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let redByte = UInt32((red * 255).rounded())
        let greenByte = UInt32((green * 255).rounded())
        let blueByte = UInt32((blue * 255).rounded())
        return (redByte << 16) | (greenByte << 8) | blueByte
    }
}
