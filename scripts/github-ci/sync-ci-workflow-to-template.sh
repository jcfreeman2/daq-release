#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $SCRIPT_DIR/repo.sh

function git_checkout_and_update_ci {
  prd_list_name=$1[@]
  workflow_file=$2
  prd_list=("${!prd_list_name}")
  for prod in "${prd_list[@]}"; do
    iprd_arr=(${prod})
    prod_name=${iprd_arr[0]//_/-}
    echo "--------------------------------------------------------------"
    echo "********************* $prod_name *****************************"
    git clone --quiet git@github.com:DUNE-DAQ/${prod_name}.git -b develop
    pushd ${prod_name}
    cp $workflow_file .github/workflows
    git add .github/workflows
    old_message=`git log -1|grep -v "^commit"`
    git commit -am "syncing $(basename $workflow_file); previous commit: ${old_message}"
    git push --quiet
    popd
  done
}


tmp_dir=$(mktemp -d -t cvmfs_dunedaq_release_XXXXXXXXXX)

pushd $tmp_dir

git clone https://github.com/DUNE-DAQ/.github.git

git_checkout_and_update_ci dune_packages_with_ci $tmp_dir/.github/workflow-templates/dunedaq-develop-cpp-ci.yml

popd

rm -rf $tmp_dir
