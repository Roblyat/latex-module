# latexmkrc

# Put ALL generated files in build/
$out_dir = 'build';
$aux_dir = 'build';

# Ensure pdf and synctex are also written into out_dir
$pdf_mode = 1;
$synctex = 1;

$interaction = 'nonstopmode';
$file_line_error = 1;

# biblatex/biber
$bibtex_use = 2;

# IMPORTANT: tell latexmk to pass -output-directory to latex/pdflatex
# (latexmk sometimes uses different vars depending on engine)
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=build %O %S';
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=build %O %S';
$xelatex  = 'xelatex  -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=build %O %S';

# # Set output directory
# $out_dir = 'build';

# # Tell latexmk to use biber for bibliography
# add_cus_dep('bcf', 'bbl', 0, 'run_biber');

# sub run_biber {
#     system("biber build/APE");
# }

# # Optional: ensure latexmk knows to use pdflatex
# $pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 -shell-escape';