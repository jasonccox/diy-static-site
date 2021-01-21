# Static Site

This repo contains my static site's content as well as the `Makefile` needed to build it.

## How It Works

The process of building the static site is encapsulated in the `Makefile`. It uses `pandoc` to convert Markdown files to HTML and simply copies files that are already in a suitable format, such as images or CSS.

> In order to maintain a consistent version of `pandoc` and to be able to build in places where `pandoc` isn't available (such as Digital Ocean's App Platform), running `make` downloads a static `pandoc` binary (Linux amd64) for its use.

The following commands are particularly useful:

- `make` - Builds the entire site.
- `make clean` - Removes the built files (but not the `pandoc` binary).
- `make preview` - Builds the entire site and launches a basic web server with `busybox httpd`. The site can then be previewed at `http://localhost:8000`.
- `make watch` - Watches for changes in the `src/` directory using `inotifywait` and automatically runs `make`.

## Organization

The `src` directory contains all of the source files needed for the site, organized in subdirectories as follows:

- `src/pages/` - Markdown files that will be converted to HTML. These can be nested arbitrarily deep within subdirectories, and they will be available at the same path (without the `src/pages/` prefix, of course) within the build directory.
- `src/partial/` - HTML snippets that will be injected into the HTML pages generated from Markdown. For example, the site header and footer are in this directory.
- `src/static/` - Any files that can be copied as-is to the build directory -- images, CSS, fonts, etc. These can be nested arbitrarily deep within subdirectories, and they will be available at the same path (without the `src/static/` prefix, of course) within the build directory.
