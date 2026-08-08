# Bundle manifest — bordered-Jacobian foundations, v0.3-candidate

Prepared 6 August 2026 for external assessment; publication metadata and a
fresh replay record were added on 8 August 2026. `git-history.txt` preserves
the supplied pre-publication history and is not the history of this public
repository.

## Read first
- `bordered_jacobian_foundations.pdf` — the manuscript (12 pp.)
- `reviews/RESPONSE_TO_REVIEW.md` — point-by-point response to the
  external developmental review of 6 August 2026
- `CLAIMS.md` — claim-to-evidence index and one-command replay

## Manuscript
- `bordered_jacobian_foundations.pdf` / `.tex` — v0.3-candidate

## Executable evidence
- `verify_bordered_jacobian.py` — exact suite, two backends
- `requirements.txt` — sympy 1.14.0, python-flint 0.9.0
- `ENVIRONMENT.txt` — interpreter, platform, pins, replay commands
- `verification_receipt_deep.txt` — 93 checks, 0 failures (~7 min)
- `verification_receipt_default.txt` — 58 checks, 0 failures (~3 s)
- `Makefile` — `make verify | deep | receipt | check | pdf`
- `SHA256SUMS` — integrity manifest (`make check` verifies)

## Assessment records
- `NOVELTY.md` — prior-art gate; four full-text classical audits
- `QUALITY_GATE.md` — (O,S,R) vector, assurance state, decision
- `reviews/external_review_2026-08-06.md` — the external review
- `reviews/RESPONSE_TO_REVIEW.md` — our response
- `reviews/sol_adversarial_2026-08-06.md` (+ prompt) — cross-model
  adversarial review (GPT-5.6 Sol, refute-framed)

## Publication drafts
- `RELEASE_PAGE.md` — draft evidencepress.org release page
- `JULY_PAGE_CORRECTION.md` — correction proposed for the July page

## Assurance state (declared)
Internally checked; replayed; cross-model adversarially reviewed;
externally reviewed (developmental, v0.2 text). NOT independently
reproduced by another party; NOT formally verified; NOT peer
reviewed. Per-bidegree checks certify instances; the all-degree
statement rests on the Section 3 proof. The two backends guard
against implementation error, not shared specification error.

## Public-release additions

- `AI_INDEX.md` and `CLAIMS.json` — agent-readable identity and claim map.
- `ASSURANCE.md` and `REPLAY_RECEIPT.md` — publication-gate audit boundary.
- `CITATION_AUDIT.md` — citation existence and contextual-use checks.
- `PROVENANCE.md`, `CITATION.cff`, `LICENSES.md`, `LICENSE`, and
  `LICENSE-CODE` — attribution, citation and reuse metadata.
