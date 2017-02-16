
APPEND   = apxPIC.tex
CHAPTERS = chIntroduction.tex chWakefield.tex chSimulations.tex chSummary.tex
DEPENDS  = $(addprefix chapters/,$(CHAPTERS)) $(addprefix appendices/,$(APPEND))

all: PhD.pdf

PhD.pdf: PhD.tex $(DEPENDS)
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make PhD.tex
	latexmk -c

clean:
	latexmk -CA
