#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Pixel4ScrCpy
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName my.scrcpy.pixel4

# Documentation:
# @raycast.author awenoo1
# @raycast.authorURL https://raycast.com/awenoo1

# Pixel4 XL Serial Number
export ANDROID_SERIAL=99031FFBA00CPX

if [ "$1" != "$ANDROID_SERIAL" ]; then
    echo "$@" > ~/Downloads/autoadb.txt
    echo "Unsupport param, detail in ~/Downloads/autoadb.txt"
    exit 1
fi

export ANDROID_SDK_ROOT=~/Library/Android/sdk
export ANDROID_HOME=${ANDROID_SDK_ROOT}
export PATH=${ANDROID_SDK_ROOT}/platform-tools:${PATH}

if ! which scrcpy > /dev/null; then
    if which brew > /dev/null; then
        brew install scrcpy
    fi
fi

if which scrcpy > /dev/null; then
    scrcpy -S -d -w -m 1140 --max-fps=20
else
    echo "Command 'scrcpy' not find in path: $PATH"
fi

