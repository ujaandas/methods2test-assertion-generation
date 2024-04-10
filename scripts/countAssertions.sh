#!/bin/bash

# Get parent dir (root of proj, where /dataset and /corpus are)
dir=$(dirname $(dirname $(readlink -f "$0")))

# Check that dir is ok
if [[ ! -d "$dir" ]]; then
    echo "Directory $dir does not exist."
    exit 1
fi

echo "Working in directory $dir"

# Read from corpus
myFiles=()
for subdir in "$dir"/corpus/raw/*; do
  if [ -d "$subdir" ]; then
    echo "Working in subdirectory $subdir"
    for files in "$(find "$subdir" -type f -name "output.tests.txt")"; do
      echo "Processing files $files"
      myFiles+=("$files")
    done
  fi
done

# Find assertions in files
for file in ${myFiles[@]}; do
  thisFileName=$(echo "$file" | grep -Po "raw\/(.*?)\/output")
  thisFileName="${thisFileName//\//-}"
  echo "Processing $thisFileName"
  awk 'BEGIN{print "Line", "\tassert", "\tassertEquals", "\tassertTrue", "\tassertFalse"} {a=gsub(/assert\(/,""); b=gsub(/assertEquals\(/,""); t=gsub(/assertTrue\(/,""); f=gsub(/assertFalse\(/,""); print NR, "\t"a, "\t"b, "\t"t, "\t"f}' $file > output/"$thisFileName".txt
done
