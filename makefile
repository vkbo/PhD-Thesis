MPhD.pdf: PhD.tex
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make PhD.tex
	latexmk -c

clean:
	latexmk -CA
