#!/bin/bash
set -e

#EMCC=~/src/emscripten/emcc
EMCC=emcc
JOBS=1
MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

generate_build_utils() {
  echo Generating build utils
  cd $MYDIR
  sh $MYDIR/sys/unix/setup.sh
  echo Buiding utils
  cd $MYDIR/util
  make CC=$EMCC -j$JOBS
  make CC=emcc lev_comp.js
  make CC=emcc dgn_comp.js
}

generate_nethack_dir() {
  echo Generating nethack directory
  cd $MYDIR
  # hack: make build succeed by putting a dummy nethack file in place
  touch $MYDIR/src/nethack
  make CC=$EMCC -j$JOBS
  make install CC=$EMCC PREFIX=$MYDIR/build
  # then remove it
  rm -rf $MYDIR/src/nethack
  cp -rf $MYDIR/build/nethack $MYDIR/src/nethack
}

build_browserhack() {
  echo "Building browserhack."
  cd $MYDIR
  # and copy the nethack directory in place so it can be bundled.
  # and build again with everything bundled
  sh $MYDIR/sys/unix/setup.sh
  make CC=$EMCC -j$JOBS
}

install_to_web() {
  echo "Installing to web/ directory."
  cp ./src/browserhack.js web/
  cp ./src/browserhack.data web/
  cp ./src/browserhack.wasm web/
  pushd web
    python ../win/web/tile2name.py
  popd
}

generate_build_utils
if [ ! -d "$MYDIR/src/nethack" ]; then
  generate_nethack_dir
fi
build_browserhack
install_to_web
