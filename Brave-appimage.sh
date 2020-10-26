#!/bin/bash
mkdir ~/Brave.AppImage
cd ~/Brave.AppImage
if [ -z "$1" ]; then 
    echo "You have to get brave.deb from: https://github.com/brave/brave-browser/releases/"
    echo "And put it as \$1"
    exit;
else
    wget "$1"
    dpkg-deb -R ./brave*.deb brave-browser.appdir
    cd ./brave-browser.appdir
    rm -rf ./DEBIAN
    cp ./usr/share/applications/brave*.desktop ./brave.desktop
    cp ./opt/brave.com/brave/product_logo_256.png ./
    sed -i 's/Icon=brave-browser/'"Icon=product_logo_256"'/' brave.desktop
    ln -sr ./opt/brave.com/brave/brave-browser ./AppRun
    cd ..
    wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
    chmod +x appimagetool-x86_64.AppImage
    ./appimagetool-x86_64.AppImage --comp gzip brave-browser.appdir -n -u 'gh-releases-zsync|hcsubser|Brave-AppImage|continuous|Brave*.AppImage.zsync'
fi