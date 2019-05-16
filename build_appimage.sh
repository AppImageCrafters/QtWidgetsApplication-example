#!/usr/bin/env bash

set -e

SOURCE_DIR=$PWD
BUILD_DIR=$PWD/conan-build-release
mkdir -p $BUILD_DIR && pushd $BUILD_DIR

# Install conan dependencies
conan install .. -s compiler.cppstd=11 -s compiler.libcxx=libstdc++11 --build missing

# Enter conan virtual environment
. activate_run.sh

# build your app as your are used to
qmake CONFIG+=release PREFIX=/usr ../QtWidgetsApplication.pro

# install you app to an AppDir
INSTALL_ROOT=$BUILD_DIR/AppDir make install

# call linuxdeploy with the Qt plugin
linuxdeploy --appdir AppDir/ --plugin qt --output appimage

# exit conan virtual env
. deactivate_run.sh

popd
