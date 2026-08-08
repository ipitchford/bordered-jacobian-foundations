# Response to the external developmental review of 6 August 2026

Reviewer recommendation: **major revisions** (confidence 0.90).
Response version: v0.3-candidate, same day. Every point was first
re-verified against the manuscript and, where mathematical, checked
computationally before action. The full review is archived as
`external_review_2026-08-06.md` in this directory.

## Major comments

**M1 — Remark 4.5 "precise classification" incorrect as stated.
ACCEPTED IN FULL; verified computationally; rewritten.**
All four sub-points were confirmed exactly:
(a) ker δ ⊋ pullbacks — the reviewer's element h = a₀b₁−a₁b₀ at
r=s=1 satisfies δh = 0, det D(m,h) = 0, h² = c₁²−4c₀c₂ a pullback,
h itself not (antisymmetric under swap); machine-checked and added
to the suite as check (III″).
(b) δ(cRⁿ) = n(s−r)cRⁿ vanishes when char | n(s−r); confirmed for
(1,2), n=3, p=3 by coefficient divisibility.
(c) mixing scaling-invariant additions with "among bihomogeneous"
was incoherent quantification.
(d) nonvanishing must be "unit of S[R⁻¹]".
Remark 4.5 is replaced by **Proposition 4.5 (Classification of
normalisers)** in exactly the reviewer's proposed form (char-0
statement; char-p qualification p ∤ n(s−r); ker δ description in
char p), with a complete proof (units of the localisation via UFD +
irreducibility, cited to Jouanolou 1991 2.3(iii); δ-weight
decomposition). A new Remark ("The kernel is larger than the
pullbacks") records the reviewer's example and the fact that only
pullback additions are absorbed by target automorphisms. Abstract
and Introduction claims revised to match.

**M2 — Evidence package not supplied. ACCEPTED with one factual
clarification; bundle now ships.** The package (suite, receipts,
SHA manifest, novelty report, quality gate, adversarial review)
existed in the release repository at review time but was not
provided to the reviewer — the review correctly treats those claims
as "not assessed", and the fault is ours for circulating the PDF
alone. This bundle now contains: the suite; pinned
`requirements.txt` and `ENVIRONMENT.txt`; deep and default receipts
with versions, platform and per-check timings; `CLAIMS.md`
(claim-to-evidence index with one-command replay); negative-control
definitions in-source with receipt lines; `SHA256SUMS`; the TeX
source; the git history. Wording changes adopted: "two separately
written computational backends" replaces "two independent
implementations" in the abstract, §5 and README, with the
shared-specification caveat stated explicitly in §5; degree bounds
described as chosen audit boundaries with the (5,6)/(6,7) timing
facts.

**M3 — Originality positioning. ACCEPTED.** "Any strand" is now
"any sufficiently high strand (degree ≥ r+s−1)"; Remark 3.1
distinguishes the determinant of the based exact complex from any
single differential and fixes the graded ring and generator order.
Added citations: Lou (20 July 2026), whose Lemma 1 is the
(r,s)=(1,2) case of the identity with the same sign — the provenance
section now credits it explicitly and narrows the July release's
claim to the all-degree statement and the degree-difference factor;
and D'Andrea–Chipalkatti 2007 as adjacent determinantal literature.
The search record ships in `NOVELTY.md`, which distinguishes
full-text audits (Jouanolou 1991/1995/1997, Chardin 1992 — conducted
after the version the reviewer saw) from bounded searches, and
which already used bounded-search language for all negative claims.

**M4 — Tao quotation. ACCEPTED.** The Introduction now states the
limitation in the reviewer's terms: Tao's remark concerns the global
affine-space phenomenon for the repeated-root slice; this identity
explains the local étaleness/normalisation component only and does
not explain the global fact.

**M5 — Formalisation and dependency overreach. ACCEPTED.**
"Close the last informal link" is replaced: the Keller disproof is
already fully formalized (PR #4474, google-deepmind/formal-conjectures,
merged 26 July 2026, commit 393aa9ab — verified via the GitHub API
and now cited as the primary source, replacing the press item);
a formalized Theorem 1.1 would add a machine-checked
factorisation-space explanation, not fill a gap. Mathlib is pinned
(master commit 1f0fbd1a, 6 August 2026). Remark 4.6 now contains a
statement-by-statement dependency table for the July release; each
row was reread against the July text during this project.

## Minor comments (22)

Actioned: 1 (undegenerate), 2 (char-p qualifications), 3 (Euler
proof reformulated via the scaling derivation, ring-agnostic),
4 (non-empty open set; τ role explained), 6–7 (Remark 3.1 grading,
generator order, based-complex distinction), 8 ("sufficiently high
strands"), 9 (worked example (1,1) with M, κ, two minors and the
bordered determinant), 10–11 (Corollary 4.2 retitled; "all scheme
points"), 12 (Corollary 4.3 identically-vs-divisor clarifier),
13 ("backends"), 14 (platform/timings in receipts; audit-boundary
statement), 15 (Mathlib pin), 16 (primary PR reference),
17 (access dates retained on web references), 18 (dependency
table), 19 (full-text vs citation-level inspection recorded in
NOVELTY.md), 20 (version + candidate status on title page),
21 ("factorisation-space explanation").
Deferred: 5 (index-letter collision — the new proposition uses F
for fields; a full renotation was judged not worth the churn),
22 (schematic — optional per the reviewer).

## Points of fact for the next assessment round

- The reviewer's independent SymPy corroboration (asymmetric cases,
  larger integer specialisations at (3,4)–(5,6)) is consistent with
  the suite's receipts.
- The REF calibration is recorded as external contextual metadata in
  `QUALITY_GATE.md`; it is not folded into the local quality vector.
