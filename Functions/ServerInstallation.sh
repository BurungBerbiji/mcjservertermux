#!/usr/bin/bash

ServerInstallation() {
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
            source ./DownloadList/vanilla_versions.sh
            echo "server.jar list for Vanilla"
            for version in "${!MINECRAFT_VERSIONS[@]}"; do
                echo "$version"
                echo ""
            done
            # Feels weird. but if it works, don't touch it right?
            echo "Secondly, enter your desired Version. For example, Type 1.17.1 or latest"
            read -p "Enter Version" version
            if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
                echo "Installing Minecraft $version"
                cd ~/MinecraftServer
                wget -O server.jar "${MINECRAFT_VERSIONS[$version]}"
            else
                echo "Invalid Version Selected"
            fi           
            echo "Done Downloading server.jar in MinecraftServer"
            ;;

        2 | Paper)
            echo "Paper Server selected..." && sleep 3
            echo "Select Server Version :"            
            source ./DownloadList/paper_versions.sh
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
            echo "Done Downloading server.jar in MinecraftServer"
            ;;

        3 | Spigot)
            source ./Functions/SpigotInstaller.sh
            ;;

        *)
            echo "Invalid Variant Selected"
            ;;
    esac

    clear
}

ServerInstallation