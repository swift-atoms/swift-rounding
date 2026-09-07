extension Swift.FloatingPoint {
    public func rounding(_ rule: Rounding) throws(Rounding.Error) -> Self { try rule(self) }
}
