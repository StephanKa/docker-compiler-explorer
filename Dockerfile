FROM ubuntu:20.04

LABEL maintainer="Stephan Kantelberg <stephan.kantelberg@zuehlke.com>"

ARG DEB_COMPILERS="g++-9 g++-10 g++-11"
ARG EXTRA_CLANG_COMPILERS="11 12 13 14 15"
ARG FMT_VERSION="8.1.1 9.0.0 9.1.0"
ARG SML_VERSION="1.1.5 1.1.6"
ARG CATCH2_VERSION="v2.13.9 v3.1.0 v3.2.0"
ARG CTRE_VERSION="v3.7 v3.7.1"
ARG EXPECTED_VERSION="v0.6.2"
ARG GOOGLETEST_VERSION="v1.12.1"
ARG HFSM2_VERSION="2.2.1"
ARG JSON_VERSION="v3.11.2"
ARG SPDLOG_VERSION="v1.10.0 v1.11.0"

EXPOSE 10240

RUN echo "*** Installing compiler required packages ***" \
    && export DEBIAN_FRONTEND=noninteractive  \
    && apt-get update \
    && apt-get install -y \
       wget \
       gnupg2 \
       lsb-release \
       apt-utils \
       software-properties-common

ADD install_compilers.sh /install_compilers.sh
ADD install_libraries.py /install_libraries.py

RUN echo "*** Installing C++ Compilers ***" \
    && chmod +x /install_compilers.sh \
    && sh /install_compilers.sh "${DEB_COMPILERS}" "${EXTRA_CLANG_COMPILERS}"


RUN echo "*** Installing Compiler Explorer ***" \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y \
       ca-certificates \
       nodejs \
       make \
       git \
       python3 \
    && apt-get autoremove --purge -y \
    && apt-get autoclean -y \
    && rm -rf /var/cache/apt/* /tmp/* \
    && git clone https://github.com/compiler-explorer/compiler-explorer.git /compiler-explorer \
    && cd /compiler-explorer \
    && echo "Add missing dependencies" \
    && npm i @sentry/node \
    && npm run webpack

RUN echo "*** Install libs ***" \
    && echo "Installing FMT" \
    && python3 /install_libraries.py -n fmt -u https://github.com/fmtlib/fmt.git -v ${FMT_VERSION} \
    && echo "Installing Boost SML" \
    && python3 /install_libraries.py -n sml -u https://github.com/boost-ext/sml.git -v ${SML_VERSION} \
    && echo "Installing Catch2" \
    && python3 /install_libraries.py -n catch2 -u https://github.com/catchorg/Catch2.git -v ${CATCH2_VERSION} \
    && echo "Installing CTRE" \
    && python3 /install_libraries.py -n ctre -u https://github.com/hanickadot/compile-time-regular-expressions.git -v ${CTRE_VERSION} \
    && echo "Installing expected_lite" \
    && python3 /install_libraries.py -n expected_lite -u https://github.com/martinmoene/expected-lite.git -v ${EXPECTED_VERSION} \
    && echo "Installing Googletest" \
    && python3 /install_libraries.py -n googletest -u https://github.com/google/googletest.git -v ${GOOGLETEST_VERSION} \
    && echo "Installing HFSM2" \
    && python3 /install_libraries.py -n hfsm2 -u https://github.com/andrew-gresyk/HFSM2.git -v ${HFSM2_VERSION} \
    && echo "Installing nlohmann-json" \
    && python3 /install_libraries.py -n nlohmann_json -u https://github.com/nlohmann/json.git -v ${JSON_VERSION} \
    && echo "Installing spdlog" \
    && python3 /install_libraries.py -n spdlog -u https://github.com/gabime/spdlog.git -v ${SPDLOG_VERSION}

ADD cpp.properties /compiler-explorer/etc/config/c++.local.properties

WORKDIR /compiler-explorer

ENTRYPOINT [ "make" ]

CMD ["run"]
