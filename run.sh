#!/bin/bash

# 5tt input
input=`jq -r '.input' config.json`
anat=`jq -r '.anat' config.json`
outdir="raw"
masks=("gm" "wm" "csf")
mask_index=("0" "2" "3")
NCORE=1

mkdir -p $outdir

## convert to different masks
# .mif
mrconvert ${input} 5tt.mif -nthreads $NCORE -force

# gm, wm, csf, gmwmi
for ((idx=0; idx<${#masks[@]}; ++idx)); do
	if [ ! -f ${masks[$idx]}.nii.gz ]; then
		mrconvert -coord 3 ${mask_index[$idx]} 5tt.mif ${masks[$idx]}_prob.nii.gz -force -nthreads $NCORE
		fslmaths ${masks[$idx]}_prob.nii.gz -bin ${masks[$idx]}.nii.gz
	fi
done

# gmwmi
[ ! -f gmwmi.nii.gz ] && 5tt2gmwmi 5tt.mif gmwmi.nii.gz -force -nthreads $NCORE -quiet

images="gm wm csf gmwmi"

for IMG in ${images}
do
	if [[ ! ${anat} == "null" ]]; then
		slicer ${anat} ${IMG}.nii.gz -a ${outdir}/${IMG}.png
	else
		slicer ${IMG}.nii.gz -a ${outdir}/${IMG}.png
	fi
done

if [ ! -f ${outdir}/gmwmi.png ]; then
	echo "failed"
	exit 1
else
	echo "complete"
	rm -rf *.nii.gz *.mif
	exit 0
fi
