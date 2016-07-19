#!/bin/bash
echo "Please enter the environment you would like to create, enter PROD or TRAINING"
read environment
cd "$(dirname "$0")"
source SetEnvironment.sh $environment
echo $ENVIRONMENT_TYPE
read -p "Press [Enter] key to start machine creation..."
cd "$(dirname "$0")"
vagrant up webserver
vagrant up staticcontent
