DATAGRIP=/opt/Datagrip
GOLAND=/opt/GoLand
IDEAIU=/opt/ideaIU

DATAGRIP_VERSION=2021.3.2
GOLAND_VERSION=2021.1.3
IDEA_VERSION=2021.1.3

if [ -z "$(ls -A $GOLAND)" ]; then
    wget https://download-cdn.jetbrains.com/go/goland-${GOLAND_VERSION}.tar.gz
    tar xvf goland-${GOLAND_VERSION}.tar.gz -C /opt
    rm -f goland-${GOLAND_VERSION}.tar.gz
    mkdir ${GOLAND}
    mv /opt/GoLand-${GOLAND_VERSION}/* ${GOLAND} 
    rm -r /opt/GoLand-${GOLAND_VERSION}
    chmod -R o+rw ${GOLAND}*
    echo "Goland installed"
else 
    echo "Goland exist."
fi

if [ -z "$(ls -A $IDEAIU)" ]; then
    wget https://download-cdn.jetbrains.com/idea/ideaIU-${IDEA_VERSION}.tar.gz
    tar xvf ideaIU-${IDEA_VERSION}.tar.gz -C /opt
    rm -f ideaIU-${IDEA_VERSION}.tar.gz
    mkdir ${IDEAIU}
    mv /opt/idea-IU-211.7628.21/* ${IDEAIU}
    rm -r /opt/idea-IU-211.7628.21
    chmod -R o+rw ${IDEAIU}
    echo "Intellij installed"
else 
    echo "Intellij exist."
fi

if [ -z "$(ls -A $DATAGRIP)" ]; then
    wget https://download.jetbrains.com/datagrip/datagrip-${DATAGRIP_VERSION}.tar.gz
    tar xvf datagrip-${DATAGRIP_VERSION}.tar.gz -C /opt
    rm -f datagrip-${DATAGRIP_VERSION}.tar.gz
    mkdir ${DATAGRIP}
    mv /opt/DataGrip-${DATAGRIP_VERSION}/* ${DATAGRIP}
    rm -r /opt/DataGrip-${DATAGRIP_VERSION}
    chmod -R o+rw ${DATAGRIP}
    echo "DATAGRIP installed"
else 
    echo "DATAGRIP exist."
fi

# Skype
if [ -z "$(ls -A /usr/bin/skypeforlinux)" ]; then
    apt-get update
    apt-get install -y sudo gnupg2
    curl -s https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
    echo "deb https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skypeforlinux.list
    apt update -y
    apt install -y skypeforlinux
    echo "Skype installed"
else 
    echo "Skype exist."
fi


# # customize which gui application to run
if [ -z "$(ls -A /usr/bin/gitkraken)" ]; then
    apt-get update -y
    apt-get install -y --no-install-recommends wget keepassxc firefox-esr
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb  -P /tmp
    apt install -y gconf2 gconf-service libgtk2.0-0 libnotify4 libnss3 gvfs-bin xdg-utils libxss1 libasound2 procps libgbm-dev
    dpkg -i /tmp/gitkraken-amd64.deb
    rm -rf /tmp/gitkraken-amd64.deb
    rm -rf /var/lib/apt/lists
    echo "gitkraken installed"
else 
    echo "gitkraken exist."
fi

# adds firefox (sometimes required to authenticate with gitkraken tokens)
# RUN apt-get update -y &&  apt install -y --no-install-recommends firefox-esr && rm -rf /var/lib/apt/lists

# adds chromium 
# RUN apt-get update -y &&  apt install -y --no-install-recommends chromium chromium-sandbox && rm -rf /var/lib/apt/lists

# adds meld - gui diff tool 
# RUN apt-get update -y &&  apt install -y --no-install-recommends meld && rm -rf /var/lib/apt/lists

# install vscode (for smooth remote container development)
# RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
#     && install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ \
#     && sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
#     && apt update \
#     && apt install -y apt-transport-https \
#     && apt install code \
#     && rm -rf /var/lib/apt/lists
