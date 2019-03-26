This repository provides an easy to set up build environment for Kodi 18.*-Leia for Android.
Note: at this moment this has only been tested for the ARM platform.
Note: this was only tested on 18.0 and forth and will NOT be tested for 18 beta or RC versions.

Prerequisite: install Docker Engine from here:
https://www.docker.com/products/docker-engine

Instructions:
1. Run the following command to build the Docker image:
   docker build -t kodi .
   And go take a coffee or something. On my computer it takes 25 minutes.

2. Clone a fresh copy of Kodi from Github. You should probably do this parallel to step 1.
   If you checkout another version after a full build, your new build will fail at some point.
   If you know how to fix this, please do!

3. Run the following command to start a shell on the container assuming you cloned Kodi to
   ~/github/xbmc (the ID could also just be "kodi"):
   docker run -v ~/github/xbmc:/source -it <id_from_last_step> /bin/bash

4. Start step 5 from here:
   https://github.com/xbmc/Xbmc/blob/master/docs/README.Android.md#5-build-tools-and-dependencies
   with the following notes:
   - NDK is r18b, not r18, since r18 is no longer available for download.
   - Add "--enable-debug=no" for a release build.
   - Note that your sources are located under /source on the container, not under $HOME.
   So, for ARM:
   ./configure --with-tarballs=$HOME/android-tools/xbmc-tarballs \
       --host=arm-linux-androideabi --with-sdk-path=$HOME/android-tools/android-sdk-linux \
       --with-ndk-path=$HOME/android-tools/android-ndk-r18b \
       --with-toolchain=$HOME/android-tools/arm-linux-androideabi-vanilla/android-21 \
       --prefix=$HOME/android-tools/xbmc-depends --enable-debug=no
