#!/usr/bin/env zsh

if [[ -d /usr/local/share/android-sdk ]]; then
  export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
fi

append-path $ANDROID_HOME/platform-tools/
