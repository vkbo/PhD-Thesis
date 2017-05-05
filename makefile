##
# PhD Thesis main Makefile
##

# Dependencies
APPENDS  = apxPIC.tex apxAnalysis.tex
CHAPTERS = chIntroduction.tex chWakefield.tex chSimulations.tex chDataAcquisition.tex chSummary.tex
DEPENDS  = $(addprefix chapters/,$(CHAPTERS)) $(addprefix appendices/,$(APPENDS))

# EPS figures
FIGURES := $(wildcard figures/*.eps)
FIGURES := $(patsubst %.eps,%.pdf,$(FIGURES))

all: PhD.pdf

PhD.pdf: PhD.tex $(DEPENDS) $(FIGURES)
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make PhD.tex
	latexmk -c

%.pdf : %.eps
	epstopdf $<

clean:
	latexmk -CA
	rm PhD.bbl
	rm PhD.run.xml
