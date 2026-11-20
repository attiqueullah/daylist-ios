import SwiftUI

/// The three colours of one list theme: a strong colour for fills, a soft tint for backgrounds and a deep tone for text.
nonisolated struct ThemeSwatch: Equatable, Sendable {
    let strong: ColorPair
    let soft: ColorPair
    let deep: ColorPair

    init(strong: (UInt32, UInt32), soft: (UInt32, UInt32), deep: (UInt32, UInt32)) {
        self.strong = ColorPair(strong.0, strong.1)
        self.soft = ColorPair(soft.0, soft.1)
        self.deep = ColorPair(deep.0, deep.1)
    }
}

/// The eight list themes from Figma (`theme/<name>/strong|soft|deep`). Violet is the app's brand theme.
nonisolated enum AppTheme: String, CaseIterable, Identifiable, Sendable {
    case violet
    case marigold
    case coral
    case moss
    case lagoon
    case berry
    case sky
    case clay

    var id: String { rawValue }

    /// Light and dark hex values for this theme.
    var swatch: ThemeSwatch {
        switch self {
        case .violet:
            ThemeSwatch(strong: (0x5B3DF5, 0x6E55FF), soft: (0xECE8FF, 0x2C2550), deep: (0x3A22B8, 0xC9BEFF))
        case .marigold:
            ThemeSwatch(strong: (0xF59E0B, 0xF59E0B), soft: (0xFEF1D6, 0x3A2A0A), deep: (0x7A4A00, 0xFFD58A))
        case .coral:
            ThemeSwatch(strong: (0xD63A20, 0xD63A20), soft: (0xFDE3DD, 0x3D1A14), deep: (0xA3241A, 0xFFB4A6))
        case .moss:
            ThemeSwatch(strong: (0x22804F, 0x22804F), soft: (0xDCF2E5, 0x12301F), deep: (0x14583A, 0x9EE0B8))
        case .lagoon:
            ThemeSwatch(strong: (0x0B7F79, 0x0B7F79), soft: (0xD8F3F1, 0x0C2E2C), deep: (0x075A55, 0x8EE3DB))
        case .berry:
            ThemeSwatch(strong: (0xD02670, 0xD02670), soft: (0xFCE1EC, 0x3A1027), deep: (0x8E1049, 0xFFA8CC))
        case .sky:
            ThemeSwatch(strong: (0x2563EB, 0x2563EB), soft: (0xE0EAFD, 0x13264A), deep: (0x1A47AE, 0xA9C6FF))
        case .clay:
            ThemeSwatch(strong: (0xC2552B, 0xC2552B), soft: (0xF9E3D9, 0x3A2016), deep: (0x86361A, 0xFFC2A8))
        }
    }

    /// Name shown to the user (accessibility label of a theme swatch, theme picker).
    var title: LocalizedStringResource {
        switch self {
        case .violet: L10n.Theme.violet
        case .marigold: L10n.Theme.marigold
        case .coral: L10n.Theme.coral
        case .moss: L10n.Theme.moss
        case .lagoon: L10n.Theme.lagoon
        case .berry: L10n.Theme.berry
        case .sky: L10n.Theme.sky
        case .clay: L10n.Theme.clay
        }
    }
}

nonisolated extension AppTheme {
    /// Fills: checkboxes, icons, selected states.
    var strong: Color { Color(swatch.strong) }
    /// Tinted backgrounds: chips, tiles.
    var soft: Color { Color(swatch.soft) }
    /// Text and icons on a soft background.
    var deep: Color { Color(swatch.deep) }
}
