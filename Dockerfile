FROM openjdk:8-jdk

ENV ANDROID_HOME /opt/android-sdk

ENV ANDROID_COMPILE_SDK 29
ENV ANDROID_BUILD_TOOLS 29.0.2
ENV ANDROID_SDK_TOOLS 4333796

RUN mkdir /opt/android-sdk && cd /opt/android-sdk && wget --quiet --output-document=sdk-tools-linux.zip "https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip" && unzip -q sdk-tools-linux.zip && rm -f sdk-tools-linux.zip

ENV PATH $PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin

RUN yes | sdkmanager --licenses && sdkmanager --update

RUN sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" "build-tools;${ANDROID_BUILD_TOOLS}"

RUN mkdir -p ~/.gradle && echo "org.gradle.daemon=false" >> ~/.gradle/gradle.properties

VOLUME ["/opt/android-sdk"]
