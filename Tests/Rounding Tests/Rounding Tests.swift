import Rounding
import Testing

@Suite struct `Rounding enforces its numerical contract` {
    @Test func `Rounding rejects invalid values and preserves signed zero`() throws {
        #expect(throws: Rounding.Error.nonfinite) { try Rounding.down(Double.nan) }
        #expect(throws: Rounding.Error.nonfinite) { try Rounding.even(Double.infinity) }
        #expect(throws: Rounding.Error.inexact) { try Rounding.exact(1.5) }
        #expect(try Rounding.exact(-0.0).sign == .minus)
        #expect(try Rounding.zero(-0.25).sign == .minus)
    }

    @Test func `Rounding agrees with Swift at halfway and adjacent values`() throws {
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

    @Test func `Rounding converts each standard rule to the policy with the same results`() throws {
        let rules: [FloatingPointRoundingRule] = [
            .down, .up, .towardZero, .awayFromZero, .toNearestOrEven, .toNearestOrAwayFromZero,
        ]
        for rule in rules {
            for value in [-2.5, -1.5, -0.5, 0.5, 1.5, 2.5, 2.25, -2.75] {
                #expect(try Rounding(rule)(value) == value.rounded(rule))
            }
        }
    }
}
