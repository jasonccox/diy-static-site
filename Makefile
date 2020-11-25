SRC_DIR = src
DST_DIR = build

PAGE_DIR = $(SRC_DIR)/pages
# use find to include files inside arbitrarily deep dirs
PAGE_SRC_FILES = $(shell find $(PAGE_DIR)/ -name '*.md')
PAGE_DST_FILES = $(patsubst $(PAGE_DIR)/%.md,$(DST_DIR)/%.html,$(PAGE_SRC_FILES))

STATIC_DIR = $(SRC_DIR)/static
# use find to include files inside arbitrarily deep dirs
STATIC_SRC_FILES = $(shell find $(STATIC_DIR) -type f)
STATIC_DST_FILES = $(patsubst $(STATIC_DIR)/%,$(DST_DIR)/%,$(STATIC_SRC_FILES))

CSS_FILES = $(patsubst $(STATIC_DIR)/%,%,$(filter %.css,$(STATIC_SRC_FILES)))
CSS_ARGS = $(patsubst %,--css=/%,$(CSS_FILES))

PARTIAL_DIR = $(SRC_DIR)/partial
HEADER = $(PARTIAL_DIR)/header.html
FOOTER = $(PARTIAL_DIR)/footer.html

PANDOC_VERSION = 2.11.2
PANDOC_URL = "https://github.com/jgm/pandoc/releases/download/$(PANDOC_VERSION)/pandoc-$(PANDOC_VERSION)-linux-amd64.tar.gz"

.PHONY: all
all: pages static

.PHONY: pages
pages: $(PAGE_DST_FILES)

$(PAGE_DST_FILES): $(DST_DIR)/%.html: $(PAGE_DIR)/%.md $(HEADER) $(FOOTER) pandoc
	mkdir -p $(dir $@)
	./pandoc \
		--from=markdown-implicit_figures \
		--to=html5 \
		--include-before-body=$(HEADER) \
		--include-after-body=$(FOOTER) \
		$(CSS_ARGS) \
		--standalone \
		--title-prefix 'Jason Cox' \
		--output=$@ $<

.PHONY: static
static: $(STATIC_DST_FILES)

$(STATIC_DST_FILES): $(DST_DIR)/%: $(STATIC_DIR)/%
	mkdir -p $(dir $@)
	cp $< $@

pandoc:
	curl -L -o pandoc.tar.gz "$(PANDOC_URL)"
	tar -xzf pandoc.tar.gz
	mv pandoc-$(PANDOC_VERSION)/bin/pandoc ./
	rm -rf pandoc-$(PANDOC_VERSION) pandoc.tar.gz

.PHONY: clean
clean:
	rm -rf $(DST_DIR)

.PHONY: clean-all
clean-all: clean
	rm -rf pandoc*

.PHONY: preview
preview: all
	cd $(DST_DIR); \
	busybox httpd -f -p 8000
