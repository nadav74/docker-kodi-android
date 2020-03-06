FROM ubuntu:16.04
MAINTAINER Nadav Rephaelli

VOLUME /root/kodi

RUN apt update && apt-get -y upgrade
RUN apt -y install autoconf build-essential curl default-jdk gawk git gperf lib32stdc++6 lib32z1 lib32z1-dev libcurl4-openssl-dev unzip zlib1g-dev unzip wget python

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN wget https://dl.google.com/android/repository/android-ndk-r20-linux-x86_64.zip

ENV HOME /root

RUN mkdir -p ${HOME}/android-tools/android-sdk-linux
RUN unzip sdk-tools-linux-4333796.zip -d ${HOME}/android-tools/android-sdk-linux
RUN unzip android-ndk-r20-linux-x86_64.zip -d ${HOME}/android-tools

RUN rm sdk-tools-linux-4333796.zip android-ndk-r20-linux-x86_64.zip


ENV SDKMANAGER_HOME ${HOME}/android-tools/android-sdk-linux/tools/bin

RUN ${SDKMANAGER_HOME}/sdkmanager --licenses
RUN ${SDKMANAGER_HOME}/sdkmanager platform-tools
RUN echo y | ${SDKMANAGER_HOME}/sdkmanager "platforms;android-28"
RUN echo y | ${SDKMANAGER_HOME}/sdkmanager "build-tools;28.0.3"

# 'Set up the arm toolchain' per Kodi documentation
RUN ${HOME}/android-tools/android-ndk-r20/build/tools/make-standalone-toolchain.sh --verbose --install-dir=${HOME}/android-tools/arm-linux-androideabi-vanilla/android-21 --platform=android-21 --toolchain=arm-linux-androideabi

RUN keytool -genkey -keystore ${HOME}/.android/debug.keystore -v -alias androiddebugkey -dname "CN=Android Debug,O=Android,C=US" -keypass android -storepass android -keyalg RSA -keysize 2048 -validity 10000

