# Novelty-gate report — bordered Jacobian foundations release

Search date: 6 August 2026.  Gate: formula-first prior-art and
object-identity check, per the novelty-gate protocol.  This report
records the bounded search behind the priority language used in
Section 7 of the manuscript.  Negative findings mean "not found in
the bounded search described here", never "proved novel".

## Objects and claims frozen

1. **Statement A** (degree-difference identity):
   det DΦ_{r,s} = (−1)^{s(r+1)}(r−s)Res² for binary-form
   multiplication-plus-resultant.
2. **Statement B** (bordered/minor identity): signed maximal minors of
   the multiplication Jacobian equal (−1)^{r(s+1)}·Res·κ_k;
   bordered form det[M;v] = (−1)^{s(r+1)+1}·Res·⟨v,κ⟩, uniform in
   r,s including r = s.
3. **Derivation** of A (and char-p, pullback obstruction, equal-degree
   localisation) from B via the Euler identity, over ℤ.
4. **Artefacts**: two-backend exact verification suite;
   Mathlib formalization blueprint.

## Search rings executed

- **Ring 1 (original sources).** Speyer thread (Secret Blogging
  Seminar, 20–24 July 2026): contains Skooi's ℤ/(d−2) class-group
  observation and Mondal's ℤ/(a−b) generalisation; no Jacobian
  determinant formula, no minors/Koszul statement.  Tao's digestion
  post (21 July 2026): explicit statement that a satisfactory
  geometric explanation was lacking; no determinant identity.
- **Ring 2 (contemporary literature).** arXiv 2608.00222 (Gao,
  August 2026, tangent-sweep counterexamples in all dimensions ≥ 3):
  framework-orthogonal; no binary-form factorisation spaces, no
  resultant Jacobian identities, no torsor/class-group content.
- **Ring 3 (classical primary literature).** The resultant as the
  determinant of a strand of the Koszul complex is classical:
  Cayley 1848; Jouanolou, Adv. Math. 90 (1991); Chardin, *The
  resultant via a Koszul complex* (MEGA 1992); Demazure,
  Enseign. Math. 58 (2012) (which reconstructs resultant formulas
  from Buchsbaum–Eisenbud determinants of complexes).  These
  establish the **principle**; searches for the specific bordered
  coordinate form, its two sign laws, and the contraction-principle
  derivation returned nothing in this exact shape.
- **Ring 4 (alias searches).** "derivative of the resultant",
  "gradient of the resultant", "maximal minors" + Sylvester +
  kernel, subresultant/adjugate literature: no statement-level
  collision found for B in bordered form.

## Adjudication by contribution unit

| Unit | Outcome |
|---|---|
| Statement A | Priority remains with the July 2026 release (DOI 10.5281/zenodo.21647593); nothing earlier or contemporaneous found. This release contributes a **new proof**, not a new statement. |
| Statement B, abstract principle | **COLLISION (intended)** with classical strand-determinant theory — cited, not claimed. |
| Statement B, bordered coordinate form + sign laws + r=s uniformity | **BRIDGE / bounded**: not found in the bounded search; claimed only with the bounded-search qualification. |
| Derivation (unit 3) | New within the bounded search; claimed as the release's main contribution. |
| Artefacts (unit 4) | New. |

## Language rules applied

The manuscript claims: complete elementary integral proof; derivation
architecture; verification suite; blueprint.  It explicitly disclaims
priority over the classical strand principle and flags possible
implicit antecedents in Jouanolou/Chardin with bounded-search
language.  No "first", "novel", or "unknown" absolutes are used for
Statement B.

## Jouanolou 1991 antecedent question — RESOLVED (2026-08-06, full-text audit)

The full text of Jouanolou, *Le formalisme du résultant*, Adv. Math.
90 (1991) 117–263, was audited (sections read: §1–2 openings, §5.1–5.11
incl. Déterminant de Sylvester, Cas des formes linéaires, lemme de
divisibilité, multiplicativité, permutation, transformations
élémentaires, formule de Laplace, covariance; §6.2–6.3; §7.4–7.5 incl.
the complete *Quelques formules complémentaires*; bibliography).

**Negative for the bordered form.** The paper proves the Sylvester
strand only (ν = d₁+d₂−1, §5.2); it contains no strand determinant
above Sylvester, no Jacobian of multiplication-plus-resultant, and
no Res² identity. §7.5's complementary formulas are
norm/characteristic-polynomial and composition formulas.
**Correction (same day, via the 1997 formulary's citations):** the
1991 paper's §§4.6.3 and 6.4.2–6.4.3 (inertia forms; dual
hypersurface — sections not directly read in this audit) DO contain
gradient-of-resultant identities: X_ℓ·∂R/∂ε_m − X_m·∂R/∂ε_ℓ is an
inertia form, and φ(∂R/∂ε₁,…,∂R/∂εₙ) ≡ 0 mod R. These are mod-R
statements for the square elimination system (the gradient
reproduces the common zero mod R) — distinct from the exact,
factorization-side bordered identity. The earlier blanket "no
differential calculus" claim was wrong and is corrected in the
manuscript.

