/-
Copyright (c) 2026 Evidence Press.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Evidence Press
-/
import BorderedJacobian.AnchorMinor

/-!
# The bordered Jacobian identity

This file composes the Euler kernel calculation, the anchored Sylvester minor and the abstract
bordered-determinant bridge.  The first theorem is stated over an integral domain with nonzero
leading coefficient; a later universal-coefficient specialization removes those temporary proof
hypotheses.
-/

open scoped BigOperators

namespace BorderedJacobian

variable {R : Type*} [CommRing R] [IsDomain R]

/--
The bordered Jacobian identity, first proved on the chart where the leading coefficient `aᵣ`
is nonzero.  The sign and resultant convention are exactly those of the Evidence Press release.
-/
theorem borderedJacobian_of_leadingCoeff_ne_zero {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R)
    (v : Fin (r + s + 2) → R) (ha : a (Fin.last r) ≠ 0) :
    (Matrix.borderLast (multiplicationJacobian a b) v).det =
      (-1 : R) ^ (s * (r + 1) + 1) * releaseResultant a b *
        (∑ j, kernelVector a b j * v j) := by
  have hminor :
      ((multiplicationJacobian a b).submatrix id (anchorIndex r s).succAbove).det =
        ((-1 : R) ^ (r * s) * releaseResultant a b) *
          kernelVector a b (anchorIndex r s) := by
    rw [multiplicationJacobian_delete_anchor, det_anchorMinor_release,
      kernelVector_anchor]
  have hborder :
      (Matrix.borderLast (multiplicationJacobian a b) v).det =
        (-1 : R) ^ ((r + s + 1) + r) *
          ((-1 : R) ^ (r * s) * releaseResultant a b) *
            (∑ j, kernelVector a b j * v j) := by
    simpa [anchorIndex] using
      (Matrix.det_borderLast_of_kernel_and_anchor_minor
        (M := multiplicationJacobian a b) (κ := kernelVector a b) (v := v)
        (j₀ := anchorIndex r s)
        (c := (-1 : R) ^ (r * s) * releaseResultant a b)
        (by simpa using ha) (kernelVector_mul_jacobian a b) hminor)
  have hsign :
      (-1 : R) ^ ((r + s + 1) + r) * (-1 : R) ^ (r * s) =
        (-1 : R) ^ (s * (r + 1) + 1) := by
    rw [← pow_add]
    have hexp :
        ((r + s + 1) + r) + r * s = (s * (r + 1) + 1) + 2 * r := by
      omega
    rw [hexp, pow_add, pow_mul]
    norm_num
  rw [hborder]
  calc
    (-1 : R) ^ ((r + s + 1) + r) *
          ((-1 : R) ^ (r * s) * releaseResultant a b) *
          (∑ j, kernelVector a b j * v j) =
        ((-1 : R) ^ ((r + s + 1) + r) * (-1 : R) ^ (r * s)) *
          releaseResultant a b * (∑ j, kernelVector a b j * v j) := by
      ring
    _ = (-1 : R) ^ (s * (r + 1) + 1) * releaseResultant a b *
          (∑ j, kernelVector a b j * v j) := by
      rw [hsign]

end BorderedJacobian
