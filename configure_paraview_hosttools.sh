#!/bin/bash

paraview_source_dir=$1
paraview_install_dir=$2
osmesa_install_dir=$3
python_install_dir=$4
cmake_command=$5

$cmake_command \
-DBUILD_SHARED_LIBS=1 \
-DPARAVIEW_USE_MPI=0 \
-DPARAVIEW_ENABLE_PYTHON=1 \
-DPARAVIEW_BUILD_QT_GUI=0 \
-DENABLE_MPI4PY=0 \
-DPARAVIEW_BUILD_PLUGIN_VisTrailsPlugin=0 \
-DVTK_USE_RPATH:BOOL=ON \
-DVTK_USE_X=0 \
-DBUILD_TESTING=0 \
-DPYTHON_EXECUTABLE="$python_install_dir/bin/python" \
-DPYTHON_INCLUDE_DIR="$python_install_dir/include/python2.7" \
-DPYTHON_LIBRARY="$python_install_dir/lib/libpython2.7.so" \
-DOPENGL_INCLUDE_DIR="$osmesa_install_dir/include" \
-DOPENGL_gl_LIBRARY="" \
-DOPENGL_glu_LIBRARY="$osmesa_install_dir/lib/libGLU.so" \
-DVTK_OPENGL_HAS_OSMESA=1 \
-DOSMESA_LIBRARY="$osmesa_install_dir/lib/libOSMesa.so" \
-DOSMESA_INCLUDE_DIR="$osmesa_install_dir/include" \
-DCMAKE_BUILD_TYPE:STRING="Release" \
-DPARAVIEW_BUILD_PLUGIN_AdiosReader:BOOL=OFF\
-DPARAVIEW_BUILD_PLUGIN_AnalyzeNIfTIIO:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_ArrowGlyph:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_CoProcessingScriptGenerator:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_EyeDomeLighting:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_ForceTime:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_H5PartReader:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_MantaView:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_Moments:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_Nektar:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_NonOrthogonalSource:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_PacMan:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_PointSprite:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_PrismPlugin:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_QuadView:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_SLACTools:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_SciberQuestToolKit:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_SierraPlotTools:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_SurfaceLIC:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_UncertaintyRendering:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_VRPlugin:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_VaporPlugin:BOOL=OFF \
-DPARAVIEW_BUILD_PLUGIN_pvblot:BOOL=OFF \
-DCMAKE_INSTALL_PREFIX:PATH="$paraview_install_dir" \
$paraview_source_dir
