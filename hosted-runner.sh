#!/bin/bash

# Run system update to refresh the package list
apt-get update

# Install curl, a tool for transferring data with URLs
apt install curl -y

# Install tar, a tool for archiving files
apt install tar -y

# Github Hosted Runner
# Create a directory named 'actions-runner' and navigate into it
mkdir actions-runner && cd actions-runner

# Download the latest GitHub Actions runner package
curl -o actions-runner-linux-x64-2.316.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.316.0/actions-runner-linux-x64-2.316.0.tar.gz

# Optional: Validate the hash of the downloaded file to ensure integrity
echo "d62de2400eeeacd195db91e2ff011bfb646cd5d85545e81d8f78c436183e09a8 actions-runner-linux-x64-2.316.0.tar.gz" | shasum -a 256 -c

# Extract the downloaded runner package
tar xzf ./actions-runner-linux-x64-2.316.0.tar.gz

# Create the runner and start the configuration process
# Allow the runner to run as root
export RUNNER_ALLOW_RUNASROOT="1"
# Set the server name for identification
export SERVERNAME="chat-easypark-deploy"
# Configure the runner with the specified repository URL and token, setting the runner name and labels
./config.sh --url https://github.com/Frnn4268/EasyParkChat --token AOOGFR6P5SCS2ERFZW3PXETGLEUOK --name webserver-$(echo $SERVERNAME) --labels $(echo $SERVERNAME) --unattended

# The final step: run the GitHub Actions runner in the background
nohup ./run.sh > /dev/null 2>&1 &