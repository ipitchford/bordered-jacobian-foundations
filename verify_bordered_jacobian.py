#!/usr/bin/env python3
"""Exact verification suite for the bordered-Jacobian foundations release.

Verifies, over the integers with no floating point and no random sampling:

  (I)   the degree-difference identity
        det D(Phi_{r,s}) = (-1)^{s(r+1)} (r-s) Res(A,B)^2,
  (II)  the bordered/minor identity
        (-1)^k det(M minus column k) = (-1)^{r(s+1)} Res(A,B) kappa_k,
        where M is the Jacobian of coefficient multiplication alone and
        kappa = (a_0,...,a_r, -b_0,...,-b_s) spans ker(dm) --- including
        the equal-degree case r = s,
  (III) the bihomogeneous contraction corollary
        det D(m, g) = (-1)^{s(r+1)+1} (p-q) g Res  for g bihomogeneous of
        weight (p, q), including the weight-difference-zero vanishing,
  (IV)  the base-point sign matrix for 1 <= r, s <= max_base,
  (V)   the characteristic-p statement: p | (r-s) forces det = 0 mod p,
  (VI)  negative controls: perturbed Jacobian, wrong sign, wrong resultant
        power, flipped kernel vector, and transposed-bidegree confusion all
        FAIL as they must.

Two separately written computational backends are cross-checked: SymPy (symbolic,
Berkowitz determinants) and python-flint (fmpz_mpoly, fraction-free
Bareiss determinants).  Conventions follow the July 2026 release:
A = sum a_i X^{r-i} Y^i, dehomogenised a(t) = sum a_i t^i, Sylvester rows
are the s shifts of a followed by the r shifts of b, so Res(X^r, Y^s) = 1.

Usage:  verify_bordered_jacobian.py [--deep]
"""
from __future__ import annotations

import argparse
import itertools
import platform
import sys
import time

import sympy as sp
import flint
from flint import Ordering, fmpz_mat, fmpz_mpoly_ctx

CHECKS = []          # (label, passed, detail)


def record(label: str, passed: bool, detail: str = "") -> None:
    CHECKS.append((label, passed, detail))
    mark = "PASS" if passed else "FAIL"
    print(f"  [{mark}] {label}" + (f"  ({detail})" if detail else ""), flush=True)


# ---------------------------------------------------------------------------
# FLINT path
# ---------------------------------------------------------------------------

def flint_ring(r: int, s: int):
    names = tuple(f"a{i}" for i in range(r + 1)) + tuple(f"b{j}" for j in range(s + 1))
    ctx = fmpz_mpoly_ctx.get(names, Ordering.lex)
    gens = ctx.gens()
    return ctx, list(gens[: r + 1]), list(gens[r + 1:])


def bareiss_det(mat):
    """Fraction-free Bareiss determinant for a square matrix of fmpz_mpoly."""
    m = [row[:] for row in mat]
    n = len(m)
    if n == 0:
        return 1
    ctx = m[0][0].context()
    one = ctx.from_dict({(0,) * ctx.nvars(): 1})
    prev = one
    sign = 1
    for k in range(n - 1):
        if not m[k][k]:
            for i in range(k + 1, n):
                if m[i][k]:
                    m[k], m[i] = m[i], m[k]
                    sign = -sign
                    break
            else:
                return ctx.from_dict({})
        for i in range(k + 1, n):
            for j in range(k + 1, n):
                m[i][j] = (m[k][k] * m[i][j] - m[i][k] * m[k][j]) // prev
        prev = m[k][k]
    return sign * m[n - 1][n - 1] if sign == 1 else -m[n - 1][n - 1]


