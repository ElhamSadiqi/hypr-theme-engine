#!/bin/bash

set -e

# -----------------------------------
# HYPR THEME ENGINE INSTALLER
# -----------------------------------

REPO_NAME="hypr-theme-engine"
INSTALL_DIR="$HOME/.config/$REPO_NAME"
BIN_DIR="$HOME/.local/bin"

echo ""
echo "======================================"
echo "   HYPR THEME ENGINE INSTALLER"
echo "======================================"
echo ""

# ---------------------------
# CHECK REQUIREMENTS
# ---------------------------
echo "[1/5] Checking requirements..."

command -v git >/dev/null || {
    echo "❌ git not installed"
    exit 1
}

echo "✔ git found"

# ---------------------------
# CLONE OR UPDATE
# ---------------------------
echo ""
echo "[2/5] Setting up repository..."

if [ -d "$INSTALL_DIR" ]; then
    echo "✔ Existing install found, updating..."
    cd "$INSTALL_DIR"
    git pull
else
    echo "✔ Cloning repository..."
    git clone https://github.com/YOUR_USERNAME/$REPO_NAME.git "$INSTALL_DIR"
fi

# ---------------------------
# CREATE BIN DIR
# ---------------------------
echo ""
echo "[3/5] Setting up scripts..."

mkdir -p "$BIN_DIR"

# Link main scripts
ln -sf "$INSTALL_DIR/scripts/theme-switch" "$BIN_DIR/theme"
ln -sf "$INSTALL_DIR/scripts/theme-picker" "$BIN_DIR/theme-picker"

chmod +x "$INSTALL_DIR/scripts/"*

# ---------------------------
# CONFIG SETUP MESSAGE
# ---------------------------
echo ""
echo "[4/5] Config setup..."

echo "✔ Config installed at:"
echo "   $INSTALL_DIR/config"

echo ""
echo "IMPORTANT:"
echo "Add this to your Hyprland config if not already:"
echo ""
echo "source = ~/.config/hypr-theme-engine/config/hypr/hyprland.conf"
echo ""

# ---------------------------
# FINISH
# ---------------------------
echo "[5/5] Done!"
echo ""
echo "🎉 Installation complete!"
echo "👉 Restart Hyprland or run: hyprctl reload"
echo ""
echo "Try:"
echo "   theme catppuccin"
echo "   theme tokyonight"
echo ""
