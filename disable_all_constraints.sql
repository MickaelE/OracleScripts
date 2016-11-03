set feedback off 
set verify off 
set wrap off 
set echo off 
prompt Finding constraints to enable... 
set termout off 
set lines 120 
set heading off 
spool tmp_enable.sql 
select 'spool igen_enable.log;' from dual; 
select 'ALTER TABLE '||substr(c.table_name,1,35)|| 
 ' ENABLE CONSTRAINT '||constraint_name||' ;' 
from dba_constraints c, dba_tables u 
where c.table_name = u.table_name
and u.owner='SCT02_BPHADMIN'; 
/ 
select 'exit;' from dual; 
set termout on 
prompt Enabling constraints now... 
set termout off 
@tmp_enable; 
!rm -i tmp_enable.sql; 
exit 
/ 
