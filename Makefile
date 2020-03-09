SRC= $(shell grep -l begin{msc} *.tex)  # note that spaces in filenames
MSC= $(SRC:.tex=.eps)                   # will cause trouble

mscs:  $(MSC)

%.eps: %.tex
	export TEXINPUTS=$${TEXINPUTS}":.:../../../software/mscpackage/currentversion:" && latex -jobname msc-file "\input{msc2pdf.tex}\begin{document}\input{$<}\end{document}"
	dvips -t a3 msc-file.dvi -o
	ps2eps -f msc-file.ps 
	epstopdf msc-file.eps
	mv msc-file.pdf `basename $< tex`pdf
	mv msc-file.eps `basename $< tex`eps


%.pdf: %.tex
	export TEXINPUTS=$${TEXINPUTS}":.:../../../software/mscpackage/currentversion:" && latex -jobname msc-file "\input{msc2pdf.tex}\begin{document}\input{$<}\end{document}"
	dvips -t a3 msc-file.dvi -o
	ps2eps -f msc-file.ps 
	epstopdf msc-file.eps
	mv msc-file.pdf `basename $< tex`pdf
	mv msc-file.eps `basename $< tex`eps


clean-all: 
	rm -f *~ *.log *.aux *.out *.dvi
	rm -f msc-file.*
	rm -f *.eps *.ps *.pdf

clean-nopdf:
	rm -f *~ *.log *.aux *.out *.dvi
	rm -f msc-file.*
	rm -f *.eps *.ps

