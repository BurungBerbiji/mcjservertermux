#!/usr/bin/bash

eulagenerate() {
    echo "Generating EULA.."
    read -p "Do you agree to the Minecraft EULA? Please type True or False: " eulaStatus
    echo "eula=$eulaStatus"
    echo "Generating EULA Finished"

}

eulagenerate