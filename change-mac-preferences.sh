#!/bin/bash

# -----------------------------------------------------------------------------
#
# This script configures macOS preferences
#
# Changelog:
# - 09 Oct 2022: Init
# - 10 Oct 2022: Configure Finder
#
# References
# - https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# - https://github.com/pawelgrzybek/dotfiles/blob/master/setup-macos.sh
# - https://macos-defaults.com/
#
# -----------------------------------------------------------------------------


# The following system preferences need system reboot to take effect
configure_system_preferences_trackpad() {
  # Enable tag-to-click
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

  # Enable tap to click for this user and for the login screen
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -bool true
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -bool true

  # Enable three-finger-drag
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
}

# The following settings require restart of Terminal app
configure_builtin_terminal() {
  defaults write com.apple.Terminal "Default Window Settings" -string Pro
  defaults write com.apple.Terminal "Startup Window Settings" -string Pro
}

# The following settings require system reboot
configure_finder() {
  # Show all filename extensions
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  # Show external hard drives on desktop
  defaults write com.apple.Finder ShowExternalHardDrivesOnDesktop -bool true
  # Show removable media on desktop
  defaults write com.apple.Finder ShowRemovableMediaOnDesktop -bool true
  # Show the warning before emptying the Trash
  defaults write com.apple.Finder WarnOnEmptyTrash -bool true
  # Remove items from bin after 30 days
  defaults write com.apple.Finder FXRemoveOldTrashItems -bool true
  # Keep folders on top - In windows when sorting by name
  defaults write com.apple.Finder _FXSortFoldersFirstOnDesktop -bool true
  # Show file full path in Finder
  defaults write com.apple.Finder ShowPathbar -bool true
  # Display a warning when changing a file extension in the Finder
  defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool true
  # disable .DS_Store
  defaults write com.apple.desktopservices DSDontWriteNetworkStores true
}

# Do not require system reboot
configure_menu_bar() {
  # Set digital clock format to "EEE d MMM HH:mm:ss", e.g., Thu 18 Aug 21:46:18
  defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""
}




# -----------------------------------------------------------------------------
#
# -------- Main --------
#
# Configure Trackpad
configure_system_preferences_trackpad

# Configure Terminal
configure_builtin_terminal

# Configure Finder
configure_finder

# Configure Menu bar
configure_menu_bar
#
# -------- End of Main --------
# -----------------------------------------------------------------------------
