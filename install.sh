#!/bin/bash

set -e

if [ ! -d Build ]; then
    echo "ERROR: \`Build\` folder not found. Please run \`build.sh\` first." >&2
    exit 1
fi

# Change if you have your .minetest folder at a different location
OHIO_FOLDER=~/.minetest/games/ohiocraft

echo "Deleting \`$OHIO_FOLDER\` if it exists..."
rm -rf $OHIO_FOLDER

echo "Creating \`$OHIO_FOLDER\`..."
mkdir -p $OHIO_FOLDER

echo "Setting up game files..."
cp -r ./Build/* $OHIO_FOLDER

echo "Installed successfully!"
