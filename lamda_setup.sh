#!/bin/bash

function lamda_server_start() {
    echo Lamda starting
    # adb shell "nohup 2>&1 1&>/dev/null sh /data/local/tmp/arm64-v8a/bin/launch.sh" &
adb shell << EOF
    sh /data/local/tmp/arm64-v8a/bin/launch.sh
    exit
EOF
}

function lamda_server_setup_then_start() {
    echo Lamda setup
    adb push $HOME/$FILENAME_LAMDA /data/local/tmp
    # adb shell "nohup 2>&1 1&>/dev/null sh /data/local/tmp/$FILENAME_LAMDA" &
adb shell << EOF
    sh /data/local/tmp/$FILENAME_LAMDA
    exit
EOF
}

function lamda_server_setup() {
    local exists=`adb shell "[ -f /data/local/tmp/arm64-v8a/bin/launch.sh ] || echo 1"`
    if [ -z "$exists" ]; then
        echo "Lamda exists";
        lamda_server_start
    else
        echo "Lamda doesn't exist";
        lamda_server_setup_then_start
    fi
}

function lamda_server_clean() {
    rm -rf /data/local/tmp/arm64-v8a
    rm -rf /data/usr
}

adb root

lamda_server_setup &
pip3 install -U lamda -q 1>/dev/null
echo Waiting lamda server up...
wait

