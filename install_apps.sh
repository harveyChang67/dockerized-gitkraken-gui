#!/bin/sh
cd /src

DATAGRIP=/opt/Datagrip
GOLAND=/opt/GoLand
IDEAIU=/opt/ideaIU

DATAGRIP_VERSION=2021.3.2
GOLAND_VERSION=2021.1.3
IDEA_VERSION=2021.1.3

install_datagrip()
{
    if [ -z "$(ls -A $DATAGRIP)" ]; then
        wget https://download.jetbrains.com/datagrip/datagrip-${DATAGRIP_VERSION}.tar.gz -P /opt
        tar xvf /opt/datagrip-${DATAGRIP_VERSION}.tar.gz -C /opt
        rm -f datagrip-${DATAGRIP_VERSION}.tar.gz
        mkdir ${DATAGRIP}
        mv /opt/DataGrip-${DATAGRIP_VERSION}/* ${DATAGRIP}
        rm -r /opt/DataGrip-${DATAGRIP_VERSION}
        chmod -R o+rw ${DATAGRIP}
        echo "DATAGRIP installed"
    else 
        echo "DATAGRIP exist."
    fi
}

install_goland()
{
    if [ -z "$(ls -A $GOLAND)" ]; then
        wget https://download-cdn.jetbrains.com/go/goland-${GOLAND_VERSION}.tar.gz -P /opt
        tar xvf /opt/goland-${GOLAND_VERSION}.tar.gz -C /opt
        rm -f goland-${GOLAND_VERSION}.tar.gz
        mkdir ${GOLAND}
        mv /opt/GoLand-${GOLAND_VERSION}/* ${GOLAND} 
        rm -r /opt/GoLand-${GOLAND_VERSION}
        chmod -R o+rw ${GOLAND}*
        echo "Goland installed"
    else 
        echo "Goland exist."
    fi
}

install_ideaiu()
{
    if [ -z "$(ls -A $IDEAIU)" ]; then
        wget https://download-cdn.jetbrains.com/idea/ideaIU-${IDEA_VERSION}.tar.gz -P /opt
        tar xvf /opt/ideaIU-${IDEA_VERSION}.tar.gz -C /opt
        rm -f ideaIU-${IDEA_VERSION}.tar.gz
        mkdir ${IDEAIU}
        mv /opt/idea-IU-211.7628.21/* ${IDEAIU}
        rm -r /opt/idea-IU-211.7628.21
        chmod -R o+rw ${IDEAIU}
        echo "Intellij installed"
    else 
        echo "Intellij exist."
    fi
}

# function to show menu
show_menu()
{
       clear
       echo "++++++++++++ MENU +++++++++++++"
       echo "1. Install DataGrip."
       echo "2. Install GoLand."
       echo "3. install IdeaIu."
       echo "f. Exit"
       echo "+++++++++++++++++++++++++++++++"
}

# function to take input
take_input()
{
        #take the input and store it in choice variable
       local choice
       read -p "Select the option from above menu: " choice
        
        #using switch case statement check the choice and call function.
       case $choice in
               1) install_datagrip ;;
               2) install_goland ;;
               3) install_ideaiu ;;
               f) exit 0;;
               *) echo "Enter Valid Option!!"
                       read -p "Press any key to Continue...."

               esac
       }

# for loop to call the show_menu and take_input function.
while true
do
       show_menu
       take_input
done