def flint_objects(r: int, s: int):
    """Return (ctx, a, b, product coefficients, Sylvester resultant, M, kappa)."""
    ctx, a, b = flint_ring(r, s)
    zero = ctx.from_dict({})
    c = [sum((a[i] * b[k - i] for i in range(r + 1) if 0 <= k - i <= s), zero)
         for k in range(r + s + 1)]
    n = r + s
    syl = [[zero for _ in range(n)] for _ in range(n)]
    for k in range(s):
        for i in range(r + 1):
            syl[k][k + i] = a[i]
    for k in range(r):
        for j in range(s + 1):
            syl[s + k][k + j] = b[j]
    R = bareiss_det(syl)
    nv = r + s + 2
    M = [[ck.derivative(x) for x in range(nv)] for ck in c]
    kappa = a + [-bj for bj in b]
    return ctx, a, b, c, R, M, kappa


def full_det_flint(r: int, s: int):
    ctx, a, b, c, R, M, kappa = flint_objects(r, s)
    nv = r + s + 2
    dR = [R.derivative(x) for x in range(nv)]
    J = [row[:] for row in M] + [dR]
    return bareiss_det(J), R


def check_full_identity_flint(r: int, s: int) -> None:
    t0 = time.time()
    det, R = full_det_flint(r, s)
    rhs = (-1) ** (s * (r + 1)) * (r - s) * R * R
    record(f"(I) full identity FLINT (r,s)=({r},{s})", det == rhs,
           f"{time.time()-t0:.1f}s")


def check_minor_identity_flint(r: int, s: int) -> None:
    t0 = time.time()
    ctx, a, b, c, R, M, kappa = flint_objects(r, s)
    sigma = (-1) ** (r * (s + 1))
    ok = True
    for k in range(r + s + 2):
        sub = [[row[j] for j in range(r + s + 2) if j != k] for row in M]
        nu = (-1) ** k * bareiss_det(sub)
        if nu != sigma * R * kappa[k]:
            ok = False
            break
    record(f"(II) minor identity FLINT (r,s)=({r},{s}) incl. sign law", ok,
           f"sigma={sigma:+d}, {time.time()-t0:.1f}s")


def bordered_det_flint(r: int, s: int, g):
    """det of [M ; dg] with dg appended as the last row."""
    ctx, a, b, c, R, M, kappa = flint_objects(r, s)
    nv = r + s + 2
    dg = [g.derivative(x) for x in range(nv)]
    return bareiss_det([row[:] for row in M] + [dg]), R


def check_bihom_corollary(r: int, s: int) -> None:
    """det D(m,g) = tau (p-q) g R for bihomogeneous g of weight (p,q)."""
    ctx, a, b, c, R, M, kappa = flint_objects(r, s)
    tau = (-1) ** (s * (r + 1) + 1)
    cases = [
        ("g=a0 (weight (1,0))", a[0], 1 - 0, a[0]),
        ("g=b0 (weight (0,1))", b[0], 0 - 1, b[0]),
        ("g=a0*b0 (weight (1,1))", a[0] * b[0], 0, a[0] * b[0]),
        ("g=a0^2*b0 (weight (2,1))", a[0] * a[0] * b[0], 1, a[0] * a[0] * b[0]),
        ("g=c1 (pullback, weight (1,1))", c[1] if len(c) > 1 else c[0], 0,
         c[1] if len(c) > 1 else c[0]),
        ("g=c0^2+c1 (nonlinear pullback)",
         c[0] * c[0] + (c[1] if len(c) > 1 else c[0]), 0,
         c[0] * c[0] + (c[1] if len(c) > 1 else c[0])),
    ]
    ok = True
    for label, g, wdiff, gpoly in cases:
        nv = r + s + 2
        dg = [g.derivative(x) for x in range(nv)]
        det = bareiss_det([row[:] for row in M] + [dg])
        expected = tau * wdiff * gpoly * R
        if det != expected:
            ok = False
            record(f"(III) bihom corollary ({r},{s}) {label}", False)
    record(f"(III) bihomogeneous contraction corollary (r,s)=({r},{s})", ok,
           "6 weight cases incl. three vanishing (balanced, linear + nonlinear pullback)")


# ---------------------------------------------------------------------------
# SymPy path (independent implementation)
# ---------------------------------------------------------------------------

