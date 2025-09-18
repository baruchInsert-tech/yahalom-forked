#!/bin/bash

# This script is a shell-based custom updater for release-please.
# It reads/writes the bundleVersion in a Unity ProjectSettings.asset file.
#
# Usage (read): ./update_unity_version.sh <path_to_file>
#   - Prints the current bundleVersion to stdout.
#
# Usage (write): ./update_unity_version.sh <path_to_file> <new_version>
#   - Updates the bundleVersion in the file.

set -e # Exit immediately if a command exits with a non-zero status.

FILE_PATH="$1"
NEW_VERSION="$2"

if [ -z "$FILE_PATH" ]; then
  echo "Error: Missing file path argument."
  exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
  echo "Error: File not found at $FILE_PATH"
  exit 1
fi

# --- Main Logic ---

if [ -n "$NEW_VERSION" ]; then
  # --- WRITE MODE ---
  # Use sed to find the line with "bundleVersion:" and replace everything
  # after it with the new version. The '-i' flag edits the file in-place.
  # The regex captures the "bundleVersion: " part and re-inserts it.
  sed -i "s/\(bundleVersion:\s*\).*/\1$NEW_VERSION/" "$FILE_PATH"
  echo "Successfully updated bundleVersion in $FILE_PATH to $NEW_VERSION"
else
  # --- READ MODE ---
  # Use grep to find the line, then sed to extract just the version string.
  grep "bundleVersion:" "$FILE_PATH" | sed 's/.*bundleVersion:\s*//'
fi