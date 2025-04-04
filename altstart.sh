#!/bin/bash

# Beware, this code is very messy and not optimized. I'm not a professional programmer, so please don't judge me. I'm just a student who is learning programming. I'm open to any suggestions and feedback. Thank you.
# Hihahaha
echo "Minecraft Server Setup Script for Arm64 Devices"
sleep 3
echo "Welcome to Minecraft Server Setup Script"
sleep 1
echo "This script will install the required dependencies to run a Minecraft server on your device."
sleep 1
echo "Internet connection is required to download the server jar."
sleep 1
echo "WARNING: Do not execute this script using Universal Version of Termux. As it will give a permission denied error."
sleep 5

# Updating & Installing dependencies
echo "Updating system packages and installing wget"
pkg upgrade -y && pkg install wget -y 
sleep 2 
clear
echo "System packages updated successfully"
sleep 2

# Setting up storage permission
read -p "Have you already used termux-setup-storage? (yes/NO): " storage_setup_done

if [ "$storage_setup_done" != "yes" ]; then
    echo "Setting up storage permission"
    termux-setup-storage 

    # Initialize counter and set timeout limit (e.g., 10 attempts)
    counter=0
    timeout=10

    while true; do
        if [ -d ~/storage/shared ]; then
            echo "Storage permission granted."
            break
        else
            echo "Storage permission denied. Attempt $((counter+1)) of $timeout."
        fi
        
        # Increment counter and check if timeout is reached
        counter=$((counter+1))
        if [ $counter -ge $timeout ]; then
            echo "Timeout reached. Please grant storage permission manually."
            break
        fi
        
        sleep 3
    done
else
    echo "Skipping storage permission setup."
fi

# Creating links for the Minecraft Server Directory with termux home directory
mkdir -p ~/storage/shared/minecraft_server
echo "Making a shortcut for the Minecraft Server Directory with termux home directory"
sleep 1
ln -s ~/storage/shared/minecraft_server ~/minecraft_server
clear

# Selecting Variant
echo "Select the variant you want to install"
echo "1. Vanilla"
echo "2. Paper"
echo "3. Spigot"
read -p "Enter the variant number: " variant

# Selecting Variant on Selected Variant
case $variant in
    1)
        echo "Vanilla Server Selected"
        sleep 3
        source ./vanilla_versions.sh
        echo "Making Directory for Minecraft Server in ~/storage/shared"
        cd ~/storage/shared/minecraft_server
        sleep 3
        echo "Installing Vanilla Server"
        sleep 1
        echo "Select Minecraft Version"
        for version in "${!MINECRAFT_VERSIONS[@]}"; do
            echo "$version"
        done
        read -p "Enter the version number: " version
        if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
            echo "Installing Minecraft $version"
            wget -O server.jar "${MINECRAFT_VERSIONS[$version]}" 
        else
            echo "Invalid Version Selected"
        fi
        ;;
    2)
        echo "Paper Server selected, Installing Paper Server..."
        source ./paper_versions.sh
        echo "Making Directory for Minecraft Server in ~/storage/shared"
        cd ~/storage/shared/minecraft_server
        echo "Installing Paper Server"
        echo "Select Minecraft Version"
        for version in "${!MINECRAFT_VERSIONS[@]}"; do
            echo "$version"
        done
        read -p "Enter the version number: " version
        if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
            echo "Installing Minecraft $version"
            wget -O server.jar "${MINECRAFT_VERSIONS[$version]}" 
        else
            echo "Invalid Version Selected"
        fi
        ;;
    3)
        echo "Installing Spigot Server"
        source ./spigot_versions.sh
        echo "Making Directory for Minecraft Server in ~/storage/shared"
        cd ~/storage/shared/minecraft_server
        echo "Installing Spigot Server"
        echo "Select Minecraft Version"
        for version in "${!MINECRAFT_VERSIONS[@]}"; do
            echo "$version"
        done
        read -p "Enter the version number: " version
        if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
            echo "Installing Minecraft $version"
            wget -O server.jar "${MINECRAFT_VERSIONS[$version]}" 
        else
            echo "Invalid Version Selected"
        fi
        ;;
    *)
        echo "Invalid Variant Selected"
        ;;
esac

# Installing Java
echo "Installing Java 21. Sadly, Java 8 is not available in termux repositories so you must find an alternative way to install it."
pkg install openjdk-21 -y

# Running the Minecraft Server
echo "Making EULA file"
read -p "Do you agree to the Minecraft EULA? (yes/no): " eula_agree

if [ "$eula_agree" == "yes" ]; then
    echo "eula=true" > eula.txt
    echo "Generating Startup JVM Args"
else
    echo "You must agree to the EULA to run the server."
    sleep 1
    echo "You need to edit the eula.txt file to agree to the EULA"
    sleep 1
fi

echo "Generating Startup JVM Args"
mkdir -p ~/.MCJavaST
read -p "Enter the amount of RAM you want to allocate to the server (in MB): " ram
echo -e "#!/bin/bash \n cd ~/minecraft_server \n java -Xms${ram}M -Xmx${ram}M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui" > ~/.MCJavaST/StartMCServer

# Define the path to the setup.sh script
SCRIPT_PATH="~/.MCJavaST/StartMCServer"

# Make the script executable
chmod +x "$SCRIPT_PATH"

# Define the directory to add to PATH
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# Check if the script directory is already in PATH
if [[ ":$PATH:" != *":$SCRIPT_DIR:"* ]]; then
    # Add the script directory to PATH in .bashrc
    echo "export PATH=\"\$PATH:$SCRIPT_DIR\"" >> "$HOME/.bashrc"
    echo "Added $SCRIPT_DIR to PATH in .bashrc"
else
    echo "$SCRIPT_DIR is already in PATH"
fi

# Reload .bashrc to apply changes
source "$HOME/.bashrc"

echo "adding StartMCServer to PATH in .bashrc successfully."

sleep 3

echo "Setup Completed"
sleep 1
echo "You can now start the server by running StartMCServer anywhere."
sleep 1
echo "Don't forget to edit the server.properties file to customize your server settings"
sleep 1
echo "Thanks for using the script"
sleep 1
read -p "Press enter to exit"