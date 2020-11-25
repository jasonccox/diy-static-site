---
pagetitle: Home
---

![headshot of Jason Cox](/assets/headshot.png){#headshot .block-center}

# Welcome to my static site!

## *This is a demo of my homemade static site generator* {.text-center}

I built a static site generator with `pandoc` and a `Makefile`. I'm planning to host the whole thing for *free* using [Github](https://github.com) and [Digital Ocean](https://digitalocean.com)'s App Platform! For now, I just have a few basic pages to demonstrate what the site generator can do.

### Lists

Here's a unordered list:

- Item 1

- Item 2

- Item 3

And an ordered one:

1. Item A

2. Item B

3. Item C

### Code

I'd like to have `code snippets` look nice on here as well:

```
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
```

(That's an excerpt from the `Makefile`, by the way.)

<style>
    #headshot {
        width: 15rem;
    }
</style>
