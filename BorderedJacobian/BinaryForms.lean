/-
Copyright (c) 2026 Evidence Press.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Evidence Press
-/
import BorderedJacobian.LinearAlgebra
import Mathlib.Algebra.Polynomial.OfFn
import Mathlib.RingTheory.Polynomial.Resultant.Basic
import Mathlib.Tactic

/-!
# Binary-form multiplication matrices

This file fixes the coefficient ordering used in the Evidence Press release.  The columns of the
multiplication Jacobian are `a₀,…,aᵣ,b₀,…,bₛ`; the distinguished column is `aᵣ`.  Deleting that
column leaves the square matrix whose first `r` columns are the shifts of `B`, whose next `s`
columns are the first `s` shifts of `A`, and whose final column is `X^s A`.
-/

open scoped BigOperators

namespace BorderedJacobian

open Polynomial

variable {R : Type*} [CommRing R]

/-- The polynomial with coefficient vector `u`. -/
noncomputable def coefficientPolynomial {n : ℕ} (u : Fin (n + 1) → R) : Polynomial R :=
  Polynomial.ofFn (n + 1) u

/-- The column occupied by `aᵣ` in the release ordering. -/
def anchorIndex (r s : ℕ) : Fin (r + s + 2) :=
  ⟨r, by omega⟩

/--
The square matrix obtained from the multiplication Jacobian by deleting the `aᵣ` column.
Its final column is the derivative with respect to `bₛ`.
-/
noncomputable def anchorMinor {r s : ℕ} (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    Matrix (Fin (r + s + 1)) (Fin (r + s + 1)) R :=
  fun k ↦ Fin.snoc
    (Fin.addCases
      (fun i : Fin r ↦
        ((Polynomial.X ^ (i : ℕ)) * coefficientPolynomial b).coeff (k : ℕ))
      (fun j : Fin s ↦
        ((Polynomial.X ^ (j : ℕ)) * coefficientPolynomial a).coeff (k : ℕ)))
    (((Polynomial.X ^ s) * coefficientPolynomial a).coeff (k : ℕ))

/-- The coefficient Jacobian of binary-form multiplication, in release column order. -/
noncomputable def multiplicationJacobian {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    Matrix (Fin (r + s + 1)) (Fin (r + s + 2)) R :=
  fun k ↦ (anchorIndex r s).insertNth
    (((Polynomial.X ^ r) * coefficientPolynomial b).coeff (k : ℕ))
    (anchorMinor a b k)

/-- The Euler kernel vector `(a₀,…,aᵣ,−b₀,…,−bₛ)`. -/
def kernelVector {r s : ℕ} (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    Fin (r + s + 2) → R :=
  (anchorIndex r s).insertNth (a (Fin.last r))
    (Fin.snoc
      (Fin.addCases
        (fun i : Fin r ↦ a i.castSucc)
        (fun j : Fin s ↦ -b j.castSucc))
      (-b (Fin.last s)))

/-- The release resultant convention: shifts of `A`, then shifts of `B`. -/
noncomputable def releaseResultant {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) : R :=
  (coefficientPolynomial b).resultant (coefficientPolynomial a) s r

@[simp]
theorem multiplicationJacobian_anchor {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) (k : Fin (r + s + 1)) :
    multiplicationJacobian a b k (anchorIndex r s) =
      ((Polynomial.X ^ r) * coefficientPolynomial b).coeff (k : ℕ) := by
  simp [multiplicationJacobian]

@[simp]
theorem multiplicationJacobian_succAbove {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R)
    (k : Fin (r + s + 1)) (j : Fin (r + s + 1)) :
    multiplicationJacobian a b k ((anchorIndex r s).succAbove j) = anchorMinor a b k j := by
  simp [multiplicationJacobian]

@[simp]
theorem kernelVector_anchor {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    kernelVector a b (anchorIndex r s) = a (Fin.last r) := by
  simp [kernelVector]

@[simp]
theorem kernelVector_succAbove {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) (j : Fin (r + s + 1)) :
    kernelVector a b ((anchorIndex r s).succAbove j) =
      Fin.snoc
        (Fin.addCases
          (fun i : Fin r ↦ a i.castSucc)
          (fun i : Fin s ↦ -b i.castSucc))
        (-b (Fin.last s)) j := by
  simp [kernelVector]

@[simp]
theorem multiplicationJacobian_delete_anchor {r s : ℕ}
    (a : Fin (r + 1) → R) (b : Fin (s + 1) → R) :
    (multiplicationJacobian a b).submatrix id (anchorIndex r s).succAbove =
      anchorMinor a b := by
  ext i j
  simp

end BorderedJacobian
