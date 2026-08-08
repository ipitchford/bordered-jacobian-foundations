# Publication-gate replay receipt

Date: 8 August 2026. Executor: repository publication workflow.

## Intake and build

- Source ZIP SHA-256: `88c6096f072bc85e1e3ea363a3405d6f3332c9ca397901f163d7f8e06dde769b`.
- Supplied `SHA256SUMS`: all entries passed before publication edits.
- Rebuilt TeX: success, 12 US-letter pages, all fonts embedded.
- PDF byte reproducibility: not claimed; TeX metadata makes separately built
  PDFs differ in bytes even when content and page geometry agree.

## Fresh exact replay

Environment: CPython 3.14.6, SymPy 1.14.0, python-flint 0.9.0,
macOS 26.5.2 arm64.

| Command | Result |
|---|---|
| `python verify_bordered_jacobian.py --deep` | 93 checks, 0 failures |
| `python verify_bordered_jacobian.py` | 58 checks, 0 failures |
| `python -O verify_bordered_jacobian.py` | 58 checks, 0 failures |
| `shasum -a 256 -c SHA256SUMS` | every frozen entry passed after corrections |

The deepest `(5,6)` exact determinant instance dominated runtime. The deep run
took approximately 586 seconds on this machine. Timings are not deterministic.

## Negative controls

The suite detected a perturbed Jacobian, wrong sign, wrong resultant power,
flipped kernel vector and transposed-bidegree confusion. The verifier contains
no `assert`-only proof checks; the optimized run exercises the same explicit
failure paths.

This is a fresh producer-workflow replay. It is not independent reproduction,
formal verification or peer review.
