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
FIGURES := $(wildcard figures/*.eps)
FIGURES := $(patsubst %.eps,%.pdf,$(FIGURES))

all: PhD.pdf

PhD.pdf: PhD.tex $(DEPENDS) $(FIGURES) $(FILES)
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make PhD.tex
	latexmk -c

%.pdf : %.eps
	epstopdf $<

clean:
	latexmk -CA
	rm PhD.bbl
	rm PhD.run.xml
