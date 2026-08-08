## Bottom line

I could **not break the bordered-Jacobian identity or its sign law**. Independent recomputation confirms the delicate signs in Sections 3.3–3.4, including all four boundary deletions. The density, product-formula, Euler, and contraction arguments are mathematically sound.

I did find one concrete sign misstatement in the equal-degree remark and several material overclaims concerning uniqueness, verification coverage, Mathlib, and downstream consequences.

### 1. **NIT — Section 3.3, \(b\)-block sign chain: no defect found**

**Location:** Section 3.3, “The \(b\)-block case.”

For deletion \(k=r+1+j\), the surviving auxiliary row is supported in the \(a\)-block. Starting from row order
\[
(\alpha_1,\dots,\alpha_r,\beta_1,\dots,\beta_s,\tau),
\]
block order requires
\[
(\alpha_1,\dots,\alpha_r,\tau\mid \beta_1,\dots,\beta_s),
\]
so moving \(\tau\) across exactly \(s\) rows contributes \((-1)^s\). That transposition count is correct.

After division by \(\Vand(\alpha,\beta,\tau)\), the mixed factors give
\[
\prod_i b(\alpha_i)
 =b_s^r\prod_{i,j}(\alpha_i-\beta_j)
 =(-1)^{rs}b_s^r\prod_{i,j}(\beta_j-\alpha_i).
\]
Thus the accumulated sign is
\[
(-1)^s(-1)^{rs}=(-1)^{s(r+1)}.
\]
The coefficient convention is also correct:
\[
b(t)=b_s\prod_{\ell=1}^s(t-\beta_\ell)
\quad\Longrightarrow\quad
b_j=(-1)^{s-j}b_s e_{s-j}(\beta).
\]

Finally,
\[
\begin{aligned}
(-1)^k\det M_{\hat k}
&=(-1)^{r+1+j+s(r+1)+s-j}b_j\Res\\
&=(-1)^{rs+r+1}b_j\Res\\
&=(-1)^{r(s+1)}(-b_j)\Res.
\end{aligned}
\]

**Verdict:** The \(b\)-block sign chain is correct.

---

### 2. **NIT — Section 3.4, \(a\)-block sign chain: no defect found**

**Location:** Section 3.4, “The \(a\)-block case.”

After deleting \(a_i\), the surviving auxiliary row is supported in the \(b\)-block. The original row order
\[
(\alpha\text{-rows}\mid\beta\text{-rows},\tau)
\]
is already block ordered: the \(a\)-block uses the \(\alpha\)-rows and the \(b\)-block uses the \(\beta,\tau\)-rows. Hence there is no additional row permutation.

The cancellation gives
\[
\det M_{\hat i}
 =(-1)^{rs}a_r e_{r-i}(\alpha)\Res.
\]
Since
\[
a_i=(-1)^{r-i}a_r e_{r-i}(\alpha),
\]
one obtains
\[
\det M_{\hat i}=(-1)^{rs+r-i}a_i\Res,
\]
and therefore
\[
(-1)^i\det M_{\hat i}
 =(-1)^{rs+r}a_i\Res
 =(-1)^{r(s+1)}a_i\Res.
\]

**Verdict:** The \(a\)-block sign chain is correct.

---

### 3. **NIT — Section 3.2, auxiliary-row split and boundary columns: airtight**

**Location:** Section 3.2, “Splitting the auxiliary row.”

If a \(b\)-column is deleted, there are \(r+1\) surviving \(a\)-columns. In the term where the \(\tau\)-row is supported in the \(b\)-block, only the \(r\) \(\alpha\)-rows have nonzero entries in those \(r+1\) columns. The \(a\)-column submatrix consequently has rank at most \(r\), so that determinant vanishes.

The symmetric argument works after deleting an \(a\)-column.

No boundary exception occurs:

- \(k=0\): \(W_{\hat 0}(\alpha)\) gives \(e_r(\alpha)\Vand(\alpha)\);
- \(k=r\): \(W_{\hat r}(\alpha)\) gives \(e_0\Vand(\alpha)=\Vand(\alpha)\);
- \(k=r+1\): \(W_{\hat 0}(\beta)\) gives \(e_s(\beta)\Vand(\beta)\);
- \(k=r+s+1\): \(W_{\hat s}(\beta)\) gives \(\Vand(\beta)\).

At special points the nominally surviving term can itself vanish—for example if \(e_r(\alpha)=0\)—but that is exactly the expected vanishing of the corresponding coefficient. “Exactly one term survives” should be read as “exactly one is not forced to vanish by block rank.”

