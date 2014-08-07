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
      - curl # for downloading thrift archive

      # thrift deps from thrift site
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
      # to work properly, java7 should be chosen
      # java 6 could be removed with next command
      # sudo apt-get remove openjdk-6-jre-headless
      - openjdk-7-jre-headless #=7u3-2.1.7-1
      - openjdk-7-jre-lib #=7u3-2.1.7-1
      - openjdk-7-jdk
      - ant # needed to generate sources for java

/tmp/install-thrift.sh:
  file.managed:
    - source: salt://thrift.sh
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: thrift-build-env
  cmd.run:
    - stateful: True