def sympy_objects(r: int, s: int):
    a = sp.symbols(f"a0:{r+1}")
    b = sp.symbols(f"b0:{s+1}")
    n = r + s
    syl = sp.zeros(n, n)
    for k in range(s):
        for i in range(r + 1):
            syl[k, k + i] = a[i]
    for k in range(r):
        for j in range(s + 1):
            syl[s + k, k + j] = b[j]
    R = syl.det(method="berkowitz")
    c = [sum(a[i] * b[k - i] for i in range(r + 1) if 0 <= k - i <= s)
         for k in range(r + s + 1)]
    xs = list(a) + list(b)
    return a, b, c, R, xs


def check_full_identity_sympy(r: int, s: int) -> None:
    t0 = time.time()
    a, b, c, R, xs = sympy_objects(r, s)
    J = sp.Matrix([[sp.diff(ck, x) for x in xs] for ck in c] +
                  [[sp.diff(R, x) for x in xs]])
    lhs = J.det(method="berkowitz")
    rhs = (-1) ** (s * (r + 1)) * (r - s) * R ** 2
    record(f"(I) full identity SymPy (r,s)=({r},{s})",
           sp.expand(lhs - rhs) == 0, f"{time.time()-t0:.1f}s")


def check_cross_implementation(r: int, s: int) -> None:
    """The two implementations must produce the identical determinant."""
    det_f, R_f = full_det_flint(r, s)
    a, b, c, R, xs = sympy_objects(r, s)
    J = sp.Matrix([[sp.diff(ck, x) for x in xs] for ck in c] +
                  [[sp.diff(R, x) for x in xs]])
    det_s = sp.expand(J.det(method="berkowitz"))
    ctx = det_f.context()
    names = [str(g) for g in ctx.gens()]
    subs = dict(zip(sp.symbols(" ".join(names)), range(len(names))))
    # compare by converting the FLINT polynomial to a SymPy expression
    expr = 0
    for monom, coeff in det_f.terms():
        term = sp.Integer(int(coeff))
        for var_index, exp in enumerate(monom):
            if exp:
                term *= sp.Symbol(names[var_index]) ** exp
        expr += term
    record(f"cross-implementation agreement (r,s)=({r},{s})",
           sp.expand(det_s - expr) == 0)


# ---------------------------------------------------------------------------
# Base-point signs, characteristic p, negative controls
# ---------------------------------------------------------------------------

def check_product_formula(r: int, s: int) -> None:
    """Res = a_r^s b_s^r prod_{i,j} (beta_j - alpha_i) in this convention,
    proved with symbolic roots (SymPy), independent of both main paths."""
    t0 = time.time()
    ar, bs = sp.symbols("ar bs")
    al = sp.symbols(f"al0:{r}")
    be = sp.symbols(f"be0:{s}")
    t = sp.Symbol("t")
    apoly = sp.expand(ar * sp.prod((t - x) for x in al))
    bpoly = sp.expand(bs * sp.prod((t - x) for x in be))
    acoef = [apoly.coeff(t, i) for i in range(r + 1)]
    bcoef = [bpoly.coeff(t, j) for j in range(s + 1)]
    n = r + s
    syl = sp.zeros(n, n)
    for k in range(s):
        for i in range(r + 1):
            syl[k, k + i] = acoef[i]
    for k in range(r):
        for j in range(s + 1):
            syl[s + k, k + j] = bcoef[j]
    lhs = syl.det(method="berkowitz")
    rhs = ar**s * bs**r * sp.prod((y - x) for x in al for y in be)
    record(f"(0) product formula in-convention (r,s)=({r},{s})",
           sp.expand(lhs - rhs) == 0, f"{time.time()-t0:.1f}s")


def check_gap_vandermonde(m: int) -> None:
    """det W_khat(x_1..x_m) = e_{m-k}(x) * Vand(x), all 0 <= k <= m (SymPy)."""
    t0 = time.time()
    xs = sp.symbols(f"x0:{m}")
    vand = sp.prod((xs[q] - xs[p]) for p in range(m) for q in range(p + 1, m))
    ok = True
    for k in range(m + 1):
        powers = [c for c in range(m + 1) if c != k]
        W = sp.Matrix([[xs[p] ** c for c in powers] for p in range(m)])
        esym = (sum(sp.prod(sub) for sub in itertools.combinations(xs, m - k))
                if m - k > 0 else 1)
        if sp.expand(W.det(method="berkowitz") - esym * vand) != 0:
            ok = False
            break
    record(f"(0') gap-Vandermonde m={m}, all k", ok, f"{time.time()-t0:.1f}s")


