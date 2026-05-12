#!/bin/sh

# You might need to restart your pc if sharun doesn't create `AppDir` in this directory (It should create dirs on its own)
set -eu

ARCH="$(uname -m)"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
DEBLOATED_PKGS="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

export ADD_HOOKS="self-updater.bg.hook"
#export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export OUTNAME=omikuji-anylinux-"$ARCH".AppImage
export DESKTOP=io.github.reakjra.omikuji.desktop.in
export ICON=https://raw.githubusercontent.com/Twig6943/omikuji/refs/heads/master/crates/omikuji/qml/icons/app.png
export OUTPATH=./dist
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1
export DEPLOY_SDL=1
export STRIP=1

export EXTRA_PLATFORM_PLUGINS=libqtquickcontrols2plugin.so

#Remove leftovers
rm -rf AppDir dist

# ADD LIBRARIES
wget --retry-connrefused --tries=30 "$DEBLOATED_PKGS" -O ./get-debloated-pkgs
wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun
chmod +x ./get-debloated-pkgs

# Debloated pkgs
./get-debloated-pkgs --add-mesa --add-vulkan

# Point to your binaries
./quick-sharun ../target/release/omikuji

# Make AppImage
./quick-sharun --make-appimage

echo "All Done!"
