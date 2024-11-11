#!/bin/bash
sudo apt update -y
sudo apt install -y nodejs npm
node -v
npm -v
sudo npm install -g @angular/cli@16
ng version
ng serve