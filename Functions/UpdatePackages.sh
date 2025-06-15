#!/usr/bin/bash

UpdatePackages() {
    echo "Starting Installer"
    sleep 5
    read -p "Do You wish to Update Packages? YES/No : " wouldUpdate
    if [ $wouldUpdate != "No"]; then
        echo "Updating System.."
        #pkg update && pkg upgrade -y
        echo "System Update Succesfully."
    else
        echo "Skipping Updating Packages"
    fi

clear

}

UpdatePackages >/dev/null