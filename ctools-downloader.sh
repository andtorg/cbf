#!/bin/bash

#NB create setupsamples during install

echo CHANGELOG:
echo
echo v0.1 still developing 

help (){

	echo 
	echo "Usage: ctools-downloader.sh -c ctoolsVersion -s saikuVersion -p saikuAdhocVersion"
	echo
	echo "-c    Ctools version number (only stable) (eg: 13.06.05)"
	echo "-s    Saiku plugin version number (eg: 2.4)"
	echo "-p    Saiku Adhoc plugin version number"
	echo "-h    This help screen"
	echo
	exit 1
}




BASE_DIR="pentaho-addons"
CTOOLS_DIR="ctools"
SAIKU_DIR="saiku"
SAIKU_ADHOC_DIR="saiku_adhoc"

TEMP_DIR=$BASE_DIR/tmp

VERSION_DIR="NUMBER"
SAIKU_VER_DIR="NUMBER"
SAIKU_ADHOC_VER_DIR="NUMBER"

while (("$#"))
do
    case "$1" in
	#--)	shift; break;;
	-c) VERSION_DIR="$2"; shift;;
	-s)	SAIKU_VER_DIR="$2"; shift;;
	-p) SAIKU_ADHOC_VER_DIR="$2"; shift;;
	*|-h)	help ;;
    esac
    shift
done



rm -rf $BASE_DIR/tmp
mkdir $TEMP_DIR





downloadCDF(){
	echo "downloading CDF..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDF-release/lastSuccessfulBuild/artifact/bi-platform-v2-plugin/dist/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -j $TEMP_DIR/dist.zip "dist/pentaho-cdf-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cdf
	unzip -j $TEMP_DIR/dist.zip "dist/pentaho-cdf-samples-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cdf
	rm $TEMP_DIR/dist.zip
	echo "CDF downloaded!"
}

downloadCDE(){
	echo "downloading CDE..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDE-release/lastSuccessfulBuild/artifact/server/plugin/dist/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/dist.zip "dist/pentaho-cdf-dd-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cde
	unzip -jo $TEMP_DIR/dist.zip "dist/pentaho-cdf-dd-solution-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cde
	rm $TEMP_DIR/dist.zip
	echo "CDE downloaded!"
}

downloadCDA(){
	echo "downloading CDA..."	
	URL='http://ci.analytical-labs.com/job/Webdetails-CDA-release/lastSuccessfulBuild/artifact/*zip*/archive.zip'	
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/archive.zip "archive/cda-pentaho/dist/cda-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cda
	unzip -jo $TEMP_DIR/archive.zip "archive/cda-pentaho/dist/cda-samples-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cda
	rm $TEMP_DIR/archive.zip
	echo "CDA downloaded!"
}


downloadCGG (){
	echo "downloading CGG..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CGG-release/lastSuccessfulBuild/artifact/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/dist.zip "archive/cgg-pentaho/dist/cgg-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cgg
	rm $TEMP_DIR/dist.zip
	echo "CGG downloaded!"
}

downloadCDC (){
	echo "downloading CDC..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDC-release/lastSuccessfulBuild/artifact/dist/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/dist.zip "dist/cdc-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cdc
	rm $TEMP_DIR/dist.zip
	echo "CDC downloaded!"
}

downloadCDB (){
	echo "downloading CDB..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDB-release/lastSuccessfulBuild/artifact/dist/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/dist.zip "dist/cdb-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cdb
	rm $TEMP_DIR/dist.zip
	echo "CDB downloaded!"
}

downloadCDV (){
	echo "downloading CDV..."
	URL='http://ci.analytical-labs.com/job/Webdetails-CDV-release/lastSuccessfulBuild/artifact/dist/*zip*/dist.zip'
	wget -P $TEMP_DIR $URL
	unzip -jo $TEMP_DIR/dist.zip "dist/cdv-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cdv
	unzip -jo $TEMP_DIR/dist.zip "dist/cdv-samples-"$VERSION_DIR".zip" -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cdv
	echo "CDV downloaded!"
}



downloadCtools(){
	# download all ctools	
		downloadCDF;
		downloadCDE;
		downloadCDA;
		downloadCGG;
		downloadCDC;
		downloadCDB;
		downloadCDV;
}



# create subfolders for addons  
if [ ! -d $BASE_DIR/$CTOOLS_DIR ]
then
	mkdir $BASE_DIR/$CTOOLS_DIR
fi

if [ ! -d $BASE_DIR/$SAIKU_DIR ]
then
	mkdir $BASE_DIR/$SAIKU_DIR
fi

if [ ! -d $BASE_DIR/$SAIKU_ADHOC_DIR ]
then
	mkdir $BASE_DIR/$SAIKU_ADHOC_DIR
fi



if [[ $VERSION_DIR != "NUMBER" ]]; then
	if [[ ! -d $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR ]]; then
		mkdir $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR
		downloadCtools;
	else 
		echo "The folder" \"$BASE_DIR/$CTOOLS_DIR/$VERSION_DIR\" "already exists. There is nothing I can do!"	
	fi
fi



