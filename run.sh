#!/bin/bash
set -x
# inputs
outdir="raw"

mkdir -p $outdir

# render overlay
fsleyes render -ds "world" -hc -hl -c 2 -ad -xz 500 -yz 500 -zz 500 --outfile ${outdir}/out.png t1.nii.gz dwi.nii.gz -ot volume -a 50 --cmap red-yellow -un mask.nii.gz -ot mask -o -mc 1 1 0

