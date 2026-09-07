import Rounding
import Testing

@Suite struct RoundingContractTests {
    @Test func failuresAndSignedZero() throws {
        #expect(throws: Rounding.Error.nonfinite) { try Rounding.down(Double.nan) }
        #expect(throws: Rounding.Error.nonfinite) { try Rounding.even(Double.infinity) }
        #expect(throws: Rounding.Error.inexact) { try Rounding.exact(1.5) }
        #expect(try Rounding.exact(-0.0).sign == .minus)
        #expect(try Rounding.zero(-0.25).sign == .minus)
    }

    @Test func agreesWithSwiftRulesAcrossHalfwayAndAdjacentValues() throws {
        let policies: [(Rounding, FloatingPointRoundingRule)] = [
            (.down, .down), (.up, .up), (.zero, .towardZero), (.away, .awayFromZero),
            (.even, .toNearestOrEven), (.nearest(.away), .toNearestOrAwayFromZero),
        ]
        for integer in -40...40 {
            let halfway = Double(integer) + 0.5
            for value in [halfway.nextDown, halfway, halfway.nextUp] {
                for (policy, standard) in policies {
                    #expect(try policy(value) == value.rounded(standard))
                }
            }
        }
    }
}
