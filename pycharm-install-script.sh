#!/bin/bash

PYCHARM_VERSION="2024.2.1"
PYCHARM_TAR="pycharm-professional-${PYCHARM_VERSION}.tar.gz"
DOWNLOAD_URL="https://download.jetbrains.com/python/${PYCHARM_TAR}"

# OSの検出
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    echo "Unsupported operating system"
    exit 1
fi

# PyCharmのダウンロードと展開
echo "Downloading PyCharm Professional ${PYCHARM_VERSION}..."
wget ${DOWNLOAD_URL}

echo "Extracting PyCharm..."
tar -xzf ${PYCHARM_TAR}

# OSに応じたインストール
if [[ ${OS} == "linux" ]]; then
    # Ubuntuの場合
    INSTALL_DIR="/opt/pycharm-professional"
    sudo mkdir -p ${INSTALL_DIR}
    sudo mv pycharm-*/* ${INSTALL_DIR}
    sudo ln -sf ${INSTALL_DIR}/bin/pycharm.sh /usr/local/bin/pycharm

    # デスクトップエントリの作成
    echo "[Desktop Entry]
Version=1.0
Type=Application
Name=PyCharm Professional
Icon=${INSTALL_DIR}/bin/pycharm.svg
Exec=${INSTALL_DIR}/bin/pycharm.sh
Comment=Python IDE for Professional Developers
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-pycharm" | sudo tee /usr/share/applications/pycharm.desktop > /dev/null

    sudo chmod +x /usr/share/applications/pycharm.desktop

    echo "PyCharm has been installed. You can start it by running 'pycharm' in the terminal or from your application menu."

elif [[ ${OS} == "macos" ]]; then
    # macOSの場合
    INSTALL_DIR="/Applications"
    mv pycharm-* ${INSTALL_DIR}/PyCharm.app

    echo "PyCharm has been installed. You can find it in your Applications folder."
fi

# クリーンアップ
rm -rf ${PYCHARM_TAR} pycharm-*

echo "Installation complete!"