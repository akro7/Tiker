#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# AGOU Setup Script
# Merges AGOU customizations with Telegram Open Source
# @author @A_KOJO / AKRO
# ─────────────────────────────────────────────────────────────────────────────

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

AGOU_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TELEGRAM_DIR="${AGOU_DIR}/../TelegramSource"

echo -e "${CYAN}"
echo "  ░█████╗░░██████╗░░█████╗░██╗░░░██╗"
echo "  ██╔══██╗██╔════╝░██╔══██╗██║░░░██║"
echo "  ███████║██║░░██╗░██║░░██║██║░░░██║"
echo "  ██╔══██║██║░░╚██╗██║░░██║██║░░░██║"
echo "  ██║░░██║╚██████╔╝╚█████╔╝╚██████╔╝"
echo "  ╚═╝░░╚═╝░╚═════╝░░╚════╝░░╚═════╝░"
echo -e "${NC}"
echo -e "${CYAN}        AGOU Setup Script v1.0${NC}"
echo -e "${CYAN}        by @A_KOJO / AKRO${NC}"
echo ""

# ─── Step 1: Clone Telegram ──────────────────────────────────────────────────
echo -e "${YELLOW}[1/5] Cloning Telegram Open Source...${NC}"
if [ ! -d "$TELEGRAM_DIR" ]; then
    git clone https://github.com/DrKLO/Telegram.git "$TELEGRAM_DIR"
    echo -e "${GREEN}✓ Telegram cloned successfully${NC}"
else
    echo -e "${GREEN}✓ Telegram source already exists${NC}"
fi

# ─── Step 2: Copy Telegram core files ────────────────────────────────────────
echo -e "${YELLOW}[2/5] Copying Telegram core files to AGOU...${NC}"

AGOU_MAIN="${AGOU_DIR}/TMessagesProj/src/main"
TELE_MAIN="${TELEGRAM_DIR}/TMessagesProj/src/main"

# Copy org.telegram package (the core)
mkdir -p "${AGOU_MAIN}/java/"
cp -r "${TELE_MAIN}/java/org" "${AGOU_MAIN}/java/"
echo -e "${GREEN}  ✓ Telegram Java sources copied${NC}"

# Copy JNI/NDK
if [ -d "${TELEGRAM_DIR}/TMessagesProj/jni" ]; then
    cp -r "${TELEGRAM_DIR}/TMessagesProj/jni" "${AGOU_DIR}/TMessagesProj/"
    echo -e "${GREEN}  ✓ JNI/NDK files copied${NC}"
fi

# Copy native libs
if [ -d "${TELEGRAM_DIR}/TMessagesProj/libs" ]; then
    cp -r "${TELEGRAM_DIR}/TMessagesProj/libs" "${AGOU_DIR}/TMessagesProj/"
    echo -e "${GREEN}  ✓ Native libraries copied${NC}"
fi

# Copy raw resources (Telegram needs these)
if [ -d "${TELE_MAIN}/res/raw" ]; then
    mkdir -p "${AGOU_MAIN}/res/raw"
    cp -r "${TELE_MAIN}/res/raw/." "${AGOU_MAIN}/res/raw/"
    echo -e "${GREEN}  ✓ Raw resources copied${NC}"
fi

# Copy assets
if [ -d "${TELE_MAIN}/assets" ]; then
    cp -r "${TELE_MAIN}/assets" "${AGOU_MAIN}/"
    echo -e "${GREEN}  ✓ Assets copied${NC}"
fi

# ─── Step 3: Patch app name references ───────────────────────────────────────
echo -e "${YELLOW}[3/5] Patching Telegram references to AGOU...${NC}"

# Replace "Telegram" with "AGOU" in ApplicationLoader
APP_LOADER="${AGOU_MAIN}/java/org/telegram/messenger/ApplicationLoader.java"
if [ -f "$APP_LOADER" ]; then
    sed -i 's/applicationName = "Telegram"/applicationName = "AGOU"/' "$APP_LOADER"
    echo -e "${GREEN}  ✓ ApplicationLoader patched${NC}"
fi

echo -e "${GREEN}  ✓ Patching complete${NC}"

# ─── Step 4: Check for API Keys ──────────────────────────────────────────────
echo -e "${YELLOW}[4/5] Checking API Keys...${NC}"

BUILD_GRADLE="${AGOU_DIR}/TMessagesProj/build.gradle"
if grep -q "YOUR_APP_ID" "$BUILD_GRADLE"; then
    echo -e "${RED}"
    echo "  ⚠️  IMPORTANT: You need to set your Telegram API Keys!"
    echo ""
    echo "  1. Go to: https://my.telegram.org/apps"
    echo "  2. Create a new app called 'AGOU'"
    echo "  3. Get your App api_id and api_hash"
    echo "  4. Edit: TMessagesProj/build.gradle"
    echo "     Change: YOUR_APP_ID  → your actual number"
    echo "     Change: YOUR_APP_HASH → your actual hash"
    echo -e "${NC}"
else
    echo -e "${GREEN}  ✓ API Keys are set${NC}"
fi

# ─── Step 5: Check Firebase ──────────────────────────────────────────────────
echo -e "${YELLOW}[5/5] Checking Firebase configuration...${NC}"

FIREBASE="${AGOU_DIR}/TMessagesProj/google-services.json"
if [ ! -f "$FIREBASE" ]; then
    echo -e "${RED}"
    echo "  ⚠️  Missing google-services.json!"
    echo ""
    echo "  1. Go to: https://console.firebase.google.com"
    echo "  2. Create project 'AGOU'"
    echo "  3. Add Android app with package: agou.eko.telegram"
    echo "  4. Download google-services.json"
    echo "  5. Place it in: TMessagesProj/google-services.json"
    echo -e "${NC}"
else
    echo -e "${GREEN}  ✓ Firebase configured${NC}"
fi

# ─── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  ✅ AGOU Setup Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  Next steps:"
echo -e "  1. Set API Keys in ${CYAN}TMessagesProj/build.gradle${NC}"
echo -e "  2. Add ${CYAN}google-services.json${NC}"
echo -e "  3. Open in Android Studio"
echo -e "  4. Build → Make Project"
echo ""
echo -e "  ${CYAN}AGOU by @A_KOJO / AKRO${NC}"
echo ""
