#!/bin/bash

echo "Welcome to Minecraft Java Server Installer."
sleep 5

clear
# Simplifies the Script by breaking into several parts saved in Funtions/
source ./Function/UpdatePackages.sh
source ./Function/StorageSetup.sh
source ./Function/ServerInstallation.sh
source ./Function/EULA.sh
source ./Function/jvmgen.sh

read -p "Finished, Reopen Termux. and Type StartMCServer to start MC Server" exitscript
