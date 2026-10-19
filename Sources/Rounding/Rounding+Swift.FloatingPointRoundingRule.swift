extension Rounding {
    public init(_ rule: FloatingPointRoundingRule) {
        switch rule {
        case .down: self = .down
        case .up: self = .up
        case .towardZero: self = .zero
        case .awayFromZero: self = .away
        case .toNearestOrEven: self = .even
        case .toNearestOrAwayFromZero: self = .nearest(.away)
        @unknown default: self = .even
        }
    }
}
