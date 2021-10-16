#!/bin/bash
set -e

#EMCC=~/src/emscripten/emcc
EMCC=emcc
JOBS=1
MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

stage1() {
sh $MYDIR/sys/unix/setup.sh
make CC=$EMCC -j$JOBS

#make install CC=$EMCC PREFIX=$MYDIR/build
#rm $MYDIR/build/nethack/nethack
#rm $MYDIR/build/nethack/recover
#cp $MYDIR/web/nethackrc.default $MYDIR/build/nethack/

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
