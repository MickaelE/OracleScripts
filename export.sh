#!/bin/sh
#Script to Perform Datapump Export.
################################################################
#Change History
#================
#DATE         AUTHOR                       CHANGE
#---------   -----------------------  -------------------
#20161017    Mickael Eriksson        New Script Created
#
#
#
################################################################
expdp system/t6triton dumpfile=expdp-`date '+%d%m%Y_%H%M%S'`.dmp directory=DATA_PUMP_DIR_2 logfile=expdp-`date '+%d%m%Y_%H%M%S'`.log schemas=GSRGPETEST03_ORABAM,GSRGPETEST03_MDS,GSRGPETEST03_SOAINFRA,GSRGPETEST03_OPSS,GSRGPETEST03_ORASDPM,bphadmin 
