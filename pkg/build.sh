#!/bin/bash

set -e
pwd=$(pwd)

version=$(jq -r ".version" ../src/plugin.json)
signkey=C406404B2459FE0B1C6CC19D3738126EDA91C86B
pkgdir=$(pwd)/../..

echo "- Arranging files..."
mkdir -p /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version/opt/dsf/plugins/SpyglassWebcamServer
cp -r $pwd/DEBIAN /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version/DEBIAN
cp -r $pwd/etc /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version/etc
cp -r ../src/dsf /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version/opt/dsf/plugins/SpyglassWebcamServer/dsf
cp -r ../src/sd /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version/opt/dsf/sd
cp ../src/plugin.json /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version/opt/dsf/plugins/SpyglassWebcamServer.json

echo "- Preparing package index"
sed -i "s/VERSION/$version/g" /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version/DEBIAN/control
sed -i "s/VERSION/$version/g" /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version/DEBIAN/changelog

echo "- Packaging files..."
cd /tmp/spyglasswebcamserverplugin
dpkg-deb --build -Zxz spyglasswebcamserverplugin_$version
dpkg-sig -k $signkey -s builder spyglasswebcamserverplugin_$version.deb
mv /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version.deb $pkgdir/spyglasswebcamserverplugin_$version.deb
rm -rf /tmp/spyglasswebcamserverplugin/spyglasswebcamserverplugin_$version

