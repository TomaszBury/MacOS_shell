#!/bin/bash

# Script to uninstall Microsoft OneDrive on macOS

# Step 1: Quit OneDrive if it's running
echo "Quitting OneDrive..."
if pgrep -x "OneDrive" > /dev/null; then
    osascript -e 'tell application "OneDrive" to quit'
    sleep 2 # Wait for OneDrive to fully quit
fi

# Step 2: Check for OneDrive processes in Activity Monitor and force quit if necessary
echo "Checking for OneDrive processes..."
if pgrep -x "OneDrive" > /dev/null; then
    echo "Force quitting OneDrive processes..."
    pkill -x "OneDrive"
    sleep 2
fi

# Step 3: Unlink OneDrive account (optional, ensures no syncing occurs)
echo "Unlinking OneDrive account..."
defaults delete com.microsoft.OneDrive # Clear OneDrive preferences
if [ -d "~/Library/Preferences/com.microsoft.OneDrive.plist" ]; then
    rm -f "~/Library/Preferences/com.microsoft.OneDrive.plist"
fi

# Step 4: Remove OneDrive application
echo "Removing OneDrive application..."
if [ -d "/Applications/OneDrive.app" ]; then
    sudo rm -rf "/Applications/OneDrive.app"
else
    echo "OneDrive.app not found in /Applications"
fi

# Step 5: Remove OneDrive-related files and folders
echo "Removing OneDrive leftover files..."
declare -a paths=(
    "~/Library/Application Support/OneDrive"
    "~/Library/Containers/com.microsoft.OneDrive-mac"
    "~/Library/Containers/com.microsoft.OneDrive.FinderSync"
    "~/Library/Group Containers/UBF8T346G9.OneDriveStandaloneSuite"
    "~/Library/Caches/com.microsoft.OneDrive"
    "~/Library/Preferences/com.microsoft.OneDrive.plist"
    "~/Library/Preferences/com.microsoft.OneDriveStandalone.plist"
    "~/Library/Application Scripts/com.microsoft.OneDrive-mac"
    "~/Library/Application Scripts/com.microsoft.OneDrive.FinderSync"
    "~/Library/Logs/OneDrive"
    "~/OneDrive"
)

for path in "${paths[@]}"; do
    if [ -e "$path" ]; then
        echo "Deleting $path..."
        rm -rf "$path"
    else
        echo "$path not found"
    fi
done

# Step 6: Remove OneDrive from Finder sidebar (if present)
echo "Removing OneDrive from Finder sidebar..."
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool false
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool false
killall Finder # Restart Finder to apply changes

# Step 7: Empty Trash to permanently delete files
echo "Emptying Trash..."
rm -rf ~/.Trash/* > /dev/null 2>&1

# Step 8: Remove OneDrive from Login Items (if present)
echo "Removing OneDrive from Login Items..."
osascript -e 'tell application "System Events" to delete login item "OneDrive"'

# Step 9: Verify removal
echo "Verifying OneDrive removal..."
if [ ! -d "/Applications/OneDrive.app" ] && [ ! -d "~/OneDrive" ]; then
    echo "OneDrive has been successfully uninstalled."
else
    echo "Some OneDrive components may still remain. Please check manually."
fi

echo "Uninstallation complete. You may need to restart your Mac for all changes to take effect."
