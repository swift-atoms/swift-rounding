public import Comparison


public enum Rounding: Sendable, Equatable {
    case direction(Direction)
    case nearest(Nearest)

    case odd

    case exact

    public enum Direction: Sendable, Equatable, CaseIterable { case down, up, zero, away }
    public enum Nearest: Sendable, Equatable, CaseIterable { case down, up, zero, away, even }
    public enum Error: Swift.Error, Sendable, Equatable { case nonfinite, inexact }

    public static var down: Self { .direction(.down) }
    public static var up: Self { .direction(.up) }
    public static var zero: Self { .direction(.zero) }
    public static var away: Self { .direction(.away) }
    public static var even: Self { .nearest(.even) }




    public func incrementsMagnitude(
        isNegative: Bool,
        integralPartIsOdd: Bool,
        fractionComparedToHalf: Comparison?
    ) throws(Error) -> Bool {
        guard let comparison = fractionComparedToHalf else { return false }
        switch self {
        case .exact: throw .inexact
        case .odd: return !integralPartIsOdd
        case .direction(.down): return isNegative
        case .direction(.up): return !isNegative
        case .direction(.zero): return false
        case .direction(.away): return true
        case .nearest(let tie):
            switch comparison {
            case .less: return false
            case .greater: return true
            case .equal:
                switch tie {
                case .down: return isNegative
                case .up: return !isNegative
                case .zero: return false
                case .away: return true
                case .even: return integralPartIsOdd
                }
            }
        }
    }


    public func callAsFunction<T: FloatingPoint>(_ value: T) throws(Error) -> T {
        guard value.isFinite else { throw .nonfinite }
        let integral = value.rounded(.towardZero)
        let fraction = (value - integral).magnitude
        let half: T = 1 / 2
        let comparison: Comparison? = fraction == 0 ? nil : (fraction < half ? .less : (fraction > half ? .greater : .equal))
        let increment = try incrementsMagnitude(
            isNegative: value.sign == .minus,
            integralPartIsOdd: integral.truncatingRemainder(dividingBy: 2) != 0,
            fractionComparedToHalf: comparison
        )
        return increment ? integral + T(signOf: value, magnitudeOf: 1) : integral
    }
}

#if !hasFeature(Embedded)
extension Rounding: Swift.Codable {}
extension Rounding.Direction: Swift.Codable {}
extension Rounding.Nearest: Swift.Codable {}
#endif
