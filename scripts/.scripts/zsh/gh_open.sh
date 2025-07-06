#!/bin/bash

# Check if GitHub repo exists
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "No repository found."
  dunstify -u critical "Repo Not Found" "gop or gh_open.sh works only in directories with a repository"
  exit 1
fi

# Get the remote URL
remote_url=$(git remote get-url origin)

# Convert any SSH into HTTPS
if [[ $remote_url == git@github.com:* ]]; then
  remote_url="https://github.com/${remote_url#git@github.com:}"
fi

# Remove trailing .git
remove_url=${remove_url%.git}

# Open in default browser
xdg-open "$remote_url" &>/dev/null
