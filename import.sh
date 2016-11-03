#!/bin/sh
#Script to Perform Datapump Import
################################################################
#Change History
#================
#DATE         AUTHOR                       cHANGE
#---------   -----------------------  -------------------
#20161027    Mickael Eriksson       New Script Created
#
#
#
################################################################

echo "#########################################################"
echo "Import utility for NePP databases"
echo "Version 1"
echo "#########################################################"


#Check if aruments are supplied.
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, You need to supply dumpfilename without .dmp"
    exit 1
fi
args=("$@")
filename=${args[0]}

impdp system/t6triton dumpfile=${filename}.dmp directory=DATA_PUMP_DIR_2 logfile=impdp-`date '+%d%m%Y_%H%M%S'`.log schemas=GSRGPETEST03_ORABAM,GSRGPETEST03_MDS,GSRGPETEST03_SOAINFRA,GSRGPETEST03_OPSS,GSRGPETEST03_ORASDPM,bphadmin 
