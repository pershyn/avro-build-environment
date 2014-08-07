#!/bin/bash
# Downloads the file and runs the thrift installation
# intended to be used with salt
# should be run only if thrift is not installed

# http://thrift.apache.org/docs/BuildingFromSource/
# http://www.apache.org/dyn/closer.cgi?path=/thrift/0.9.1/thrift-0.9.1.tar.gz

VERSION="0.7.0"

# check if required version of thrift is installed:
THRIFT_OUTPUT=$(/usr/local/bin/thrift -version)
if [ "$THRIFT_OUTPUT" == "Thrift version ${VERSION}" ]; then
  echo # an empty line here so the next line will be the last.
  echo "changed=no comment='required version of thrift is installed: ${VERSION}'"
  exit 0
fi

# if not - install it

pushd /tmp
BUILD_FOLDER="thrift-${VERSION}"

# clean-up possibly existing folder for build "thrift-${VERSION}"
if [ -d $BUILD_FOLDER ]; then
  rm -rf thrift-${VERSION}
fi

# HTTDS in only for 0.9.1 and on. 0.9.1 is also reachable by HTTP.
#curl https://dist.apache.org/repos/dist/release/thrift/${VERSION}/thrift-${VERSION}.tar.gz | tar zx

curl http://archive.apache.org/dist/thrift/${VERSION}/thrift-${VERSION}.tar.gz | tar xz
if [ -d $BUILD_FOLDER ]; then
  pushd $BUILD_FOLDER
  # permission fixes due to bug in thrift 0.7.0 archive
  chown vagrant:vagrant ./*
  chmod +x ./configure

  ./configure > configure.log
  make > make.log
  make install
  popd
fi
popd

# check if required version of thrift is installed:
THRIFT_OUTPUT=$(/usr/local/bin/thrift -version)
echo # an empty line here so the next line will be the last.
if [ "$THRIFT_OUTPUT" == "Thrift version 0.9.1" ]; then
  echo "changed=yes comment='required version of thrift is installed: ${VERSION}'"
  exit 0
else
  # installation failed
  echo "changed=no comment='Failed to install thrift - see logs in ${BUILD_FOLDER}'"
  exit 1
fi
