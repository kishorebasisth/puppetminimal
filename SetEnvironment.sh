#!/bin/bash
#echo "Which environment are you planning to create enter either PROD or TRAINING"
environment=$1
echo "$environment will be set as your default environment, if you would like to change it re-run the script"
export ENVIRONMENT_TYPE=$environment
