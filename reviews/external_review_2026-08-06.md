# External developmental and release-readiness review

Received 6 August 2026, on the **v0.2 manuscript (9 pp.), circulated
without the evidence package**. Recommendation: major revisions
before release; confidence 0.90; no fatal concerns identified in the
principal theorem.

Our point-by-point response is in `RESPONSE_TO_REVIEW.md` (v0.3).
The review is archived here as received.

---

**Manuscript:** *The bordered Jacobian of binary-form multiplication:
an integral foundation for the degree-difference principle*
**Manuscript date:** 6 August 2026 · **Review date:** 6 August 2026
**Proposed destination:** Evidence Press candidate release
**Recommendation:** Major revisions before release
**Confidence:** High — 0.90 · **Fatal concerns:** None identified in
the principal theorem

## 1. Executive assessment

Nine-page theoretical/computational note giving an explicit integral
formula for the bordered Jacobian of multiplication of two binary
forms. Central contribution is Theorem 1.1: every signed maximal
minor of the multiplication Jacobian is the resultant times the
relative-scaling kernel vector, with a fully specified sign.
Corollaries recover the degree-difference determinant, explain the
equal-degree collapse, and identify the pullback obstruction. On the
material inspected, the theorem and its principal corollaries appear
mathematically correct. The root-interpolation proof is economical,
self-contained and materially stronger than the
factorisation-and-base-point argument it replaces; this is the
manuscript's strongest feature.

Major revisions recommended. No fatal defect in the main identity.
The decisive mathematical weakness is the advertised "precise
classification" of normalising functions: Remark 4.5 is not correct
as stated, conflates pullbacks with the full kernel of the scaling
derivation, and omits essential characteristic-p qualifications. The
decisive release-readiness weakness is evidential: Section 5
describes extensive SymPy/FLINT verification, but the code,
environment, receipts, outputs and negative-control records were not
supplied, so those claims are presently not assessed. Positioning
also needs tightening: the exact signed bordered formula may be a
useful explicit specialisation, but the determinant-of-Koszul-complex
principle is classical, and the Tao quotation currently overstates
what the paper explains.

## 2. Scope and evidence limits

Materials inspected: the complete nine-page PDF; a REF-style 12-point
scoring rubric; all displayed definitions, lemmas, proof steps,
corollaries, remarks and references; the public Evidence Press
description of its verification model; the previous degree-difference
candidate release and its public evidence structure; relevant
classical and current literature; current Mathlib documentation and
the primary Lean pull request cited indirectly by the manuscript.
The reviewer also independently reconstructed the multiplication
Jacobian, resultant convention, relative-scaling vector and bordered
determinant in a separately written SymPy calculation.

Not supplied: `verify_bordered_jacobian.py`; the claimed FLINT
implementation; dependency or environment files; command transcripts
and output logs; verification receipts; negative-control outputs; a
SHA-256 manifest; a claim-to-evidence index; TeX source; an immutable
release archive; the proposed formalisation. Computational claims are
therefore **not assessed**, not failed.

Review standard applied: correctness of mathematical claims;
agreement between theorem, proof and consequences; accurate
positioning against prior work; conformity with Evidence Press's
stated minimum of an internally replayed, archived evidence package.
Absence of peer review is not treated as a defect; absence of a
reviewable evidence package is, because executable and archived
evidence is central to that model.

## 3. Contribution and positioning

Strongest defensible thesis: the manuscript proves, over Z and for
all r,s ≥ 1, that det[M; v] = (−1)^{s(r+1)+1} Res(A,B)⟨v,κ⟩. The
mathematically valuable part is the combination of a uniform formula
for every signed maximal minor, exact sign conventions, an elementary
interpolation proof, integral validity and arbitrary base change, and
the resulting one-line computation of every Jacobian obtained by
adjoining one scalar function to multiplication.

Claim-to-evidence map:

