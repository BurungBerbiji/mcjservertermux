#!/usr/bin/bash

SpigotInstaller() {
    spigotbuildtools="https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"

    echo "Installing depedencies..."
    pkg install git openjdk-21 -y
    cd ~/storage/shared/MinecraftServer
#    mkdir BuildTools && cd BuildTools
    wget -O BuildTools.jar $spigotbuildtools && java -jar BuildTools.jar --final-name server.jar
    
    
}

SpigotInstaller