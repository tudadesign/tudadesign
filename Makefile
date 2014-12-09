#!/usr/bin/make -f
# Makefile for the Latex-Classes for the corporate design of TU Darmstadt.
# Copyright (C) 2014 Benjamin Brockhaus
# You can modify and/or redistribute this under the terms of GPL v2 or later


#Where to install the files:
DEST = $(DESTDIR)/usr/local/share

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

install:
	#create target directories and if necessary parent-directories
	mkdir -p $(DEST)/texmf/doc/latex/tuddesign
	mkdir -p $(DEST)/texmf/tex/latex/tuddesign
	#copy files to target destination
	cp -rf texmf/doc/latex/tuddesign/*** $(DEST)/texmf/doc/latex/tuddesign
	cp -rf texmf/tex/latex/tuddesign/*** $(DEST)/texmf/tex/latex/tuddesign
	#set permissions of copied files and folders
	find $(DEST)/texmf/doc/latex/tuddesign/ -type d -exec chmod 755 {} +
	find $(DEST)/texmf/doc/latex/tuddesign/ -type f -exec chmod 644 {} +
	find $(DEST)/texmf/tex/latex/tuddesign/ -type d -exec chmod 755 {} +
	find $(DEST)/texmf/tex/latex/tuddesign/ -type f -exec chmod 644 {} +
	#link documentation
	mkdir -p $(DEST)/doc/tuddesign
	ln -s $(DEST)/texmf/doc/latex/tuddesign $(DEST)/doc/tuddesign/doc
uninstall:
	rm -rf $(DEST)/texmf/doc/latex/tuddesign
	rm -rf $(DEST)/texmf/tex/latex/tuddesign
	rm -rf $(DEST)/doc/tuddesign

# --------------------------------------------------------------------------------

.PHONY: doc clean clean-all %.clean %.realclean install uninstall

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
	TEXINPUTS=":$(CURDIR)/texmf/tex/latex/tuddesign//:" latex $(basename $(notdir $@)).tex; \
	TEXINPUTS=":$(CURDIR)/texmf/tex/latex/tuddesign//:" latex $(basename $(notdir $@)).tex;
