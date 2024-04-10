#!/bin/bash

# Get parent dir (root of proj, where /dataset and /corpus are)
dir=$(dirname $(dirname $(readlink -f "$0")))

# Check that dir is ok
if [[ ! -d "$dir" ]]; then
    echo "Directory $dir does not exist."
    exit 1
fi

echo "Working in directory $dir"

# Find and extract
find "$dir" -type f -name "*.tar.bz2" -execdir tar -xvf {} \;

# On completion
echo "Extraction complete"