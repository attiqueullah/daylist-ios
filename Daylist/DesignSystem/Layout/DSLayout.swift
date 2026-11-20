import SwiftUI

/// Spacing scale from the Figma "Daylist layout" variables (`space/4` … `space/40`).
nonisolated enum DSSpace {
    static let s4: CGFloat = 4
    static let s8: CGFloat = 8
    static let s12: CGFloat = 12
    static let s16: CGFloat = 16
    static let s20: CGFloat = 20
    static let s24: CGFloat = 24
    static let s32: CGFloat = 32
    static let s40: CGFloat = 40
}

/// Corner radii (`radius/8` … `radius/full`).
nonisolated enum DSRadius {
    static let r8: CGFloat = 8
    static let r12: CGFloat = 12
    static let r16: CGFloat = 16
    static let r20: CGFloat = 20
    static let r28: CGFloat = 28
    /// Large enough to make any control a pill.
    static let full: CGFloat = 999
}

/// Drop shadows (`elevation/1`, `elevation/2`). Figma's blur is twice SwiftUI's shadow radius.
nonisolated enum DSElevation: CaseIterable, Sendable {
    case one
    case two

    var offsetY: CGFloat {
        switch self {
        case .one: 1
        case .two: 6
        }
    }

    var blur: CGFloat {
        switch self {
        case .one: 2
        case .two: 24
        }
    }

    var opacity: Double {
        switch self {
        case .one: 0.08
        case .two: 0.12
        }
    }
}

extension View {
    /// Applies a design-system drop shadow.
    func dsElevation(_ elevation: DSElevation) -> some View {
        shadow(
            color: DSColor.scrim.opacity(elevation.opacity),
            radius: elevation.blur / 2,
            x: 0,
            y: elevation.offsetY
        )
    }
}
