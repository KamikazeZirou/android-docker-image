FROM cimg/android:2022.04.1-node

ENV HOME /home/circleci
ENV FLUTTER_HOME=${HOME}/sdks/flutter
ENV FLUTTER_VERSION=2.10.5
ENV FLUTTER_ROOT=$FLUTTER_HOME

RUN mkdir -p $FLUTTER_HOME

# Install firebase tools
RUN sudo curl -sL https://firebase.tools | bash

# Install tools for easylauncher
RUN sudo apt-get update && sudo apt-get install -y fontconfig ttf-dejavu

# Install Flutter SDK
ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin
RUN git clone --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}
RUN flutter precache

# Ignore SIGPIPE because 'yes' always raises it.
RUN set +o pipefail && yes | flutter doctor --android-licenses
RUN flutter doctor
