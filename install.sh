#!/bin/bash
set -e

# -----------------------------------
# HYPR THEME ENGINE INSTALLER (V2)
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
# DETECT CONTEXT (IMPORTANT FIX)
# ---------------------------
echo ""
echo "[2/5] Detecting installation source..."

# If user is already inside repo, DO NOT clone
if [ -f "./install.sh" ] && [ -d "./themes" ]; then
    echo "✔ Running from local repo (no internet needed)"
    INSTALL_DIR="$(pwd)"

# If installed system already exists
elif [ -d "$INSTALL_DIR/.git" ]; then
    echo "✔ Existing install found, updating..."
    git -C "$INSTALL_DIR" pull --rebase

# Fresh install
else
    echo "✔ Cloning repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# ---------------------------
# SETUP CLI COMMANDS
# ---------------------------
echo ""
echo "[3/5] Setting up CLI commands..."

mkdir -p "$BIN_DIR"

chmod +x "$INSTALL_DIR/scripts/theme-switch" 2>/dev/null || true
chmod +x "$INSTALL_DIR/scripts/theme-picker" 2>/dev/null || true

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
echo "Make sure Hyprland includes:"
echo "source = ~/.config/hypr-theme-engine/config/hypr/hyprland.conf"

# ---------------------------
# DONE
# ---------------------------
echo ""
echo "[5/5] Done!"
echo ""
echo "🎉 Installation complete!"
echo ""
echo "Try:"
echo "  theme catppuccin"
echo "  theme tokyonight"
echo ""
