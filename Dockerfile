FROM debian
ARG PROJECT
WORKDIR /build
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    bc \
    cpio \
    python \
    rsync \
    build-essential

ADD buildroot buildroot

ADD Config.in Config.in
ADD common.mk common.mk
ADD external.mk external.mk
ADD external.desc external.desc
ADD package package

ADD project/toolchain project/toolchain
ADD Makefile.toolchain Makefile.toolchain
RUN BR2_EXTERNAL=$(pwd) make -f "Makefile.toolchain";

ADD patch patch

ADD overlay/$PROJECT overlay/$PROJECT
ADD project/$PROJECT project/$PROJECT
ADD Makefile.$PROJECT Makefile.$PROJECT
RUN BR2_EXTERNAL=$(pwd) make -f "Makefile.$PROJECT";
