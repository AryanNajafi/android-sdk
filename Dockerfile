FROM openjdk:8-jdk

ENV ANDROID_HOME /opt/android-sdk

ENV ANDROID_COMPILE_SDK 28
ENV ANDROID_BUILD_TOOLS 28.0.3
ENV ANDROID_SDK_TOOLS 4333796

COPY android-accept-licenses.sh /opt/

RUN mkdir /opt/android-sdk && cd /opt/android-sdk && wget --quiet --output-document=sdk-tools-linux.zip "https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip" && unzip -q sdk-tools-linux.zip && rm -f sdk-tools-linux.zip

ENV PATH $PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin

RUN apt-get update -qq && apt-get install -y expect

RUN chmod +x /opt/android-accept-licenses.sh

RUN /opt/android-accept-licenses.sh "sdkmanager --licenses"

RUN sdkmanager --update
RUN sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}"
RUN sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"

RUN mkdir -p ~/.gradle && echo "org.gradle.daemon=false" >> ~/.gradle/gradle.properties

VOLUME ["/opt/android-sdk"]
