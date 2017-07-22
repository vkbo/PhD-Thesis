##
# PhD Thesis main Makefile
##

# Dependencies
APPENDS  := $(wildcard appendices/*.tex)
CHAPTERS := $(wildcard chapters/*.tex)
INCLUDES := $(wildcard includes/*.tex)
DEPENDS   = $(APPENDS) $(CHAPTERS) $(INCLUDES)

# Files and Figures
FILES   := $(wildcard files/*.pdf)
FIGEPS  := $(wildcard figures/*.eps)
FIGSVG  := $(wildcard figures/*.svg)
FIGEPS  := $(patsubst %.eps,%.pdf,$(FIGEPS))
FIGSVG  := $(patsubst %.svg,%.pdf,$(FIGSVG))

all: PhD.pdf

PhD.pdf: PhD.tex $(DEPENDS) $(FIGEPS) $(FIGSVG) $(FILES)
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make PhD.tex
	latexmk -c

%.pdf : %.eps
	epstopdf $<

%.pdf : %.svg
	inkscape -f $< -A $@

clean:
	latexmk -CA
	rm PhD.bbl
	rm PhD.run.xml
