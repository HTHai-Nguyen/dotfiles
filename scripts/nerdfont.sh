#!/usr/bin/env bash
# ==========================================================
# Nerd Font Installer with FZF (multi-select + remove)
# ==========================================================
set -euo pipefail

FONT_DIR="$HOME/.local/share/fonts"
DOWNLOAD_DIR="$HOME/Downloads"
GITHUB_API="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"

# ---------------------- Functions ------------------------
check_dependencies() {
  for cmd in curl wget unzip fc-cache grep fzf; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "❌ Missing dependency: $cmd"
      exit 1
    fi
  done
}

fetch_font_list() {
  echo "🌐 Fetching Nerd Fonts list from GitHub..."
  curl -s "$GITHUB_API" \
    | grep -oP '(?<="name": ")[^"]+\.zip' \
    | sed 's/\.zip//g' | sort -u
}

download_and_install_font() {
  local font="$1"
  local zip_file="$DOWNLOAD_DIR/${font}.zip"
  local url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.zip"

  if fc-list | grep -iq "$font"; then
    echo "✅ Font '$font' is already installed. Skipping."
    return
  fi

  # Check URL
  if ! curl --output /dev/null --silent --head --fail "$url"; then
    echo "❌ Font '$font' not found at $url"
    return
  fi

  # Download
  echo "⬇️  Downloading $font..."
  wget -q -O "$zip_file" "$url"

  # Verify contents
  if ! unzip -l "$zip_file" | grep -Eq '\.(ttf|otf)'; then
    echo "❌ ZIP does not contain font files. Removing..."
    rm -f "$zip_file"
    return
  fi

  # Extract
  echo "📦 Extracting to $FONT_DIR"
  mkdir -p "$FONT_DIR"
  unzip -o "$zip_file" -d "$FONT_DIR" >/dev/null

  # Update cache
  echo "🔄 Updating font cache..."
  fc-cache -f -v >/dev/null

  # Verify
  if fc-list | grep -iq "$font"; then
    echo "✅ Installation complete: $font"
  else
    echo "⚠️  Installation attempted but font not detected."
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

# Handle remove option
if [[ "${1:-}" == "--remove" ]]; then
  if [[ -z "${2:-}" ]]; then
    echo "Usage: $0 --remove fontname"
    exit 1
  fi
  remove_font "$2"
  exit 0
fi

# Fetch fonts
FONT_LIST=$(fetch_font_list)
if [[ -z "$FONT_LIST" ]]; then
  echo "❌ Failed to retrieve font list from GitHub."
  exit 1
fi

# FZF selection (multi-select)
echo "🎨 Select Nerd Fonts to install (type to search, TAB for multi-select):"
SELECTED_FONTS=$(echo "$FONT_LIST" | fzf --height 40% --reverse --prompt="Font: " --multi --border)

if [[ -z "$SELECTED_FONTS" ]]; then
  echo "❌ No font selected. Exiting."
  exit 1
fi

# Install selected fonts
for font in $SELECTED_FONTS; do
  download_and_install_font "$font"
done

echo
echo "🎉 All selected fonts processed!"

