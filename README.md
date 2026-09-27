# nemo-convert-image

A Nemo file-manager integration for converting images using ImageMagick and Zenity.

The action adds **“Convert image…”** to the Nemo context menu, allowing one or multiple selected images to be converted to another format and optionally resized through a graphical interface.

## Features

- Convert one or multiple images at once.
- Supports JPEG / JPG, PNG, WebP, BMP, TIFF and GIF.
- Graphical format and size selection through Zenity.
- Uses ImageMagick for image conversion.
- Prevents accidental overwriting of existing files.
- Works directly from the Nemo file manager.
- Supports batch conversion.

## Requirements

This project requires:

- Linux
- Nemo file manager
- Bash
- ImageMagick
- Zenity

### Installing dependencies

On Debian/Ubuntu-based systems:

```bash
sudo apt update
sudo apt install imagemagick zenity nemo
```

On distributions using other package managers, install the equivalent packages for `imagemagick`, `zenity` and `nemo`.

## Installation

Copy the conversion script:

```bash
mkdir -p ~/.local/bin
cp convert-image.sh ~/.local/bin/
chmod +x ~/.local/bin/convert-image.sh
```

Install the Nemo action:

```bash
mkdir -p ~/.local/share/nemo/actions
cp convert-image.nemo_action ~/.local/share/nemo/actions/
```

Install the icon:

```bash
mkdir -p ~/.local/share/icons/hicolor/48x48/apps
cp convert-image.png ~/.local/share/icons/hicolor/48x48/apps/
```

Refresh the icon cache if necessary:

```bash
gtk-update-icon-cache ~/.local/share/icons/hicolor 2>/dev/null || true
```

Restart Nemo:

```bash
nemo -q
```

## Usage

1. Open Nemo.
2. Select one or more supported image files.
3. Right-click the selection.
4. Choose **Convert image…**.
5. Select the desired output format.
6. Select the desired image size.
7. Confirm the conversion.

Converted files are created alongside the original files. Existing files are not overwritten.

## Supported Input Formats

The Nemo action is registered for:

```text
jpg
jpeg
png
webp
bmp
tiff
gif
```

The actual conversion capabilities depend on the ImageMagick installation and its available format support.

## How It Works

The Nemo action is defined by:

```text
convert-image.nemo_action
```

When the user selects images and chooses **Convert image…**, Nemo executes:

```text
~/.local/bin/convert-image.sh
```

The script uses:

- **Bash** for application logic.
- **Zenity** for graphical dialogs.
- **ImageMagick** for image conversion.

The action supports multiple selected files through Nemo's `%F` file-list expansion.

## Project Structure

```text
nemo-convert-image/
├── README.md
├── convert-image.sh
├── convert-image.nemo_action
└── convert-image.png
```

### Files

- `convert-image.sh` — main conversion script.
- `convert-image.nemo_action` — Nemo context-menu integration.
- `convert-image.png` — application icon.
- `README.md` — project documentation.

## Uninstallation

Remove the installed files:

```bash
rm -f ~/.local/bin/convert-image.sh
rm -f ~/.local/share/nemo/actions/convert-image.nemo_action
rm -f ~/.local/share/icons/hicolor/48x48/apps/convert-image.png
```

Then restart Nemo:

```bash
nemo -q
```

The project dependencies are not removed because ImageMagick, Zenity and Nemo may be required by other applications.

## Notes

This project is designed for Linux systems using the Nemo file manager.

The installation commands are intended for Debian/Ubuntu-based systems. Other distributions may require different package-management commands or installation paths.

The script does not modify the original image files; converted images are written as separate output files.

## License

MIT License.

See the `LICENSE` file for the complete license text.

## Author

Gonzalo Suarez

## Repository

https://github.com/obi7one/nemo-convert-image
