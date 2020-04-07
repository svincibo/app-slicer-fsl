#!/bin/bash

# t1/t2, flair, dwi, or fmri
dwi=`jq -r '.dwi' config.json`
mask=`jq -r '.mask' config.json`
outdir="raw"

mkdir -p $outdir

slicer ${dwi} ${mask} -a ${outdir}/out.png

#if [ ! -f ${outdir}/out.png ]; then
#	echo "failed"
#	exit 1
#else
#	echo "complete"
#	exit 0
#fi
