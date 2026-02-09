#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
DAPP_U_DIR="$PARENT_DIR/dapp-u"
BUILDS_DIR="$SCRIPT_DIR"

echo -e "${BLUE}🚀 Deploying dapp-u builds...${NC}"
echo -e "${BLUE}📍 Script location: $SCRIPT_DIR${NC}"
echo -e "${BLUE}📍 Builds location: $BUILDS_DIR${NC}"

# Verify directories exist
if [ ! -d "$DAPP_U_DIR" ]; then
  echo -e "${RED}❌ Error: dapp-u directory not found at $DAPP_U_DIR${NC}"
  exit 1
fi

if [ ! -d "$BUILDS_DIR" ]; then
  echo -e "${RED}❌ Error: dapp-u-builds directory not found at $BUILDS_DIR${NC}"
  echo -e "${RED}   Expected location: $BUILDS_DIR${NC}"
  exit 1
fi

# Copy files from dapp-u
echo -e "${BLUE}📦 Copying files...${NC}"
cp "$DAPP_U_DIR/dapp-u.mds.zip" "$BUILDS_DIR/" || { echo -e "${RED}❌ Failed to copy dapp-u.mds.zip${NC}"; exit 1; }
cp "$DAPP_U_DIR/public/favicon.ico" "$BUILDS_DIR/" || { echo -e "${RED}❌ Failed to copy favicon.ico${NC}"; exit 1; }
cp "$DAPP_U_DIR/dapp-u-store.json" "$BUILDS_DIR/" || { echo -e "${RED}❌ Failed to copy dapp-u-store.json${NC}"; exit 1; }

# Git operations
echo -e "${BLUE}📝 Staging changes...${NC}"
cd "$BUILDS_DIR" || exit 1

# Stage all changes first
git add -A

# Check if there are changes
if git diff --cached --quiet; then
  echo -e "${RED}❌ No changes to commit${NC}"
  exit 0
fi

# Commit and push
TIMESTAMP=$(date +%Y-%m-%d\ %H:%M:%S)
echo -e "${BLUE}💾 Committing with timestamp...${NC}"
git commit -m "Build update: $TIMESTAMP"

echo -e "${BLUE}⬆️  Pushing to GitHub...${NC}"
git push

echo -e "${GREEN}✅ Deployment successful!${NC}"
echo -e "${GREEN}📁 ZIP: https://github.com/astowny/dapp-u-builds/raw/main/dapp-u.mds.zip${NC}"
echo -e "${GREEN}🎨 Favicon: https://github.com/astowny/dapp-u-builds/raw/main/favicon.ico${NC}"
