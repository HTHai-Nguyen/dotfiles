#!/usr/bin/env bash

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
        read -rp "Enter the font name (e.g., CascadiaCode, RobotoMono, Iosevka): " FONT_NAME
        ;;
    *)
        echo "❌ Invalid selection. Exiting."
        exit 1
        ;;
esac

# Normalize font name (capitalize first letter if all lowercase)
if [[ "$FONT_NAME" =~ ^[a-z]+$ ]]; then
    FONT_NAME="$(tr '[:lower:]' '[:upper:]' <<< "${FONT_NAME:0:1}")${FONT_NAME:1}"
fi

echo
echo "🔤 Selected font: $FONT_NAME"
echo

FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"
FONT_ZIP="$HOME/Downloads/${FONT_NAME}.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"

# Check if font is already installed
if fc-list | grep -i "$FONT_NAME" >/dev/null 2>&1; then
    echo "✅ Font '$FONT_NAME' is already installed. Skipping download."
else
    # Create font directory if not exists
    if [ ! -d "$FONT_DIR" ]; then
        echo "📂 Creating font directory: $FONT_DIR"
        mkdir -p "$FONT_DIR"
    fi

    # Check if the zip already exists
    if [ -f "$FONT_ZIP" ]; then
        echo "✅ Font zip file already exists: $FONT_ZIP"
    else
        echo "⬇️  Downloading $FONT_NAME Nerd Font..."

        # Check if the URL exists before downloading
        if curl --output /dev/null --silent --head --fail "$FONT_URL"; then
            wget -O "$FONT_ZIP" "$FONT_URL"
        else
            echo "❌ Font '$FONT_NAME' not found on Nerd Fonts GitHub."
            echo "👉 Check the exact font name at: https://github.com/ryanoasis/nerd-fonts/releases/latest"
            exit 1
        fi
    fi

    # Extract font files
    echo "📦 Extracting fonts to: $FONT_DIR"
    unzip -o "$FONT_ZIP" -d "$FONT_DIR" >/dev/null

    # Refresh font cache
    echo "🔄 Updating font cache..."
    fc-cache -f -v >/dev/null

    echo "✅ $FONT_NAME Nerd Font installation complete!"
fi

echo
echo "🎉 Done! You can now use '$FONT_NAME Nerd Font' in your terminal or editor."
