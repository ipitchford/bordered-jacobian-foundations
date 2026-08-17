/-
Copyright (c) 2026 Evidence Press.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Evidence Press
-/
import BorderedJacobian.BorderedIdentity

/-!
# Naturality under change of coefficients

The universal-coefficient proof needs the multiplication Jacobian, its maximal minors, the Euler
kernel and the release resultant to commute with a ring homomorphism.  These lemmas isolate those
functoriality statements from the later specialization argument.
-/

namespace BorderedJacobian

variable {R S : Type*} [CommRing R] [CommRing S]

/-- The bounded coefficient polynomial commutes with a ring homomorphism. -/
theorem coefficientPolynomial_map (f : R →+* S) {n : ℕ} (u : Fin (n + 1) → R) :
    coefficientPolynomial (fun i ↦ f (u i)) = (coefficientPolynomial u).map f := by
  ext k
  rw [Polynomial.coeff_map]
  by_cases hk : k < n + 1
  · let i : Fin (n + 1) := ⟨k, hk⟩
    have h₁ := coefficientPolynomial_coeff (u := fun i ↦ f (u i)) i
    have h₂ := coefficientPolynomial_coeff (u := u) i
    simpa [i] using h₁.trans (congrArg f h₂).symm
  · have hle : n + 1 ≤ k := Nat.le_of_not_gt hk
    rw [coefficientPolynomial_coeff_eq_zero (fun i ↦ f (u i)) hle,
      coefficientPolynomial_coeff_eq_zero u hle, map_zero]

/-- A shifted bounded coefficient vector commutes with a ring homomorphism. -/
@[simp]
theorem shiftedCoefficient_map (f : R →+* S) {n : ℕ}
    (u : Fin (n + 1) → R) (d k : ℕ) :
    ((Polynomial.X ^ d) * coefficientPolynomial (fun i ↦ f (u i))).coeff k =
      f (((Polynomial.X ^ d) * coefficientPolynomial u).coeff k) := by
  rw [coefficientPolynomial_map]
  calc
    (((Polynomial.X : Polynomial S) ^ d) * (coefficientPolynomial u).map f).coeff k =
        ((((Polynomial.X : Polynomial R) ^ d) * coefficientPolynomial u).map f).coeff k := by
      simp
    _ = f ((((Polynomial.X : Polynomial R) ^ d) * coefficientPolynomial u).coeff k) := by
      rw [Polynomial.coeff_map]

/-- The tail of the Euler kernel commutes with a ring homomorphism. -/
theorem kernelTail_map (f : R →+* S) {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) (k : Fin (r + s + 1)) :
    kernelTail (fun i ↦ f (a i)) (fun j ↦ f (b j)) k = f (kernelTail a b k) := by
  refine Fin.lastCases ?_ (fun j ↦ ?_) k
  · simp [kernelTail]
  · induction j using Fin.addCases with
    | left i => simp [kernelTail]
    | right j => simp [kernelTail]

/-- The Euler kernel vector commutes with a ring homomorphism. -/
@[simp]
theorem kernelVector_map (f : R →+* S) {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) (k : Fin (r + s + 2)) :
    kernelVector (fun i ↦ f (a i)) (fun j ↦ f (b j)) k = f (kernelVector a b k) := by
  refine (anchorIndex r s).succAboveCases ?_ (fun j ↦ ?_) k
  · simp
  · simp [kernelTail_map]

/-- The same kernel naturality, oriented for mapping an established identity. -/
theorem map_kernelVector (f : R →+* S) {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) (k : Fin (r + s + 2)) :
    f (kernelVector a b k) =
      kernelVector (fun i ↦ f (a i)) (fun j ↦ f (b j)) k := by
  symm
  exact kernelVector_map f a b k

/-- The anchored square minor commutes entrywise with a ring homomorphism. -/
@[simp]
theorem anchorMinor_map_apply (f : R →+* S) {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R)
    (i : Fin (r + s + 1)) (j : Fin (r + s + 1)) :
    anchorMinor (fun k ↦ f (a k)) (fun k ↦ f (b k)) i j =
      f (anchorMinor a b i j) := by
  refine Fin.lastCases ?_ (fun j ↦ ?_) j
  · simp [anchorMinor]
  · induction j using Fin.addCases with
    | left j => simp [anchorMinor]
    | right j => simp [anchorMinor]

/-- The multiplication Jacobian commutes entrywise with a ring homomorphism. -/
@[simp]
theorem multiplicationJacobian_map_apply (f : R →+* S) {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R)
    (i : Fin (r + s + 1)) (j : Fin (r + s + 2)) :
    multiplicationJacobian (fun k ↦ f (a k)) (fun k ↦ f (b k)) i j =
      f (multiplicationJacobian a b i j) := by
  refine (anchorIndex r s).succAboveCases ?_ (fun j ↦ ?_) j
  · simp
  · simp

/-- The multiplication Jacobian itself is the entrywise image of the source matrix. -/
theorem multiplicationJacobian_map (f : R →+* S) {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    multiplicationJacobian (fun i ↦ f (a i)) (fun j ↦ f (b j)) =
      (multiplicationJacobian a b).map f := by
  ext i j
  simp

/-- A deleted maximal minor commutes with a ring homomorphism. -/
@[simp]
theorem map_deletedMinor (f : R →+* S) {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) (k : Fin (r + s + 2)) :
    f (((multiplicationJacobian a b).submatrix id k.succAbove).det) =
      ((multiplicationJacobian (fun i ↦ f (a i)) (fun j ↦ f (b j))).submatrix
        id k.succAbove).det := by
  rw [f.map_det]
  congr 1
  ext i j
  simp

/-- The resultant convention used by the release commutes with a ring homomorphism. -/
@[simp]
theorem map_releaseResultant (f : R →+* S) {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    f (releaseResultant a b) =
      releaseResultant (fun i ↦ f (a i)) (fun j ↦ f (b j)) := by
  simp only [releaseResultant]
  rw [coefficientPolynomial_map, coefficientPolynomial_map,
    Polynomial.resultant_map_map]

end BorderedJacobian
