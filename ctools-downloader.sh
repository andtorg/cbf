#!/bin/bash

echo CHANGELOG:
echo
echo v0.1 still developing 

BASE_DIR="pentaho-addons"
VERSION_DIR=$1

rm -rf $BASE_DIR/tmp
mkdir $BASE_DIR/tmp


downloadCDF(){
	echo "downloading CDF..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDF-release/lastSuccessfulBuild/artifact/bi-platform-v2-plugin/dist/*zip*/dist.zip'
	wget -P $BASE_DIR/tmp $URL 
	#rm -f .tmp/dist/marketplace.xml
	#unzip .tmp/dist/dist.zip -d .tmp > /dev/null
	echo "CDF downloaded!"
}

downloadAll(){
	downloadCDF;

}

if [ ! -d $BASE_DIR/$VERSION_DIR ]
then
	mkdir $BASE_DIR/$VERSION_DIR
	downloadAll;

else 
	echo The folder $BASE_DIR/$VERSION_DIR already exists. There is nothing I can do!
fi

