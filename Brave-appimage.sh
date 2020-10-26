#!/bin/bash
mkdir ~/Brave.AppImage
cd ~/Brave.AppImage
curl -s https://api.github.com/repos/brave/brave-browser/releases/latest | jq -r ".assets[] | select(.name | contains(\"amd64.deb\")) | .browser_download_url" | wget -i -
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
