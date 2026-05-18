#!/bin/bash
# Clean up old asdf versions, keeping the versions listed in ~/.tool-versions.
# nodejs additionally keeps the versions listed in NODEJS_EXTRA_KEEP.

set -e

TOOL_VERSIONS_FILE="${HOME}/.tool-versions"

# Extra nodejs versions to keep, besides the one in ~/.tool-versions.
NODEJS_EXTRA_KEEP=("22.8.0")

# Check for dry-run mode
DRY_RUN=false
if [ "$1" = "--dry-run" ] || [ "$1" = "-n" ]; then
    DRY_RUN=true
    echo "=== DRY RUN MODE ==="
    echo "No versions will be actually removed"
    echo ""
fi

if [ ! -f "$TOOL_VERSIONS_FILE" ]; then
    echo "Error: $TOOL_VERSIONS_FILE not found" >&2
    exit 1
fi

echo "Starting asdf cleanup..."
echo "Reading versions from: $TOOL_VERSIONS_FILE"
echo ""

# Show disk usage before
echo "Disk usage before cleanup:"
du -sh ~/.asdf/installs/* | sort -hr
echo ""

cleanup_tool() {
    local tool=$1
    shift
    local keep_versions=("$@")

    echo "=== $tool ==="

    if [ ${#keep_versions[@]} -eq 0 ] || [ -z "${keep_versions[0]}" ]; then
        echo "No keep version specified — skipping"
        echo ""
        return
    fi

    echo "Keeping: ${keep_versions[*]}"

    local all_versions
    all_versions=$(asdf list "$tool" 2>/dev/null | sed 's/^[[:space:]*]*//' || echo "")

    if [ -z "$all_versions" ]; then
        echo "Not installed via asdf — skipping"
        echo ""
        return
    fi

    local to_remove=""
    while IFS= read -r version; do
        [ -z "$version" ] && continue
        local keep=false
        for kv in "${keep_versions[@]}"; do
            if [ "$version" = "$kv" ]; then
                keep=true
                break
            fi
        done
        if [ "$keep" = false ]; then
            to_remove+="${version}"$'\n'
        fi
    done <<< "$all_versions"

    to_remove=$(printf '%s' "$to_remove" | sed '/^$/d')

    if [ -n "$to_remove" ]; then
        local remove_count
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

# Iterate over entries in ~/.tool-versions
while IFS= read -r line || [ -n "$line" ]; do
    # Skip blank lines and comments
    [ -z "${line// /}" ] && continue
    [[ "$line" =~ ^[[:space:]]*# ]] && continue

    # shellcheck disable=SC2206
    fields=($line)
    tool="${fields[0]}"
    version="${fields[1]}"

    if [ "$tool" = "nodejs" ]; then
        cleanup_tool "$tool" "$version" "${NODEJS_EXTRA_KEEP[@]}"
    else
        cleanup_tool "$tool" "$version"
    fi
done < "$TOOL_VERSIONS_FILE"

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
