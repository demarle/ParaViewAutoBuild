#!/bin/bash

paraview_source_dir=$1
paraview_install_dir=$2
osmesa_install_dir=$3
python_install_dir=$4
cmake_command=$5
toolchain_file=$6
native_build_dir=$7
cxx_flags=$8

if [ ! -z "$cxx_flags" ]; then
  cxx_flags=-DCMAKE_CXX_FLAGS_RELEASE:STRING=\"$cxx_flags\"
fi


$cmake_command \
-DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
-DParaView3CompileTools_DIR=$native_build_dir \
-DBUILD_SHARED_LIBS=0 \
-DPARAVIEW_USE_MPI=1 \
-DPARAVIEW_ENABLE_PYTHON=1 \
-DPARAVIEW_BUILD_QT_GUI=0 \
-DENABLE_MPI4PY=0 \
-DVTK_USE_X=0 \
-DBUILD_TESTING=0 \
\
-DVTK_USE_SYSTEM_HDF5:BOOL=1 \
-DHDF5_LIBRARIES:FILEPATH=\
/soft/apps/current/hdf5-1.8.9/lib/libhdf5.a \
-DHDF5_LIBRARY:FILEPATH=\
/soft/apps/current/hdf5-1.8.9/lib/libhdf5.a \
-DHDF5_INCLUDE_DIRS:PATH=\
/soft/apps/current/hdf5-1.8.9/include \
-DHDF5_INCLUDE_DIR:PATH=\
/soft/apps/current/hdf5-1.8.9/include \
\
-DVTK_USE_SYSTEM_ZLIB:BOOL=1 \
-DZLIB_LIBRARY:FILEPATH=\
/soft/apps/current/zlib-1.2.5/lib/libz.a \
-DZLIB_INCLUDE_DIR:PATH=\
/soft/apps/current/zlib-1.2.5/include \
\
-DPYTHON_INCLUDE_DIR="$python_install_dir/include/python2.5" \
-DPYTHON_LIBRARY="$python_install_dir/lib/libpython2.5.a" \
-DOPENGL_INCLUDE_DIR="$osmesa_install_dir/include" \
-DOPENGL_gl_LIBRARY="" \
-DOPENGL_glu_LIBRARY="$osmesa_install_dir/lib/libGLU.a" \
-DVTK_OPENGL_HAS_OSMESA=1 \
-DOSMESA_LIBRARY="$osmesa_install_dir/lib/libOSMesa.a" \
-DOSMESA_INCLUDE_DIR="$osmesa_install_dir/include" \
-DCMAKE_BUILD_TYPE:STRING="Release" \
"$cxx_flags" \
-DCMAKE_INSTALL_PREFIX:PATH="$paraview_install_dir" \
-DPARAVIEW_BUILD_PLUGIN_AdiosReader:BOOL=OFF\
-DPARAVIEW_BUILD_PLUGIN_AnalyzeNIfTIReaderWriter:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_CoProcessingScriptGenerator:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_EyeDomeLighting:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_ForceTime:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_H5PartReader:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_Manta:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_Moments:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_Nektar:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_PacMan:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_PointSprite:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_Prism:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_SLACTools:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_SQToolkit:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_SierraPlotTools:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_StreamingView:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_SurfaceLIC:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_VRPlugin:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_VaporPlugin:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_pvblot:BOOL=OFF \
-C $paraview_source_dir/CMake/TryRunResults-ParaView3-bgl-xlc.cmake \
$paraview_source_dir
