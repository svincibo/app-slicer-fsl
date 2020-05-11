#!/bin/bash

# t1/t2, flair, dwi, or fmri
input=`jq -r '.input' config.json`
outdir="raw"
vol=`jq -r '.volume' config.json`

mkdir -p $outdir

if [[ ! ${vol} == "" ]]; then
	fslselectvols -i ${input} -o volume.nii.gz --vols=${vol}
	input="volume.nii.gz"
fi

slicer ${input} -a ${outdir}/out.png

if [ ! -f ${outdir}/out.png ]; then
	echo "failed"
	exit 1
else
	echo "complete"
	exit 0
fi
