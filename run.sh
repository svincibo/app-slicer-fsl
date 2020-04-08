#!/bin/bash

# inputs
anat=`jq -r '.anat' config.json`
dwi=`jq -r '.dwi' config.json`
bvals=`jq -r '.bvals' config.json`
outdir="raw"

mkdir -p $outdir

# make brainmask
select_dwi_vols ${dwi} ${bvals} nodif 0 -m
bet nodif.nii.gz nodif_brain -f 0.4 -g 0 -m

# render overlay
fsleyes render -ds "world" -hc -hl -c 0 --outfile ${outdir}/out.png t1.nii.gz nodif_brain_mask.nii.gz -ot mask -o -mc 1 0 0


slicer ${input} -a ${outdir}/out.png

#if [ ! -f ${outdir}/out.png ]; then
#	echo "failed"
#	exit 1
#else
#	echo "complete"
#	exit 0
#fi
