#!/bin/bash

#NB create setupsamples during install

echo CHANGELOG:
echo
echo v0.1 still developing 

BASE_DIR="pentaho-addons"
TEMP_DIR=$BASE_DIR/tmp

VERSION_DIR=$1


rm -rf $BASE_DIR/tmp
mkdir $TEMP_DIR


downloadCDF(){
	echo "downloading CDF..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDF-release/lastSuccessfulBuild/artifact/bi-platform-v2-plugin/dist/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -j $TEMP_DIR/dist.zip "dist/pentaho-cdf-"$VERSION_DIR".zip" -d $BASE_DIR/$VERSION_DIR/cdf
	unzip -j $TEMP_DIR/dist.zip "dist/pentaho-cdf-samples-"$VERSION_DIR".zip" -d $BASE_DIR/$VERSION_DIR/cdf
	rm $TEMP_DIR/dist.zip
	echo "CDF downloaded!"
}

downloadCDE(){
	echo "downloading CDE..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDE-release/lastSuccessfulBuild/artifact/server/plugin/dist/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/dist.zip "dist/pentaho-cdf-dd-"$VERSION_DIR".zip" -d $BASE_DIR/$VERSION_DIR/cde
	unzip -jo $TEMP_DIR/dist.zip "dist/pentaho-cdf-dd-solution-"$VERSION_DIR".zip" -d $BASE_DIR/$VERSION_DIR/cde
	rm $TEMP_DIR/dist.zip
	echo "CDE downloaded!"
}

downloadCDA(){
	echo "downloading CDA..."	
	URL='http://ci.analytical-labs.com/job/Webdetails-CDA-release/lastSuccessfulBuild/artifact/*zip*/archive.zip'	
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/archive.zip "archive/cda-pentaho/dist/cda-"$VERSION_DIR".zip" -d $BASE_DIR/$VERSION_DIR/cda
	unzip -jo $TEMP_DIR/archive.zip "archive/cda-pentaho/dist/cda-samples-"$VERSION_DIR".zip" -d $BASE_DIR/$VERSION_DIR/cda
	rm $TEMP_DIR/archive.zip
	echo "CDA downloaded!"
}


downloadCGG (){
	echo "downloading CGG..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CGG-release/lastSuccessfulBuild/artifact/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/dist.zip "archive/cgg-pentaho/dist/cgg-"$VERSION_DIR".zip" -d $BASE_DIR/$VERSION_DIR/cgg
	rm $TEMP_DIR/dist.zip
	echo "CGG downloaded!"
}

downloadCDC (){
	echo "downloading CDC..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDC-release/lastSuccessfulBuild/artifact/dist/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/dist.zip "dist/cdc-"$VERSION_DIR".zip" -d $BASE_DIR/$VERSION_DIR/cdc
	rm $TEMP_DIR/dist.zip
	echo "CDC downloaded!"
}

downloadCDB (){
	echo "downloading CDB..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDB-release/lastSuccessfulBuild/artifact/dist/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/dist.zip "dist/cdb-"$VERSION_DIR".zip" -d $BASE_DIR/$VERSION_DIR/cdb
	rm $TEMP_DIR/dist.zip
	echo "CDB downloaded!"
}


downloadAll(){
	downloadCDF;
	downloadCDE;
	downloadCDA;
	downloadCGG;
	downloadCDC;
	downloadCDB;
}

if [ ! -d $BASE_DIR/$VERSION_DIR ]
then
	mkdir $BASE_DIR/$VERSION_DIR
	downloadAll;

else 
	echo The folder $BASE_DIR/$VERSION_DIR already exists. There is nothing I can do!
fi

