# The Bordered Jacobian and the Degree-Difference Principle

*Draft release page for evidencepress.org — companion to
[degree-difference-affine-slices](https://evidencepress.org/releases/degree-difference-affine-slices/).*

## Central Identity

For binary forms $A$ of degree $r$ and $B$ of degree $s$, let $M$ be
the Jacobian matrix of coefficient multiplication
$(A,B)\mapsto AB$ and let
$\kappa=(a_0,\dots,a_r,-b_0,\dots,-b_s)$ be the relative-scaling
direction. For **every** row vector $v$:

$$\det\begin{pmatrix}M\\ v\end{pmatrix}
=(-1)^{s(r+1)+1}\,\mathrm{Res}(A,B)\,\langle v,\kappa\rangle$$

as an identity over the integers, for all $r,s\ge1$ — including
$r=s$.

## The Bordered Jacobian Principle

The top exterior power of the multiplication differential is the
resultant times the contraction of the source volume form along the
lost scaling direction. Every Jacobian obtained by adjoining one
scalar function to multiplication is computed by a single pairing:
$\det D(m,g)=\pm\,\mathrm{Res}\cdot dg(\kappa)$.

## Key Consequences

**The degree-difference identity, over ℤ**: taking $g=\mathrm{Res}$
(Euler weight $(s,r)$) recovers
$\det D\Phi_{r,s}=(-1)^{s(r+1)}(r-s)\mathrm{Res}^2$ — the July
release's central identity — by a proof using no irreducibility, no
unique factorisation, and no base-point sign count.

**Characteristic p**: $\Phi_{r,s}$ is étale on the coprime locus over
a field $F$ if and only if $(s-r)\cdot 1_F\ne 0$ — in characteristic
zero exactly when $r\ne s$, in characteristic $p>0$ exactly when
$p\nmid s-r$.

**The pullback obstruction**: no function of the product alone can
complete the chart — $g=h\circ m$ forces the determinant to vanish
identically.

**The equal-degree collapse, localised**: at $r=s$ the bordered
identity survives undegenerate; only the Euler weight $s-r$
vanishes. The resultant becomes scaling-invariant and its derivative
goes blind to the lost direction. This addresses, at the
infinitesimal level, the explanatory gap Tao noted publicly: the
resultant is the *minimal* normaliser — unique up to constants,
powers, and additions of scaling-invariant functions — and the
degree difference is the eigenvalue by which each of its powers
reproduces itself.

## Verification Boundary

A two-backend exact suite (SymPy symbolic; FLINT
integer-polynomial with fraction-free elimination) verifies: the full
identity for every bidegree $r+s\le8$ plus spot checks
$(4,5),(5,5),(5,6)$; the minor identity with its sign law, including
$r=s$, through $r+s\le7$; the product formula with symbolic roots;
the base-point sign matrix for $r,s\le40$; characteristic-$p$
divisibility; cross-implementation agreement; and five negative
controls. Per-bidegree checks certify instances; the all-degree
statement rests on the manuscript's elementary proof
(interpolation + gap-Vandermonde + product formula + density).

This suite supersedes the July release's ledger, which verified the
base-point sign matrix and cubic-specific algebra but not the
determinant identity itself.

## Formalization Blueprint

Mathlib already machine-checks a monic analogue:
`UniversalFactorizationRing` proves the monic factorisation
presentation's Jacobian *is* the Sylvester matrix — a square
truncation of the matrix in the bordered identity — and that the
universal coprime factorisation ring is étale over any base. The
monic normalisation removes the scaling direction, so this is an
ingredient rather than an instance: three lemmas, carrying the
degree-difference content itself, separate the current state from a
fully formal bordered identity. The Keller counterexample is already
formalized in Lean. A complete formalization of this identity would
connect the present foundations argument to that existing development,
subject to the remaining bridge obligations described above.

## Context and Related Work

The bordered identity is the coordinate form of a classical
principle — the resultant as the determinant of a strand of the
Koszul complex (Cayley 1848; Jouanolou 1991; Chardin 1992; Demazure
2012). The four primary classical sources — Jouanolou 1991 and
1995, the 1997 formulary, and Chardin 1992 — were all audited at
full text for this release. None contains the bordered form, the
kernel-vector identification, the sign laws, or the
degree-difference factor. Their nearest contents are cited as the
antecedents Theorem 1.1 upgrades: the linear-forms
bordered-evaluation principle, Chardin's divisibility/gcd remark,
the mod-R gradient calculus, the bordered Macaulay-matrix calculus
for the apolarity functional, and the twisted-jacobian identity
Jac ≡ d₁⋯dₙ·dét(f_ij) mod (f) — the square-system dual in which
the product of the degrees plays the role our degree difference
plays on the factorization side. Gao's August 2026 tangent-sweep
paper (arXiv:2608.00222) is framework-orthogonal.

## Availability

- **PDF manuscript**: bordered_jacobian_foundations.pdf (12 pp.)
- **Verification suite**: verify_bordered_jacobian.py (+ receipt)
- **Reports**: NOVELTY.md (search boundary), QUALITY_GATE.md
- **DOI**: *to be minted on Zenodo at publication*
- **Status**: Unrefereed candidate; awaiting independent human
  verification. Cross-model adversarial review (GPT-5.6 Sol,
  refute-framed) completed 2026-08-06: the identity and both sign
  laws survived independent recomputation; all findings on
  surrounding claims applied. Review archived in the package.