| Principal claim | Manuscript support | Assessment |
|---|---|---|
| Theorem 1.1, bordered Jacobian identity | Full proof in §3, Lemmas 2.1–2.2 | **Strong; no defect found** |
| Corollary 1.2, contraction principle | Direct expansion and Thm 1.1 | **Strong** |
| Corollary 4.1, degree-difference identity | Cor 1.2 plus Euler identity | **Strong** |
| Corollary 4.2, characteristic-dependent étaleness | Determinant criterion on resultant-open locus | **Substantively correct; wording needs refinement** |
| Corollary 4.3 and equal-degree explanation | dm(κ)=0 and the scaling weight | **Strong** |
| Remark 4.5, "precise classification" | Informal unit and weight argument | **Incorrect/overstated as written** |
| Section 5 computational coverage | Described but no executable material supplied | **Not assessed** |
| Section 6 Mathlib bridge | Comparison with live Mathlib theorems | **Substantially accurate, with an overclaim in the conclusion** |
| Remark 4.6, all downstream July dependencies | Assertion rather than dependency audit | **Not independently established** |

Originality: the manuscript properly concedes the
determinant-of-a-Koszul-complex principle is classical (Chardin;
Demazure; Jouanolou). Within the bounded search conducted for this
review, the reviewer did not locate the exact all-degree formula with
the two displayed sign laws, this coefficient ordering, simultaneous
treatment of r = s, or the arbitrary-border contraction formulation.
That absence is not proof of priority. Most defensible claim: "an
explicit, signed and integral coordinate realisation of a classical
determinant-of-complex principle, together with a short elementary
proof and a useful contraction corollary." Should not be represented
as a new foundational theory of resultants.

## 4. Major comments

### 1. The "precise classification" of normalising functions is not correct as stated

The abstract, Introduction and Remark 4.5 claim the resultant is the
unique or minimal normaliser, up to constants, powers and
scaling-invariant additions, describing two "exactly-described
ambiguities". The argument does not establish that formulation and
several parts are false without additional hypotheses. Let
δ = Σ aᵢ ∂/∂aᵢ − Σ bⱼ ∂/∂bⱼ. Theorem 1.1 shows the relevant condition
is that δg be a unit on D(Res). Four problems:

**First**, pullbacks through multiplication do not exhaust ker δ. For
r = s = 1, h = a₀b₁ − a₁b₀ satisfies δh = 0 but is not a polynomial in
the product coefficients: interchanging A and B leaves AB fixed and
sends h to −h in characteristic ≠ 2, whereas any pullback H(AB) is
symmetric under that interchange.

**Second**, "every cResⁿ does work" is false in positive
characteristic: δ(cResⁿ) = n(s−r)cResⁿ, which vanishes if the
characteristic divides n(s−r). E.g. r=1, s=2 over characteristic p,
g = Res^p does not complete the chart.

**Third**, arbitrary scaling-invariant additions are incompatible with
the claimed classification "among bihomogeneous candidates": when
r ≠ s a non-zero power of the resultant has non-zero relative weight
whereas a torus invariant has weight zero, and their sum is generally
not bihomogeneous.

**Fourth**, "nonvanishing on the coprime locus" must be formulated
scheme-theoretically as being a unit in S[Res⁻¹], or over an
algebraic closure.

Positive characteristic adds a further distinction: ker δ need not
equal the ring of torus invariants — a monomial whose integer weight
is divisible by p is killed by δ without being invariant under the
full G_m-action.

**Required revision.** Replace Remark 4.5 and the corresponding
abstract and introductory claims with a precise proposition. Suitable
characteristic-zero formulation:

> Let k be a field of characteristic zero, S = k[a₀,…,a_r,b₀,…,b_s],
> R = Res(A,B), suppose R is irreducible, and assume r ≠ s. Then
> (m,g) is étale throughout D(R) exactly when δg = cRⁿ for some
> c ∈ k^× and n ≥ 1. Equivalently, g = (c/(n(s−r)))Rⁿ + h with
> h ∈ ker δ. Among bihomogeneous g, this reduces to non-zero scalar
> multiples of powers Rⁿ.

For characteristic p, state separately that n(s−r) must be invertible
in k, and describe the ambiguity as ker δ, not automatically as the
torus-invariant ring. This correction does not weaken Theorem 1.1,
Corollary 1.2 or the degree-difference identity.

### 2. The advertised verification suite cannot presently support an Evidence Press release

Section 5 gives unusually specific claims about exact SymPy and FLINT
computations, coefficient-level agreement, degree ranges and negative
controls. None of the underlying evidence was supplied for review.
Evidence Press's stated minimum is internal replay: complete scripts,
exact evidence, passing mutation or negative controls, archival
deposit, a claim-to-evidence map, pinned environments and integrity
manifests. The previous degree-difference release publicly supplies
manuscript, source, checker, requirements file, verification outputs,
negative-control output, replay receipt, claim index and SHA-256
manifest.

