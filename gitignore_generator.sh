#!/bin/bash

# List of paths not to be ignored
FILE_EXCEPTIONS=(
  ".gitignore"
  ".zshrc"
  "README.md"
  "LICENSE"
  "$(basename "$0")" # current script
)

DIR_EXCEPTIONS=(
#  ".config"
  "scripts"
)

CONFIG_EXCEPTIONS=(
  "i3"
  "picom"
  "dunst"
  "kitty"
  "nvim"
  "flameshot"
  "gtk-3.0"
)

# Build the .gitignore content
GITIGNORE_CONTENT="*\n"  # ignore everything by default

for path in "${FILE_EXCEPTIONS[@]}"; do
  GITIGNORE_CONTENT+="!$path\n"
done

GITIGNORE_CONTENT+="\n"

for path in "${DIR_EXCEPTIONS[@]}"; do
  GITIGNORE_CONTENT+="!$path/\n"
  GITIGNORE_CONTENT+="!$path/**\n\n"
done

GITIGNORE_CONTENT+="\n"

for path in "${CONFIG_EXCEPTIONS[@]}"; do
  GITIGNORE_CONTENT+="!.config/$path/\n"
  GITIGNORE_CONTENT+="!.config/$path/**\n\n"
done

# Display generated content
echo -e "The following .gitignore will be created:\n"
echo -e "$GITIGNORE_CONTENT"

# Ask for confirmation
read -p "Do you want to overwrite .gitignore with this content? (y/n) " CONFIRM
if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
  echo -e "$GITIGNORE_CONTENT" > .gitignore
  echo ".gitignore updated successfully!"
else
  echo "Cancelled. No changes made."
fi

