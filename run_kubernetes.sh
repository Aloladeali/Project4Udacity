#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath="alolade/projectfour:v1.0.0"

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run projectfour --image=alolade/projectfour:v1.0.0 --port=80 --labels app=projectfour


# Step 3:
# List kubernetes 
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward projectfour 8000:80

