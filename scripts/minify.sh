#!/bin/bash

# compress PNG images
find ./public/ -type f -iname "*.png" -exec convert {} -strip {} \;

# compress JPG images
find ./public/ -type f -iname "*.jpg" -exec convert {} -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace sRGB {} \;

# minify HTML+CSS+JS
./node_modules/.bin/html-minifier \
    --collapse-boolean-attributes \
    --collapse-inline-tag-whitespace \
    --collapse-whitespace \
    --minify-css \
    --minify-js \
    --minify-ur-ls \
    --quote-character \" \
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
