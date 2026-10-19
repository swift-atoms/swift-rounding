extension Rounding {
    public enum Nearest: Sendable, Hashable, CaseIterable { case down, up, zero, away, even }
}

#if !hasFeature(Embedded)
    extension Rounding.Nearest: Swift::Codable {}
#endif
