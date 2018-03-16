#!/bin/sh

if [ -f $CUST_PACKAGE_LIST ]; then
  PKG_PARAMS="PACKAGES=\"$(cat $CUST_PACKAGE_LIST | tr "\n" " ")\""
fi

[ "$(ls -A $CUST_FILES 2> /dev/null)" ] && FILES_PARAMS="FILES=$CUST_FILES"

if [ -f $CUST_REPO_LIST ]; then
  cat $CUST_REPO_LIST >> $BUILD_ROOT/repositories.conf
fi

[ "$(ls -A $CUST_PACKAGES 2> /dev/null)" ] && cp -af $CUST_PACKAGES/* $BUILD_ROOT/packages/

cd $BUILD_ROOT
sed -i s/'23552k(ubi),25600k@0x6c0000(firmware)'/'120832k(ubi),122880k@0x6c0000(firmware)'/ target/linux/ar71xx/image/legacy.mk
make info
eval make -j image PROFILE="${PROFILE}" $FILES_PARAMS $PKG_PARAMS
