# Set output directory
$out_dir = 'build';

# Tell latexmk to use biber for bibliography
add_cus_dep('bcf', 'bbl', 0, 'run_biber');

sub run_biber {
    system("biber build/APE");
}

# Optional: ensure latexmk knows to use pdflatex
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 -shell-escape';