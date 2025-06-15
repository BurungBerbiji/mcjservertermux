#!/usr/bin/bash

TermuxSetupStorage() {
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
}

ServerStorageSetup() {
    # Part 1/2
    echo "Starting Storage Setup" sleep 3
    mkdir -p ~/storage/shared/MinecraftServer
    ln -s ~/storage/shared/MinecraftServer MinecraftServer
    echo "Storage Setup Done"
    echo "Creating Folder on Termux home directory"1
    
    
    # Part 2/2
    mkdir -p ~/.MCJavaST
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

}

TermuxSetupStorage
ServerStorageSetup >/dev/null

