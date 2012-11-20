#!/bin/bash


# Get full path to this script
cd `dirname $0`
script_dir=`pwd`


# Get build options
source $script_dir/build_options.sh

if [ -z "$base" ]; then
  echo "build_options.sh did not specify base directory"
  exit 1
fi

install_base=$base/install
xinstall_base=$base/install/cross
python_install_dir=$install_base/python-2.5.2
python_xinstall_dir=$xinstall_base/python-2.5.2
paraview_install_dir=$install_base/paraview
paraview_xinstall_dir=$xinstall_base/paraview

git_command=git
cmake_command=cmake
toolchain_file=$base/toolchains/$toolchain_file

setup_native_compilers()
{
echo "setup_native_compilers"
#module unload PrgEnv-pgi PrgEnv-gnu
#module load gcc
export CC=/usr/bin/cc
export CXX=/usr/bin/c++
}

setup_cross_compilers()
{
echo "setup_cross_compilers"
#module unload gcc
#module load $cross_compiler_module
export CC=bgxlc
export CXX=bgxlC
}

grab()
{
url=$1
file=$2
cp $script_dir/$file ./
}

do_toolchains()
{
echo "do_toolchains"
rm -rf $base/toolchains
mkdir -p $base/toolchains
cd $base/toolchains
fname=`basename $toolchain_file`
cp $script_dir/toolchains/$fname ./
sed -i -e "s|XINSTALL_DIR|$xinstall_base|g" $toolchain_file 
}


do_python_download()
{
echo "do_python_download"
mkdir -p $base/source/python
cd $base/source/python
package=Python-2.5.2
grab http://www.python.org/ftp/python/2.5.2 $package.tgz
rm -rf $package
tar -zxf $package.tgz
}

do_python_build_native()
{
echo "do_python_build_native"
cd $base/source/python
source=Python-2.5.2
rm -rf build-native
mkdir build-native
cd build-native
../$source/configure --prefix=$python_install_dir --enable-shared
$make_command && make install
}


do_python_build_cross()
{
echo "do_python_build_cross"
cd $base/source/python
source=Python-2.5.2
rm -rf $source-cmakeified
cp -r $source $source-cmakeified
source=$source-cmakeified
cp $script_dir/add_cmake_files_to_python2-5-2.patch ./
patch -p1 -d $source < add_cmake_files_to_python2-5-2.patch

rm -rf build-cross
mkdir build-cross
cd build-cross

# todo - remove PYTHON_BUILD_LIB_SHARED=0
# it is here for bg/p which finds libdl and sets
# build shared default to true, should key off TARGET_SUPPORTS_SHARED_LIBS

$cmake_command \
  -DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
  -DCMAKE_BUILD_TYPE:STRING=Release \
  -DPYTHON_BUILD_LIB_SHARED:BOOL=0 \
  -DWITH_THREAD:BOOL=0 \
  -DHAVE_GETGROUPS:BOOL=0 \
  -DHAVE_SETGROUPS:BOOL=0 \
  -DENABLE_IPV6:BOOL=0 \
  -DCMAKE_INSTALL_PREFIX=$python_xinstall_dir \
  -C ../$source/CMake/TryRunResults-Python-bgl-gcc.cmake \
  -C $script_dir/python_modules.cmake \
  ../$source

$make_command && make install

}

do_python()
{
echo "do_python"
do_toolchains
do_python_download

setup_native_compilers
do_python_build_native

setup_cross_compilers
do_python_build_cross
}

if [ -z $1 ]
then
  set -x
  echo "Please specify a build step."
  exit 1
else
  set -x
  $1
fi
