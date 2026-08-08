# Quality-gate record — bordered-Jacobian foundations release

**Boundary.** Assess whether this release makes an original,
significant and rigorous contribution within resultant theory /
computational algebraic geometry, and whether the evidence suffices to
publish it as an Evidence Press *unrefereed candidate*, as of
2026-08-06.  Local decision aid only; not an official assessment
score.

**Claim.** The bordered Jacobian identity
det[M;v] = (−1)^{s(r+1)+1}·Res·⟨v,κ⟩ in ℤ[a,b,v] for all r,s ≥ 1
including r=s, with corollaries: the integral degree-difference
identity, the characteristic-p étaleness criterion, the pullback
obstruction, and the equal-degree localisation.  Output type:
manuscript + exact verification suite + formalization blueprint.

**Novelty-gate handoff.** See `NOVELTY.md` (search date 2026-08-06).
Abstract strand principle: COLLISION with classical theory — cited,
not claimed.  Bordered coordinate form + sign laws + r=s uniformity:
BRIDGE/bounded.  Derivation architecture and artefacts: clear within
the bounded search.  Statement priority for the degree-difference
identity itself remains with the July release (DOI
10.5281/zenodo.21647593).

## Ex-post scores

| Dimension | Score | Confidence | Justification |
|---|---|---|---|
| Originality | **2/4** | high | The load-bearing principle is deliberately classical (Cayley/Jouanolou/Chardin/Demazure). Original content: the bordered coordinate form with both exact sign laws, uniformity at r=s, the contraction-principle derivation, the integral/char-p upgrade. A foundations contribution, not a new object. |
| Significance | **3/4** | medium | Repairs the foundation of an active trilogy attached to the first Jacobian-conjecture counterexample; answers, at the infinitesimal level, the explanatory gap Tao stated publicly; supersedes an inaccurate verification ledger; the Mathlib blueprint gives a credible near-term formalization route (monic core already machine-checked upstream). Not 4: lemma-level within the wider event. |
| Rigour | **3/4** | high (external review concurs: "3* Low", 7/12) | Statement identity pinned (conventions, signs explicit); proof is uniform in degree and clearly separated from per-instance machine checks; density argument explicit; two separately written computational backends (SymPy/FLINT) agree coefficient-wise; 93 deep-tier checks incl. five negative controls; every sign cross-anchored to machine-verified sign laws; refute-framed cross-model review completed — the theorem and sign chains survived independent recomputation, and all prose-level findings were repaired (v0.2). Not 4: prose proof not formalized; no independent human review yet. |

**Q (local, geometric mean) ≈ 66.**  Vector first:
(O=2, S=3, R=3, assurance below, reception immature).

## Assurance (separate from quality)

Status: **internally checked + replayed + cross-model adversarially
reviewed + externally reviewed (developmental)** (deterministic exact arithmetic, two separately
written computational backends, negative controls; GPT-5.6 Sol refute-framed review
completed 2026-08-06, archived in `reviews/`).  NOT independently
reproduced by a human; NOT formally verified; NOT peer reviewed.

**Adversarial review outcome**: the core theorem and both sign laws
survived — Sol independently recomputed the Section 3.3/3.4 sign
chains, the four boundary deletions, the product formula, the density
argument, and the Euler weights, and "could not break the
bordered-Jacobian identity or its sign law".  Fifteen findings: one
concrete prose misstatement (Remark 4.4 dropped the (−1)^k — fixed)
and four material overclaims (resultant uniqueness; suite coverage;
Mathlib "monic chart"; local-vs-global scope), all verified and
repaired in v0.2, plus wording repairs (char-p at r=s,
characteristic-zero language, auditability of the July-ledger claim).
Limit statement: machine checks certify bidegrees r+s ≤ 8 plus
(4,5),(5,5),(5,6); the all-degree statement rests on the Section 3
proof, now with an adversarial re-derivation on record.

## External contextual metadata (not folded into the vector)

The external review supplied an indicative REF-style calibration
(UoA 10): originality 2* High (6/12), significance 2* Medium (5/12),
rigour 3* Low (7/12), overall 2* High (6/12), with 3* Low overall
"plausible after correction and successful evidence replay". Both
conditions are now met. This is recorded as contextual metadata per
the open-metric policy; it is not an official assessment and is not
merged into the local (O,S,R) vector above.

## Reception

Immature (release day).  Reassess no earlier than 2026-11-06.

## Red flags / missing evidence

- ~~The possible implicit antecedent in Jouanolou (1991)~~ RESOLVED
  2026-08-06 by full-text audit (user supplied the PDF): no bordered
  form, no strand above Sylvester, no resultant differential calculus;
  closest content is the linear-forms bordered-evaluation principle
  (Prop. 5.4.4), now cited in the manuscript as the methodological
  antecedent. Chardin (MEGA 1992) likewise RESOLVED by full-text
  audit same day: no bordered form; its §IV Remark 1 (Res divides
  every maximal minor; gcd in the generic case) is the scalar shadow
  of the minor identity, now cited. Jouanolou 1997 formulary also
  RESOLVED (user-supplied PDF, 132 pp.): no collision; three
  nearest-neighbour items cited (bordered Macaulay calculus for
  ω, mod-R gradient identities, below-Sylvester binary
  determinantal ideals). One correction logged: 1991 §§4.6.3/6.4
  DO contain mod-R gradient-of-resultant identities (found via the
  formulary's citations); the manuscript's audit language was
  corrected accordingly. The 1995 *Aspects invariants* source was
  subsequently audited at full text; `NOVELTY.md` records the scope.
- ~~No human domain expert has read the proof.~~ An external
  developmental review (6 August 2026) has now assessed the
  manuscript and independently corroborated the identity at instance
  level; it is a review of the v0.2 text without the evidence
  package, so a further round against v0.3 remains desirable.
- The July release's summary page overstates its own machine ledger;
  this release supersedes it and should be cross-linked when
  published.

## Decision

**candidate** — ship as an Evidence Press unrefereed candidate with
controls: (1) the Sol adversarial review and the external
developmental review are complete, archived in `reviews/`, and their
findings are applied (v0.2, v0.3); (2) the classical-corpus audit is
complete at full text for all four primary sources; (3) cross-link
and correct the July release's verification-boundary claim
(`JULY_PAGE_CORRECTION.md`).  Next reassessment: on a further
external review against v0.3 with the evidence bundle in hand.
