#!/bin/bash
# Simple script to clean up old asdf versions
# nodejs: keep 24.4.0 and 22.8.0
# other tools: keep only current version

set -e

# Check for dry-run mode
DRY_RUN=false
if [ "$1" = "--dry-run" ] || [ "$1" = "-n" ]; then
    DRY_RUN=true
    echo "=== DRY RUN MODE ==="
    echo "No versions will be actually removed"
    echo ""
fi

echo "Starting asdf cleanup..."
echo ""

# Show disk usage before
echo "Disk usage before cleanup:"
du -sh ~/.asdf/installs/* | sort -hr
echo ""

# nodejs - keep 24.4.0 and 22.8.0
echo "=== nodejs ==="
echo "Keeping: 24.4.0, 22.8.0"
all_nodejs=$(asdf list nodejs | sed 's/^[[:space:]*]*//')
to_remove_nodejs=$(echo "$all_nodejs" | grep -v -E "^(24\.4\.0|22\.8\.0)$")

if [ -n "$to_remove_nodejs" ]; then
    remove_count=$(echo "$to_remove_nodejs" | wc -l)
    echo "Will remove $remove_count versions:"
    echo "$to_remove_nodejs" | sed 's/^/  - /'
    
    if [ "$DRY_RUN" = false ]; then
        echo "$to_remove_nodejs" | while read -r version; do
            if [ -n "$version" ]; then
                echo "Removing nodejs $version..."
                asdf uninstall nodejs "$version" || echo "Failed to remove $version"
            fi
        done
    fi
else
    echo "No versions to remove"
fi
echo ""

# Function for other tools
cleanup_simple() {
    local tool=$1
    local keep_version=$2
    
    echo "=== $tool ==="
    echo "Keeping: $keep_version"
    
    all_versions=$(asdf list "$tool" 2>/dev/null | sed 's/^[[:space:]*]*//' || echo "")
    to_remove=$(echo "$all_versions" | grep -v "^${keep_version}$" || echo "")
    
    if [ -n "$to_remove" ]; then
        remove_count=$(echo "$to_remove" | wc -l)
        echo "Will remove $remove_count versions:"
        echo "$to_remove" | sed 's/^/  - /'
        
        if [ "$DRY_RUN" = false ]; then
            echo "$to_remove" | while read -r version; do
                if [ -n "$version" ]; then
                    echo "Removing $tool $version..."
                    asdf uninstall "$tool" "$version" || echo "Failed to remove $version"
                fi
            done
        fi
    else
        echo "No versions to remove"
    fi
    echo ""
}

# Clean up other tools
cleanup_simple "golang" "1.24.5"
cleanup_simple "deno" "2.4.1"
cleanup_simple "gohugo" "0.148.1"
cleanup_simple "zig" "0.14.1"
cleanup_simple "nim" "2.2.4"
cleanup_simple "terraform" "1.12.2"
cleanup_simple "kubectl" "1.31.0"
cleanup_simple "fzf" "0.64.0"
cleanup_simple "neovim" "nightly"

# Show disk usage after
if [ "$DRY_RUN" = false ]; then
    echo "Disk usage after cleanup:"
    du -sh ~/.asdf/installs/* | sort -hr
    echo ""
fi

if [ "$DRY_RUN" = true ]; then
    echo "Dry run complete! No versions were removed."
    echo "Run without --dry-run to actually remove versions."
else
    echo "Cleanup complete!"
fi