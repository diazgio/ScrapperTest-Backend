#!/usr/bin/env bash
# exit on error
set -o errexit

sudo apt-get update
sudo apt-get install -y wget unzip chromium-browser

# Descargar ChromeDriver
CHROME_DRIVER_VERSION=$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
wget -N https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/tmp
unzip ~/tmp/chromedriver_linux64.zip -d ~/tmp
sudo mv -f ~/tmp/chromedriver /usr/local/bin/chromedriver
sudo chown root:root /usr/local/bin/chromedriver
sudo chmod 0755 /usr/local/bin/chromedriver

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
