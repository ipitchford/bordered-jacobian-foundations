Adversarial review request — REFUTE if you can.

Target: the manuscript at
/Users/admin/affine_hyperplane_slices/degree_difference_foundations/bordered_jacobian_foundations.tex
(companion verification suite: verify_bordered_jacobian.py in the same
directory; you may read both, and run the suite if useful).

The manuscript claims, for binary forms A (deg r), B (deg s), with M
the (r+s+1)x(r+s+2) Jacobian of coefficient multiplication and
kappa = (a_0..a_r, -b_0..-b_s):

  det[M; v] = (-1)^{s(r+1)+1} Res(A,B) <v,kappa>   in Z[a,b,v], all r,s>=1 incl. r=s,

proved by evaluation at roots + one auxiliary point, a gap-Vandermonde
lemma, and an in-convention product formula; then derives the July
degree-difference identity det DPhi = (-1)^{s(r+1)}(r-s)Res^2 over Z,
a char-p etaleness criterion, a pullback obstruction, and an
equal-degree localisation.

Your job is to BREAK it. Priorities:
1. The sign chains in Sections 3.3 and 3.4 (b-block and a-block cases):
   recompute independently; check the transposition sign (-1)^s, the
   block ordering claims, and the elementary-symmetric/coefficient
   sign conventions b_j = (-1)^{s-j} b_s e_{s-j}(beta).
2. The multilinear split of the tau-row and the vanishing argument
   (rows vs columns count) — is the "exactly one term survives" claim
   airtight when the deleted column is a boundary column (k=0, k=r,
   k=r+1, k=r+s+1)?
3. The density argument: is proving the identity on the locus
   (distinct roots, a_r b_s != 0) sufficient to conclude in Z[a,b,v]?
   Any subtlety with the auxiliary point tau?
4. The product-formula lemma and its convention (Sylvester rows = s
   shifts of a then r shifts of b; Res(X^r, Y^s)=1): check against the
   claimed forms b_s^r prod a(beta_j) = (-1)^{rs} a_r^s prod b(alpha_i).
5. The contraction principle and the Euler identity: weights of Res as
   (s,r) — right way round? dRes(kappa) = (s-r)Res?
6. Overclaiming: the priority language in Section 7, the Mathlib
   claims in Section 6 (UniversalFactorizationRing: jacobiMatrix =
   Sylvester up to sign; coprime factorization ring etale), and the
   claim that the July release's ledger did not verify the identity.
7. Anything else: the r=s uniformity claim, Remark 4.4's assertion
   that a coefficient functional gives det = +-a_0 Res, the
   "why the resultant" argument in Remark 4.5.

Report format: numbered findings, each with severity
(FATAL/MAJOR/MINOR/NIT), the exact location, your independent
computation or counterexample attempt, and a verdict. If you cannot
refute a claim after genuine effort, say so explicitly. Do not
paraphrase the paper back; attack it.
