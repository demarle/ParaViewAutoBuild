
#platform=bgl
platform=bgp
#platform=eureka
#platform=jaguarpf
#platform=jaguarpfgcc
#platform=krakengcc
#platform=franklingcc

set_bgl_options()
{
  base=$HOME/source/autobuild2
  toolchain_file=toolchain-xlc-bgl.cmake
  make_command="make -j2"
  paraview_cross_cxx_flags="-O2 -qstrict -qarch=440 -qtune=440 -qcpluscmt"
  osmesa_config_name=bgl-osmesa-xlc
}

set_bgp_options()
{
  base=/scratch/demarle/autobuildxlc/newbuild
  toolchain_file=BlueGeneP-xl-static.cmake
  make_command="nice make -j4"
  paraview_cross_cxx_flags="-O2"
  osmesa_config_name=bgp-osmesa-xlc
}

set_eureka_options()
{
  base=/scratch/pmarion/test_build
  make_command="make -j2"
}

set_jaguarpfgcc_options()
{
  base=/autofs/na4_proj/csc035/demarle/pv3.14.0/GNUBUILD
  toolchain_file=cray-cnl-toolchain.cmake
  make_command="nice make -j8"
  osmesa_config_name=craycle-osmesa-gnu
  cross_compiler_module=PrgEnv-gnu
}

set_krakengcc_options()
{
  base=$HOME/gccbuild
  toolchain_file=cray-cnl-toolchain.cmake
  make_command="make -j2"
  osmesa_config_name=craycle-osmesa-gnu
  cross_compiler_module=PrgEnv-gnu
}

set_franklingcc_options()
{
  base=$SCRATCH/gccbuild
  toolchain_file=cray-cnl-toolchain.cmake
  make_command="make -j2"
  osmesa_config_name=craycle-osmesa-gnu
  cross_compiler_module=PrgEnv-gnu
}


set_${platform}_options
