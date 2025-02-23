#!/bin/bash

# Step 1: Pull the latest code (if using Git)
git pull origin main

# Step 2: Build the Docker image
docker build -t myphpapp .

# Step 3: Stop and remove existing container (if running)
docker stop myphpapp-container || true
docker rm myphpapp-container || true

# Step 4: Run the new container
docker run -d -p 8080:80 --name myphpapp-container myphpapp

# Step 5: Verify the deployment
sleep 5
curl http://localhost:8080

