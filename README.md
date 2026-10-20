# Touchpad Gestures Win (GNOME Shell 51)

Touchpad Gestures Win is a GNOME Shell extension that lets you map **3-finger** and **4-finger** touchpad swipes/taps to desktop actions (overview, workspace switching, media, volume/brightness, custom keybinds, and more).

## Supported GNOME version

- **GNOME Shell 51** (target version for this branch/repository state)

Older GNOME versions are not declared in metadata for this version of the extension.

## Tech stack

- **GJS / JavaScript ES modules**
- **GNOME Shell extension APIs**
- **Mutter/Clutter/St shell runtime objects**
- **GSettings** (schema: `org.gnome.shell.extensions.touchpad-gestures`)
- **Libadwaita/GTK4** for preferences UI (`prefs.js`)

## Repository layout

```text
.
├── extension.js
├── prefs.js
├── metadata.json
├── schemas/
│   └── org.gnome.shell.extensions.touchpad-gestures.gschema.xml
└── scripts/
    ├── package.sh
    └── validate.sh
```

Required extension entry files stay at the repository root (`metadata.json`, `extension.js`).

## Installation (local/dev)

1. Copy or symlink this directory to:
   - `~/.local/share/gnome-shell/extensions/touchpad-gestures@alpha.com`
2. Compile schemas:
   - `glib-compile-schemas ~/.local/share/gnome-shell/extensions/touchpad-gestures@alpha.com/schemas`
3. Restart GNOME Shell session (or log out/in), then enable the extension.

## Development and validation commands

From repository root:

- Validate metadata/schema/basic structure:
  - `./scripts/validate.sh`
- Package extension zip (requires `gnome-extensions` CLI):
  - `./scripts/package.sh`

## Debugging

- Live shell logs:
  - `journalctl --user -f /usr/bin/gnome-shell`
- Looking Glass:
  - `Alt` + `F2`, then type `lg`
- Verify extension state:
  - `gnome-extensions info touchpad-gestures@alpha.com`

## Packaging

`scripts/package.sh` creates a zip artifact using `gnome-extensions pack` and includes:

- `metadata.json`
- `extension.js`
- `prefs.js`
- `schemas/` (schema XML and compiled schema if present)

## Known limitations

- Designed for **Wayland GNOME Shell runtime behavior** and Shell internals used by this extension.
- Uses GNOME Shell internal objects for swipe-tracker suppression; internal object layouts can change between major shell versions.
- Gesture event handling depends on compositor/input stack behavior and may vary across hardware/drivers.

## Contributing

1. Keep root entrypoint files (`metadata.json`, `extension.js`) in place.
2. Keep schema keys, metadata `settings-schema`, and prefs/extension key usage in sync.
3. Preserve enable/disable cleanup symmetry (signals, GLib sources, tracker state restoration).
4. Run `./scripts/validate.sh` before opening a PR.