def check_ker_delta_controls() -> None:
    """External-review controls: ker(delta) is larger than the pullbacks,
    and ker(delta)-additions preserve the bordered Jacobian.
    (i) r=s=1, h = a0*b1 - a1*b0: delta(h)=0, det D(m,h)=0, and h is not
        a pullback although h^2 = c1^2 - 4*c0*c2 is.
    (ii) r=1,s=2: det D(m, R + h0) == det D(m, R) for h0 = a0*b1 - a1*b0
        in ker(delta)."""
    t0 = time.time()
    ok = True
    # (i) SymPy at (1,1)
    a, b, c, R, xs = sympy_objects(1, 1)
    h = a[0] * b[1] - a[1] * b[0]
    delta_h = (sum(x * sp.diff(h, x) for x in a)
               - sum(x * sp.diff(h, x) for x in b))
    ok &= sp.expand(delta_h) == 0
    J = sp.Matrix([[sp.diff(ck, x) for x in xs] for ck in c] +
                  [[sp.diff(h, x) for x in xs]])
    ok &= sp.expand(J.det()) == 0
    c0, c1, c2 = c
    ok &= sp.expand(h**2 - (c1**2 - 4 * c0 * c2)) == 0
    # (ii) SymPy at (1,2)
    a, b, c, R, xs = sympy_objects(1, 2)
    h0 = a[0] * b[1] - a[1] * b[0]
    target = (-1) ** (2 * 2) * (1 - 2) * R**2
    for g in (R, R + h0, R + c[0] ** 2):
        J = sp.Matrix([[sp.diff(ck, x) for x in xs] for ck in c] +
                      [[sp.diff(g, x) for x in xs]])
        ok &= sp.expand(J.det() - target) == 0
    record("(III'') ker-delta controls (external-review examples)", ok,
           f"{time.time()-t0:.1f}s")


def check_base_signs(max_deg: int) -> None:
    t0 = time.time()
    bad = 0
    for r in range(1, max_deg + 1):
        for s in range(1, max_deg + 1):
            size = r + s + 2
            rows = [[0] * size for _ in range(size)]
            for i in range(r + 1):
                rows[s + i][i] = 1
            for j in range(s + 1):
                rows[j][r + 1 + j] = 1
            rows[-1][0] = s
            rows[-1][r + 1 + s] = r
            expected = (-1) ** (s * (r + 1)) * (r - s)
            if fmpz_mat(rows).det() != expected:
                bad += 1
    record(f"(IV) base-point signs 1<=r,s<={max_deg}", bad == 0,
           f"{max_deg*max_deg} cases, {time.time()-t0:.1f}s")


def check_char_p() -> None:
    ok = True
    for (r, s, p) in [(1, 3, 2), (1, 4, 3), (2, 4, 2), (2, 5, 3), (3, 5, 2)]:
        det, R = full_det_flint(r, s)
        if any(int(coeff) % p for _, coeff in det.terms()):
            ok = False
    record("(V) characteristic p | (r-s) forces det = 0 mod p", ok,
           "(1,3)m2 (1,4)m3 (2,4)m2 (2,5)m3 (3,5)m2")


