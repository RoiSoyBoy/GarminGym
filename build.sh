#!/bin/bash

# Set the path to the Connect IQ SDK
sdk_path="C:/Users/roi hatipesh/AppData/Roaming/Garmin/ConnectIQ/Sdks/connectiq-sdk-win-8.2.1-2025-06-19-f69b94140"

# Set the output directory for the compiled application
output_dir="bin"

# Set the name of the application
app_name="GymTracker"

# Clean the output directory
rm -rf "$output_dir"
mkdir -p "$output_dir"

# Compile the application
monkeyc -o "$output_dir/$app_name.prg" -f monkey.jungle

# Build the application package
monkeydo "$output_dir/$app_name.prg" -o "$output_dir/$app_name.iq"

echo "Build complete. The application package is located at $output_dir/$app_name.iq"
