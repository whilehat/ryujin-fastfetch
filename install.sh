
#!/usr/bin/env bash

# ==================================================
# RYUJIN FASTFETCH CUSTOMIZER
# AUTOMATIC INSTALLER
# Author: whilehat
# Version: 1.0.0
# ==================================================

set -Eeuo pipefail

VERSION="1.0.0"
APP="RYUJIN FASTFETCH"

REPO="https://raw.githubusercontent.com/whilehat/ryujin-fastfetch/main"

CONFIG_DIR="$HOME/.config/fastfetch"
CONFIG_FILE="$CONFIG_DIR/config.jsonc"
IMAGE="$CONFIG_DIR/linuxfound.png"

# --------------------------------------------------
# COLORS
# --------------------------------------------------

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RESET='\033[0m'

# --------------------------------------------------
# BANNER
# --------------------------------------------------

banner() {
    echo -e "${CYAN}"
    echo "  ____  __   __      _  _"
    echo " |  _ \ \ \ / /     | || |"
    echo " | |_) | \ V / _   _| || |_"
    echo " |  _ <   | || | | |__   _|"
    echo " | |_) |  | || |_| |  | |"
    echo " |____/   |_| \__,_|  |_|"
    echo ""
    echo "      FASTFETCH CUSTOMIZER"
    echo -e "${RESET}"
}

# --------------------------------------------------
# CHECK DEPENDENCIES
# --------------------------------------------------

check_dependencies() {

    echo -e "${CYAN}[RYUJIN] Checking dependencies...${RESET}"

    for cmd in curl file; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo -e "${RED}[ERROR] Missing dependency: $cmd${RESET}"
            exit 1
        fi
    done

    if ! command -v fastfetch >/dev/null 2>&1; then
        echo -e "${RED}[ERROR] Fastfetch is not installed.${RESET}"
        echo "Install Fastfetch using your distribution package manager."
        exit 1
    fi
}

# --------------------------------------------------
# CREATE CONFIG DIRECTORY
# --------------------------------------------------

create_directory() {

    echo -e "${CYAN}[RYUJIN] Creating configuration directory...${RESET}"

    mkdir -p "$CONFIG_DIR"
}

# --------------------------------------------------
# DOWNLOAD CUSTOM IMAGE
# --------------------------------------------------

download_image() {

    echo -e "${YELLOW}[RYUJIN] Downloading custom image...${RESET}"

    TEMP_IMAGE="$IMAGE.tmp"

    if curl -fL --retry 3 \
        --connect-timeout 15 \
        "$REPO/linuxfound.png" \
        -o "$TEMP_IMAGE"; then

        if [[ -s "$TEMP_IMAGE" ]] &&
           file "$TEMP_IMAGE" | grep -qi 'PNG image'; then

            mv "$TEMP_IMAGE" "$IMAGE"

            echo -e "${GREEN}[SUCCESS] Image downloaded.${RESET}"
        else
            rm -f "$TEMP_IMAGE"
            echo -e "${RED}[ERROR] Invalid PNG image.${RESET}"
            exit 1
        fi

    else
        rm -f "$TEMP_IMAGE"
        echo -e "${RED}[ERROR] Image download failed.${RESET}"
        exit 1
    fi
}

# --------------------------------------------------
# BACKUP EXISTING CONFIGURATION
# --------------------------------------------------

backup_config() {

    if [[ -f "$CONFIG_FILE" ]]; then

        BACKUP="$CONFIG_FILE.backup.$(date +%Y%m%d%H%M%S)"

        cp "$CONFIG_FILE" "$BACKUP"

        echo -e "${YELLOW}[RYUJIN] Previous configuration backed up.${RESET}"
        echo "Backup: $BACKUP"
    fi
}

# --------------------------------------------------
# GENERATE CONFIGURATION
# --------------------------------------------------

generate_config() {

    echo -e "${CYAN}[RYUJIN] Generating Fastfetch configuration...${RESET}"

    # Escape backslashes and quotes for JSON
    JSON_IMAGE=$(printf '%s' "$IMAGE" | sed 's/\\/\\\\/g; s/"/\\"/g')

    TEMP_CONFIG="$CONFIG_FILE.tmp"

    cat > "$TEMP_CONFIG" <<EOF
{
  "\$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",

  "logo": {
    "type": "kitty",
    "source": "$JSON_IMAGE",
    "width": 32,
    "padding": {
      "top": 1,
      "left": 2,
      "right": 3
    }
  },

  "display": {
    "separator": "  "
  },

  "modules": [
    "break",
    {
      "type": "title",
      "format": "{user-name}@{host-name}"
    },
    "separator",
    {
      "type": "os",
      "key": "OS"
    },
    {
      "type": "kernel",
      "key": "KERNEL"
    },
    {
      "type": "wm",
      "key": "WM"
    },
    {
      "type": "shell",
      "key": "SHELL"
    },
    {
      "type": "terminal",
      "key": "TERM"
    },
    {
      "type": "cpu",
      "key": "CPU"
    },
    {
      "type": "gpu",
      "key": "GPU"
    },
    {
      "type": "memory",
      "key": "RAM"
    },
    {
      "type": "disk",
      "key": "DISK"
    },
    {
      "type": "uptime",
      "key": "UPTIME"
    },
    "break",
    "colors"
  ]
}
EOF

    # Validate JSON before replacing the configuration
    if ! fastfetch --config "$TEMP_CONFIG" --list-modules >/dev/null 2>&1; then
        echo -e "${RED}[ERROR] Configuration validation failed.${RESET}"
        rm -f "$TEMP_CONFIG"
        exit 1
    fi

    mv "$TEMP_CONFIG" "$CONFIG_FILE"

    echo -e "${GREEN}[SUCCESS] Configuration installed.${RESET}"
}

# --------------------------------------------------
# COMPLETE INSTALLATION
# --------------------------------------------------

install_ryujin() {

    banner

    check_dependencies
    create_directory
    download_image
    backup_config
    generate_config

    echo ""
    echo -e "${GREEN}======================================${RESET}"
    echo -e "${GREEN} RYUJIN FASTFETCH INSTALLED SUCCESSFULLY${RESET}"
    echo -e "${GREEN}======================================${RESET}"

    echo ""
    echo "Configuration: $CONFIG_FILE"
    echo "Custom image:  $IMAGE"
    echo ""
    echo "Run Fastfetch using:"
    echo "fastfetch --config $CONFIG_FILE"
    echo ""
}

# --------------------------------------------------
# START
# --------------------------------------------------

install_ryujin
