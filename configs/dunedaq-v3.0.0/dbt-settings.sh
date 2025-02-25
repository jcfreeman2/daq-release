export DUNE_DAQ_BASE_RELEASE="dunedaq-develop"

dune_products_dirs=(
    "/cvmfs/dunedaq.opensciencegrid.org/products"
    "/cvmfs/dunedaq-development.opensciencegrid.org/products"
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
    "daq_cmake           v2_1_3            e19:prof"
    "ers                 v1_1_6e           e19:prof"
    "logging             v1_0_6            e19:prof"
    "cmdlib              v1_1_5f           e19:prof"
    "restcmd             v1_2_0            e19:prof"
    "opmonlib            v1_3_5b           e19:prof"
    "rcif                v1_1_2b           e19:prof"
    "appfwk              v2_6_1            e19:prof"
    "listrev             v3_0_0            e19:prof"
    "utilities           v2_1_0            e19:prof"
    "erskafka            v1_4_1            e19:prof"
    "kafkaopmon          v1_3_2f           e19:prof"
    "influxopmon         v1_5_4            e19:prof"
    "ipm                 v2_5_1            e19:prof"
    "serialization       v1_3_0            e19:prof"
    "iomanager           v1_0_1            e19:prof"
    "dfmessages          v2_4_0            e19:prof"
    "detdataformats      v3_4_1            e19:prof"
    "detchannelmaps      v1_1_3            e19:prof"
    "daqdataformats      v3_3_3b           e19:prof"
    "readoutlibs         v1_1_1            e19:prof"
    "readoutmodules      v1_1_1            e19:prof"
    "fdreadoutlibs       v1_3_0            e19:prof"
    "ndreadoutlibs       v1_1_0            e19:prof"
    "dfmodules           v2_7_2            e19:prof"
    "flxlibs             v1_6_1            e19:prof"
    "lbrulibs            v1_1_1            e19:prof"
    "networkmanager      v1_1_1            e19:prof"
    "timing              v6_2_0            e19:prof"
    "timinglibs          v1_7_2            e19:prof"
    "daqconf             v5_3_1            e19:prof"
    "trigger             v1_4_2            e19:prof"
    "triggeralgs         v1_1_2            e19:prof"
    "dqm                 v1_3_7            e19:prof"
    "hdf5libs            v2_1_0d           e19:prof"
    "rawdatautils        v1_0_0e           e19:prof"
    "uhallibs            v1_1_1            e19:prof"
    "dtpcontrols         v2_0_2            e19:prof"
    "dtpctrllibs         v1_0_1            e19:prof"
    "wibmod              v1_4_1            e19:prof"
    "sspmodules          v1_1_1            e19:prof"
)

