#!/bin/bash
vo=`cat version`
vn=$((vo+1))
git mv elpack_0.$vo elpack_0.$vn
sed -e "s/^Version.*/Version: 0.$vn/" -i elpack_0.${vn}/DEBIAN/control

dpkg-deb --build elpack_0.$vn deb

echo $vn > version

git add *

git commit -m "New version 0.${vn}"

#git push
