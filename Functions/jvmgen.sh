#!/usr/bin/bash

# Script using Aikar's Flags to Optimize Server

jvmgen() {
    echo "Generating Startup JVM Args"
    read -p "Enter the amount of RAM you want to allocate to the server (in MB): " ram
    echo -e "#!/bin/bash \n cd ~/minecraft_server \n java -Xms${ram}M -Xmx${ram}M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui" > ~/.MCJavaST/StartMCServer

clear
}

jvmgen