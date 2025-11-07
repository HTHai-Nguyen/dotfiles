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
    # Giữ nguyên phần này
    for cmd in curl wget unzip fc-cache grep fzf jq; do
      if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ Missing dependency: $cmd"
        exit 1
      fi
    done
}

fetch_font_assets() {
    # Giữ nguyên phần này
    echo "🌐 Fetching Nerd Fonts assets from GitHub..."
    curl -s "$GITHUB_API" \
      | jq -r '.assets[] | select(.name | test("zip$")) | "\(.name) \(.browser_download_url)"'
}

download_and_install_font() {
    local font_name="$1"
    local url="$2"
    local zip_file="$DOWNLOAD_DIR/$font_name" # Font name đã có .zip

    # Cải tiến việc kiểm tra font đã cài đặt:
    # Chỉ kiểm tra sự tồn tại của thư mục nếu cần để tránh sai lệch tên
    local font_check_pattern=$(echo "$font_name" | sed 's/\.zip$//')

    if fc-list | grep -iq "$font_check_pattern"; then
      echo "✅ Font '$font_check_pattern' is already installed. Skipping."
      return
    fi

    echo "⬇️  Downloading $font_check_pattern..."
    # Đảm bảo thư mục Download tồn tại
    mkdir -p "$DOWNLOAD_DIR"
    wget -q -O "$zip_file" "$url"

    # Sửa lỗi: Sử dụng grep đơn giản hơn để kiểm tra font files
    # Lệnh này kiểm tra xem có bất kỳ file .ttf, .otf, hoặc .TTF, .OTF nào trong ZIP không.
    if ! unzip -l "$zip_file" | grep -Eq '\.((t|o)tf|(T|O)TF)$'; then
      echo "❌ ZIP does not contain font files (ttf/otf). Removing: $zip_file"
      rm -f "$zip_file"
      return
    fi

    echo "📦 Extracting to $FONT_DIR"
    mkdir -p "$FONT_DIR"
    # Thêm -j để bỏ qua các thư mục con không cần thiết (docs, licenses, v.v.)
    unzip -o -j "$zip_file" -d "$FONT_DIR" '*.ttf' '*.otf' >/dev/null

    echo "🔄 Updating font cache..."
    fc-cache -f -v >/dev/null

    # Kiểm tra lại sau khi cài đặt
    if fc-list | grep -iq "$font_check_pattern"; then
      echo "✅ Installation complete: $font_check_pattern"
    else
      # Cảnh báo nếu font không được phát hiện (có thể do tên)
      echo "⚠️  Installation attempted but font not detected. Check $FONT_DIR for files."
    fi
}

remove_font() {
    local font="$1"
    # Giữ nguyên phần này, đã hoạt động tốt cho việc tìm và xóa font
    if ! fc-list | grep -iq "$font"; then
      echo "❌ Font '$font' not installed."
      return
    fi

    echo "🗑 Removing font '$font'..."
    # Thêm -exec rm -f để tránh hỏi xác nhận
    find "$FONT_DIR" -type f \( -iname "*$font*.ttf" -o -iname "*$font*.otf" \) -exec rm -f {} \;
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

# Fetch assets
ASSETS=$(fetch_font_assets)
if [[ -z "$ASSETS" ]]; then
    echo "❌ Failed to retrieve font assets from GitHub."
    exit 1
fi

# Prepare fzf menu: show only font name, preserve URL
MENU=$(echo "$ASSETS" | awk '{print $1}')
URL_MAP="$ASSETS" # Giữ nguyên biến ASSETS thay vì tạo biến URL_MAP mới

# fzf multi-select
echo "🎨 Select Nerd Fonts to install (type to search, TAB for multi-select):"
SELECTED_ZIP_NAMES=$(echo "$MENU" | fzf --height 40% --reverse --prompt="Font: " --multi --border)

if [[ -z "$SELECTED_ZIP_NAMES" ]]; then
    echo "❌ No font selected. Exiting."
    exit 1
fi

# Install selected fonts
echo "$SELECTED_ZIP_NAMES" | while IFS= read -r font_name_only; do
    # Tìm URL bằng grep -F (tìm chuỗi cố định) và lấy trường thứ 2
    # Sử dụng ASSETS thay vì URL_MAP để giảm biến trung gian
    url=$(echo "$URL_MAP" | grep -F "$font_name_only " | awk '{print $2}' | head -n 1)
    
    # Chỉ truyền tên ZIP đầy đủ (.zip) và URL
    download_and_install_font "$font_name_only" "$url"
done

echo
echo "🎉 All selected fonts processed!"
