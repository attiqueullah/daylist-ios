import SwiftUI
import UIKit

/// The numbers behind one text style.
nonisolated struct DSTextSpec: Equatable, Sendable {
    let face: DSFontFace
    /// Point size at the default Dynamic Type setting.
    let size: CGFloat
    /// Line height as a multiple of the size (Figma "line height %").
    let lineHeight: CGFloat
    /// Letter spacing as a fraction of the size (Figma "letter spacing %").
    let tracking: CGFloat
    /// The system style this one grows and shrinks with when the user changes text size.
    let relativeTo: Font.TextStyle

    init(
        _ face: DSFontFace,
        _ size: CGFloat,
        lineHeight: CGFloat,
        tracking: CGFloat = 0,
        relativeTo: Font.TextStyle
    ) {
        self.face = face
        self.size = size
        self.lineHeight = lineHeight
        self.tracking = tracking
        self.relativeTo = relativeTo
    }
}

/// The 18 text styles from Figma. Apply with `.dsTextStyle(.body)`.
nonisolated enum DSTextStyle: CaseIterable, Sendable {
    case display
    case titleLarge
    case title
    case titleSmall
    case brand
    case headline
    case body
    case bodyLong
    case bodyStrong
    case button
    case subhead
    case subheadStrong
    case callout
    case calloutStrong
    case caption
    case label
    case meta
    case footnote

    var spec: DSTextSpec {
        switch self {
        case .display: DSTextSpec(.spaceGroteskBold, 34, lineHeight: 1.10, tracking: -0.02, relativeTo: .largeTitle)
        case .titleLarge: DSTextSpec(.spaceGroteskBold, 28, lineHeight: 1.15, tracking: -0.02, relativeTo: .title)
        case .title: DSTextSpec(.spaceGroteskMedium, 22, lineHeight: 1.25, relativeTo: .title2)
        case .titleSmall: DSTextSpec(.spaceGroteskMedium, 18, lineHeight: 1.25, relativeTo: .title3)
        case .brand: DSTextSpec(.spaceGroteskBold, 18, lineHeight: 1.20, relativeTo: .headline)
        case .headline: DSTextSpec(.interSemiBold, 17, lineHeight: 1.30, relativeTo: .headline)
        case .body: DSTextSpec(.interMedium, 16, lineHeight: 1.35, relativeTo: .body)
        case .bodyLong: DSTextSpec(.interRegular, 16, lineHeight: 1.50, relativeTo: .body)
        case .bodyStrong: DSTextSpec(.interBold, 16, lineHeight: 1.30, relativeTo: .body)
        case .button: DSTextSpec(.interSemiBold, 16, lineHeight: 1.20, relativeTo: .body)
        case .subhead: DSTextSpec(.interMedium, 15, lineHeight: 1.35, relativeTo: .subheadline)
        case .subheadStrong: DSTextSpec(.interSemiBold, 15, lineHeight: 1.35, relativeTo: .subheadline)
        case .callout: DSTextSpec(.interMedium, 14, lineHeight: 1.35, relativeTo: .callout)
        case .calloutStrong: DSTextSpec(.interSemiBold, 14, lineHeight: 1.35, relativeTo: .callout)
        case .caption: DSTextSpec(.interRegular, 13, lineHeight: 1.40, relativeTo: .caption)
        case .label: DSTextSpec(.interSemiBold, 13, lineHeight: 1.30, tracking: 0.04, relativeTo: .caption)
        case .meta: DSTextSpec(.interMedium, 12, lineHeight: 1.30, relativeTo: .caption2)
        case .footnote: DSTextSpec(.interSemiBold, 12, lineHeight: 1.30, relativeTo: .footnote)
        }
    }
}

private struct DSTextStyleModifier: ViewModifier {
    let style: DSTextStyle
    @ScaledMetric private var size: CGFloat

    init(style: DSTextStyle) {
        self.style = style
        _size = ScaledMetric(wrappedValue: style.spec.size, relativeTo: style.spec.relativeTo)
    }

    func body(content: Content) -> some View {
        content
            .font(.custom(style.spec.face.rawValue, fixedSize: size))
            .tracking(size * style.spec.tracking)
            .lineSpacing(extraLineSpacing)
    }

    /// The gap Figma's line height needs on top of the font's own line height.
    private var extraLineSpacing: CGFloat {
        let natural = UIFont(name: style.spec.face.rawValue, size: size)?.lineHeight ?? size
        return size * style.spec.lineHeight - natural
    }
}

extension View {
    /// Applies a design-system text style: font, size (scales with Dynamic Type), line height and letter spacing.
    func dsTextStyle(_ style: DSTextStyle) -> some View {
        modifier(DSTextStyleModifier(style: style))
    }
}
