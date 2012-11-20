# the name of the target operating system
set(CMAKE_SYSTEM_NAME BlueGeneP-static)

# Set search paths to prefer local, admin-installed wrappers for the BG backend compilers
set(BGP_GNU_COMPILER_SEARCH_PATHS
  /usr/local/bin
  /usr/bin
  /soft/apps/current/gcc-4.3.2/gnu-linux/bin)

# GNU C Compilers
find_program(CMAKE_C_COMPILER       powerpc-bgp-linux-gcc      ${BGP_GNU_COMPILER_SEARCH_PATHS})
find_program(CMAKE_CXX_COMPILER     powerpc-bgp-linux-g++      ${BGP_GNU_COMPILER_SEARCH_PATHS})
find_program(CMAKE_Fortran_COMPILER powerpc-bgp-linux-gfortran ${BGP_GNU_COMPILER_SEARCH_PATHS})

# Make sure MPI_COMPILER wrapper matches the gnu compilers.  
# Prefer local machine wrappers to driver wrappers here too.
find_program(MPI_COMPILER NAMES mpicxx mpic++ mpiCC mpicc 
  PATHS 
  /usr/local/bin
  /usr/bin
  /soft/apps/darshan/bin/default
)
