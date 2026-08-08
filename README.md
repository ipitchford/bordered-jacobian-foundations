# The bordered Jacobian of binary-form multiplication

[![Status: unrefereed candidate](https://img.shields.io/badge/status-unrefereed%20candidate-9f6f00)](#status)
[![Licence: CC0 1.0](https://img.shields.io/badge/original%20content-CC0--1.0-lightgrey)](LICENSE)
[![Code: MIT](https://img.shields.io/badge/code-MIT-blue)](LICENSE-CODE)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21855302.svg)](https://doi.org/10.5281/zenodo.21855302)

**Release:** 0.3-candidate, 8 August 2026  
**Repository maintainer and publisher:** Ian Pitchford  
**Scholarly attribution:** Anonymous

**An integral foundation for the degree-difference principle.**
Companion and foundations release for
[*The degree-difference principle and affine slices of binary-form
factorisation spaces*](https://doi.org/10.5281/zenodo.21647593)
(Evidence Press, 27 July 2026).

## Main result

For binary forms A (degree r) and B (degree s), with M the
(r+s+1)×(r+s+2) Jacobian matrix of coefficient multiplication and
κ = (a₀,…,a_r, −b₀,…,−b_s) the relative-scaling kernel vector:

    det [M ; v] = (−1)^{s(r+1)+1} · Res(A,B) · ⟨v, κ⟩     for every row v,

as an identity in ℤ[a,b,v], for **all** r,s ≥ 1 including r = s.
Equivalently, the signed maximal minors of M are
(−1)^{r(s+1)} · Res · κ_k.

Contracting the border against the Euler derivative of any
bihomogeneous g of weight (p,q) gives
det D(m,g) = (−1)^{s(r+1)+1}(p−q)·g·Res.  Consequences:

- **g = Res** recovers the July release's degree-difference identity
  det DΦ = (−1)^{s(r+1)}(r−s)Res², now over ℤ — with a proof using no
  irreducibility, no unique factorisation, and no base-point inversion
  count.
- **Characteristic p**: Φ is étale on the coprime locus over any field
  of characteristic p iff p ∤ s−r (étale over ℤ[1/(s−r)]).
- **Pullback obstruction**: g = h∘m gives det ≡ 0 — no function of the
  product can complete the chart.
- **Equal degrees localised**: the bordered identity does not
  degenerate at r = s; only the Euler weight s−r vanishes.

## Files

| File | Contents |
|---|---|
| `bordered_jacobian_foundations.tex/.pdf` | The manuscript (12 pp.) |
| `verify_bordered_jacobian.py` | Exact two-backend verification suite |
| `verification_receipt_deep.txt` | Output of the `--deep` tier |
| `CLAIMS.md` | Claim-to-evidence index + one-command replay |
| `requirements.txt`, `ENVIRONMENT.txt` | Pinned deps, platform, replay |
| `SHA256SUMS` | Integrity manifest |
| `AI_INDEX.md`, `CLAIMS.json` | Agent-readable claim, evidence and status map |
| `REPLAY_RECEIPT.md`, `ASSURANCE.md` | Fresh publication replay and trust boundary |
| `CITATION_AUDIT.md` | Source-identity and contextual-use audit |
| `PROVENANCE.md`, `LICENSES.md` | Attribution, intake and reuse terms |
| `NOVELTY.md` | Novelty-gate search report (four full-text audits) |
| `QUALITY_GATE.md` | Quality-gate record (O/S/R vector, assurance, decision) |
| `reviews/` | Cross-model adversarial review (Sol) + external developmental review + response |
| `Makefile` | `make pdf`, `make verify`, `make deep`, `make receipt` |

## Verification

```
python3 -m venv v && v/bin/pip install -r requirements.txt
v/bin/python verify_bordered_jacobian.py          # default tier, ~3 s, 58 checks
v/bin/python verify_bordered_jacobian.py --deep   # deep tier, ~7 min, 93 checks
```

Requires `sympy` and `python-flint` (pinned in `requirements.txt`).
The central determinant identity is checked in two separately written
computational backends (symbolic Berkowitz vs.
exact integer-polynomial fraction-free Bareiss) with
coefficient-identical cross-comparison for r+s ≤ 5; each remaining
check states its backend in the output.  Coverage: the full identity
for all bidegrees r+s ≤ 8 plus spot checks (4,5), (5,5), (5,6); the
minor/bordered identity including r = s through r+s ≤ 7; the product
formula with symbolic roots; the gap-Vandermonde lemma; the
base-point sign matrix for r,s ≤ 40; characteristic-p divisibility;
contraction cases including linear and nonlinear pullbacks; and five
negative controls that confirm the checks can fail.

**Declared boundaries.** Per-bidegree checks certify instances; the
all-degree statement rests on the manuscript's proof (Section 3).
The two backends guard against implementation error, not against a
shared specification error: they are separately written paths within
one suite by one author.
The July release's script verified its base-point sign matrix and
cubic-specific algebra but not the determinant identity itself; this
suite closes that gap and supersedes that ledger.

## Formalization

Mathlib already machine-checks the monic chart of the main theorem
(`Mathlib.RingTheory.Polynomial.UniversalFactorizationRing`: the
factorisation presentation's Jacobian *is* the Sylvester matrix, and
the universal coprime factorisation ring is étale).  Section 6 of the
manuscript maps each statement to its formalized analogue and lists
the three missing lemmas.

## Status

v0.3-candidate. Unrefereed; two reviews on record (cross-model
adversarial; external developmental), both actioned — see
`reviews/`. Awaiting independent reproduction by another party.
Produced by AI systems under human direction as part of the Evidence
Press programme.

## Licence and reuse

Original manuscript text, documentation, reviews, release metadata and
other original non-code content are dedicated to the public domain under
CC0 1.0. Original source code is available under the MIT License. Citations
and links do not relicense third-party works. See `LICENSES.md`.

Agents may reuse the exact statements and artefacts, but must preserve the
candidate status and the assurance distinctions in `AI_INDEX.md`.

The immutable candidate archive is preserved by Zenodo under version DOI
[`10.5281/zenodo.21855302`](https://doi.org/10.5281/zenodo.21855302).
