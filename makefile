DOC ?= APE
TEXDIR = .

all: build/$(DOC).pdf

build/$(DOC).pdf: $(TEXDIR)/$(DOC).tex
	latexmk -pdf -shell-escape -outdir=build $(TEXDIR)/$(DOC)

clean:
	latexmk -C -outdir=build $(TEXDIR)/$(DOC)
	rm -rf build/_minted-$(DOC)
