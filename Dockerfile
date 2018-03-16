FROM debian:latest
MAINTAINER Jemy Zhang <jemy.zhang@gmail.com>

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV VERSION "17.01.4"
ENV PROFILE "WNDR4300V1"
ENV DOWNLOAD_URL "https://downloads.openwrt.org/releases/${VERSION}/targets/ar71xx/nand/lede-imagebuilder-${VERSION}-ar71xx-nand.Linux-x86_64.tar.xz"
ENV BUILD_ROOT "/build_root"
ENV CUST_CFG "$BUILD_ROOT/cust_cfg"
ENV CUST_PACKAGES "$CUST_CFG/packages"
ENV CUST_PACKAGE_LIST "$CUST_CFG/package.lst"
ENV CUST_REPO_LIST "$CUST_CFG/repositories.conf"
ENV CUST_FILES "$BUILD_ROOT/files"

RUN apt-get update \
    && apt-get install -y tzdata ca-certificates \
       bash perl make gcc g++ libncurses5-dev gawk zlib1g-dev bzip2 python git-core file \
       curl wget tar unzip \
    && apt-get clean \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

RUN wget $DOWNLOAD_URL -O imagebuilder.tar.xz \
    && mkdir -p $BUILD_ROOT \
    && tar Jxf imagebuilder.tar.xz --strip 1 -C $BUILD_ROOT \
    && rm -f imagebuilder.tar.xz

VOLUME $CUST_FILES $CUST_CFG

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
