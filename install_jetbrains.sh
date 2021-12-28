DATAGRIP=/opt/datagrip
GOLAND=/opt/GoLand
IDEAIU=/opt/ideaIU

DATAGRIP_VERSION=2021.3.2
GOLAND_VERSION=2021.1.3
IDEA_VERSION=2021.1.3

if [ -z "$(ls -A $GOLAND)" ]; then
    wget https://download-cdn.jetbrains.com/go/goland-${GOLAND_VERSION}.tar.gz
    tar xvf goland-${GOLAND_VERSION}.tar.gz -C /opt
    rm -f goland-${GOLAND_VERSION}.tar.gz
    mv /opt/GoLand-${GOLAND_VERSION}/* ${GOLAND} 
    chmod -R o+rw ${GOLAND}*
    rm /opt/GoLand-${GOLAND_VERSION}/
    echo "Goland installed"
else 
    echo "Goland exist."
fi

if [ -z "$(ls -A $IDEAIU)" ]; then
    wget https://download-cdn.jetbrains.com/idea/ideaIU-${IDEA_VERSION}.tar.gz
    tar xvf ideaIU-${IDEA_VERSION}.tar.gz -C /opt
    rm -f ideaIU-${IDEA_VERSION}.tar.gz
    mv /opt/idea-IU-211.7628.21/* ${IDEAIU}
    chmod -R o+rw ${IDEAIU}
    echo "Intellij installed"
else 
    echo "Intellij exist."
fi

if [ -z "$(ls -A $DATAGRIP)" ]; then
    wget https://download.jetbrains.com/datagrip/datagrip-${DATAGRIP_VERSION}.tar.gz
    tar xvf datagrip-${DATAGRIP_VERSION}.tar.gz -C /opt
    rm -f datagrip-${DATAGRIP_VERSION}.tar.gz
    mv /opt/DataGrip-${DATAGRIP_VERSION}/* ${DATAGRIP} 
    chmod -R o+rw ${DATAGRIP} 
    echo "DATAGRIP installed"
else 
    echo "DATAGRIP exist."
fi
