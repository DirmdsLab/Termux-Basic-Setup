#!/usr/bin/env bash
set -e

# =========================
# Paths & State
# =========================
ROOT_DIR="$(pwd)"
TEMP_DIR="$ROOT_DIR/temp"
STATE_FILE="$TEMP_DIR/UwU.temp"
LOG_FILE="$TEMP_DIR/setup.log"

mkdir -p "$TEMP_DIR"

# =========================
# Run Metadata
# =========================
RUN_ID="$(date '+%Y-%m-%d %H:%M:%S')"
SEPARATOR="============================================================"

# =========================
# Logging Helpers
# =========================
timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

log() {
    echo "[$RUN_ID] $1" | tee -a "$LOG_FILE"
}

run() {
    log "RUN: $*"
    "$@" >>"$LOG_FILE" 2>&1
}

# =========================
# State Helpers
# =========================
is_first_setup() {
    [[ ! -f "$STATE_FILE" ]]
}

mark_setup_done() {
    echo "Delete This ReSetup" > "$STATE_FILE"
    log "State file created: $STATE_FILE"
}

# =========================
# Always Run Tasks
# =========================
always_run() {
    log "=== ALWAYS RUN TASKS START ==="

    # Art-hypr
    run rm -rf "$HOME/Documents/art-cli"
    run ln -sf "$ROOT_DIR/external/DirmdsLab/LupaMinum_Hyprland/external/DirmdsLab/Art" "$HOME/Documents/art-cli"

    # Tmux
    run rm -rf "$HOME/.tmux.conf"
    run ln -sf "$ROOT_DIR/external/DirmdsLab/LupaMinum_Hyprland/user/.tmux.conf" "$HOME/.tmux.conf"

    # Nano
    run rm -rf "$HOME/.nanorc"
    run ln -sf "$ROOT_DIR/external/DirmdsLab/LupaMinum_Hyprland/user/.nanorc" "$HOME/.nanorc"

    # Bash
    run rm -rf "$HOME/.bashrc"
    run ln -sf "$ROOT_DIR/.bashrc" "$HOME/.bashrc"

    # btop
    run rm -rf "$HOME/.config/btop"
    run ln -sf "$ROOT_DIR/external/DirmdsLab/LupaMinum_Hyprland/user/.config/btop" "$HOME/.config/btop"

    # cava
    run rm -rf "$HOME/.config/cava"
    run ln -sf "$ROOT_DIR/external/DirmdsLab/LupaMinum_Hyprland/user/.config/cava" "$HOME/.config/cava"

    # fish
    run rm -rf "$HOME/.config/fish"
    run ln -sf "$ROOT_DIR/external/DirmdsLab/LupaMinum_Hyprland/user/.config/fish" "$HOME/.config/fish"

    # fastfetch
    run rm -rf "$HOME/.config/fastfetch"
    run ln -sf "$ROOT_DIR/external/DirmdsLab/LupaMinum_Hyprland/user/.config/fastfetch" "$HOME/.config/fastfetch"

    # starship.toml
    run rm -rf "$HOME/.config/starship.toml"
    run ln -sf "$ROOT_DIR/external/DirmdsLab/LupaMinum_Hyprland/user/.config/starship.toml" "$HOME/.config/starship.toml"

    # Script
    run rm -rf "$HOME/File/Script"
    run ln -sf "$ROOT_DIR/external/DirmdsLab/LupaMinum_Hyprland/user/File/Script" "$HOME/File/Script"

    log "=== ALWAYS RUN TASKS END ==="
}

# =========================
# First Setup Only Tasks
# =========================
first_setup_only() {

    pkg install openssh fish starship tmux proot-distro eza fastfetch cava pulseaudio zip unzip -y

    log "=== FIRST SETUP TASKS START ==="

    # Home Folder
    run mkdir -p "$HOME/.config"
    run mkdir -p "$HOME/Documents"
    run mkdir -p "$HOME/Downloads"

    run mkdir -p "$HOME/File"
    run mkdir -p "$HOME/File/Code"
    run mkdir -p "$HOME/File/Temp"
    run mkdir -p "$HOME/File/Software"

    # Tmux
    run rm -rf "$HOME/.config/tmux"
    run mkdir -p "$HOME/.config/tmux/plugins/catppuccin/"
    run git clone -b v2.3.0 https://github.com/DirmdsLab/catppuccin-tmux.git ~/.config/tmux/plugins/catppuccin/tmux
    
    mv $PREFIX/etc/motd $PREFIX/etc/motd.bak

    SSHD_CONFIG="$PREFIX/etc/ssh/sshd_config"

    echo "[*] Changing SSH port..."

    # Remove the comment from the default port and change it to 8010
    sed -i 's/^#Port 8022/Port 8010/' "$SSHD_CONFIG"

    echo "[*] Confirming changes:"
    grep -A 10 Port "$SSHD_CONFIG"


    chmod +x optional.sh

    log "=== FIRST SETUP TASKS END ==="
}

# =========================
# Main
# =========================
echo -e "\n$SEPARATOR" >>"$LOG_FILE"
log "Setup script started"

if is_first_setup; then
    log "First setup detected"
    first_setup_only
    mark_setup_done
else
    log "First setup already done, skipping"
fi

always_run

log "Setup script finished"
echo "$SEPARATOR" >>"$LOG_FILE"
echo "Set passwd if first setup ^_^"


# Bruh GPT 