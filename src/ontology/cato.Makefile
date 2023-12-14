## Customize Makefile settings for cato
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

ROBOT_TEMPLATE_URL="https://docs.google.com/spreadsheets/d/1hSoAZnqrticR-B7vb6qyjlB_OXul9ZXaOAxgA5VUPiw/export?format=csv&gid=0"

.PHONY: $(TEMPLATEDIR)/example.csv
$(TEMPLATEDIR)/example.csv:
	wget $(ROBOT_TEMPLATE_URL) -O $@

.PHONY: update_template
update_template: $(TEMPLATEDIR)/example.csv

### Nanobot
NANOBOT_URL := https://github.com/ontodev/nanobot.rs/releases/download/v2023-11-30/nanobot-x86_64-unknown-linux-musl

_nanobot:
	#rm -f ../../nanobot ../../nanobot-*
	#curl -L -o ../../nanobot $(NANOBOT_URL)
	chmod +x $@

NANOBOT := ./nanobot

### Databases

TABLES := $(shell cut -f 2 src/schema/table.tsv | tail -n+2)

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