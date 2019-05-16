# QtWidgetsApplication Example

Minimal example of how to create an AppImage from a Qt Widgets Application using conan.io as package manager.

## Requirements
Project requirements will be handled using conan.io therefore the dependencies will be listed on a `conanfile.txt` see https://docs.conan.io/en/latest/reference/conanfile_txt.html?highlight=conanfile

```
[requires]
libpng/1.6.36@bincrafters/stable
qt/5.12.3@appimage-conan-community/stable

[build_requires]
# linuxdeploy is required to build the AppImage therefore is listed only as build require
linuxdeploy-plugin-appimage/continuous@appimage-conan-community/stable
linuxdeploy-plugin-qt/continuous@appimage-conan-community/stable
appimagetool_installer/11@appimage-conan-community/stable

[generators]
# allow to run qmake from the build dir
qmake
# create conan virtual environment (required to run linuxdeploy)
virtualrunenv

[options]
# Require shared libs
zlib:shared=True
qt:shared=True
```

## Build 
```
mkdir build && cd build;

# Install conan dependencies requiring them to be built using c++ 11 and linked to libstdc++11  
conan install .. -s compiler.cppstd=11 -s compiler.libcxx=libstdc++11 --build missing

# Enter conan virtual environment (just like python virtual environments)
. activate_run.sh

# build your app as your are used to
qmake CONFIG+=release PREFIX=/usr ../QtWidgetsApplication.pro

# Let's crete the AppImage
# install you app to an AppDir
INSTALL_ROOT=$BUILD_DIR/AppDir make install

# call linuxdeploy with the Qt plugin
linuxdeploy --appdir AppDir/ --plugin qt --output appimage

# exit conan virtual env
. deactivate_run.sh

```
