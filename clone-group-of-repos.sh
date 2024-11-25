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

# Function to create directories recursively
create_directory() {
    local dir_path=$1
    mkdir -p "$dir_path"
}

# Function to clone the repository
clone_repository() {
    local repo_url=$1
    local dir_path=$2
    git clone "$repo_url" "$dir_path"
}

# Function to process repositories
process_repositories() {
    local dir_path=$1
    local repo_list=$2

    for repo in $repo_list
    do
        # Construct the full URL for the repository
        repo_url="$base_url/$dir_path/$repo.git"

        # Create the directory structure
        repo_dir=$(echo "$repo")
        create_directory "$dir_path/$repo_dir"

        echo -e "\n${BOLD}${GREEN}🔄 Cloning repository: ${BLUE}$dir_path/$repo_dir${NC}"
        echo -e "${YELLOW}$LINE${NC}"
        clone_repository "$repo_url" "$dir_path/$repo_dir"
        echo -e "\n${GREEN}✅ Cloning completed for: $dir_path/$repo_dir${NC}"
        echo -e "${YELLOW}$LINE${NC}"
    done
}

# Clear terminal before starting
clear

echo -e "${BOLD}${GREEN}🚀 Starting Repository Cloning Process${NC}\n"

# Define repositories to sync as an array for clarity and ease of management
apps=("repo-name-1" "repo-name-2" "repo-name-3" "repo-name-4" "repo-name-5" "repo-name-6")

# Sync the paurushrai/apps repositories
process_repositories "apps" "${apps[@]}"

echo -e "\n${BOLD}${GREEN}🎉 All repository cloning completed!${NC}\n"
