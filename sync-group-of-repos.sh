#!/bin/bash

# Set the base URL
base_url="https://www.github.com/paurushrai/"

# Terminal colors and formatting
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD='\033[1m'
LINE="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Function to get the default branch of a repository
get_default_branch() {
  git remote show origin | grep 'HEAD branch' | awk '{print $NF}'
}

# Function to sync the repository with its head branch
sync_repository() {
  local dir_path=$1

  if [[ -d "$dir_path" ]]; then
    cd "$dir_path" || return
    local default_branch
    default_branch=$(get_default_branch)

    echo -e "\n${BOLD}${GREEN}🔄 Starting sync: ${BLUE}$dir_path${NC}"
    echo -e "${YELLOW}$LINE${NC}"
    echo -e "${BLUE}📦 Repository: $dir_path${NC}"
    echo -e "${BLUE}🌿 Default Branch: $default_branch${NC}\n"

    git stash --include-untracked
    git clean -fdx
    git reset --hard HEAD
    git fetch --all
    git checkout -f "$default_branch"
    git pull origin "$default_branch"

    cd ../../

    echo -e "\n${GREEN}✅ Sync completed for: $dir_path${NC}"
    echo -e "${YELLOW}$LINE${NC}\n"
  else
    echo -e "\n${BOLD}${RED}❌ Error: Directory '$dir_path' does not exist. Skipping sync.${NC}\n"
  fi
}

# Function to process repositories
process_repositories() {
  local dir_path=$1
  shift
  local repo_list=("$@")

  for repo in "${repo_list[@]}"; do
    local full_dir_path="$dir_path/$repo"
    sync_repository "$full_dir_path"
  done
}

# Clear terminal before starting
clear

echo -e "${BOLD}${GREEN}🚀 Starting Repository Sync Process${NC}\n"

# Define repositories to sync as an array for clarity and ease of management
apps=("repo-name-1" "repo-name-2" "repo-name-3" "repo-name-4" "repo-name-5" "repo-name-6")

# Sync the paurushrai/apps repositories
process_repositories "apps" "${apps[@]}"

echo -e "${BOLD}${GREEN}🎉 All repository syncs completed!${NC}\n"
