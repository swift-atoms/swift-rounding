import Rounding
import Testing

@Suite
struct `Rounding applies directed and nearest policies` {
    @Suite struct `Scalar rounding follows directed nearest exact and odd policies` {}
    @Suite struct `Scalar rounding handles negative values and values away from ties` {}
    @Suite struct `No scalar rounding integration cases are defined` {}
    @Suite(.serialized) struct `No scalar rounding performance cases are defined` {}
}

extension `Rounding applies directed and nearest policies`.`Scalar rounding follows directed nearest exact and odd policies` {
    @Test
    func `Directed rounding selects the requested integer boundary`() throws {
        #expect(try 2.5.rounding(.down) == 2.0)
        #expect(try 2.5.rounding(.up) == 3.0)
        #expect(try 2.5.rounding(.zero) == 2.0)
        #expect(try 2.5.rounding(.away) == 3.0)
    }

    @Test
    func `Nearest rounding resolves halfway values toward even integers`() throws {
        #expect(try 2.5.rounding(.even) == 2.0)
        #expect(try 3.5.rounding(.even) == 4.0)
    }

    @Test
    func `Nearest rounding applies the selected halfway tie breaker`() throws {
        #expect(try 2.5.rounding(.nearest(.up)) == 3.0)
        #expect(try 2.5.rounding(.nearest(.down)) == 2.0)
        #expect(try 2.5.rounding(.nearest(.away)) == 3.0)
        #expect(try 2.5.rounding(.nearest(.zero)) == 2.0)
    }

    @Test
    func `Odd rounding maps inexact values to an odd integer`() throws {
        #expect(try 2.0.rounding(.odd) == 2.0)
        #expect(try 2.5.rounding(.odd) == 3.0)
        #expect(try 3.5.rounding(.odd) == 3.0)
    }

    @Test
    func `Exact rounding preserves integer values`() throws {
        #expect(try 2.0.rounding(.exact) == 2.0)
        #expect(try (-3.0).rounding(.exact) == -3.0)
    }
}

extension `Rounding applies directed and nearest policies`.`Scalar rounding handles negative values and values away from ties` {
    @Test
    func `Directed rounding handles negative values according to its policy`() throws {
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
