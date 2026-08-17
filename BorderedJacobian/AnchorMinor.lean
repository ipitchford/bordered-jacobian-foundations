/-
Copyright (c) 2026 Evidence Press.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Evidence Press
-/
import BorderedJacobian.BinaryForms
import Mathlib.Algebra.Polynomial.Coeff

/-!
# The anchored maximal minor

The upper-left block of the `aᵣ`-deleted multiplication Jacobian is Mathlib's Sylvester
matrix.  Its final row vanishes except at the final entry, which is `aᵣ`.  A Laplace expansion
therefore identifies the anchored maximal minor with the resultant, with the convention-change
sign recorded explicitly.
-/

namespace BorderedJacobian

open Polynomial

variable {R : Type*} [CommRing R]

/-- A shifted bounded coefficient vector is exactly the corresponding Sylvester entry. -/
theorem coeff_X_pow_mul_coefficientPolynomial {n : ℕ}
    (u : Fin (n + 1) → R) (d k : ℕ) :
    ((Polynomial.X ^ d) * coefficientPolynomial u).coeff k =
      if k ∈ Set.Icc d (d + n) then (coefficientPolynomial u).coeff (k - d) else 0 := by
  rw [Polynomial.coeff_X_pow_mul']
  simp only [Set.mem_Icc]
  by_cases hdk : d ≤ k
  · rw [if_pos hdk]
    by_cases hkn : k ≤ d + n
    · rw [if_pos ⟨hdk, hkn⟩]
    · rw [if_neg (by simp [hdk, hkn])]
      exact coefficientPolynomial_coeff_eq_zero u (by omega)
  · rw [if_neg hdk, if_neg (by simp [hdk])]

/-- Deleting the bottom row and final column of the anchor minor gives the Sylvester matrix. -/
theorem anchorMinor_core {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    (anchorMinor a b).submatrix Fin.castSucc Fin.castSucc =
      Polynomial.sylvester (coefficientPolynomial a) (coefficientPolynomial b) r s := by
  classical
  ext i j
  induction j using Fin.addCases with
  | left j =>
      simp [anchorMinor, Polynomial.sylvester,
        coeff_X_pow_mul_coefficientPolynomial]
  | right j =>
      have hcast :
          Fin.natAdd r j.castSucc = (Fin.natAdd r j).castSucc := by
        ext
        simp
      simp [anchorMinor, Polynomial.sylvester,
        coeff_X_pow_mul_coefficientPolynomial, hcast]

/-- Every non-final entry in the bottom row of the anchor minor vanishes. -/
@[simp]
theorem anchorMinor_last_castSucc {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) (j : Fin (r + s)) :
    anchorMinor a b (Fin.last (r + s)) j.castSucc = 0 := by
  classical
  induction j using Fin.addCases with
  | left j =>
      simp only [anchorMinor, Fin.snoc_castSucc, Fin.addCases_left, Fin.val_last]
      rw [coeff_X_pow_mul_coefficientPolynomial]
      simp only [Set.mem_Icc]
      rw [if_neg (by omega)]
  | right j =>
      simp only [anchorMinor, Fin.snoc_castSucc, Fin.addCases_right, Fin.val_last]
      rw [coeff_X_pow_mul_coefficientPolynomial]
      simp only [Set.mem_Icc]
      rw [if_neg (by omega)]

/-- The final entry in the bottom row is the leading coefficient `aᵣ`. -/
@[simp]
theorem anchorMinor_last_last {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    anchorMinor a b (Fin.last (r + s)) (Fin.last (r + s)) = a (Fin.last r) := by
  classical
  simp only [anchorMinor, Fin.snoc_last, Fin.val_last]
  rw [coeff_X_pow_mul_coefficientPolynomial]
  simp only [Set.mem_Icc]
  rw [if_pos (by omega)]
  simpa [show r + s - s = r by omega] using coefficientPolynomial_coeff a (Fin.last r)

/-- The anchored maximal minor is Mathlib's `A.resultant B`, times `aᵣ`. -/
theorem det_anchorMinor {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    (anchorMinor a b).det =
      (coefficientPolynomial a).resultant (coefficientPolynomial b) r s * a (Fin.last r) := by
  classical
  rw [Matrix.det_succ_row (anchorMinor a b) (Fin.last (r + s)), Fin.sum_univ_castSucc]
  simp only [anchorMinor_last_castSucc, mul_zero, zero_mul, Finset.sum_const_zero, zero_add,
    anchorMinor_last_last, Fin.val_last]
  have hsub :
      (anchorMinor a b).submatrix (Fin.last (r + s)).succAbove
          (Fin.last (r + s)).succAbove =
        Polynomial.sylvester (coefficientPolynomial a) (coefficientPolynomial b) r s := by
    simpa using anchorMinor_core a b
  have hsign : (-1 : R) ^ ((r + s) + (r + s)) = 1 := by
    rw [show (r + s) + (r + s) = 2 * (r + s) by omega, pow_mul]
    norm_num
  rw [hsign, one_mul, hsub]
  simp [Polynomial.resultant, mul_comm]

/-- The same determinant in the resultant convention used by the release. -/
theorem det_anchorMinor_release {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    (anchorMinor a b).det =
      (-1 : R) ^ (r * s) * releaseResultant a b * a (Fin.last r) := by
  rw [det_anchorMinor, Polynomial.resultant_comm]
  simp [releaseResultant, mul_assoc]

end BorderedJacobian
