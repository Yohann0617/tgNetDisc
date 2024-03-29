#!/bin/bash

if [ "$(dpkg --print-architecture)" = "amd64" ]; then
    dpkg -i /tmp/repo/amd/*.deb && apt-get install -f \
    && apt-get clean
elif [ "$(dpkg --print-architecture)" = "arm64" ]; then
    dpkg -i /tmp/repo/arm/*.deb && apt-get install -f \
    && apt-get clean
fi
