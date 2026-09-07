import Rounding
import Testing

@Suite("Rounding")
struct NumericRoundingTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

extension NumericRoundingTests.Unit {
    @Test
    func `directed rounding modes`() throws {
        #expect(try 2.5.rounding(.down) == 2.0)
        #expect(try 2.5.rounding(.up) == 3.0)
        #expect(try 2.5.rounding(.zero) == 2.0)
        #expect(try 2.5.rounding(.away) == 3.0)
    }

    @Test
    func `nearest rounding ties to even`() throws {
        #expect(try 2.5.rounding(.even) == 2.0)
        #expect(try 3.5.rounding(.even) == 4.0)
    }

    @Test
    func `nearest rounding with tie breakers`() throws {
        #expect(try 2.5.rounding(.nearest(.up)) == 3.0)
        #expect(try 2.5.rounding(.nearest(.down)) == 2.0)
        #expect(try 2.5.rounding(.nearest(.away)) == 3.0)
        #expect(try 2.5.rounding(.nearest(.zero)) == 2.0)
    }

    @Test
    func `odd rounding`() throws {
        #expect(try 2.0.rounding(.odd) == 2.0)
        #expect(try 2.5.rounding(.odd) == 3.0)
        #expect(try 3.5.rounding(.odd) == 3.0)
    }

    @Test
    func `exact rounding for integers`() throws {
        #expect(try 2.0.rounding(.exact) == 2.0)
        #expect(try (-3.0).rounding(.exact) == -3.0)
    }
}

extension NumericRoundingTests.EdgeCase {
    @Test
    func `negative values with directed rounding`() throws {
        #expect(try (-2.5).rounding(.down) == -3.0)
        #expect(try (-2.5).rounding(.up) == -2.0)
        #expect(try (-2.5).rounding(.zero) == -2.0)
        #expect(try (-2.5).rounding(.away) == -3.0)
    }

    @Test
    func `non-tie values round to nearest`() throws {
        #expect(try 2.3.rounding(.even) == 2.0)
        #expect(try 2.3.rounding(.nearest(.up)) == 2.0)
        #expect(try 2.3.rounding(.nearest(.down)) == 2.0)

        #expect(try 2.7.rounding(.even) == 3.0)
        #expect(try 2.7.rounding(.nearest(.up)) == 3.0)
        #expect(try 2.7.rounding(.nearest(.down)) == 3.0)
    }
}
