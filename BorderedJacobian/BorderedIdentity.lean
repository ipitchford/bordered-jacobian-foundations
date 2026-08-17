/-
Copyright (c) 2026 Evidence Press.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Evidence Press
-/
import BorderedJacobian.AnchorMinor

/-!
# The bordered Jacobian and signed-minor identities

This file composes the Euler kernel calculation, the anchored Sylvester minor and the abstract
bordered-determinant bridge.  It first proves both release identities over an integral domain on
the chart where the leading coefficient `aᵣ` is nonzero.  A universal-coefficient specialization
will remove those temporary proof hypotheses.
-/

open scoped BigOperators

namespace Matrix

variable {R : Type*}

/-- The coordinate row supported at `k`. -/
def basisRow [Zero R] [One R] {n : ℕ} (k : Fin n) : Fin n → R :=
  fun j ↦ if j = k then 1 else 0

@[simp]
theorem basisRow_same [Zero R] [One R] {n : ℕ} (k : Fin n) :
    basisRow (R := R) k k = 1 := by
  simp [basisRow]

@[simp]
theorem basisRow_ne [Zero R] [One R] {n : ℕ} {j k : Fin n} (h : j ≠ k) :
    basisRow (R := R) k j = 0 := by
  simp [basisRow, h]

/-- Laplace expansion of a bordered matrix whose final row is a coordinate row. -/
theorem det_borderLast_basisRow [CommRing R] {n : ℕ}
    (M : Matrix (Fin n) (Fin (n + 1)) R) (k : Fin (n + 1)) :
    (borderLast M (basisRow (R := R) k)).det =
      (-1 : R) ^ (n + (k : ℕ)) * (M.submatrix id k.succAbove).det := by
  classical
  rw [Matrix.det_succ_row (borderLast M (basisRow (R := R) k)) (Fin.last n)]
  have hsub (j : Fin (n + 1)) :
      (borderLast M (basisRow (R := R) k)).submatrix
          (Fin.last n).succAbove j.succAbove = M.submatrix id j.succAbove := by
    ext i l
    simp
  simp_rw [hsub]
  simp [basisRow]

end Matrix

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
      ring
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

/--
The signed maximal-minor identity on the same nonzero-leading-coefficient chart.
This is obtained from the bordered theorem by using a coordinate row and Laplace expansion.
-/
theorem signedMinor_of_leadingCoeff_ne_zero {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R)
    (k : Fin (r + s + 2)) (ha : a (Fin.last r) ≠ 0) :
    (-1 : R) ^ (k : ℕ) *
        ((multiplicationJacobian a b).submatrix id k.succAbove).det =
      (-1 : R) ^ (r * (s + 1)) * releaseResultant a b * kernelVector a b k := by
  have heq :
      (-1 : R) ^ ((r + s + 1) + (k : ℕ)) *
          ((multiplicationJacobian a b).submatrix id k.succAbove).det =
        (-1 : R) ^ (s * (r + 1) + 1) * releaseResultant a b *
          kernelVector a b k := by
    rw [← Matrix.det_borderLast_basisRow (multiplicationJacobian a b) k]
    simpa [Matrix.basisRow] using
      (borderedJacobian_of_leadingCoeff_ne_zero a b
        (Matrix.basisRow (R := R) k) ha)
  have hleft :
      (-1 : R) ^ (r + s + 1) *
          (-1 : R) ^ ((r + s + 1) + (k : ℕ)) = (-1 : R) ^ (k : ℕ) := by
    rw [← pow_add]
    have hexp :
        (r + s + 1) + ((r + s + 1) + (k : ℕ)) =
          (k : ℕ) + 2 * (r + s + 1) := by
      ring
    rw [hexp, pow_add, pow_mul]
    norm_num
  have hright :
      (-1 : R) ^ (r + s + 1) * (-1 : R) ^ (s * (r + 1) + 1) =
        (-1 : R) ^ (r * (s + 1)) := by
    rw [← pow_add]
    have hexp :
        (r + s + 1) + (s * (r + 1) + 1) =
          r * (s + 1) + 2 * (s + 1) := by
      ring
    rw [hexp, pow_add, pow_mul]
    norm_num
  calc
    (-1 : R) ^ (k : ℕ) *
          ((multiplicationJacobian a b).submatrix id k.succAbove).det =
        ((-1 : R) ^ (r + s + 1) *
          (-1 : R) ^ ((r + s + 1) + (k : ℕ))) *
          ((multiplicationJacobian a b).submatrix id k.succAbove).det := by
      rw [hleft]
    _ = (-1 : R) ^ (r + s + 1) *
        ((-1 : R) ^ ((r + s + 1) + (k : ℕ)) *
          ((multiplicationJacobian a b).submatrix id k.succAbove).det) := by
      ring
    _ = (-1 : R) ^ (r + s + 1) *
        ((-1 : R) ^ (s * (r + 1) + 1) * releaseResultant a b *
          kernelVector a b k) := by
      rw [heq]
    _ = ((-1 : R) ^ (r + s + 1) *
          (-1 : R) ^ (s * (r + 1) + 1)) *
          releaseResultant a b * kernelVector a b k := by
      ring
    _ = (-1 : R) ^ (r * (s + 1)) * releaseResultant a b *
          kernelVector a b k := by
      rw [hright]

end BorderedJacobian