**Positive: a methodological antecedent to cite.** Prop. 5.4.4 (with
5.4.1–5.4.3): for n−1 generic linear forms, the signed maximal minors
Δ_j of the coefficient matrix satisfy Δ_j = ∂R/∂T_j for the bordered
determinant R = Res(l₁,…,l_{n−1}, λ), X_iΔ_j − X_jΔ_i lies in the
ideal of the forms, and Res(l₁,…,l_{n−1}, f) = f(Δ). This is the
linear-forms case of "bordered determinant = border evaluated at the
signed-minor/kernel vector", with no resultant factor. The release's
theorem is the analogous statement one strand above Sylvester for
binary-form multiplication, where the minors acquire the factor Res
and the Euler pairing produces the degree difference. Now cited in
the manuscript.

## Chardin 1992 antecedent question — RESOLVED (2026-08-06, full-text audit)

The full text of Chardin, *The resultant via a Koszul complex*
(MEGA-92, Progr. Math. 109, Birkhäuser, 1993, 29–39; author's PDF)
was audited — all 8 pages. It develops the McRae-invariant /
alternate-product-of-minor-determinants algorithm across strand
differentials for ν ≥ Σ(dᵢ−1)+1, with an arithmetic application
(p-adic valuation of the resultant).

**Negative for the bordered form**: no kernel-vector identification,
no sign laws, no binary-form specialisation, no Jacobian of
(product, resultant), no resultant differentials.

**Positive: the scalar shadow, now cited.** §IV Remark 1 states that
the resultant divides every maximal minor of the generalized
Sylvester matrix ∂₁^ν for ν > Σ(dᵢ−1) and equals their gcd in the
generic case. For n = 2 and ν = r+s this matrix is exactly the
multiplication Jacobian M. The release's Theorem 1.1 upgrades this
gcd statement to the exact signed vector identity
(−1)^k·minor_k = (−1)^{r(s+1)}·Res·κ_k. Cited in Remark 3.1.

## Jouanolou 1997 formulary — RESOLVED (2026-08-06, full-text audit)

The full text of *Formes d'inertie et résultant: un formulaire*
(Adv. Math. 126 (1997) 119–250; user-supplied PDF, all 132 pages)
was audited: intro + §3.9 structure, §§3.10–3.11 in detail through
the bibliography.

**Negative for the bordered form**: no strand above Sylvester for
two binary forms, no kernel-vector minor identification, no sign
laws, no Res² Jacobian, no degree-difference factor, no
étaleness/factorization content.

**Positive: three nearest-neighbour items, now cited.**
(1) §3.10.25–3.10.30 and §3.11.19.23–3.11.19.31: a bordered
Macaulay-matrix calculus — bordering by a row u and column v
computes the apolarity functional, det Θ*_ν(f;u,v) = c_ν(f)·ω(uv),
with parasitic factors computed explicitly (e.g. b = U^x̂ at n=3).
(2) §3.10.15/3.10.31: gradient-of-resultant identities mod R,
citing [J3 = 1991] §§4.6.3/6.4.2–6.4.3 (see correction above).
(3) §3.11.18.18–3.11.18.35: the explicit two-binary-forms case —
determinantal-ideal computations BELOW the Sylvester degree
(ν ≤ δ = m+n−2, injective side) for Eagon–Northcott acyclicity and
integer-coefficient inertia-form generators; Lemma 3.11.18.20 gives
Dét(M) = (U₀,…,U_m)^{v−m+1} as ideals.

## Aspects invariants 1995 — RESOLVED (2026-08-06, full-text audit)

The full text of *Aspects invariants de l'élimination* (Adv. Math.
114 (1995) 1–174; user-supplied PDF) was audited: intro/plan,
§§3.4.3–3.5.7 (singularities of the resultant, jacobian/Fitting
ideals, conductor), §3.7.1 (mod-R product congruences for
∂R/∂U_{iα}, Rees(jac(𝔄))), all of §3.8 (Wiebe transition
determinants; twisted jacobian), bibliography.

**Negative for the bordered form** — no coefficient-side
factorization Jacobian, no exact kernel-vector identity, no Res²,
no degree difference.

**Positive: the square-system dual, now cited.**
(1) §3.5.5 (linear case): bordered-determinant minors satisfy
Δᵢ = ∂Δ/∂U_{1i}, with B/ΔB ≅ Rees(Δ₁,…,Δₙ).
(2) §3.7.1.4–1.9: ∏∂R/∂U_{iα(j)} ≡ ∏∂R/∂U_{iβ(j)} mod R when
Σα = Σβ; Ker(ω̂) = inertia forms — the systematic mod-R gradient
calculus (base: 1991 §§6.4.2–3).
(3) §3.8.1.9 + §3.8.2.6–2.9: Jac(f₁,…,fₙ) ≡ d₁⋯dₙ·dét(f_ij)
mod (f₁,…,fₙ) (variable-side Jacobian; Euler identities used the
same way we use them) and ω(dét(f_ij)) = Res. The constant there is
the PRODUCT of the degrees on the elimination side; ours is the
DIFFERENCE of the degrees on the factorization side, exact over ℤ.

## Corpus audit status — COMPLETE

All four primary classical sources are audited at full text:
Jouanolou 1991, Chardin 1992, Jouanolou 1995, Jouanolou 1997.
Reading-scope note: 1991 §§4.6/6.4 are known via the corpus's own
citations (1995: 3.5.4, 3.7.1.4; 1997: 3.10.15) rather than direct
reading. The bounded-search qualification now applies only to the
literature beyond this corpus.
