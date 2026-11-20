import SwiftUI
import UIKit

/// A colour that has one hex value for light mode and one for dark mode.
nonisolated struct ColorPair: Equatable, Sendable {
    let light: UInt32
    let dark: UInt32

    init(_ light: UInt32, _ dark: UInt32) {
        self.light = light
        self.dark = dark
    }
}

extension UIColor {
    /// Builds an opaque colour from a `0xRRGGBB` value.
    nonisolated convenience init(hex: UInt32) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }
}

extension Color {
    /// A colour that follows the system appearance (light or dark).
    nonisolated init(_ pair: ColorPair) {
        self.init(uiColor: UIColor { traits in
            UIColor(hex: traits.userInterfaceStyle == .dark ? pair.dark : pair.light)
        })
    }
}

/// Semantic colour roles, taken from the Figma "Daylist colours" variables (light and dark).
///
/// Views use these roles and never a hex value or a system colour.
nonisolated enum DSColor {
    // Backgrounds
    static let canvas = Color(ColorPair(0xF4F2FB, 0x121019))
    static let surface = Color(ColorPair(0xFFFFFF, 0x1E1B29))
    static let sunken = Color(ColorPair(0xF1EEF8, 0x2A2638))
    static let scrim = Color(ColorPair(0x17142B, 0x000000))

    // Text
    static let textPrimary = Color(ColorPair(0x17142B, 0xF4F2FB))
    static let textSecondary = Color(ColorPair(0x5A5670, 0xB3AEC6))
    static let textOnColor = Color(ColorPair(0xFFFFFF, 0xFFFFFF))
    static let textOnLight = Color(ColorPair(0x17142B, 0x17142B))
    static let textDanger = Color(ColorPair(0xA3241A, 0xFF8A7A))
    static let textAccent = Color(ColorPair(0x5B3DF5, 0xA99BFF))

    // Lines and controls
    static let hairline = Color(ColorPair(0xE3E0EE, 0x353047))
    static let controlOff = Color(ColorPair(0x958FAB, 0x6A6480))

    // Brand
    static let brandPrimary = Color(ColorPair(0x5B3DF5, 0x6E55FF))
    static let brandPrimarySoft = Color(ColorPair(0xECE8FF, 0x2C2550))
    static let brandPrimaryDeep = Color(ColorPair(0x3A22B8, 0xC9BEFF))
}
