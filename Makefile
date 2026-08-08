PY ?= python3
TEX = bordered_jacobian_foundations

.PHONY: pdf verify deep receipt check clean

pdf:
	latexmk -pdf -interaction=nonstopmode $(TEX).tex

verify:
	$(PY) verify_bordered_jacobian.py

deep:
	$(PY) verify_bordered_jacobian.py --deep

receipt:
	$(PY) verify_bordered_jacobian.py --deep > verification_receipt_deep.txt 2>&1
	$(PY) verify_bordered_jacobian.py > verification_receipt_default.txt 2>&1
	find . -type f ! -path './.git/*' ! -name SHA256SUMS \
	  ! -name '*.aux' ! -name '*.log' ! -name '*.out' ! -name '*.fls' \
	  ! -name '*.fdb_latexmk' ! -name '*.synctex.gz' ! -name '.DS_Store' \
	  -print | LC_ALL=C sort | xargs shasum -a 256 > SHA256SUMS

check: SHA256SUMS
	shasum -a 256 -c SHA256SUMS

clean:
	latexmk -C $(TEX).tex
