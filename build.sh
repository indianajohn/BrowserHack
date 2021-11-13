#!/bin/bash
set -e

#EMCC=~/src/emscripten/emcc
EMCC=emcc
JOBS=1
MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

stage1() {
cd $MYDIR
sh $MYDIR/sys/unix/setup.sh
echo Buiding utils
cd $MYDIR/util
make CC=$EMCC -j$JOBS
make CC=emcc lev_comp.js
make CC=emcc dgn_comp.js

echo Buiding everything
cd $MYDIR
# hack: make build succeed by putting a dummy nethack file in place
rm -rf $MYDIR/src/nethack
touch $MYDIR/src/nethack
make CC=$EMCC -j$JOBS
make install CC=$EMCC PREFIX=$MYDIR/build
# then remove it
rm -rf $MYDIR/src/nethack
# and copy the nethack directory in place so it can be bundled.
rm -rf $MYDIR/src/nethack
cp -rf $MYDIR/build/nethack $MYDIR/src/nethack
# and build again with everything bundled
make CC=$EMCC -j$JOBS
}

stage2() {
cp ./src/browserhack.js web/
cp ./src/browserhack.data web/
cp ./src/browserhack.wasm web/

pushd web
  python ../win/web/tile2name.py
popd
}

stage1
stage2
