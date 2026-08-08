# Claim-to-evidence index

Maps each verification claim in Section 5 of the manuscript to the
suite function that implements it and the receipt lines that record
it. Suite: `verify_bordered_jacobian.py` (one file; two separately
written computational backends — SymPy symbolic and python-flint
exact ℤ-polynomial with fraction-free Bareiss). Receipts:
`verification_receipt_deep.txt` (--deep tier, the release record) and
`verification_receipt_default.txt` (fast tier). Environment:
`requirements.txt`, `ENVIRONMENT.txt`; the receipt tail records
package versions and platform.

Replay:

```
python3 -m venv v && v/bin/pip install -r requirements.txt
v/bin/python verify_bordered_jacobian.py --deep
```

| Manuscript §5 item | Suite function | Receipt line pattern | Backend |
|---|---|---|---|
| (0) product formula, symbolic roots, 5 bidegrees | `check_product_formula` | `(0) product formula in-convention (r,s)=…` | SymPy |
| (0′) gap-Vandermonde, m = 2..5, all k | `check_gap_vandermonde` | `(0') gap-Vandermonde m=…` | SymPy |
| (I) full identity, all r+s ≤ 8 + (4,5),(5,5),(5,6) | `check_full_identity_flint` | `(I) full identity FLINT (r,s)=…` | FLINT |
| (I) full identity, r+s ≤ 5, independent path | `check_full_identity_sympy` | `(I) full identity SymPy (r,s)=…` | SymPy |
| (I) coefficientwise backend agreement, r+s ≤ 5 | `check_cross_implementation` | `cross-implementation agreement (r,s)=…` | both |
| (II) minor identity + sign law, r+s ≤ 7 incl. r=s | `check_minor_identity_flint` | `(II) minor identity FLINT (r,s)=… sigma=…` | FLINT |
| (III) contraction corollary, 6 weight cases × 4 bidegrees | `check_bihom_corollary` | `(III) bihomogeneous contraction corollary …` | FLINT |
| (III″) ker-δ controls (external-review examples) | `check_ker_delta_controls` | `(III'') ker-delta controls …` | SymPy |
| (IV) base-point signs, r,s ≤ 40 (1600 cases) | `check_base_signs` | `(IV) base-point signs 1<=r,s<=40` | FLINT fmpz |
| (V) char-p forward direction, 5 (r,s,p) triples | `check_char_p` | `(V) characteristic p | (r-s) forces det = 0 mod p` | FLINT |
| (VI) five negative controls | `negative_controls` | `(VI) NC1 … NC5 … detected` | FLINT |

Boundaries declared in the manuscript and repeated here: per-bidegree
checks certify instances, not the all-degree quantifier, which rests
on the Section 3 proof; the two backends guard against implementation
error, not shared specification error; the degree bounds are chosen
audit boundaries except that (6,7)+ was measured impractical.

Integrity: SHA-256 digests of every release file are appended to
`verification_receipt_deep.txt` and duplicated in `SHA256SUMS`.
