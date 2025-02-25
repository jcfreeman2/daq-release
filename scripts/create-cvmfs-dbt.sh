#!/bin/bash

TARGET_DIR=/home/dingpf/cvmfs_dunedaq/tools/
##TARGET_DIR=/home/dingpf/cvmfs_dunedaq/tools/

mkdir -p /var/tmp
cd /var/tmp
rm -rf dbt
rm -rf daq-buildtools
git clone git@github.com:DUNE-DAQ/daq-buildtools.git

cd daq-buildtools

mkdir -p /var/tmp/dbt
for i in `git tag`; do 
	if [[ $i = v* ]]; then
	        echo $i
		git archive --format=tar --prefix=$i/ $i | (cd /var/tmp/dbt && tar xf -)
	fi
done

for i in `git tag`; do 
	if [[ $i = dunedaq* ]]; then
		for j in `git tag --points-at $(git show-ref -s $i)`; do
			echo $j
			if [[ $j = "v"* ]]; then
				cd /var/tmp/dbt
				echo $i $j
				ln -s $j $i
				cd /var/tmp/daq-buildtools
			fi
		done
	fi
done

rm -rf /var/tmp/dbt/v*_for_docs

rsync -vau /var/tmp/dbt $TARGET_DIR

rm -rf /var/tmp/dbt
rm -rf /var/tmp/daq-buildtools
