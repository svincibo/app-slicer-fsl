#!/bin/bash

# noddi
fa=`jq -r '.fa' config.json`
md=`jq -r '.md' config.json`
ad=`jq -r '.ad' config.json`
rd=`jq -r '.rd' config.json`
met="fa md ad rd"

outdir="raw"

mkdir -p $outdir

for MET in $met
do
	img=$(eval "echo \$${MET}")
	slicer ${img} -a ${outdir}/${MET}.png
done

if [ ! -f ${outdir}/rd.png ]; then
	echo "failed"
	exit 1
else
	echo "complete"
	exit 0
fi
