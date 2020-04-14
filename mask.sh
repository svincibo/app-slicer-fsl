#!/bin/bash

dwi=`jq -r '.dwi' config.json`
bvals=`jq -r '.bvals' config.json`

select_dwi_vols ${dwi} ${bvals} nodif 0 -m

bet nodif.nii.gz nodif_brain -f 0.2 -g 0 -m

mv nodif_brain.nii.gz dwi.nii.gz
mv nodif_brain_mask.nii.gz mask.nii.gz
