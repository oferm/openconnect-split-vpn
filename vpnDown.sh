#!/bin/bash

if [[ $EUID != 0 ]]; then
    echo "not sudo!"
    exit 1
fi

killall openconnect
