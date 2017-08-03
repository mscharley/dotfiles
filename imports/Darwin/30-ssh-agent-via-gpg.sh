#!/usr/bin/env bash

# Disable the OS X ssh-agent.
sudo launchctl disable /System/Library/LaunchAgents/org.openbsd.ssh-agent.plist
sudo launchctl unload /System/Library/LaunchAgents/org.openbsd.ssh-agent.plist
