# Makefile for the Latex-Classes for the corporate design of TU Darmstadt.
# Copyright (C) 2014 Benjamin Brockhaus
# You can modify and/or redistribute this under the terms of GPL v2 or later

#List of documentation-files
DOC = texmf/doc/latex/tuddesign/TUD_doc.pdf

#List of example-files
EXAMPLES = texmf/doc/latex/tuddesign/examples/tudposter/TUDposter.pdf\
	texmf/doc/latex/tuddesign/examples/tudreport/TUDarticle.pdf\
	texmf/doc/latex/tuddesign/examples/tudreport/TUDreport.pdf\
	texmf/doc/latex/tuddesign/examples/tudletter/TUDletter.pdf\
	texmf/doc/latex/tuddesign/examples/tudexercise/TUDexercise.pdf\
	texmf/doc/latex/tuddesign/examples/tudbeamer/TUDbeamer.pdf

#Keep GNU make from automatically deleting files with these endings:
.PRECIOUS: %.ps %.dvi

all:	doc

#build all documentation
doc:	$(DOC) $(EXAMPLES)

#Clean up all the intermediate files
clean:	$(DOC:.pdf=.clean) $(EXAMPLES:.pdf=.clean)

#Remove the output files too
clean-all:	clean $(DOC:.pdf=.realclean) $(EXAMPLES:.pdf=.realclean)


# --------------------------------------------------------------------------------

.PHONY: doc clean clean-all %.clean %.realclean

%.clean:
	cd $(dir $@); rm -f $(basename $(notdir $@)).aux \
	$(basename $(notdir $@)).log \
	$(basename $(notdir $@)).toc \
	$(basename $(notdir $@)).out \
	$(basename $(notdir $@)).lof \
	$(basename $(notdir $@)).len \
	$(basename $(notdir $@)).nav \
	$(basename $(notdir $@)).snm
%.realclean:
	cd $(dir $@); \
	rm -f $(basename $(notdir $@)).dvi \
	$(basename $(notdir $@)).ps \
	$(basename $(notdir $@)).pdf
%.pdf:	%.ps
	cd $(dir $@); \
	ps2pdf $(notdir $<);
%.ps:	%.dvi
	cd $(dir $@); \
	dvips $(notdir $<);
%.dvi:
	cd $(dir $@); \
	latex $(basename $(notdir $@)).tex; \
	latex $(basename $(notdir $@)).tex;
