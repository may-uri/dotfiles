#!/bin/bash

mime_type=$(file --mime-type "$1" -bL)

case $mime_type in
  text/*|application/json) bat --color=always "$1" ;;
  *) echo "Previewer not configured for $1" ;;
esac

