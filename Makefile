#
# main.tex -> build/main.pdf, via latexmk (settings live in .latexmkrc)
#

MAIN = main

.PHONY: all watch sample clean distclean

all:
	latexmk -pdf $(MAIN)

# Rebuild on every save.
watch:
	latexmk -pdf -pvc $(MAIN)

# Build the reference sample from sample/. latexmk only auto-reads .latexmkrc
# from its cwd, so point it at the root one explicitly.
sample:
	cd sample && latexmk -r ../.latexmkrc -pdf sigconf

# Remove auxiliary files, keep the PDFs.
clean:
	latexmk -c $(MAIN)
	cd sample && latexmk -r ../.latexmkrc -c sigconf

# Remove everything generated, PDFs included.
distclean:
	latexmk -C $(MAIN)
	cd sample && latexmk -r ../.latexmkrc -C sigconf
