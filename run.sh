#!/bin/bash

# noddi
icvf=`jq -r '.icvf' config.json`
od=`jq -r '.od' config.json`
isovf=`jq -r '.isovf' config.json`
met="icvf od isovf"

outdir="raw"

mkdir -p $outdir

for MET in $met
do
	img=$(eval "echo \$${MET}")
	slicer ${img} -a ${outdir}/${MET}.png
done

if [ ! -f ${outdir}/isovf.png ]; then
	echo "failed"
	exit 1
else
	echo "complete"
	exit 0
fi
