#!/bin/bash

set -e

# -----------------------------------
# HYPR THEME ENGINE INSTALLER
# -----------------------------------

REPO_URL="https://github.com/ElhamSadiqi/hypr-theme-engine.git"
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

command -v git >/dev/null 2>&1 || {
    echo "❌ git not installed"
    exit 1
}

echo "✔ git found"

# ---------------------------
# CLONE OR UPDATE
# ---------------------------
echo ""
echo "[2/5] Setting up repository..."

if [ -d "$INSTALL_DIR/.git" ]; then
    echo "✔ Existing install found, updating..."
    git -C "$INSTALL_DIR" pull --rebase
else
    echo "✔ Cloning repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# ---------------------------
# CREATE BIN DIR + LINK COMMANDS
# ---------------------------
echo ""
echo "[3/5] Setting up CLI commands..."

mkdir -p "$BIN_DIR"

# Ensure scripts are executable
chmod +x "$INSTALL_DIR/scripts/theme-switch" 2>/dev/null || true
chmod +x "$INSTALL_DIR/scripts/theme-picker" 2>/dev/null || true

# Create symlinks (overwrite safely)
ln -sf "$INSTALL_DIR/scripts/theme-switch" "$BIN_DIR/theme"
ln -sf "$INSTALL_DIR/scripts/theme-picker" "$BIN_DIR/theme-picker"

# ---------------------------
# CONFIG INFO
# ---------------------------
echo ""
echo "[4/5] Config setup..."

echo "✔ Installed at:"
echo "   $INSTALL_DIR"

echo ""
echo "IMPORTANT:"
echo "Make sure Hyprland includes this line:"
echo ""
echo "source = ~/.config/hypr-theme-engine/config/hypr/hyprland.conf"
echo ""

# ---------------------------
# FINISH
# ---------------------------
echo "[5/5] Done!"
echo ""
echo "🎉 Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Restart Hyprland OR run: hyprctl reload"
echo "  2. Try:"
echo "     theme catppuccin"
echo "     theme tokyonight"
echo ""
