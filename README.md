# Rounding

Rounding chooses an integral result from a fractional value. Directional policies select toward negative infinity, positive infinity, zero, or away from zero. Nearest policies differ only at halfway cases. Odd rounding preserves exact integers and otherwise selects the adjacent odd integer; it is not nearest-odd rounding. Exact mode rejects a fractional value with `.inexact`.

Floating-point application returns an integral value in the same scalar representation, preserves signed zero, and rejects NaN and infinity with `.nonfinite`. It neither narrows to machine integer storage nor chooses a quantum. Quantizer owns the grid; explicit integer conversions own range checks.

Division and Integer apply the same policy to exact integer remainders. `incrementsMagnitude` describes a quotient truncated toward zero and the fractional magnitude's comparison with one half. A nil comparison means exactness.

The core uses Swift and Comparison without Foundation or custom C packages.
