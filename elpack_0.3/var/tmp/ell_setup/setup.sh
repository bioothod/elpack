#!/bin/bash

function format {
	disk=$1
	mkfs.ext4 $disk
	tune2fs -m0 $disk
}

disks=`cat /var/tmp/disks.txt`

num=1
for disk in $disks; do
	echo $disk
	format $disk

	uuid=`blkid -o export $disk | grep UUID`
	fs=`blkid -o export $disk | grep TYPE | awk -F "=" {'print $2'}`
	mount_point="/mnt/ell.$num"
	mkdir -p $mount_point

	mount_options="defaults,noatime,barrier=0,nobarrier,nodelalloc"
	last_arguments="0 2"

	done="`grep $uuid /etc/fstab`"
	if test x"$done" = x""; then
		echo "$uuid $mount_point $fs $mount_options $last_arguments" >> /etc/fstab
	else
		echo "UUID $uuid is already installed: $done";
	fi
	num=$(($num + 1))
done
