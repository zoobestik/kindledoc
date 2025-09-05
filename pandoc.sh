#!/usr/bin/env bash
set -euo pipefail

# Usage: ./build-epub.sh /path/to/input.md
# Produces: /path/to/input.epub
# Title = filename without extension (underscores -> spaces)
# Author = "Gemini"
# Looks for kindle.css next to the input file first, then next to this script.

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /path/to/input.md" >&2
  exit 2
fi

input_arg="$1"

input_dir_rel="$(dirname -- "$input_arg")"
input_base="$(basename -- "$input_arg")"
cd -- "$input_dir_rel"
input="$(pwd -P)/$input_base"

# Basic checks
if [ ! -f "$input" ]; then
  echo "Error: file not found: $input" >&2
  exit 3
fi

#if ! command -v pandoc >/dev/null 2>&1; then
#  echo "Error: pandoc not found in PATH. Install pandoc and try again." >&2
#  exit 4
#fi

base="$(basename -- "$input")"
raw_title="${base%.*}"

# Sanitize title: convert underscores to spaces (optional)
title="${raw_title//_/ }"
ext="pdf"

type="kindle"
script_dir="/Users/chernenko/code/pandoc"
output="output/$raw_title.$ext"

mkdir -p "$script_dir/input"
mkdir -p "$script_dir/output"

cp -f "$input_arg" "$script_dir/input/"

docker build --platform=linux/amd64 -t pandoc "$script_dir"

docker run --rm  --platform=linux/amd64 \
      --volume "$script_dir:/data" \
      --user "$(id -u):$(id -g)" \
      pandoc "/data/input/$base" -o "/data/$output" \
        --defaults=/data/config/$type.$ext.yaml \
        -V title="$title"

open "$script_dir/output"

echo "Created EPUB: $script_dir/$output"
