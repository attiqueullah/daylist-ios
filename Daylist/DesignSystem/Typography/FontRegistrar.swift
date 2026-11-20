import CoreText
import Foundation

/// The bundled font files, named by their PostScript name.
nonisolated enum DSFontFace: String, CaseIterable, Sendable {
    case interRegular = "Inter-Regular"
    case interMedium = "Inter-Medium"
    case interSemiBold = "Inter-SemiBold"
    case interBold = "Inter-Bold"
    case spaceGroteskMedium = "SpaceGrotesk-Medium"
    case spaceGroteskBold = "SpaceGrotesk-Bold"

    /// Name of the `.ttf` file in `Resources/Fonts`.
    var fileName: String {
        switch self {
        case .interRegular: "Inter_400Regular"
        case .interMedium: "Inter_500Medium"
        case .interSemiBold: "Inter_600SemiBold"
        case .interBold: "Inter_700Bold"
        case .spaceGroteskMedium: "SpaceGrotesk_500Medium"
        case .spaceGroteskBold: "SpaceGrotesk_700Bold"
        }
    }
}

/// Makes the bundled fonts available to the app without listing them in Info.plist.
enum FontRegistrar {
    /// Registers every bundled font for this process. Safe to call more than once.
    /// - Returns: The number of fonts that are available after the call.
    @discardableResult
    static func registerAll(in bundle: Bundle = .main) -> Int {
        DSFontFace.allCases.filter { face in
            guard let url = bundle.url(forResource: face.fileName, withExtension: "ttf") else { return false }
            var error: Unmanaged<CFError>?
            if CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error) { return true }
            let code = error.map { CFErrorGetCode($0.takeRetainedValue()) }
            return code == CFIndex(CTFontManagerError.alreadyRegistered.rawValue)
        }.count
    }
}
