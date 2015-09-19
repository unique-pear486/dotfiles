#!/bin/bash

# If not root, run again with sudo
if (($EUID != 0))
then
  sudo "$0" "$@"
  exit
fi

apt-get update

for package in vim-gtk python3 exuberant-ctags tree python-pip \
    python-virtualenv curl
do
    apt-get install -y $package
done

# Get google app engine if not already installed
if ! [ -d "/opt/google_appengine" ]; then
    echo "installing Google App Engine v1.9.26"
    wget -O /tmp/GAE.zip https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.26.zip
    unzip -q /tmp/GAE.zip -d /opt/
    rm /tmp/GAE.zip
    if ! grep -q "google app engine" ~/.profile ; then
        echo "Adding GAE to .profile"
        echo "" >> ~/.profile
        echo "# Installed google app engine" >> ~/.profile
        echo "export PATH=\$PATH:/opt/google_appengine" >> ~/.profile
        echo "export PYTHONPATH=\$PYTHONPATH:/opt/google_appengine" >> ~/.profile
    fi
fi

# Get node if not already installed
if ! [ -d "/opt/node" ]; then
    echo "installing node.js v0.12.7 x64"
    wget -O /tmp/node.tar.gz https://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz
    tar xzf /tmp/node.tar.gz -C /opt/
    mv /opt/node-v0.12.7-linux-x64 /opt/node
    rm /tmp/node.tar.gz
    if ! grep -q "node.js" ~/.profile ; then
        echo "Adding node.js to .profile"
        echo "" >> ~/.profile
        echo "# Installed node.js and eslint" >> ~/.profile
        echo "export PATH=\$PATH:/opt/node/bin" >> ~/.profile
    fi
fi

export PATH=$PATH:/opt/node/bin
# Get node packages
for package in eslint
do
    if ! npm list -g $package ; then
        npm install -g $package
    fi
done
