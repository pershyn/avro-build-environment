# This state installs thrift compiler and required libs to do thrift development
# thrift-compiler is present in debian, but the version is old,
# also it is available only in jessy
# https://packages.debian.org/jessie/thrift-compiler
# so original manual is followed here to compile it from sources
# http://thrift.apache.org/docs/install/ubuntu/

# Environment to build the thrift-compiler
thrift-build-env:
  pkg.installed:
    - pkgs:
      - curl
      - libboost-dev
      - libboost-test-dev
      - libboost-program-options-dev
      - libevent-dev
      - automake
      - libtool
      - flex
      - bison
      - pkg-config
      - g++
      - libssl-dev
      # some pythond deps
      - python-all
      - python-all-dev
      - python-all-dbg
      # java deps
      - openjdk-7-jre-headless #=7u3-2.1.7-1
      - openjdk-7-jre-lib #=7u3-2.1.7-1
      - openjdk-7-jdk
      - ant
      # to work properly, java7 should be chosen
      # sudo apt-get remove openjdk-6-jre-headless

# build and install thrift-compiler (in separate shell script)
/tmp/install-thrift.sh:
  file.managed:
    - source: salt://install-thrift.sh
    - mode: 755
    - require:
      - pkg: thrift-build-env
  cmd.run:
    - stateful: True
    - require:
      - file: /tmp/install-thrift.sh
        # thrift being not already installed???
