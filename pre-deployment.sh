#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e
# Pipefail ensures the entire pipeline fails if any command within it fails
set -o pipefail

# Update the list of available packages and their versions
apt-get update &&

# Install curl, a tool for transferring data with URLs
apt install curl -y &&

# Install tar, a tool for archiving files
apt install tar -y &&

## Install Node.js

# Check the available versions of Node.js
apt policy nodejs &&

# Install Node.js and NPM (Node Package Manager)
apt-get install nodejs -y &&
apt install npm -y &&

# Install Nginx, a high-performance web server
apt-get install nginx -y &&

# Start the Nginx service
service nginx start &&

# Enable Nginx to start on system boot
systemctl enable nginx &&

# Install nano, a text editor
apt-get install nano -y &&

# Install PM2, a process manager for Node.js applications
npm install pm2 -g &&

# Configure PM2 to start the Express application at system startup for the user 'ubuntu'
env PATH=$PATH:/usr/local/bin pm2 startup -u ubuntu &&

# Start to listening in port 4000, start the created Node.js server using PM2 and name it 'backend'
echo "const http = require('http'); const server = http.createServer((req, res) => { res.statusCode = 200; res.setHeader('Content-Type', 'text/plain'); res.end('Hello, World!'); }); server.listen(4000, () => { console.log('Server running at http://localhost:3000/'); });" > hello-world.js && pm2 start hello-world.js --name backend &&

# Clone the EasyParkChat repository from GitHub
git clone https://github.com/Frnn4268/EasyParkChat.git &&
# Change directory to EasyParkChat
cd EasyParkChat &&
# Change directory to the 'public' folder within EasyParkChat
cd public &&

# Deploying frontend for the first time
# Set environment variables for the frontend
echo REACT_APP_API_URL="${backend_url}:4000" > .env &&
echo REACT_APP_LOCALHOST_KEY="chat-app-current-user" >> .env &&

# Install dependencies for the frontend
npm install &&
# Build the frontend application
npm run build &&
# Set permissions for the Nginx html directory
chmod 777 /var/www/html -R &&
# Remove existing files in the Nginx html directory
rm -rf /var/www/html/* &&
# Copy the built frontend files to the Nginx html directory
scp -r ./build/* /var/www/html &&

# Restart the Nginx service to apply changes
systemctl restart nginx &&

# Deploying backend for the first time
# Move back to the root of the repository
cd .. && 
# Change directory to the 'server' folder within EasyParkChat
cd server &&
# Set environment variables for the backend
echo MONGO_URL="mongodb+srv://Frnn:@mongocluster.o2eojyk.mongodb.net/snappy?retryWrites=true&w=majority" > .env &&

# Install dependencies for the backend
npm install &&
# Remove the existing 'backend' PM2 process
pm2 delete backend &&
# Start the backend application using PM2 and name it 'backend'
pm2 start index.js --name backend