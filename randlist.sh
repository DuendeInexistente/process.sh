#!/bin/bash
find downloads -iname "*.txt" -type f  -exec cat {} \; | sort | uniq | sort -R | grep -i "^http"
