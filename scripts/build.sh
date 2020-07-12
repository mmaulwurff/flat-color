#!/bin/bash

set -e

#filename=flat-color-$(git describe --abbrev=0 --tags).pk3
filename=flat-color.pk3

rm  -f $filename
zip -R $filename "*.md" "*.txt" "*.zs" "*.pal"
gzdoom $filename "$@"
