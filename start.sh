#!/bin/bash

markdownpp slides.mdpp -o slides.md && reveal-md slides.md --theme theme/mytheme.css || echo "Something went wrong" && exit 1
