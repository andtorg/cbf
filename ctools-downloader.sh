#!/bin/bash

#NB create setupsamples during install

echo CHANGELOG:
echo
echo v1.0 
echo

help (){

	echo 
	echo "Usage: ctools-downloader.sh -m mode -c ctoolsVersion -s saikuVersion -p saikuAdhocVersion -l pentahoSolutionPath -w pentahoWebappPath"
	echo
	echo "-m    mode to be set either as \"download\" or \"install\""
	echo "-c    ctools version number (only stable) (eg: 13.06.05)"
	echo "-s    saiku plugin version number (eg: 2.4)"
	echo "-p    saiku Adhoc plugin version number"
	echo "-l    pentaho solution path"
	echo "-w    pentaho webapp server path (required for cgg on versions before 4.5. eg: /biserver-ce/tomcat/webapps/pentaho)"
	echo "-h    this help screen"
	echo
	exit 1
}

coloredPrint (){
	# Print a message in a specific color to standard output
	# Usage: coloredPrint color message
	local red=$(tput setaf 1) green=$(tput setaf 2) reset=$(tput sgr0)
	case "$1" in
		green) echo $green$2$reset;;
		red) echo $red$2$reset;;
		*) echo "$1 does not seem to be a color"
    esac
}



BASE_DIR="pentaho-addons"
CTOOLS_DIR="ctools"
SAIKU_DIR="saiku"
SAIKU_ADHOC_DIR="saiku_adhoc"

TEMP_DIR=$BASE_DIR/tmp

VERSION_DIR="NUMBER"
SAIKU_VERSION="NUMBER"
SAIKU_ADHOC_VERSION="NUMBER"

SOLUTION_DIR='PATH'	
WEBAPP_PATH='PATH'


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
	-l) SOLUTION_DIR="$2"; shift;;
	-w) WEBAPP_PATH="$2"; shift;;
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




# Define install functions
setupSamples() {
	if [ ! -d  $SOLUTION_DIR/plugin-samples ]
	then
		mkdir $SOLUTION_DIR/plugin-samples
	fi
	
	if [ ! -f  $SOLUTION_DIR/plugin-samples/index.xml ]
	then
		echo '<index><visible>true</visible><name>Plugin Samples</name><description>Plugin Samples</description></index>' > $SOLUTION_DIR/plugin-samples/index.xml
	fi		
}

installCDF (){
	coloredPrint green "Installing CDF..."
	rm -rf $SOLUTION_DIR/system/pentaho-cdf
	# Removing samples dir. First two are deprecated
	rm -rf $SOLUTION_DIR/bi-developers/cdf-samples	
	rm -rf $SOLUTION_DIR/plugin-samples/cdf-samples	
	rm -rf $SOLUTION_DIR/plugin-samples/pentaho-cdf
	
	unzip $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cdf/pentaho-cdf-$VERSION_DIR.zip -d $SOLUTION_DIR/system/ > /dev/null
	setupSamples
	unzip $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cdf/pentaho-cdf-samples-$VERSION_DIR.zip -d $SOLUTION_DIR/plugin-samples/ > /dev/null
	coloredPrint green "CDF Installed!"
}


installCDE (){
	coloredPrint green "Installing CDE..."
	rm -rf $SOLUTION_DIR/system/pentaho-cdf-dd
	# Removing samples dir. First two are deprecated
	rm -rf $SOLUTION_DIR/cde_sample
	rm -rf $SOLUTION_DIR/plugin-samples/cde_sample
	rm -rf $SOLUTION_DIR/plugin-samples/pentaho-cdf-dd
	
	unzip $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cde/pentaho-cdf-dd-$VERSION_DIR.zip -d $SOLUTION_DIR/system/ > /dev/null
	setupSamples
	unzip $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cde/pentaho-cdf-dd-solution-$VERSION_DIR.zip -d $SOLUTION_DIR/plugin-samples/ > /dev/null
	coloredPrint green "CDE Installed!"
}

installCDA (){
	coloredPrint green "Installing CDA..."
	rm -rf $SOLUTION_DIR/system/cda
	# Removing samples dir. First is deprecated
	rm -rf $SOLUTION_DIR/bi-developers/cda
	rm -rf $SOLUTION_DIR/plugin-samples/cda
		
	unzip $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cda/cda-$VERSION_DIR.zip -d $SOLUTION_DIR/system/ > /dev/null			
	setupSamples	
	unzip $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cda/cda-samples-$VERSION_DIR.zip -d $SOLUTION_DIR/plugin-samples/ > /dev/null
	coloredPrint green "CDA Installed!" 
}

installCGG (){
	coloredPrint green "Installing CGG..."
	rm -rf $SOLUTION_DIR/system/cgg
	unzip $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cgg/cgg-$VERSION_DIR.zip -d $SOLUTION_DIR/system/ > /dev/null			
	
	# Changes to the server; 1 - delete batik; 2 - copy new one plus xml and fop
	if [[ $WEBAPP_PATH != 'PATH' ]]
	then
		LIB_DIR=$WEBAPP_PATH/WEB-INF/lib
		CGG_DIR=$SOLUTION_DIR/system/cgg/lib
		rm -rf $LIB_DIR/batik-* $LIB_DIR/xml-apis* $LIB_DIR/xmlgraphics*
		cp $CGG_DIR/batik-[^j]* $CGG_DIR/xml* $LIB_DIR
		coloredPrint green "CGG Installed!" 
	else
		echo
		echo coloredPrint red ' [CGG] No webapp path provided, if you are using pentaho older than 4.5 cgg will not work properly)'
	fi
}

installCDC (){
	coloredPrint green "Installing CDC..."
	rm -rf $SOLUTION_DIR/system/cdc
	unzip $BASE_DIR/$CTOOLS_DIR/$VERSION_DIR/cdc/cdc-$VERSION_DIR.zip -d $SOLUTION_DIR/system/ > /dev/null			

	# Changes to the server; 
	# 1 - copy hazelcast to WEB-INF/lib
	LIB_DIR=$WEBAPP_PATH/WEB-INF/lib
	CDC_HAZELCAST_DIR=$SOLUTION_DIR/system/cdc/pentaho-lib
	rm -rf $LIB_DIR/hazelcast-*.jar		
	rm -rf $LIB_DIR/cdc-hazelcast-*.jar		
	cp $CDC_HAZELCAST_DIR/*.jar  $LIB_DIR
	coloredPrint green "CDC Installed!" 
}

# for install mode
installing (){
	# installCDF;
	# installCDE;
	# installCDA;
	# installCGG;
	installCDC;
}


if [[ $MODE = "download" ]]
	then
		downloading;
	else
		installing;
fi

