/-
Copyright (c) 2026 Evidence Press.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Evidence Press
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Algebra.BigOperators.Fin

/-!
# A bordered-determinant bridge

This file isolates the finite-linear-algebra step needed for the bordered Jacobian identity.
It turns a right-kernel vector and one anchored maximal minor into the determinant of every
bordered square matrix.  The proof replaces the anchor column by the corresponding linear
combination of all columns, expands along that column, and cancels its nonzero anchor coordinate.
-/

open scoped BigOperators

namespace Matrix

variable {R : Type*} [CommRing R]

/-- Append a row to an `n × (n+1)` matrix. -/
def borderLast {n : ℕ} (M : Matrix (Fin n) (Fin (n + 1)) R)
    (v : Fin (n + 1) → R) : Matrix (Fin (n + 1)) (Fin (n + 1)) R :=
  fun i j ↦ if h : (i : ℕ) < n then M ⟨i, h⟩ j else v j

@[simp]
theorem borderLast_castSucc {n : ℕ} (M : Matrix (Fin n) (Fin (n + 1)) R)
    (v : Fin (n + 1) → R) (i : Fin n) (j : Fin (n + 1)) :
    borderLast M v i.castSucc j = M i j := by
  simp [borderLast]

@[simp]
theorem borderLast_last {n : ℕ} (M : Matrix (Fin n) (Fin (n + 1)) R)
    (v : Fin (n + 1) → R) (j : Fin (n + 1)) :
    borderLast M v (Fin.last n) j = v j := by
  simp [borderLast]

/--
Let `M` be an `n × (n+1)` matrix and let `κ` be a right-kernel vector.  If one coordinate
`κ j₀` is nonzero and the maximal minor obtained by deleting column `j₀` is `c * κ j₀`,
then bordering `M` by any row `v` gives the expected contraction formula.

This is the abstract bookkeeping lemma behind the bordered Jacobian identity.  The domain
hypothesis is used only to cancel the universal anchor coordinate.
-/
theorem det_borderLast_of_kernel_and_anchor_minor [IsDomain R] {n : ℕ}
    (M : Matrix (Fin n) (Fin (n + 1)) R) (κ v : Fin (n + 1) → R)
    (j₀ : Fin (n + 1)) (c : R)
    (hj₀ : κ j₀ ≠ 0)
    (hker : ∀ i, ∑ j, κ j * M i j = 0)
    (hminor : (M.submatrix id j₀.succAbove).det = c * κ j₀) :
    (borderLast M v).det =
      (-1 : R) ^ (n + (j₀ : ℕ)) * c * (∑ j, κ j * v j) := by
  classical
  let B : Matrix (Fin (n + 1)) (Fin (n + 1)) R := borderLast M v
  let U : Matrix (Fin (n + 1)) (Fin (n + 1)) R :=
    B.updateCol j₀ (fun i ↦ ∑ j, κ j • B i j)
  have hdet : U.det = κ j₀ * B.det := by
    simpa [U, smul_eq_mul] using Matrix.det_updateCol_sum B j₀ κ
  have htop (i : Fin n) : U i.castSucc j₀ = 0 := by
    simp [U, B, hker i, smul_eq_mul]
  have hlast : U (Fin.last n) j₀ = ∑ j, κ j * v j := by
    simp [U, B, smul_eq_mul]
  have hsub :
      U.submatrix (Fin.last n).succAbove j₀.succAbove =
        M.submatrix id j₀.succAbove := by
    ext i j
    simp [U, B]
  have hsub_cast :
      U.submatrix Fin.castSucc j₀.succAbove = M.submatrix id j₀.succAbove := by
    simpa using hsub
  have hexpand :
      U.det = (-1 : R) ^ (n + (j₀ : ℕ)) * (∑ j, κ j * v j) *
        (M.submatrix id j₀.succAbove).det := by
    rw [Matrix.det_succ_column U j₀, Fin.sum_univ_castSucc]
    simp [htop, hlast, hsub_cast]
  change B.det = (-1 : R) ^ (n + (j₀ : ℕ)) * c * (∑ j, κ j * v j)
  apply mul_left_cancel₀ hj₀
  calc
    κ j₀ * B.det = U.det := hdet.symm
    _ = (-1 : R) ^ (n + (j₀ : ℕ)) * (∑ j, κ j * v j) *
        (M.submatrix id j₀.succAbove).det := hexpand
    _ = κ j₀ * ((-1 : R) ^ (n + (j₀ : ℕ)) * c * (∑ j, κ j * v j)) := by
      rw [hminor]
      ring

end Matrix
