# Makefile for RFC

XML2RFC :=xml2rfc
OUTDIR  := output
LOGDIR  := logs

SOURCES= \
	*.xml

all:: banner $(SOURCES)
	@echo "  * All Done."
	@echo
	 
clean:
	@rm -f "$(OUTDIR)"/* "$(LOGDIR)"/*

distclean: clean
	@rm -rf "$(OUTDIR)" "$(LOGDIR)"

$(SOURCES)::
	@echo ; \
	[ -d "$(OUTDIR)" ] || mkdir -p "$(OUTDIR)" ; \
	[ -d "$(LOGDIR)" ] || mkdir -p "$(LOGDIR)" ; \
	echo "  * Compiling: $@" ; \
	out=`echo $@ | sed "s|.xml|.txt|"` ; \
	out=`cat "$@" | grep docName | head -n 1 | sed "s|.*docName\=\"||" | sed "s|\".*||"`; \
	echo -n "    - [TXT] format ... " && \
	$(XML2RFC) $@ -u -o "$(OUTDIR)/$$out.txt" 2>$(LOGDIR)/err.txt >$(LOGDIR)/log.txt && \
	echo "Ok." || echo "ERROR (check the err file)."; \
	out=`echo $@ | sed "s|.xml|.html|"` ; \
	out=`cat "$@" | grep docName | head -n 1 | sed "s|.*docName\=\"||" | sed "s|\".*||"`; \
	echo -n "    - [HTML] format ... " && \
	$(XML2RFC) $@ --html -u -o "$(OUTDIR)/$$out.html" 2>>$(LOGDIR)/err.txt >>$(LOGDIR)/log.txt && \
	echo "Ok." || echo "ERROR (check the err file)."; \
	echo

banner::
	@echo
	@echo "IETF RFC and I-D Compiler Makefile"
	@echo "(c) 2018 by Massimiliano Pala and OpenCA Labs"
	@echo "All Rights Reserved"
	@echo
