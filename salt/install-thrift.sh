#!/bin/bash
# Downloads the file and runs the thrift installation
# intended to be used with salt
# should be run only if thrift is not installed

# http://thrift.apache.org/docs/BuildingFromSource/
# http://www.apache.org/dyn/closer.cgi?path=/thrift/0.9.1/thrift-0.9.1.tar.gz

cd /tmp
rm -rf thrift-0.7.0
curl http://archive.apache.org/dist/thrift/0.7.0/thrift-0.7.0.tar.gz | tar xz
#curl http://mirror.synyx.de/apache/thrift/0.9.1/thrift-0.9.1.tar.gz | tar xz
#cd thrift-0.9.1/
chown vagrant:vagrant ./*
cd thrift-0.7.0/
# fix some broken permissions
chmod 755 ./configure
./configure > configure.log
make > make.log
sudo make install

# writing the state line (DUMMY)
echo  # an empty line here so the next line will be the last.
echo "changed=yes comment='thrift installation script finished (check logs)'"