Assurance state from materials inspected: manuscript inspected;
source code, environment reproducibility, internal replay, negative
controls and claimed SymPy/FLINT agreement all **not assessed**;
independent instance reimplementation partial (reviewer only); formal
verification of Theorem 1.1 explicitly not done; independent
specialist review — this report only.

"Two independent implementations" also needs scrutiny: two algebra
systems invoked by one shared codebase, with a shared matrix
constructor and shared expected formula, are two computational
backends but not necessarily independent implementations. A common
indexing or specification error can survive both.

**Required revision.** Before release, supply and replay: all source
files (or a more modest description of the backends' relationship);
exact package and interpreter versions, preferably a lock file or
container; one-command clean-environment replay instructions;
checked-in output transcripts and machine-readable receipts; hashes
of all release artefacts; negative-control definitions and outputs; a
claim-to-evidence index; a frozen archive and public mirror; and a
comparison showing the archived script and the paper use identical
coefficient ordering, Sylvester convention and signs. The release
page should distinguish producer-side agreement between two backends,
independent reimplementation by another party, and proof of the
all-degree theorem.

### 3. The originality claim requires a sharper comparison with classical resultant complexes

Formulations such as "the resultant is the determinant of any strand
of the Koszul complex" and "the strand just above the Sylvester
strand" remain too broad. Chardin explains the resultant through
determinants or alternating products of determinants of Koszul
differentials and gives an algorithm involving maximal minors of
appropriate graded strands — substantially anticipating the
conceptual mechanism, though not, in the passages inspected, stating
the present bordered matrix with these signs. Demazure supplies
classical Sylvester, multihomogeneity and universal-resultant
material but should not be implied to prove this exact bordered-strand
statement without a precise locator. D'Andrea and Chipalkatti treat
Jacobian ideals, maximal-minor resolutions and determinantal
structures for binary discriminants and resultants — adjacent rather
than duplicative, but it belongs in the literature discussion. There
is also a contemporaneous explicit (r,s)=(1,2) coefficient–resultant
calculation, det D(m,Res) = −Res², which is a special case rather
than the all-degree bordered theorem, but which narrows any claim
that the degree-difference determinant first appears only in the July
Evidence Press release.

**Required revision.** Recast as: classical — resultants as
determinants or torsions of suitable Koszul strands; possibly new or
at least not located — the exact signed coordinate identity for all
maximal minors and arbitrary border; new within the Evidence Press
project — an elementary integral proof replacing the earlier argument
and extending its verification boundary. Add exact locators. Replace
"any strand" with a technically accurate statement about sufficiently
high exact strands or the determinant of the relevant based complex.
State "a bounded search did not locate the exact signed bordered
formula"; do not state or imply that it is absent from the
literature. Include the search record in the evidence package.

### 4. The Tao quotation is attached to a different geometric question

In its immediate source context, Tao's remark concerns the **global
affine-space phenomenon for the repeated-root hyperplane class** — why
that particular slice is affine — rather than the local Jacobian
non-degeneracy of multiplication after resultant normalisation. The
manuscript does explain why the resultant detects the relative-scaling
direction, why the degree difference occurs, why the equal-degree case
collapses, and why product pullbacks do not supply a missing
coordinate. It does **not** explain why the particular repeated-root
slice is globally isomorphic to affine three-space. Local étaleness is
not a proof of global affineness. The qualification "at the
infinitesimal level" reduces but does not remove the problem.

**Required revision.** Either remove the quotation or state the
limitation explicitly: "This identity explains the local étaleness and
normalisation component of the construction. It does not explain the
separate global 'affine miracle' identified by Tao, namely why the
repeated-root slice itself is affine three-space." Observe the same
distinction in the title, abstract, press summary and any downstream
claims.

### 5. The formalisation and downstream-dependency claims overreach the evidence

Section 6's final claim — that formalising Theorem 1.1 would close
"the last informal link" from first principles to the counterexample's
étale geometry — is stronger than the cited evidence supports. Remark
4.6 similarly asserts that all relevant downstream results now inherit
the new foundation without presenting a dependency audit.

The live Mathlib documentation does contain the stated monic results
(`universalFactorizationMapPresentation_jacobiMatrix`;
`universalFactorizationMapPresentation_jacobian`; the universal
coprime factorisation ring by localisation), so the manuscript's
substantive distinction between the monic truncation and the
non-monic scaling direction is sound. However, the primary Lean record
shows a direct formal disproof merged into the Formal Conjectures
repository on 26 July 2026, merge commit `393aa9a`, eleven passing
checks. A formalisation of Theorem 1.1 would therefore add a
machine-checked **factorisation-space explanation**; it is not
evidently a missing logical step required by the already formalised
counterexample.

**Required revision.** Replace the secondary media reference with the
primary repository, pull request and pinned merge commit; pin a
Mathlib commit or release; list exact Mathlib theorem names,
assumptions and sign conventions; change "close the last informal
link" to "formalise the factorisation-space explanation of the
determinant"; add a dependency table for the July manuscript (earlier
theorem number; determinant input used; replacement result; whether
the downstream proof was reread, replayed or merely inferred).

