#!/usr/bin/env zsh

if [[ -d /usr/local/share/android-sdk ]]; then
  export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
fi

if [[ -d $HOME/Library/Android/sdk ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
else
  export ANDROID_HOME="$HOME/.android"
fi
