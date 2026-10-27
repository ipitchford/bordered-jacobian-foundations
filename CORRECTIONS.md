# Corrections

## 2026-10-27 — errata to bordered-jacobian-foundations 0.3-candidate (DOI 10.5281/zenodo.21855302)

The archived PDF, the manuscript source, the Zenodo deposit and the tag `v0.3-candidate` are unchanged. These errata were confirmed by the Evidence Press archive audit and are also shown at <https://evidencepress.org/releases/bordered-jacobian-foundations/>.

1. Corrected the description of the computational checks in the abstract and introduction. The archived text says each identity is verified in two separately written backends (SymPy and FLINT). As §5 states, the cross-comparison covers only the central degree-difference identity. The checks are: Corollary 4.1 in FLINT through r + s ≤ 8, with spot checks to (5, 6), and independently in SymPy, with coefficient-identical agreement, through r + s ≤ 5; the bordered/minor identity in FLINT only, through r + s ≤ 7.

   This corrects how the checks are described; the identities and the checks themselves are unchanged. No theorem, certificate, computation or stated result is affected.

2. Corrected an internal inconsistency in Remark 4.7. The archived text lists “the torsor structure” among the results that use identity (1), but the statement-by-statement table in the same remark records Proposition 2.4 (the torsor structure) as independent of it, proved via Kummer covers. The words “the torsor structure,” should be deleted.

   The table is correct. No theorem, certificate, computation or stated result is affected.
