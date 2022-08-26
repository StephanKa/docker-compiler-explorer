FROM ubuntu:20.04

LABEL maintainer="Stephan Kantelberg <stephan.kantelberg@zuehlke.com>"

ARG DEB_COMPILERS="g++-9 g++-10 g++-11"
ARG EXTRA_CLANG_COMPILERS="11 12 13 14 15"
ARG FMT_VERSION="8.1.1 9.0.0"

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
ADD install_fmt.sh /install_fmt.sh

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
    && apt-get autoremove --purge -y \
    && apt-get autoclean -y \
    && rm -rf /var/cache/apt/* /tmp/* \
    && git clone https://github.com/compiler-explorer/compiler-explorer.git /compiler-explorer \
    && cd /compiler-explorer \
    && echo "Add missing dependencies" \
    && npm i @sentry/node \
    && npm run webpack

RUN echo "*** Install libs ***" \
    && sh /install_fmt.sh "${FMT_VERSION}"

ADD cpp.properties /compiler-explorer/etc/config/c++.local.properties

WORKDIR /compiler-explorer

ENTRYPOINT [ "make" ]

CMD ["run"]
