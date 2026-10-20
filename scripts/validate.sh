#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[validate] checking required files"
for required in metadata.json extension.js prefs.js schemas/org.gnome.shell.extensions.touchpad-gestures.gschema.xml; do
    [[ -f "${ROOT_DIR}/${required}" ]] || {
        echo "[validate] missing required file: ${required}" >&2
        exit 1
    }
done

echo "[validate] checking metadata.json syntax"
python3 -m json.tool "${ROOT_DIR}/metadata.json" >/dev/null

echo "[validate] checking merge-conflict markers"
if grep -R --line-number -E '<<<<<<<|=======|>>>>>>>' "${ROOT_DIR}"/*.js "${ROOT_DIR}"/schemas/*.xml >/dev/null; then
    echo "[validate] found unresolved merge markers" >&2
    exit 1
fi

echo "[validate] validating GSettings schema"
glib-compile-schemas --strict --dry-run "${ROOT_DIR}/schemas"

echo "[validate] ok"
