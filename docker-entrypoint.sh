#!/bin/sh

hugo server \
    --baseURL http://$(hostname -i) \
    --bind $(hostname -i) \
    --port 80 \
    --watch \
    --debug \
    --verbose
