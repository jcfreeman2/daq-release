export DUNE_DAQ_BASE_RELEASE="dunedaq-v2.10.1"

dune_products_dirs=(
    "/cvmfs/dunedaq.opensciencegrid.org/releases/dunedaq-v2.10.1/externals"
    "/cvmfs/dunedaq.opensciencegrid.org/releases/dunedaq-v2.10.1/packages"
	     
)

dune_systems=(
    "gcc               v8_2_0"
    "python            v3_8_3b"
)

dune_devtools=(
    "cmake             v3_17_2"
    "gdb               v9_2"
    "ninja             v1_10_0"
)

dune_externals=(
    "cetlib            v3_11_01     e19:prof"
    "TRACE             v3_16_02"
    "fftw              v3_3_10"
    "folly             v2021_12_13  e19:prof"
    "nlohmann_json     v3_9_0c      e19:prof"
    "pistache          v2020_10_07  e19:prof"
    "highfive          v2_3_1       e19:prof"
    "zmq               v4_3_1c      e19:prof"
    "cppzmq            v4_3_0       e19:prof"
    "msgpack_c         v3_3_0       e19:prof"
    "felix             v1_2_2       e19:prof"
    "pybind11          v2_6_2       e19:prof"
    "uhal              v2_8_1       e19:prof"
    "cpr               v1_5_2       e19:prof"
    "librdkafka        v1_7_0       e19:prof"
    "protobuf          v3_14_0      e19"
    "cli11             v2_1_2       e19:prof"
)

dune_daqpackages=(
  "daq_cmake        v2_1_2b       e19:prof"
  "ers              v1_1_6b       e19:prof"
  "logging          v1_0_5c       e19:prof"
  "cmdlib           v1_1_5c       e19:prof"
  "restcmd          v1_1_5b       e19:prof"
  "opmonlib         v1_3_4c       e19:prof"
  "rcif             v1_1_1g       e19:prof"
  "appfwk           v2_4_0b       e19:prof"
  "listrev          v2_2_1b       e19:prof"
  "utilities        v1_1_0b       e19:prof"
  "erskafka         v1_4_0b       e19:prof"
  "kafkaopmon       v1_3_2c       e19:prof"
  "influxopmon      v1_5_3c       e19:prof"
  "ipm              v2_3_1b       e19:prof"
  "serialization    v1_2_4b       e19:prof"
  "dfmessages       v2_3_0b       e19:prof"
  "detdataformats   v3_3_2b       e19:prof"
  "detchannelmaps   v1_0_3b       e19:prof"
  "daqdataformats   v3_3_2        e19:prof"
  "readoutlibs      v1_0_2b       e19:prof"
  "readoutmodules   v1_0_2b       e19:prof"
  "fdreadoutlibs    v1_0_3b       e19:prof"
  "ndreadoutlibs    v1_0_2b       e19:prof"
  "dfmodules        v2_5_2        e19:prof"
  "flxlibs          v1_3_1b       e19:prof"
  "lbrulibs         v1_0_8b       e19:prof"
  "networkmanager   v1_0_3b       e19:prof"
  "nwqueueadapters  v1_5_1b       e19:prof"
  "timing           v6_1_4b       e19:prof"
  "timinglibs       v1_6_3        e19:prof"
  "trigemu          v2_3_2c       e19:prof"
  "daqconf          v5_0_3        e19:prof"
  "trigger          v1_3_2        e19:prof"
  "triggeralgs      v1_0_0b       e19:prof"
  "dqm              v1_3_3        e19:prof"
  "hdf5libs         v2_1_0        e19:prof"
  "rawdatautils     v1_0_0b       e19:prof"
  "uhallibs         v1_0_1b       e19:prof"
  "dtpcontrols      v1_0_2b       e19:prof"
  "wibmod           v1_3_2b       e19:prof"
  "sspmodules       v1_0_3b       e19:prof"
)