## 5. Rigour, results and inference

Audit of the central proof: the architecture is sound. Expansion in
the border row correctly reduces to the signed maximal-minor formula,
and the parity relation connecting the two sign conventions is
correct. Verifying the polynomial identity on the dense open subset
(non-zero leading coefficients; simple, pairwise distinct roots; no
shared root) is legitimate; choosing τ separately at each point is
harmless because the identity is τ-independent, but this should be
explained in one sentence. The coefficient comparison in the auxiliary
Vandermonde determinant gives the stated elementary-symmetric factor
with the stated sign; no missing parity factor was found. Defining the
Sylvester rows explicitly and checking normalisation at (X^r, Y^s) is
good practice. The auxiliary-row split leaves exactly one potentially
non-zero block term; the row-transposition count in the b-block case
and its absence in the a-block case are consistent with the final
signs. Equality on a dense open subset over C gives equality in
C[a,b], and since both sides lie in Z[a,b] the integral identity
follows. The contraction principle, degree-difference determinant,
pullback obstruction and equal-degree rank statement all follow
correctly. The prominent defect begins with the attempted global
classification in Remark 4.5, not with the theorem or these
corollaries.

Independent calculations performed for this review (reviewer's own
SymPy reconstruction, not the manuscript's advertised program):

| Check | Cases | Outcome |
|---|---|---|
| Symbolic polynomial equality for every signed maximal minor | (1,1),(1,2),(2,1),(2,2),(1,3),(3,1),(2,3) | All passed |
| Symbolic degree-difference determinant | Same cases | All passed |
| Exact integer specialisations, all maximal minors and full determinant | (3,4),(4,5),(5,5),(5,6), two non-zero-resultant trials each | All passed |
| Border/minor parity audit | General symbolic parity | Consistent |
| Gap-Vandermonde sign audit | General derivation | Consistent |
| Product-formula sign audit | Both root-product forms | Consistent |
| Theorem 1.1 to Corollaries 1.2 and 4.1 | General sign algebra | Consistent |

Exact resultants in the larger tests: (3,4): 63, 116; (4,5): −7988,
99816; (5,5): 96391, 66128; (5,6): −18229, −1264312. These checks
materially reduce the risk of a hidden sign or indexing error; they do
not establish the universal theorem and do not validate the
manuscript's claimed FLINT implementation or degree ranges.

Reviewer inference: the main theorem is very likely correct.
Residual mathematical risks are principally unnoticed convention
mismatch with an external downstream manuscript; imprecision in the
Koszul-complex interpretation; and unsupported extension of local
determinant information into global classification or downstream
geometry.

## 6. External literature check

Search date 6 August 2026. Sources searched or inspected: general
scholarly web search; arXiv; Springer and author-hosted full text;
EMS Press; Mathlib documentation and source links; GitHub; Evidence
Press and its public repository; current REF 2029 guidance.
Representative strings: `"bordered Jacobian" resultant binary forms`;
`"Jacobian of multiplication" binary forms resultant`; `"maximal
minors" multiplication map resultant`; `"resultant via a Koszul
complex"`; `"degree difference" resultant squared Jacobian`; exact
manuscript title; exact verification-script name; Mathlib theorem
names cited in Section 6. Bounded search, not systematic.

Pivotal comparisons: Chardin (1993) — the conceptual
determinant-of-strand mechanism is classical; exact bordered
coordinate formula not located in inspected passages. Jouanolou
(1991) — supports classical positioning; not all 147 pages inspected,
so no novelty conclusion should rest on an assertion of absence.
Demazure (2012) — supports Lemmas 2.2–2.3 and the unit discussion but
should not be cited as a direct source for the exact bordered theorem
without a locator. D'Andrea and Chipalkatti (2007) — adjacent
literature that should be acknowledged. Lou (2026) — establishes a
contemporaneous (1,2) special case. Mathlib — the proposed
formalisation bridge is credible but requires non-monic bookkeeping
and pinned versions. Formal Conjectures PR #4474 — the bordered
theorem would formalise an explanatory route, not complete an
otherwise absent formal disproof. Tao (2026) — the quoted "miracle"
is the global affine property of the repeated-root slice.

Implications: the originality claim should be **positive but
bounded** — not a new resultant construction; not a complete
explanation of the affine-slice geometry; plausibly a useful explicit
theorem and proof not already isolated in this form; a substantial
repair of the July release's determinant foundation.

## 7. Minor comments

1. Abstract: replace "undegenerate" with "non-degenerate" or "does not
   degenerate".
2. Abstract and Introduction: every positive-characteristic statement
   about powers of the resultant must include the condition that the
   relevant integer weight be non-zero in the base field.
3. Lemma 2.3: because the surrounding text says "work over a
   commutative ring", formulate the proof using the Euler derivation or
   formal Laurent-polynomial identity rather than language that could
   be read as analytic differentiation of a curve.
4. Section 3: state explicitly that U is a non-empty Zariski-open
   subset; explain that the pointwise choice of τ is used only to
   evaluate a determinant and that the final expression is
   τ-independent.
5. Section 3 notation: column indices and several polynomial indices
   use k; consider reserving k for a field in later classification
   statements.
6. Remark 3.1: define the graded ring S, its shifts and the ordering of
   the two Koszul generators. In the displayed strand, the relation
   (A,−B) corresponds to a particular ordering of (B,A).
7. Remark 3.1: distinguish the determinant of a based exact complex
   from the determinant of a single differential.
8. Classical principle wording: replace "the resultant is the
   determinant of any strand" with a statement specifying the exact or
   sufficiently high graded strands for which the construction applies.
9. Add a worked example: display M, κ, one or two maximal minors and
   the full bordered determinant for (r,s) = (1,1) or (1,2).
10. Corollary 4.2: the title "Étaleness over any base" is broader than
    the statement; rename or give a general base-scheme formulation.
11. Corollary 4.2: clarify whether "at every point" means every scheme
    point, every geometric point or every rational point.
12. Corollary 4.3: "no coefficient … can serve as the added
    coordinate" should retain the qualifier "on the whole coprime
    locus".
13. Section 5: use "two exact computational backends" unless the two
    implementations have genuinely separate construction, indexing and
    expected-value code.
14. Section 5: report execution environment, runtime, memory
    requirements and whether the stated upper degree bounds are
    resource limits or chosen audit boundaries.
15. Section 6: pin the exact Mathlib commit or release and include the
    complete theorem names.
16. Reference [11]: replace the secondary news report with the primary
    pull request, merge commit and repository source.
17. Public-post references: provide access dates, archived snapshots
    where possible, and exact post/comment locators.
18. Remark 4.6: add a theorem-by-theorem dependency table.
19. Priority section: separate sources examined in full text from
    sources inspected only through metadata or opening sections.
20. Versioning: add a manuscript version number, intended
    evidence-package version, source commit and release-candidate
    status.
21. Section 6 conclusion: replace "last informal link" with a statement
    limited to the factorisation-space interpretation.
22. Presentation: the typesetting is clean and the proof readable. A
    one-page schematic would improve accessibility but is not required.

## 8. Prioritised revision plan

**Must fix before the claims are publishable.** (1) Correct Remark 4.5
and every associated uniqueness, minimality and characteristic-p
statement in the abstract and Introduction. (2) Supply a complete,
archived and internally replayed evidence package for Section 5, with
code, environments, outputs, negative controls, hashes and claim
mapping. (3) Reframe the Tao quotation. (4) Narrow and document the
originality claim, including precise comparison with Chardin,
Jouanolou, Demazure, adjacent binary-resultant literature and the
contemporaneous (1,2) calculation. (5) Replace the formalisation
overclaim and secondary citation; add pinned Mathlib and Lean
references. (6) Audit and document every claimed downstream dependency
on the July release.

**Should fix to strengthen the paper.** Worked example; Koszul grading
and determinant-line interpretation; ring-agnostic Euler argument;
Corollary 4.2 title alignment; backend-vs-reproduction distinction;
archived literature-search record with full-text vs metadata
distinction; precise locators for classical references.

**Could improve presentation or future work.** Conceptual diagram;
Lean formalisation as a separate evidence object; investigation of
ker δ and its relation to product pullbacks as a separate
proposition; a coordinate-free determinant-line statement preceding
the coefficient formula.

## 9. Editorial recommendation

**Major revisions.** Confidence high, 0.90. The central bordered
Jacobian theorem appears correct, useful and suitable in scale for an
Evidence Press candidate release. The required repairs do not demand
new experimental data or a redesign of the proof, but they affect
prominent claims in the abstract and the manuscript's release
assurance. The recommendation would change to minor revisions or
release-ready candidate if the normaliser classification is corrected;
the Tao and formalisation claims are narrowed; the literature and
dependency records are made auditable; the complete computational
suite cleanly replays in a pinned environment; and code and manuscript
conventions agree exactly.

## 10. Provisional REF calibration

Most relevant unit: UoA 10, Mathematical Sciences, Main Panel B. As of
6 August 2026 final REF 2029 panel criteria were still scheduled for
completion in autumn 2026, so generic REF star definitions and the
supplied 12-point mapping are used rather than a final panel judgement.

| Dimension | Indicative grade | 12-point | Rationale | Confidence |
|---|---:|---:|---|---|
| Originality | 2* High | 6/12 | Explicit signed bordered identity and contraction packaging not located in bounded search; but the determinant-of-Koszul-complex principle is classical, a special (1,2) determinant was already public, and non-redundancy is not yet established by an expert-level literature audit. | Medium |
| Significance | 2* Medium | 5/12 | Repairs an identifiable foundation in the July project and gives a reusable local formula; wider significance currently limited — does not explain the global affine miracle, settle a broad resultant problem, or independently establish downstream geometry. | Medium |
| Rigour | 3* Low | 7/12 | Complete coherent proof, exact conventions, strong independent low-degree corroboration; the classification error and absent replay evidence prevent a stronger rating. Borderline with 2* High, but 3* Low because the central theorem appears rigorously established. | Medium–high |
| Overall | 2* High | 6/12 | Holistically: sound and useful central theorem, materially false secondary classification, not yet release-replayable from supplied materials. | Medium–high |

Overall rating is holistic, not an arithmetic average. After
correction and successful evidence replay, a 3* Low (7/12) overall
assessment would be plausible, chiefly reflecting greater rigour and
credible non-redundancy; it would not automatically establish 3*
significance. This calibration is indicative and is **not an official
REF panel decision**.

## 11. References

Chardin, M. (1993). The resultant via a Koszul complex. In
*Computational algebraic geometry* (Progress in Mathematics 109,
pp. 29–39). Birkhäuser. doi:10.1007/978-1-4612-2752-6_3

D'Andrea, C., & Chipalkatti, J. (2007). On the Jacobian ideal of the
binary discriminant, with an appendix by A. Abdesselam.
*Collectanea Mathematica, 58*(2), 155–180. arXiv:math/0601705

Demazure, M. (2012). Résultant, discriminant. *L'Enseignement
Mathématique, 58*(3–4), 333–373. doi:10.4171/LEM/58-3-5

Jouanolou, J.-P. (1991). Le formalisme du résultant. *Advances in
Mathematics, 90*(2), 117–263. doi:10.1016/0001-8708(91)90031-2

Lou, A. (2026, July 20). *Deriving an explicit polynomial
counterexample to the Jacobian conjecture.*

OpenAI Codex / Anthropic models. (2026). *Candidate evidence bundle
for the degree-difference principle and affine slices of binary-form
factorisation spaces* (v0.1-candidate). Zenodo.
doi:10.5281/zenodo.21647593

Tao, T. (2026, July 21). *A digestion of the Jacobian conjecture
counterexample.* What's New.

Evidence Press. (2026). *About this site.*

Lezeau, P. (2026). *feat: add Jacobian disproof* [PR #4474; merged
commit 393aa9a]. google-deepmind/formal-conjectures.

Mathlib contributors. (2026).
*Mathlib.RingTheory.Polynomial.Resultant.Basic*;
*Mathlib.RingTheory.Polynomial.UniversalFactorizationRing.*

Research Excellence Framework. (2026). *Section 4 — Contributions to
Knowledge and Understanding guidance*; *REF survey information.*

[END]
