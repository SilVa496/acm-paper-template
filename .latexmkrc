# Put lib/ (the bundled acmart.cls / ACM-Reference-Format.bst) ahead of the
# system TeX tree, so the bundled version wins over whatever TeX Live ships.
# Relative paths resolve against the directory latexmk is invoked from, so
# both the project root and sample/ are covered.
$ENV{TEXINPUTS} = './lib//:../lib//:' . ($ENV{TEXINPUTS} // '');
$ENV{BSTINPUTS} = './lib//:../lib//:' . ($ENV{BSTINPUTS} // '');

$pdf_mode   = 1;       # pdflatex
$bibtex_use = 2;       # run bibtex, and remove .bbl on `latexmk -C`
$out_dir    = 'build';
$clean_ext  = 'run.xml bcf synctex.gz';
