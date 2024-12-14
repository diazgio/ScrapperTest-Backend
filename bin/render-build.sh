#!/usr/bin/env bash
# exit on error
set -o errexit

# Actualizar repositorios e instalar dependencias necesarias
sudo apt-get update
sudo apt-get install -y wget unzip chromium-browser libglib2.0-0 libnss3 libgconf-2-4 libfontconfig1 libx11-xcb1

# Descargar ChromeDriver
CHROME_DRIVER_VERSION=$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
wget -N https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/tmp
unzip ~/tmp/chromedriver_linux64.zip -d ~/tmp
sudo mv -f ~/tmp/chromedriver /usr/local/bin/chromedriver
sudo chown root:root /usr/local/bin/chromedriver
sudo chmod 0755 /usr/local/bin/chromedriver

# Exportar PATH para que Render pueda encontrar chromedriver
export PATH=$PATH:/usr/local/bin
echo "PATH configurado como: $PATH"

# Verificar que chromedriver y chromium-browser están instalados correctamente
echo "Verificando instalaciones:"
which chromedriver || echo "chromedriver no encontrado en el PATH"
which chromium-browser || echo "chromium-browser no encontrado en el PATH"

# Instalar gems y precompilar assets
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
