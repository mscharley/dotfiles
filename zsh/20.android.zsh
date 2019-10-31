#!/usr/bin/env zsh

if [[ -d /usr/local/share/android-sdk ]]; then
  ANDROID_SDK_ROOT=/usr/local/share/android-sdk
fi

if [[ -d $HOME/Library/Android/sdk ]]; then
  ANDROID_HOME="$HOME/Library/Android/sdk"
else
  ANDROID_HOME="${XDG_CONFIG_HOME:-$HOME/opt}/android"
fi

append-path $ANDROID_HOME/platform-tools/
