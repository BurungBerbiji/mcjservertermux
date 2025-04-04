#!/bin/bash

# Introduction
echo "Starting Installer"
sleep 5
read -p "Do You wish to Update Packages? YES/No" wouldUpdate
if [ $wouldUpdate != "No"]; then
    echo "Updating System.."
    pkg update && pkg upgrade -y
    echo "System Update Succesfully."
else
    echo "Skipping Updating Packages"
fi

clear


# Step 1/6
echo "Welcome to Minecraft Java Server Installer."
sleep 5

clear


# Step 2/6
read -p "Have You already use the termux-setup-storage y/N" tssStatus
sleep 2
if [ $tssStatus != "y"]; then
   echo "Starting termux-setup-storage" && sleep 2
   termux-setup-storage
   echo "Setup Completed."
   echo "Ignore the error."
else
    echo "termux-setup-storage skipped" && sleep 1
fi

clear


# Step 3/6
echo "Starting Storage Setup" sleep 3
mkdir -p ~/storage/shared/MinecraftServer
ln -s ~/storage/shared/MinecraftServer MinecraftServer
echo "Storage Setup Done"

clear


# Step 4/6
echo "Starting Server Installation"
sleep 3
echo "Minecraft Java server.jar List"
echo "Server Type"
echo "1. Vanilla"
echo "2. Paper"
echo "3. Spigot"
echo -e "First. Please select Server Type : \n example : Enter 1 or Vanilla to select Vanilla as Server Type"
read -p "Server Type : " variant
case $variant in
    1 | Vanilla)
        echo "Vanilla Server selected..." && sleep 3
        echo "Select Server Version :"
        # Thanks AI, but the code looks messy
        source ./vanilla_versions.sh
        for version in "${!MINECRAFT_VERSIONS[@]}"; do
            echo "$version"
            echo ""
        done
        # Feels weird. but if it works, don't touch it right?
        echo "Secondly, enter your desired Version. For example, Type 1.17.1"
        read -p "Enter Version" version
        if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
            echo "Installing Minecraft $version"
            cd ~/MinecraftServer
            wget -O server.jar "${MINECRAFT_VERSIONS[$version]}"
        else
            echo "Invalid Version Selected"
        fi
        # Thanks AI, but the code is messy
        echo "Done Downloading server.jar in MinecraftServer"
        ;;

    2 | Paper)
        echo "Paper Server selected..." && sleep 3
        echo "Select Server Version :"
        # Thanks AI, but the code looks messy
        source ./paper_versions.sh
        for version in "${!MINECRAFT_VERSIONS[@]}"; do
            echo "$version"
            echo ""
        done
        # Feels weird. but if it works, don't touch it right?
        echo "Secondly, enter your desired Version. For example, Type 1.17.1"
        read -p "Enter Version" version
        if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
            echo "Installing Paper $version"
            cd ~/MinecraftServer
            wget -O server.jar "${MINECRAFT_VERSIONS[$version]}"
        else
            echo "Invalid Version Selected"
        fi
        # Thanks AI, but the code is messy
        echo "Done Downloading server.jar in MinecraftServer"
        ;;


    3 | Spigot)
        echo "Spigot Server selected..." && sleep 3
        echo "Select Server Version :"
        # Thanks AI, but the code looks messy
        source ./spigot_versions.sh
        for version in "${!MINECRAFT_VERSIONS[@]}"; do
            echo "$version"
            echo ""
        done
        # Feels weird. but if it works, don't touch it right?
        echo "Secondly, enter your desired Version. For example, Type 1.17.1"
        read -p "Enter Version" version
        if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
            echo "Installing Spigot $version"
            cd ~/MinecraftServer
            wget -O server.jar "${MINECRAFT_VERSIONS[$version]}"
        else
            echo "Invalid Version Selected"
        fi
        # Thanks AI, but the code is messy
        echo "Done Downloading server.jar in MinecraftServer"
        ;;

     *)
        echo "Invalid Variant Selected"
        ;;
esac

clear


# Step 5/6
echo "Generating EULA.."
read -p "Do you agree to the Minecraft EULA? Please type True or False: " eulaStatus
echo "eula=$eulaStatus"
echo "Generating EULA Finished"


echo "Generating Startup JVM Args"
mkdir -p ~/.MCJavaST
read -p "Enter the amount of RAM you want to allocate to the server (in MB): " ram
echo -e "#!/bin/bash \n cd ~/minecraft_server \n java -Xms${ram}M -Xmx${ram}M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui" > ~/.MCJavaST/StartMCServer

clear


# Step 6/6
# Define the path to the setup.sh script
SCRIPT_PATH=~/.MCJavaST/StartMCServer

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

clear


# Step Finished/6

read -p "Finished, Reopen Termux. and Type StartMCServer to start MC Server" exit
