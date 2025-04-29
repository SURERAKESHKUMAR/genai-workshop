#!/bin/bash

# Make all scripts in the scripts directory executable

# Change to the scripts directory
cd "$(dirname "$0")"

# Make all .sh files executable
echo "Making all .sh files executable..."
chmod +x *.sh

echo "Done!"