**Verdict:** No counterexample, including at the four boundary columns.

---

### 4. **NIT — Section 2.1/product-formula convention: no defect found**

**Location:** Sylvester convention and Lemma 2.2.

For \(r=s=1\),
\[
\Res(A,B)=
\det\begin{pmatrix}a_0&a_1\\ b_0&b_1\end{pmatrix}
=a_0b_1-a_1b_0.
\]
With
\[
a(t)=a_1(t-\alpha),\qquad b(t)=b_1(t-\beta),
\]
this equals
\[
a_1b_1(\beta-\alpha)
=b_1a(\beta)
=-a_1b(\alpha),
\]
matching all three displayed formulas.

In general the evaluated multiplication map has columns ordered \((u,w)\) but nonzero row blocks against \((w,u)\), producing the anti-diagonal sign \((-1)^{rs}\). The formulas
\[
\Res=b_s^r\prod_j a(\beta_j)
\quad\text{and}\quad
\Res=(-1)^{rs}a_r^s\prod_i b(\alpha_i)
\]
are correct in the stated convention. Also \(\Res(X^r,Y^s)=1\).

**Verdict:** Product formula and normalization upheld.

---

### 5. **NIT — Section 3 opening, density and auxiliary point: no defect found**

**Location:** First paragraph of Section 3.

The relevant coefficient locus is the nonempty open set cut out by
\[
a_rb_s\,\Disc(a)\,\Disc(b)\,\Res(A,B)\ne0.
\]
It is Zariski dense in \(\mathbb C^{r+s+2}\). For each coefficient point in this locus, a \(\tau\) outside the finite root set exists. The computation is valid for any such \(\tau\), and every \(\tau\)-factor cancels before the final expression.

There is no need to choose \(\tau\) algebraically as a function of the coefficients: the argument proves the desired equality at every point of the dense coefficient locus after making an auxiliary pointwise choice.

**Verdict:** The density argument is sound. It would be slightly clearer to say explicitly that all roots in the combined \(\alpha,\beta\) list are pairwise distinct.

---

### 6. **NIT — Lemma 2.3 and Corollary 1.2, weights and contraction: no defect found**

**Location:** Euler identity and contraction principle.

There are \(s\) Sylvester rows involving \(A\) and \(r\) involving \(B\), so
\[
\Res(\lambda A,\mu B)=\lambda^s\mu^r\Res(A,B).
\]
For
\[
\kappa=(A,-B),
\]
the corresponding derivation is
\[
D_\kappa=\sum_i a_i\partial_{a_i}-\sum_j b_j\partial_{b_j},
\]
hence
\[
D_\kappa\Res=(s-r)\Res.
\]
Appending \(d\Res\) as the last Jacobian row therefore yields
\[
\det D\Phi_{r,s}
=(-1)^{s(r+1)+1}(s-r)\Res^2
=(-1)^{s(r+1)}(r-s)\Res^2.
\]

**Verdict:** The weights are the right way around, and the degree-difference sign follows correctly.

---

### 7. **MINOR — Remark 4.4 incorrectly drops the cofactor sign**

**Location:** Remark 4.4, sentence:

> “At \(r=s\) the minor identity survives with sign \(+1\): the maximal minors of \(M\) equal \(\Res\cdot\kappa_k\) on the nose.”

Even when \(r=s\), the theorem states
\[
(-1)^k\det M_{\hat k}=\Res\,\kappa_k,
\]
not
\[
\det M_{\hat k}=\Res\,\kappa_k.
\]

Concrete counterexample at \(r=s=1\):
\[
M=
\begin{pmatrix}
b_0&0&a_0&0\\
b_1&b_0&a_1&a_0\\
0&b_1&0&a_1
\end{pmatrix},
\qquad
R=a_0b_1-a_1b_0.
\]
Deleting the \(a_1\)-column, \(k=1\), gives
\[
\det M_{\hat1}=-a_1R,
\]
whereas \(\kappa_1=a_1\). Only the **signed** minor satisfies
\[
(-1)^1\det M_{\hat1}=a_1R.
\]

**Verdict:** Concrete false statement, but only in the prose remark. Replace “the maximal minors” with “the signed maximal minors.”

---

### 8. **MAJOR — “The resultant—and only the resultant—repairs multiplication” is false**

**Location:** Abstract; Introduction discussion of “why the resultant”; Remark 4.5.

