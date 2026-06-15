#!/usr/bin/env bash
# Recompute the SHA256 pins in the Makefile so they match the currently pinned
# *_VERSION values.
#
# Renovate's regex managers bump only the version line (e.g. UV_VERSION); they
# cannot recompute the paired checksum, so *_SHA256 goes stale on every bump.
# This script re-derives each checksum from the upstream release and rewrites
# the Makefile in place. Invoked by .github/workflows/sync-pinned-sha256.yml,
# but also runnable locally:  bash .github/scripts/sync-pinned-sha256.sh
set -euo pipefail

makefile="${1:-Makefile}"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# Read a "FOO := bar" style variable from the Makefile.
get_var() {
	sed -n -E "s/^$1[[:space:]]*:=[[:space:]]*(.*[^[:space:]])[[:space:]]*\$/\1/p" "$makefile" | head -n1
}

# Replace the value of "FOO := ..." in place (value is a hex digest, sed-safe).
set_var() {
	sed -i -E "s|^($1[[:space:]]*:=[[:space:]]*).*|\1$2|" "$makefile"
}

dl() { curl -fsSL --retry 3 -o "$1" "$2"; }

changed=0
report() { # label old new
	if [ "$2" != "$3" ]; then
		echo "  $1: $2 -> $3"
		changed=1
	else
		echo "  $1: up to date"
	fi
}

echo "Syncing SHA256 pins in $makefile"

# --- uv: official .sha256 alongside the asset ---
uv_ver="$(get_var UV_VERSION)"
dl "$work/uv.sha256" "https://github.com/astral-sh/uv/releases/download/${uv_ver}/uv-x86_64-unknown-linux-gnu.tar.gz.sha256"
uv_new="$(awk '{print $1; exit}' "$work/uv.sha256")"
report "UV_SHA256 (uv ${uv_ver})" "$(get_var UV_SHA256)" "$uv_new"
set_var UV_SHA256 "$uv_new"

# --- rustup: official .sha256 (format: "<sha>  *./rustup-init") ---
rustup_ver="$(get_var RUSTUP_VERSION)"
dl "$work/rustup.sha256" "https://static.rust-lang.org/rustup/archive/${rustup_ver}/x86_64-unknown-linux-gnu/rustup-init.sha256"
rustup_new="$(awk '{print $1; exit}' "$work/rustup.sha256")"
report "RUSTUP_INIT_SHA256 (rustup ${rustup_ver})" "$(get_var RUSTUP_INIT_SHA256)" "$rustup_new"
set_var RUSTUP_INIT_SHA256 "$rustup_new"

# --- asdf: no upstream .sha256 (only .md5), so compute from the tarball ---
asdf_ver="$(get_var ASDF_VERSION)"
dl "$work/asdf.tar.gz" "https://github.com/asdf-vm/asdf/releases/download/${asdf_ver}/asdf-${asdf_ver}-linux-amd64.tar.gz"
asdf_new="$(sha256sum "$work/asdf.tar.gz" | awk '{print $1}')"
report "ASDF_SHA256 (asdf ${asdf_ver})" "$(get_var ASDF_SHA256)" "$asdf_new"
set_var ASDF_SHA256 "$asdf_new"

echo "changed=${changed}"
