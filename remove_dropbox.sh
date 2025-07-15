#!/bin/bash
# Quit Dropbox
pkill -f Dropbox
# Uninstall Dropbox app
rm -rf /Applications/Dropbox.app
# Remove Dropbox folder and configs
rm -rf ~/Dropbox ~/.dropbox
# Empty Trash
rm -rf ~/.Trash/Dropbox.app