Let \(C_0=a_0b_0\), the first coefficient of \(AB\). Since \(C_0\) is a pullback from the product,
\[
dC_0(\kappa)=0.
\]
Set
\[
g=\Res+C_0.
\]
Then
\[
dg(\kappa)=d\Res(\kappa)=(s-r)\Res.
\]
Consequently \((m,g)\) has exactly the same Jacobian determinant as \((m,\Res)\). In fact,
\[
(m,\Res+C_0)
\]
is obtained from \((m,\Res)\) by the target automorphism
\[
(C,z)\longmapsto (C,z+C_0(C)).
\]
Thus it has the same étaleness and global covering behavior.

There are also infinitely many bihomogeneous choices:
\[
g=c\,\Res^n,
\]
for which
\[
dg(\kappa)=n(s-r)c\,\Res^n.
\]
Over characteristic zero and \(r\ne s\), every such \(g\) completes multiplication on the whole coprime locus.

The defensible statement is narrower:

- among bihomogeneous normalizers, irreducibility implies that those nonvanishing on \(D(\Res)\) are constant multiples of powers of \(\Res\);
- \(\Res\) is the minimal positive power;
- modulo functions annihilated by \(d(-)(\kappa)\), many non-bihomogeneous normalizers are equivalent.

**Verdict:** The determinant computation is correct, but the asserted uniqueness is refuted.

---

### 9. **MAJOR — The verification suite is materially overdescribed**

**Location:** Abstract and opening paragraph of Section 5.

The manuscript claims that “every identity” is checked “in two independent implementations.” The supplied suite does not do that:

- product formula: SymPy only;
- full degree-difference determinant: both FLINT and SymPy at the smaller overlapping degrees;
- maximal-minor identity: FLINT only;
- contraction examples: FLINT only;
- characteristic-\(p\) examples: FLINT only;
- base-point signs: FLINT integer matrices only;
- gap-Vandermonde lemma: not tested;
- density argument: not testable and not tested;
- general pullback obstruction: not tested, only one coefficient \(c_1\);
- étaleness “if and only if”: not tested;
- characteristic-\(p\) suite checks only the vanishing implication for five selected triples.

The cross-implementation comparison applies only to the full determinant at low bidegrees. The suite is still useful and substantial, but it is not a two-implementation verification of every identity.

**Verdict:** Verification evidence for the main identity is strong but the manuscript’s coverage claim is false. The wording should enumerate which checks use which backend.

---

### 10. **MAJOR — The Mathlib “monic chart of Corollary 4.2” claim conflates different maps**

**Location:** Section 6 table and surrounding text.

The monic multiplication map is not a chart of the degree-difference map in a way that preserves its étaleness criterion. It is a transverse slice obtained by fixing two leading coefficients and one target coefficient.

The discrepancy is already visible at \(r=s=1\). Write
\[
a(t)=a_0+t,\qquad b(t)=b_0+t.
\]
The monic multiplication map is
\[
(a_0,b_0)\longmapsto (c_0,c_1)
=(a_0b_0,a_0+b_0),
\]
with Jacobian
\[
\begin{pmatrix}
b_0&a_0\\
1&1
\end{pmatrix},
\qquad
\det=b_0-a_0=-\Res.
\]
It is étale on the monic coprime locus \(a_0\ne b_0\).

By contrast, the original nonmonic map
\[
\Phi_{1,1}=(m,\Res)
\]
is everywhere degenerate because \(r=s\).

Therefore Mathlib’s monic coprime-factorization étaleness, even assuming the cited theorem and interpretation are exact, cannot be called a “monic chart of Corollary 4.2.” It proves a related square Sylvester determinant after the scaling direction has been removed, not the degree-difference criterion.

The manuscript itself acknowledges that the bordered bookkeeping remains unformalized, which also weakens the abstract’s claim that the monic chart of the bordered identity is “already machine-checked.”

**Verdict:** The Mathlib material is relevant background, but its relationship to the present theorem is overstated. Exact theorem statements and hypotheses should be quoted rather than summarized as an analogue of the characteristic-\(p\) corollary.

---

### 11. **MINOR — The proof does use characteristic-zero input**

**Location:** Abstract versus Section 2 opening and Section 3 conclusion.

The abstract says the proof uses “no characteristic-zero input,” but the proof explicitly proceeds by:

1. passing to \(\mathbb C\);
2. factoring into roots;
3. proving the equality on a Zariski-dense complex open set.

