#!/usr/bin/env bash

set -euo pipefail

# Symlink qsb
sudo mkdir -p /usr/lib/qt6/bin
if [[ ! -e /usr/lib/qt6/bin/qsb ]]; then
    QSB_PATH="$(command -v qsb6 2>/dev/null || command -v qsb 2>/dev/null)"
    sudo ln -sf "$QSB_PATH" /usr/lib/qt6/bin/qsb
fi

# Qt env vars
export QMAKE=/usr/lib/qt6/bin/qmake
export QML_SOURCES_PATHS="$PWD/crates/omikuji/qml"

export EXTRA_PLATFORM_PLUGINS=libqwayland.so
export EXTRA_QT_MODULES=svg,imageformats,wayland-decoration-client,wayland-graphics-integration-client,wayland-shell-integration


# linuxdeploy + Qt plugin

wget -qO "linuxdeploy" \
    "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage"
wget -qO "linuxdeploy-plugin-qt" \
    "https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage"
chmod +x "linuxdeploy" "linuxdeploy-plugin-qt"

export APPDIR="$PWD/omikuji-appdir"

mkdir -p \
    "$APPDIR/usr/bin" \
    "$APPDIR/usr/share/applications" \
    "$APPDIR/usr/share/icons/hicolor/512x512/apps"

cp target/release/omikuji "$APPDIR/usr/bin/omikuji"

sed "s|@EXEC_PATH@|omikuji|" packaging/io.github.reakjra.omikuji.desktop.in \
    > "$APPDIR/usr/share/applications/io.github.reakjra.omikuji.desktop"

cp crates/omikuji/qml/icons/app.png \
    "$APPDIR/usr/share/icons/hicolor/512x512/apps/io.github.reakjra.omikuji.png"

chmod +x packaging/AppRun

NO_STRIP=1 ./linuxdeploy \
    --appdir "$APPDIR" \
    --plugin qt \
    --custom-apprun=packaging/AppRun \
    --output appimage
