{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    desktop-file-utils
    libGL
    xorg.libX11
    xorg.libXcomposite
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXtst

    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-ugly
    gst_all_1.gstreamer
    libdrm
    xorg.libpciaccess
    xorg.xkeyboardconfig

    bzip2
    gdk-pixbuf
    glib
    gtk2
    gtk3
    zlib

    SDL2
    at-spi2-atk
    atk
    cairo
    cups
    curlWithGnuTls
    dbus
    dbus-glib
    expat
    fontconfig
    freetype
    libcap
    libudev0-shim
    libusb1
    nspr
    nss
    pango
    udev
    xorg.libICE
    xorg.libSM
    xorg.libXScrnSaver
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXi
    xorg.libXinerama
    xorg.libXrender
    xorg.libXxf86vm

    SDL
    SDL2_image
    glew110
    libGLU
    libidn
    libogg
    libuuid
    libvorbis
    libxkbcommon
    mesa
    openssl
    tbb
    vulkan-loader
    wayland
    xorg.libXmu
    xorg.libXt
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm

    SDL2_mixer
    SDL2_ttf
    SDL_image
    SDL_mixer
    SDL_ttf
    alsa-lib
    flac
    freeglut
    libappindicator-gtk2
    libcaca
    libcanberra
    libgcrypt
    libjpeg
    libmikmod
    libpng12
    libpulseaudio
    librsvg
    libsamplerate
    libthai
    libtheora
    libtiff
    libvdpau
    libvpx
    pixman
    speex
    xorg.libXft

    e2fsprogs
    fribidi
    harfbuzz
    keyutils.lib
    libgpg-error
    libjack2
    p11-kit

    gmp

    # libraries not on the upstream include list, but nevertheless expected
    # by at least one appimage
    libtool.lib # for Synfigstudio
    xorg.libxshmfence # for apple-music-electron
    at-spi2-core
    pciutils # for FreeCAD
    pipewire # immersed-vr wayland support
  ];
}
