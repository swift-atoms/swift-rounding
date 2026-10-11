extension Rounding {
    public enum Direction: Sendable, Equatable, CaseIterable { case down, up, zero, away }
}

#if !hasFeature(Embedded)
extension Rounding.Direction: Swift::Codable {}
#endif
