#!/bin/bash

# Setup frida server
set -x
adb root
adb remount
adb forward tcp:27043 tcp:27043
adb forward tcp:27042 tcp:27042
adb push $HOME/$FILENAME_FRIDASERVER /data/local/tmp/
adb shell "chmod 755 /data/local/tmp/$FILENAME_FRIDASERVER"
adb shell "nohup 2>&1 1&>/dev/null /data/local/tmp/$FILENAME_FRIDASERVER" &
set +x

