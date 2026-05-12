# Building

Disclaimer: This was written with arch in mind. So the package names might be different or some might not even exist on your distro.

1. Install the dependencies;
```
build-essential
pkg-config
cmake
libudev-dev
libfuse2
wget
protobuf-compiler
rust
cmake
file
libxkbcommon-dev
libxkbcommon-x11-0
fuse2
libxcb-cursor-dev
libcups2-dev
libglib2.0-0
libglib2.0-dev
libproxy1v5
libproxy-dev
qt6-base-dev
qt6-base-dev-tools
qt6-tools-dev
qt6-tools-dev-tools
qt6-wayland
qt6-wayland-dev
libqt6waylandclient6
qml6-module-qtwayland-compositor
libqt6core5compat6
libqt6core5compat6-dev
qt6-base-private-dev

# these might not be required
libfbclient
mariadb
unixodbc
postgresql-libs
jxrlib
```

2. Add `/usr/lib/qt6/bin` to your `$PATH` if needed

```sh
export PATH="/usr/lib/qt6/bin:$PATH"
```

3. Compile the app
```sh
cargo build --release -p omikuji
```

4.Run `./packaging/make-appimage.sh` to make an appimage.
