#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UUID="touchpad-gestures@alpha.com"
OUT_DIR="${ROOT_DIR}/dist"

if ! command -v gnome-extensions >/dev/null 2>&1; then
    echo "gnome-extensions CLI is required for packaging." >&2
    exit 1
fi

mkdir -p "${OUT_DIR}"

gnome-extensions pack "${ROOT_DIR}" \
    --force \
    --out-dir "${OUT_DIR}" \
    --extra-source "prefs.js" \
    --extra-source "schemas/org.gnome.shell.extensions.touchpad-gestures.gschema.xml"

echo "Packaged extension: ${OUT_DIR}/${UUID}.shell-extension.zip"