def negative_controls() -> None:
    # 1. perturbed Jacobian entry must break the identity
    ctx, a, b, c, R, M, kappa = flint_objects(2, 3)
    nv = 2 + 3 + 2
    dR = [R.derivative(x) for x in range(nv)]
    one = ctx.from_dict({(0,) * ctx.nvars(): 1})
    Mbad = [row[:] for row in M] + [dR]
    Mbad[0][0] = Mbad[0][0] + one
    det_bad = bareiss_det(Mbad)
    rhs = (-1) ** (3 * 3) * (2 - 3) * R * R
    record("(VI) NC1 perturbed Jacobian detected", det_bad != rhs)

    # 2. wrong sign must fail
    det, R12 = full_det_flint(1, 2)
    record("(VI) NC2 wrong sign detected", det != R12 * R12)

    # 3. wrong resultant power must fail
    record("(VI) NC3 wrong power detected",
           det != (-1) ** (2 * 2) * (1 - 2) * R12)

    # 4. flipped kernel vector must break the minor identity
    ctx, a, b, c, R, M, kappa = flint_objects(1, 2)
    kbad = a + list(b)          # sign flip on the b block
    sigma = (-1) ** (1 * 3)
    broke = False
    for k in range(5):
        sub = [[row[j] for j in range(5) if j != k] for row in M]
        nu = (-1) ** k * bareiss_det(sub)
        if nu != sigma * R * kbad[k]:
            broke = True
            break
    record("(VI) NC4 flipped kernel vector detected", broke)

    # 5. transposed bidegrees must disagree: formula(1,3) != formula(3,1)
    det13, R13 = full_det_flint(1, 3)
    rhs31 = (-1) ** (1 * 4) * (3 - 1) * R13 * R13
    record("(VI) NC5 transposed-bidegree confusion detected", det13 != rhs31)


# ---------------------------------------------------------------------------

def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--deep", action="store_true",
                    help="extended tier (roughly 30-60 minutes)")
    args = ap.parse_args()

    t0 = time.time()
    max_full_flint = 8 if args.deep else 6
    max_full_sympy = 5 if args.deep else 4
    max_minor = 7 if args.deep else 5
    max_cross = 5 if args.deep else 4
    max_base = 40 if args.deep else 16

    print("Product formula in this Sylvester convention (symbolic roots):")
    for (r, s) in [(1, 1), (1, 2), (2, 2), (2, 3), (3, 3)]:
        check_product_formula(r, s)

    print("Gap-Vandermonde lemma (symbolic):")
    for m in range(2, 6):
        check_gap_vandermonde(m)

    print("Full determinant identity, FLINT path:")
    for n in range(2, max_full_flint + 1):
        for r in range(1, n):
            check_full_identity_flint(r, n - r)
    if args.deep:
        print("Full determinant identity, FLINT path, high-bidegree spot checks:")
        for (r, s) in [(4, 5), (5, 5), (5, 6)]:
            check_full_identity_flint(r, s)

    print("Full determinant identity incl. r=s, SymPy path:")
    for n in range(2, max_full_sympy + 1):
        for r in range(1, n):
            check_full_identity_sympy(r, n - r)

    print("Minor identity with sign law, incl. r=s, FLINT path:")
    for n in range(2, max_minor + 1):
        for r in range(1, n):
            check_minor_identity_flint(r, n - r)

    print("Bihomogeneous contraction corollary:")
    for (r, s) in [(1, 2), (2, 3), (2, 2), (1, 4)]:
        check_bihom_corollary(r, s)

    print("Kernel-of-derivation controls:")
    check_ker_delta_controls()

    print("Cross-implementation agreement:")
    for n in range(2, max_cross + 1):
        for r in range(1, n):
            check_cross_implementation(r, n - r)

    print("Base-point signs:")
    check_base_signs(max_base)

    print("Characteristic p:")
    check_char_p()

    print("Negative controls (must all FAIL-as-designed):")
    negative_controls()

    failed = [label for (label, ok, _) in CHECKS if not ok]
    print()
    print(f"{len(CHECKS)} checks, {len(failed)} failures, "
          f"total {time.time()-t0:.0f}s "
          f"[tier: {'deep' if args.deep else 'default'}]")
    print("versions: sympy", sp.__version__, "| python-flint", flint.__version__,
          "| python", sys.version.split()[0])
    print("platform:", platform.platform(), "|", platform.machine())
    if failed:
        for f in failed:
            print("FAILED:", f)
        sys.exit(1)
    print("ALL CHECKS PASSED")


if __name__ == "__main__":
    main()
