#!/bin/bash

# Function to install make
install_make() {
    echo "Installing make..."
    sudo apt update && sudo apt install -y make
}

# Check if make is installed
if ! command -v make &> /dev/null; then
    echo "make is not installed. Attempting to install it..."
    install_make

    # Check if the installation was successful
    if ! command -v make &> /dev/null; then
        echo "Error: Failed to install make. Please install it manually."
        exit 1
    fi
fi

# Build the Docker image
echo "Building the Docker image..."
make build

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
else
    echo "Error: Docker image failed to build."
    exit 1
fi

# Run containers
echo "Running containers..."
make start

# Check if the container is running
if [ $? -eq 0 ]; then
    echo "Docker container is running successfully!"
else
    echo "Error: Docker container failed to start."
    exit 1
fi

# Wait for user confirmation to stop the running containers
while true; do
    read -p "Do you want to stop the running containers? (yes/no): " answer
    if [[ "$answer" == "yes" ]]; then
        echo "Stopping the running containers..."
        make stop
        
        # Check if the stop was successful
        if [ $? -eq 0 ]; then
            echo "Docker containers stopped successfully!"
        else
            echo "Error: Docker container failed to stop."
            exit 1
        fi
        break # Exit the loop after stopping
    elif [[ "$answer" == "no" ]]; then
        echo "Continuing to run the containers. Exiting the stop prompt."
        break # Exit the loop without stopping
    else
        echo "Invalid input. Please enter 'yes' or 'no'."
    fi
done
