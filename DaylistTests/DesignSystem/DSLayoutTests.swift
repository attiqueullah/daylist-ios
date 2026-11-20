import CoreGraphics
@testable import Daylist
import Testing

/// Checks spacing, radius and elevation tokens against the Figma "Daylist layout" variables and effect styles.
struct DSLayoutTests {
    @Test func spacingScaleMatchesFigma() {
        let scale: [CGFloat] = [
            DSSpace.s4, DSSpace.s8, DSSpace.s12, DSSpace.s16,
            DSSpace.s20, DSSpace.s24, DSSpace.s32, DSSpace.s40,
        ]
        #expect(scale == [4, 8, 12, 16, 20, 24, 32, 40])
    }

    @Test func radiiMatchFigma() {
        let radii: [CGFloat] = [DSRadius.r8, DSRadius.r12, DSRadius.r16, DSRadius.r20, DSRadius.r28, DSRadius.full]
        #expect(radii == [8, 12, 16, 20, 28, 999])
    }

    @Test func elevationOneMatchesFigma() {
        #expect(DSElevation.one.offsetY == 1)
        #expect(DSElevation.one.blur == 2)
        #expect(DSElevation.one.opacity == 0.08)
    }

    @Test func elevationTwoMatchesFigma() {
        #expect(DSElevation.two.offsetY == 6)
        #expect(DSElevation.two.blur == 24)
        #expect(DSElevation.two.opacity == 0.12)
    }
}
