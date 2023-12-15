## Customize Makefile settings for cato
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

$(TEMPLATEDIR)/example.csv: $(TEMPLATEDIR)/example.tsv
	cat $< | sed 1d > $<.tmp.tsv
	(echo "ID\tsubset\tlabel\nID\tAI oboInOwl:inSubset\tLABEL"; cat $<.tmp.tsv) | tr '\t' ',' > $@
	rm -f $<.tmp.tsv
	
_nanobot:
	chmod +x $@

NANOBOT := ./nanobot

### Databases

.PHONY: clean
clean:
	rm -rf .nanobot.db

.nanobot.db: $(NANOBOT)
	$(NANOBOT) init

.PHONY: init
init: .nanobot.db

.PHONY: serve
serve: .nanobot.db
	$(NANOBOT) serve