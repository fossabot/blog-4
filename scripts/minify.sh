#!/bin/bash

./node_modules/.bin/html-minifier \
    --collapse-boolean-attributes \
    --collapse-inline-tag-whitespace \
    --collapse-whitespace \
    --minify-css \
    --minify-js \
    --minify-ur-ls \
    --quote-character \" \
    --remove-attribute-quotes \
    --remove-redundant-attributes \
    --remove-script-type-attributes \
    --remove-style-link-type-attributes \
    --remove-tag-whitespace \
    --sort-attributes \
    --sort-class-name \
    --use-short-doctype \
    --input-dir ./public \
    --output-dir ./public \
    --file-ext html
