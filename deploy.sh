#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Deploying dapp-u builds...${NC}"

# Copy files from dapp-u
echo -e "${BLUE}📦 Copying files...${NC}"
cp ../dapp-u/dapp-u.mds.zip .
cp ../dapp-u/public/favicon.ico .

# Git operations
echo -e "${BLUE}📝 Staging changes...${NC}"
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
