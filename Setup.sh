#!/bin/bash
# Prepare development enviroment with empty spring project

##Upgrade system
echo "upgrade system start\n"
sudo apt-get update
sudo apt-get upgrade
echo "system updated\n"

##Java

sudo apt install openjdk-17-jdk -y
echo "jdk 17 installed\n"

##Validate git

echo "git"
git --version 2>&1 >/dev/null # improvement by tripleee
GIT_IS_AVAILABLE=$?
if [ $GIT_IS_AVAILABLE -eq 0 ]; then 
    echo " installation start\n"
    sudo apt install git -y
    else
    echo " is already installed\n"
fi

##Spring boot
echo "Cloning spring repo\n"

git clone https://github.com/spring-projects/spring-cli $HOME/temp/spring-cli

cd $HOME/temp/spring-cli

./gradlew clean build -x test

JARPATH=$(find $HOME/temp/spring-cli/build/libs -type f -name "spring-cli-0.*.0-SNAPSHOT.jar");

if [-z $JARPATH]; then 
    echo Error creating alias;
else
    echo path correcto;
    alias spring="java -jar $JARPATH";
    echo spring alias created successfully\n;
fi

# create project
cd $HOME;
spring boot new Store;

echo "To make permanent the aliar run: \"alias spring='java -jar $JARPATH'\""

echo "To run the project acces to root project file and type: \"mvnw spring-boot:run\""
