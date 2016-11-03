Disable: 

set feedback off 
set verify off 
set echo off 
prompt Finding constraints to disable... 
set termout off 
set pages 80 
set heading off 
set linesize 120 
spool tmp_disable.sql 
select 'spool igen_disable.log;' from dual; 
select 'ALTER TABLE '||substr(c.table_name,1,35)|| 
 ' DISABLE CONSTRAINT '||constraint_name||' ;' 
from dba_constraints c, dba_tables u 
where c.table_name = u.table_name
and u.owner='SCT02_BPHADMIN'; 
select 'exit;' from dual; 
set termout on 
prompt Disabling constraints now... 
set termout off 
--@tmp_disable.sql; 
exit 
/ 