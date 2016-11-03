#!/bin/bash
. 
./vars.sh


# Run installation

sqlplus "system/${SYSTEM_PASSWORD} " @accountposting.
sql
sqlplus "system/${SYSTEM_PASSWORD} " @BLACKLIST.sql       

sqlplus "system/${SYSTEM_PASSWORD} " @REPORTBLOCKDETAIL.
sql
sqlplus "system/${SYSTEM_PASSWORD} " @BLACKLIST_D.sql    

sqlplus "system/${SYSTEM_PASSWORD} " @PAYMENTTRANSACTION.sql     

sqlplus "system/${SYSTEM_PASSWORD} " @WORKLISTITEM.
sql
sqlplus "system/${SYSTEM_PASSWORD} " @CreateReadRole.sql


sql
sqlplus "system/${SYSTEM_PASSWORD} " @synonyms.sql

