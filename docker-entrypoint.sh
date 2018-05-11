#!/bin/sh

hugo server \
    --baseURL http://codeep.blue \
    --cacheDir /tmp/hugo_cache \
    --bind $(hostname -i) \
    --port 80 \
    --disableFastRender \
    --enableGitInfo \
    --gc \
    --verbose
