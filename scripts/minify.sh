#!/bin/bash

./node_modules/.bin/html-minifier \
    --collapse-boolean-attributes \
    --collapse-inline-tag-whitespace \
    --collapse-whitespace \
    --no-include-auto-generated-tags \
    --minify-css \
    --minify-js \
    --minify-ur-ls \
    --quote-character \' \
    --remove-attribute-quotes \
    --remove-comments \
    --remove-empty-elements \
    --remove-optional-tags \
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
