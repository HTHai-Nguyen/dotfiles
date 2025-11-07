#!/usr/bin/env bash
# --------------------------------------------------
# Nerd Font Installer
# --------------------------------------------------

set -e  # stop on any error

echo
echo "=============================="
echo "   🧠 Nerd Font Installer"
echo "=============================="
echo

# Menu options
echo "Select a Nerd Font to install:"
echo "[1] JetBrainsMono"
echo "[2] Hack"
echo "[3] DejaVuSansMono"
echo "[4] MesloLG"
echo "[5] FiraCode"
echo "[6] Others (type the name manually)"
echo

read -rp "Enter your choice (1-6): " choice

case $choice in
    1) FONT_NAME="JetBrainsMono" ;;
    2) FONT_NAME="Hack" ;;
    3) FONT_NAME="DejaVuSansMono" ;;
    4) FONT_NAME="MesloLG" ;;
    5) FONT_NAME="FiraCode" ;;
    6)
        read -rp "Enter the font name (exactly as on GitHub, e.g., CascadiaCode, RobotoMono): " FONT_NAME
        ;;
    *)
        echo "❌ Invalid selection. Exiting."
        exit 1
        ;;
esac

echo
echo "🔤 Selected font: $FONT_NAME"
echo

FONT_DIR="$HOME/.local/share/fonts"
FONT_ZIP="$HOME/Downloads/${FONT_NAME}.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"

# Check if font already installed
if fc-list | grep -iq "$FONT_NAME"; then
    echo "✅ Font '$FONT_NAME' already installed. Skipping download."
    exit 0
fi

# Check if URL actually exists
echo "🌐 Checking font availability on GitHub..."
if ! curl --output /dev/null --silent --head --fail "$FONT_URL"; then
    echo "❌ Font '$FONT_NAME' not found on Nerd Fonts GitHub."
    echo "👉 Check available fonts at: https://github.com/ryanoasis/nerd-fonts/releases/latest"
    exit 1
fi

# Download the font
echo "⬇️  Downloading $FONT_NAME Nerd Font..."
wget -q -O "$FONT_ZIP" "$FONT_URL"

# Verify the zip file contains font files
if ! unzip -l "$FONT_ZIP" | grep -Eq '\.(ttf|otf)'; then
    echo "❌ The downloaded file does not contain any font files. Possibly a bad download."
    rm -f "$FONT_ZIP"
    exit 1
fi

# Extract font files directly into ~/.local/share/fonts
echo "📦 Extracting fonts to: $FONT_DIR"
unzip -o "$FONT_ZIP" -d "$FONT_DIR" >/dev/null

# Update font cache
echo "🔄 Updating font cache..."
fc-cache -f -v >/dev/null

# Verify installation success
if fc-list | grep -iq "$FONT_NAME"; then
    echo "✅ $FONT_NAME Nerd Font installation complete!"
else
    echo "⚠️ Font installation attempted, but system cannot find '$FONT_NAME'."
    echo "Try running: fc-cache -f -v"
fi

echo
echo "🎉 Done! You can now use '$FONT_NAME Nerd Font' in your terminal or editor."

