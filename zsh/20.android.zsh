#!/usr/bin/env zsh

if [[ -d /usr/local/share/android-sdk ]]; then
  export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
fi

export ANDROID_HOME="$HOME/.android"
