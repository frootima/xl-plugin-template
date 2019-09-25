#!/bin/bash

#
# XebiaLabs Configure Plugin Directory:  xl-configure-plugin-directory.sh
# XebiaLabs, Dave Roberts, September 23 2017
#

echo
echo "Command format is ../xl-configure-plugin-directory.sh LCPLUGINNAME SCRIPTDIRNAME WEBSCRIPTDIRNAME"
echo
echo "LCPLUGINNAME should be hyphenated lowercase, e.g., xl-my-demo-plugin"
echo "SCRIPTDIRNAME should be camelcase, e.g., MyDemo"
echo "WEBSCRIPTDIRNAME should be hyphenated lowercase, e.g., my-demo"
echo
echo "Or, execute without arguments and enter responses at the prompts"
echo
echo "Execute from your local github/xebialabs, github/xebialabs-community, or xebialabs-external directory"
echo

#
# Organize parameters
#

if [ $# -lt 1 ]
then
    read -p "Lowercase plugin name (LCPLUGINNAME): " LCPLUGINNAME
else
    LCPLUGINNAME="$1"
fi

if [ $# -lt 2 ]
then
    read -p "Script directory (SCRIPTDIRNAME): " SCRIPTDIRNAME
else
    SCRIPTDIRNAME="$2"
fi

if [ $# -lt 3 ]
then
    read -p "Web script directory (WEBSCRIPTDIRNAME): " WEBSCRIPTDIRNAME
else
    WEBSCRIPTDIRNAME="$3"
fi

if [ $# -gt 3 ]
then
  echo "Too many arguments were supplied"
  echo "Ignoring extra arguments and continuing"
  echo
fi

XLPLUGINTEMPLATE="$(dirname $0)"

echo "Plugin name:           $LCPLUGINNAME"
echo "Script directory:      $SCRIPTDIRNAME"
echo "Web script directory:  $WEBSCRIPTDIRNAME"
echo

#
# Make the LCPLUGINNAME and images directories
#

mkdir -p $LCPLUGINNAME/images

#
# Copy the mostly static root components
#

cp -R $XLPLUGINTEMPLATE/gradle $LCPLUGINNAME
cp $XLPLUGINTEMPLATE/.gitignore $XLPLUGINTEMPLATE/.travis.yml $XLPLUGINTEMPLATE/build.gradle $XLPLUGINTEMPLATE/gradlew $XLPLUGINTEMPLATE/gradlew.bat $XLPLUGINTEMPLATE/License.md $LCPLUGINNAME

#
# Sed the files that need LCPLUGINNAME replaced
#

sed "s/LCPLUGINNAME/$LCPLUGINNAME/g" $XLPLUGINTEMPLATE/README-TEMPLATE.md > $LCPLUGINNAME/README.md
sed "s/LCPLUGINNAME/$LCPLUGINNAME/g" $XLPLUGINTEMPLATE/settings.gradle > $LCPLUGINNAME/settings.gradle

#
# Make the remaining directories and copy the rest of the files
#

# Java
mkdir -p $LCPLUGINNAME/src/main/java
cp $XLPLUGINTEMPLATE/src/main/java/template.java $LCPLUGINNAME/src/main/java

# Resources
mkdir -p $LCPLUGINNAME/src/main/resources/$SCRIPTDIRNAME
cp $XLPLUGINTEMPLATE/src/main/resources/plugin-version.properties $LCPLUGINNAME/src/main/resources

# synthetic.xml, xl-rest-endpoints.xml, xl-rules.xml, xl-ui-plugin.xml
cp $XLPLUGINTEMPLATE/src/main/resources/*.xml $LCPLUGINNAME/src/main/resources

# template.py, template.sh.ftl, template.xml
cp $XLPLUGINTEMPLATE/src/main/resources/template/template.* $LCPLUGINNAME/src/main/resources/$SCRIPTDIRNAME

# Web for XL Deploy UI extension
mkdir -p $LCPLUGINNAME/src/main/resources/web/$WEBSCRIPTDIRNAME/css
mkdir -p $LCPLUGINNAME/src/main/resources/web/$WEBSCRIPTDIRNAME/js
cp $XLPLUGINTEMPLATE/src/main/resources/web/template-for-xld-ui-extension/index.html $LCPLUGINNAME/src/main/resources/web/$WEBSCRIPTDIRNAME/index.html
cp $XLPLUGINTEMPLATE/src/main/resources/web/template-for-xld-ui-extension/css/cc-fonts.css $LCPLUGINNAME/src/main/resources/web/$WEBSCRIPTDIRNAME/css/cc-fonts.css
cp $XLPLUGINTEMPLATE/src/main/resources/web/template-for-xld-ui-extension/css/template.css $LCPLUGINNAME/src/main/resources/web/$WEBSCRIPTDIRNAME/css/$WEBSCRIPTDIRNAME.css
cp $XLPLUGINTEMPLATE/src/main/resources/web/template-for-xld-ui-extension/js/template.js $LCPLUGINNAME/src/main/resources/web/$WEBSCRIPTDIRNAME/js/$WEBSCRIPTDIRNAME.js

# Web for XL Release tile
mkdir -p $LCPLUGINNAME/src/main/resources/web/include/$WEBSCRIPTDIRNAME/css
mkdir -p $LCPLUGINNAME/src/main/resources/web/include/$WEBSCRIPTDIRNAME/js
cp $XLPLUGINTEMPLATE/src/main/resources/web/include/template-for-xlr-tile/index.html $LCPLUGINNAME/src/main/resources/web/include/$WEBSCRIPTDIRNAME/index.html
cp $XLPLUGINTEMPLATE/src/main/resources/web/include/template-for-xlr-tile/css/cc-fonts.css $LCPLUGINNAME/src/main/resources/web/include/$WEBSCRIPTDIRNAME/css/cc-fonts.css
cp $XLPLUGINTEMPLATE/src/main/resources/web/include/template-for-xlr-tile/css/template.css $LCPLUGINNAME/src/main/resources/web/include/$WEBSCRIPTDIRNAME/css/$WEBSCRIPTDIRNAME.css
cp $XLPLUGINTEMPLATE/src/main/resources/web/include/template-for-xlr-tile/js/template.js $LCPLUGINNAME/src/main/resources/web/include/$WEBSCRIPTDIRNAME/js/$WEBSCRIPTDIRNAME.js

echo "Complete"
echo
