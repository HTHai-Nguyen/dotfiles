#!/usr/bin/env bash
# ========================================================
# Nerd Font Installer with FZF (multi‑select + remove)
# Uses real download URLs from Nerd Fonts GitHub release
# ========================================================
set -euo pipefail

FONT_DIR="$HOME/.local/share/fonts"
DOWNLOAD_DIR="$HOME/Downloads"
GITHUB_API="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"

# ---------------------- Functions ------------------------
check_dependencies() {
  for cmd in curl wget unzip fc-cache grep fzf jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "❌ Missing dependency: $cmd"
      exit 1
    fi
  done
}

fetch_font_assets() {
  echo "🌐 Fetching Nerd Fonts assets from GitHub..."
  curl -s "$GITHUB_API" \
    | jq -r '.assets[] | select(.name | test("zip$")) | "\(.name) \(.browser_download_url)"'
}

download_and_install_font() {
  local font_name="$1"
  local url="$2"
  local zip_file="$DOWNLOAD_DIR/${font_name}.zip"

  if fc-list | grep -iq "$font_name"; then
    echo "✅ Font '$font_name' is already installed. Skipping."
    return
  fi

  echo "⬇️ Downloading $font_name..."
  wget -q -O "$zip_file" "$url"

  if ! unzip -l "$zip_file" | grep -Eq '\.(ttf|otf)'; then
    echo "❌ ZIP does not contain font files. Removing..."
    rm -f "$zip_file"
    return
  fi

  echo "📦 Extracting to $FONT_DIR"
  mkdir -p "$FONT_DIR"
  unzip -o "$zip_file" -d "$FONT_DIR" >/dev/null

  echo "🔄 Updating font cache..."
  fc-cache -f -v >/dev/null

  if fc-list | grep -iq "$font_name"; then
    echo "✅ Installation complete: $font_name"
  else
    echo "⚠️ Installation attempted but font not detected."
  fi
}

remove_font() {
  local font="$1"
  if ! fc-list | grep -iq "$font"; then
    echo "❌ Font '$font' not installed."
    return
  fi

  echo "🗑 Removing font '$font'..."
  find "$FONT_DIR" -type f -iname "*$font*.ttf" -o -iname "*$font*.otf" -exec rm -v {} \;
  fc-cache -f -v >/dev/null
  echo "✅ Font '$font' removed."
}

# ---------------------- Main ------------------------
check_dependencies

if [[ "${1:-}" == "--remove" ]]; then
  if [[ -z "${2:-}" ]]; then
    echo "Usage: $0 --remove fontname"
    exit 1
  fi
  remove_font "$2"
  exit 0
fi

ASSETS=$(fetch_font_assets)
if [[ -z "$ASSETS" ]]; then
  echo "❌ Failed to retrieve font assets from GitHub."
  exit 1
fi

MENU=$(echo "$ASSETS" | awk '{print $1}')
URL_MAP=$(echo "$ASSETS")

echo "🎨 Select Nerd Fonts to install (type to search, TAB for multi‑select):"
SELECTED=$(echo "$MENU" | fzf --height 40% --reverse --prompt="Font: " --multi --border)

if [[ -z "$SELECTED" ]]; then
  echo "❌ No font selected. Exiting."
  exit 1
fi

for font in $SELECTED; do
  url=$(echo "$URL_MAP" | grep -F "$font " | awk '{print $2}')
  download_and_install_font "$font" "$url"
done

echo
echo "🎉 All selected fonts processed!"

