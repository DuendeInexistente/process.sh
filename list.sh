#!/bin/bash
find downloads -iname "*.txt" -type f -exec echo  \; -exec echo {} \; -exec cat {} \; -exec echo  \;