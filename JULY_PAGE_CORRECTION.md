# Suggested correction to the July release page

Page: https://evidencepress.org/releases/degree-difference-affine-slices/

The current **Verification Boundary** section states:

> The accompanying SymPy script validates the determinant identity for
> bidegrees r+s ≤ 4 via Sylvester-matrix computation and base-point
> signs through degree eight, including negative controls.

This overstates the shipped script. The released
`verify_degree_difference_affine_slices.py` (draft and final
byte-identical; receipt lists six checks) verifies the base-point
sign matrix for r,s ≤ 8 and the cubic-specific algebra
(parametrisation, inverse, G, F, discriminant, collision), but does
**not** verify the determinant identity det DΦ = ±(r−s)Res² at any
bidegree. It also contains no negative controls.

Suggested replacement text:

> The accompanying SymPy script validates the base-point sign matrix
> for degrees up to eight and the cubic case's parametrisation,
> inverse, conjugacy, and discriminant algebra exactly over ℚ. The
> determinant identity itself was not machine-checked in this
> release; the companion foundations release [link] now verifies it
> per bidegree through r+s ≤ 8 in two separately written computational
> backends, with negative controls, and re-proves it over ℤ.

Rationale for correcting rather than silently superseding: the
release's stated assurance boundary is itself a published claim, and
Evidence Press's value rests on those boundaries being exact.
