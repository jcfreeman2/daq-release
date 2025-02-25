# "build_order" lists packages in the order you'd want CMake to see
# them (via "add_subdirectory") during a simultaneous build. This is
# due to their dependencies: e.g., you'd want CMake to see
# daq-buildtools first in order to create daq-buildtoolsConfig.cmake
# so "find_package(daq-builtools)" will work for all the other
# packages, and so on. If a new package is introduced into the
# development area, the developer is encouraged to add it to its
# appropriate place in this list

set(build_order "daq-cmake" "ers" "erskafka" "erses" "logging" "opmonlib" "cmdlib" "rcif" "restcmd" "appfwk" "listrev" "daqdemos" "ipm" "serialization" "nwqueueadapters" "daqdataformats" "detdataformats" "detchannelmaps" "dfmessages" "trigemu" "triggeralgs" "timing" "timinglibs" "trigger" "readout" "flxlibs" "dfmodules" "influxopmon" "kafkaopmon" "minidaqapp" "dqm" "lbrulibs" "wibmod" "sspmodules" "hdf5libs")
