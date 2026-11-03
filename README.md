# swift-rounding

Use this package when a value has to be rounded to an integer under a policy chosen as a value: one that can be stored, compared or encoded, that covers ties toward either infinity, round-to-odd and an exact mode that refuses to round, and that fails rather than passing NaN or infinity through. Start from `Rounding`, applied by calling it on a value or through `rounding(_:)` on any `Swift.FloatingPoint`. When one of the standard library's six rules is enough and non-finite values may pass through, use `Swift.FloatingPointRoundingRule` with `rounded(_:)` instead; `Rounding` converts from it. For integer code that keeps its own truncated quotient and remainder, `incrementsMagnitude(isNegative:integralPartIsOdd:fractionComparedToHalf:)` decides the rounding step without going through floating point.

## Laws

- Every policy rejects NaN and both infinities with `Rounding.Error.nonfinite`, before anything else is checked.
- An integral value is returned unchanged by every policy, including the sign of zero. A value that truncates to zero keeps its sign, so `Rounding.zero` turns `-0.25` into `-0.0`.
- `Rounding.exact` fails with `Rounding.Error.inexact` exactly when the value has a fractional part. No other policy fails on a finite value.
- `Rounding.Direction` rounds every non-integral value: `.down` toward negative infinity, `.up` toward positive infinity, `.zero` toward zero, `.away` away from zero.
- `Rounding.nearest(_:)` picks the closer integer. The `Rounding.Nearest` case only decides an exact half: `.down`, `.up`, `.zero` and `.away` as for `Rounding.Direction`, and `.even` to the even neighbour.
- `Rounding.odd` sends every non-integral value to whichever neighbouring integer is odd.
- The six policies that correspond to `Swift.FloatingPointRoundingRule` (`.down`, `.up`, `.zero`, `.away`, `.even`, `.nearest(.away)`) give the same result as `rounded(_:)` with that rule, at halfway values and at the values adjacent to them.
