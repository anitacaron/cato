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
