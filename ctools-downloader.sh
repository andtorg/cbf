#!/bin/bash

#NB create setupsamples during install

echo CHANGELOG:
echo
echo v1.0 
echo

help (){

	echo 
	echo "Usage: ctools-downloader.sh -c ctoolsVersion -s saikuVersion -p saikuAdhocVersion"
	echo
	echo "-m    Mode to be set either for download or install"
	echo "-c    Ctools version number (only stable) (eg: 13.06.05)"
	echo "-s    Saiku plugin version number (eg: 2.4)"
	echo "-p    Saiku Adhoc plugin version number"
	echo "-h    This help screen"
	echo
	exit 1
}

# variables for colors
red=$(tput setaf 1)
reset=$(tput sgr0)


BASE_DIR="pentaho-addons"
CTOOLS_DIR="ctools"
SAIKU_DIR="saiku"
SAIKU_ADHOC_DIR="saiku_adhoc"

TEMP_DIR=$BASE_DIR/tmp

VERSION_DIR="NUMBER"
SAIKU_VERSION="NUMBER"
SAIKU_ADHOC_VERSION="NUMBER"

MODE="TO-SET"

(("$#")) || help

while (("$#"))
do
    case "$1" in
	#--)	shift; break;;
	-m) MODE="$2"; shift;;
	-c) VERSION_DIR="$2"; shift;;
	-s)	SAIKU_VERSION="$2"; shift;;
	-p) SAIKU_ADHOC_VERSION="$2"; shift;;
	*|-h)	help ;;
    esac
    shift
done

if [[ $MODE != install && $MODE != download ]]; then
	
	echo $red"Mode not set; use either \"-m download\" or \"-m install\"" $reset
	exit 1
fi



# rm -rf $TEMP_DIR
# mkdir $TEMP_DIR





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
	rm $TEMP_DIR/dist.zip
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

downloadSaiku (){
	echo "downloading Saiku plugin..."
	URL='http://analytical-labs.com/downloads/saiku-plugin-'$SAIKU_VERSION'.zip'
	rm -f $BASE_DIR/$SAIKU_DIR/"saiku-plugin-"$SAIKU_VERSION".zip" #remove if already exists
	wget -P $BASE_DIR/$SAIKU_DIR $URL
	echo "Saiku downloaded!"
}

downloadSaikuAdhoc (){
	echo "downloading Saiku-Adhoc plugin..."
	URL='https://github.com/Mgiepz/saiku-reporting/raw/gh-pages/downloads/saiku-adhoc-plugin-'$SAIKU_ADHOC_VERSION'.zip'
	rm -f $BASE_DIR/$SAIKU_ADHOC_DIR/"saiku-plugin-"$SAIKU_ADHOC_VERSION".zip" #remove if already exists
	wget -P $BASE_DIR/$SAIKU_ADHOC_DIR $URL
	echo "Saiku-Adhoc plugin downloaded!"
}

# for download mode
downloading() { 

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

	if [[ $SAIKU_VERSION != "NUMBER" ]]; then
		downloadSaiku;
	fi

	if [[ $SAIKU_ADHOC_VERSION != "NUMBER" ]]; then
		downloadSaikuAdhoc;
	fi
}

if [[ $MODE = "download" ]]
	then
		downloading;
	else
		echo $red"this should install something"$reset
fi

