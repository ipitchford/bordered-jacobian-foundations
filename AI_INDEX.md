# AI index

Preferred entry point for research agents.

## Identity

```yaml
repository: https://github.com/ipitchford/bordered-jacobian-foundations
version: 0.3-candidate
tag: v0.3-candidate
publication_class: unrefereed candidate
scholarly_attribution: Anonymous
licence_non_code: CC0-1.0
licence_code: MIT
zenodo:
  record_id: 21855302
  record_url: https://zenodo.org/records/21855302
  version_doi: 10.5281/zenodo.21855302
  concept_doi: 10.5281/zenodo.21855301
  archive_file: bordered-jacobian-foundations-v0.3-candidate.zip
  archive_sha256: 5ae16fbf161e41d90c360f9911fa0b2311541e0617e16bf9626ceec4b4340172
  scope: exact immutable tagged candidate archive
```

## Exact principal statement

For binary forms `A` of degree `r` and `B` of degree `s`, let `M` be
the `(r+s+1) x (r+s+2)` coefficient Jacobian of multiplication and
`kappa=(a_0,...,a_r,-b_0,...,-b_s)`. The candidate proves, for all
integers `r,s >= 1` including `r=s`,

```text
det([M; v]) = (-1)^(s(r+1)+1) Res(A,B) <v,kappa>
```

as an identity over `Z[a,b,v]` for every border row `v`.

## Status vector

- Statement precision: high; conventions and signs are explicit.
- Producer replay: passed, including optimized Python and negative controls.
- Independent rerun: none documented.
- Independent reimplementation: none documented.
- Formal proof: none; Mathlib ingredients only.
- Specialist review: partial, because the developmental review covered v0.2
  text without the complete v0.3 evidence package.
- Editorial peer review: none.
- Novelty: bounded. The Koszul/resultant strand principle is classical and
  cited; the exact coordinate bridge was not located in the recorded corpus.
- Version stability: the candidate tag is intended to be immutable.

## Claim map

| ID | Scope | Evidence | Non-inference rule |
|---|---|---|---|
| BJ-1 | All-degree bordered/minor identity | Manuscript proof; finite SymPy/FLINT instances and signs | Finite replay does not prove the all-degree quantifier |
| BJ-2 | Integral degree-difference corollary | Euler contraction of BJ-1; exact instances | Do not attribute priority over the cited July statement |
| BJ-3 | Characteristic-p etaleness criterion | Manuscript proof; selected modular checks | Checks cover examples, not arbitrary fields |
| BJ-4 | Pullback obstruction and equal-degree localisation | Manuscript proof; encoded contraction cases | Does not prove the global affine-space phenomenon |
| BJ-5 | Normaliser classification | Manuscript Proposition 4.5 and proof | Not formalised or independently reviewed against v0.3 |

## Safe reuse

Agents may cite the exact statements, hypotheses, hashes and replay commands.
They must retain the unrefereed-candidate label and must not infer truth,
priority, independent verification, formalisation or peer review from public
availability, a DOI, clean hashes or passing producer-side checks.

## Entry points

- `bordered_jacobian_foundations.pdf` — manuscript.
- `CLAIMS.json` and `CLAIMS.md` — machine- and human-readable claim maps.
- `verify_bordered_jacobian.py` — exact executable checks.
- `REPLAY_RECEIPT.md` and `ASSURANCE.md` — replay and trust boundary.
- `CITATION_AUDIT.md` and `NOVELTY.md` — source and bounded-search records.
- `PROVENANCE.md` and `LICENSES.md` — attribution and reuse.
