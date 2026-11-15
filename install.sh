
#!/usr/bin/env bash

# ==================================================
# RYUJIN FASTFETCH CUSTOMIZER
# Author: whilehat
# Version: 1.0.0
# ==================================================

VERSION="1.0.0"
APP="RYUJIN FASTFETCH"

# Fastfetch executable (avoid wrapper recursion)
REAL_FASTFETCH="/usr/bin/fastfetch"

# Configuration
CONFIG_DIR="$HOME/.config/fastfetch"
IMAGE="$CONFIG_DIR/linuxfound.png"

# GitHub raw image URL
IMAGE_URL="https://raw.githubusercontent.com/whilehat/ryujin-fastfetch/main/linuxfound.png"

# Image settings
LOGO_TYPE="kitty"
LOGO_WIDTH=32

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
    echo "  ____  __   __      _  _  "
    echo " |  _ \ \ \ / /     | || | "
    echo " | |_) | \ V / _   _| || |_ "
    echo " |  _ <   | || | | |__   _|"
    echo " | |_) |  | || |_| |  | |  "
    echo " |____/   |_| \__,_|  |_|  "
    echo ""
    echo "      FASTFETCH CUSTOMIZER"
    echo -e "${RESET}"
}

# --------------------------------------------------
# CHECK DEPENDENCIES
# --------------------------------------------------

check_dependencies() {

    if [[ ! -x "$REAL_FASTFETCH" ]]; then
        echo -e "${RED}[ERROR] Fastfetch not installed.${RESET}"
        exit 1
    fi

    if ! command -v curl >/dev/null 2>&1; then
        echo -e "${RED}[ERROR] curl is required.${RESET}"
        exit 1
    fi

    mkdir -p "$CONFIG_DIR"
}

# --------------------------------------------------
# DOWNLOAD IMAGE
# --------------------------------------------------

download_image() {

    echo -e "${YELLOW}[RYUJIN] Downloading image...${RESET}"

    TEMP_IMAGE="${IMAGE}.tmp"

    if curl -fL --retry 3 \
        --connect-timeout 15 \
        "$IMAGE_URL" \
        -o "$TEMP_IMAGE"; then

        if [[ -s "$TEMP_IMAGE" ]] &&
           file "$TEMP_IMAGE" | grep -qi 'PNG image'; then

            mv "$TEMP_IMAGE" "$IMAGE"

            echo -e "${GREEN}[SUCCESS] Image installed.${RESET}"

        else
            rm -f "$TEMP_IMAGE"
            echo -e "${RED}[ERROR] Invalid image file.${RESET}"
            exit 1
        fi

    else
        rm -f "$TEMP_IMAGE"
        echo -e "${RED}[ERROR] Download failed.${RESET}"
        exit 1
    fi
}

# --------------------------------------------------
# ENSURE IMAGE EXISTS
# --------------------------------------------------

ensure_image() {

    if [[ ! -s "$IMAGE" ]]; then
        download_image
    else
        echo -e "${GREEN}[RYUJIN] Custom image found.${RESET}"
    fi
}

# --------------------------------------------------
# RUN FASTFETCH
# --------------------------------------------------

run_fastfetch() {

    ensure_image

    echo -e "${CYAN}[RYUJIN] Starting $1 profile...${RESET}"

    exec "$REAL_FASTFETCH" \
        --logo "$IMAGE" \
        --logo-type "$LOGO_TYPE" \
        --logo-width "$LOGO_WIDTH"
}

# --------------------------------------------------
# HELP
# --------------------------------------------------

show_help() {

    banner

    echo "Usage: fastfetch [OPTION]"
    echo ""
    echo "Available options:"
    echo ""
    echo "  -arch       Arch Linux profile"
    echo "  -kali       Kali Linux profile"
    echo "  -fedora     Fedora profile"
    echo "  -ubuntu     Ubuntu profile"
    echo "  -update     Download latest image"
    echo "  -remove     Remove custom image"
    echo "  -version    Show version"
    echo "  -help       Show help"
    echo ""
    echo "  No argument  Run normal Fastfetch"
}

# --------------------------------------------------
# MAIN
# --------------------------------------------------

case "${1:-}" in

    -arch)
        check_dependencies
        banner
        run_fastfetch "Arch Linux"
        ;;

    -kali)
        check_dependencies
        banner
        run_fastfetch "Kali Linux"
        ;;

    -fedora)
        check_dependencies
        banner
        run_fastfetch "Fedora"
        ;;

    -ubuntu)
        check_dependencies
        banner
        run_fastfetch "Ubuntu"
        ;;

    -update)
        check_dependencies
        banner
        download_image
        ;;

    -remove)
        rm -f "$IMAGE"
        echo -e "${GREEN}[SUCCESS] Custom image removed.${RESET}"
        ;;

    -version|--version)
        echo "$APP v$VERSION"
        ;;

    -help|--help|-h)
        show_help
        ;;

    "")
        exec "$REAL_FASTFETCH"
        ;;

    *)
        echo -e "${RED}[ERROR] Unknown option: $1${RESET}"
        echo "Use: fastfetch -help"
        exit 1
        ;;

esac
