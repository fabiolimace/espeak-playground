#!/bin/bash

sudo echo && \
cd ~/git/espeak-br && \
cmake -Bbuild -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON && \
cmake --build build && \
cmake --build build --target data && \
sudo cmake --install build