That is a perfectly valid way to prove an identity in \(\mathbb Z[a,b,v]\), but it is a characteristic-zero proof. What is true is that the resulting identity is integral and hence valid after arbitrary base change.

**Verdict:** Replace “uses no characteristic-zero input” with “requires no characteristic-zero hypothesis in the statement and yields an integral identity.”

---

### 12. **MINOR — The characteristic-\(p\) criterion is ambiguous at \(r=s\) in characteristic zero**

**Location:** Corollary 4.2.

The clean condition is
\[
(s-r)\cdot1_F\ne0\quad\text{in }F.
\]
Equivalently:

- if \(\operatorname{char}F=0\), require \(r\ne s\);
- if \(\operatorname{char}F=p>0\), require \(p\nmid(s-r)\).

Writing
\[
\operatorname{char}F\nmid s-r
\]
is nonstandard when \(\operatorname{char}F=0\), especially at \(r=s\). Likewise \(\mathbb Z[1/(s-r)]\) needs qualification when \(s-r=0\); formally localizing at zero gives the zero ring/empty base, not a meaningful equal-degree étaleness assertion.

**Verdict:** The intended criterion is correct, but the equal-degree/characteristic-zero wording should be repaired.

---

### 13. **MAJOR — The local pairing does not by itself derive the listed global properties**

**Location:** Remark 4.5 and Remark 4.6.

The bordered determinant and Euler pairing establish the local Jacobian/étaleness statement. They do not, by themselves, derive:

- the \(\mu_{|s-r|}\)-torsor structure;
- the class group \(\mathbb Z/|s-r|\mathbb Z\);
- the covering degree \(|s-r|\binom{r+s}{r}\);
- slice classifications or Euler-characteristic exclusions.

Those require separate global arguments about factorization fibers, group actions, quotient geometry, and compactly supported invariants. A local determinant formula cannot determine a covering degree or class group in isolation.

The statement that all these properties “inherit the same integer from this single pairing” is explanatory rhetoric, not a proved implication. Similarly, saying downstream results “now rest on Theorem 1.1 and Lemma 2.3 alone” is false if read literally; at most, those results now use these as their determinant input.

There is also an internal tension: Remark 4.5 invokes the assertion that a polynomial nonvanishing on \(D(\Res)\) is a power of \(\Res\), which depends on irreducibility, while Remark 4.6 says irreducibility is no longer load-bearing “anywhere in the chain.”

**Verdict:** The local foundation is valid, but the manuscript overstates what it alone proves.

---

### 14. **MINOR — Historical ledger and priority claims are not auditable from the supplied materials**

**Location:** Introduction, Section 5 final paragraph, and Section 7.

The assertion that the July ledger “did not verify the identity itself at any bidegree” cannot be established from the present suite. It requires inspection of an archived July repository or ledger. Likewise, negative literature claims about what public threads or databases did not contain require a reproducible search record.

The priority section is appropriately qualified as a bounded search, so I found no direct contradiction. But the ledger claim is presented as fact without supplying the old ledger, version hash, or archive.

**Verdict:** Not refuted, but not independently verified from the manuscript and companion script.

---

### 15. **NIT — Remark 4.4’s coefficient-functional example is correct**

**Location:** Remark 4.4.

For \(g=a_0\),
\[
dg(\kappa)=a_0,
\]
so
\[
\det D(m,a_0)
=(-1)^{s(r+1)+1}a_0\Res.
\]
Thus the claimed \(\pm a_0\Res\) is correct. A coefficient can vanish on the coprime locus—for example \(A=Y^r\), \(B=X^s\) has \(a_0=0\) and \(\Res\ne0\).

**Verdict:** No defect in this example.

---

## Overall verdict

The core mathematical result survives adversarial review:

\[
\det\begin{pmatrix}M\\v\end{pmatrix}
=(-1)^{s(r+1)+1}\Res(A,B)\langle v,\kappa\rangle
\]
and
\[
\det D\Phi_{r,s}
=(-1)^{s(r+1)}(r-s)\Res^2
\]
have the correct signs and are valid uniformly at \(r=s\).

The manuscript should nevertheless be revised to:

1. restore the missing \((-1)^k\) in Remark 4.4;
2. abandon “only the resultant” uniqueness, or state a precise classification modulo scaling-invariant additions and powers;
3. narrow the verification claims to what the suite actually checks;
4. distinguish the Mathlib monic slice from the bordered and degree-difference maps;
5. qualify the characteristic-zero and characteristic-\(p\) language;
6. separate the local determinant input from the additional global geometry.
