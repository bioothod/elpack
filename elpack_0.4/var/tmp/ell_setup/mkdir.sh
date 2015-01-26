#!/bin/bash

disks=`cat /var/tmp/disks.txt`

num=1
for disk in $disks; do
	mount_point="/mnt/ell.$num"
	mkdir -p $mount_point/elliptics/{data,history,log}

	num=$(($num + 1))
done
