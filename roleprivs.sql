select 'grant ' || privilege ||' on '||owner||'.' || table_name ||' to'|| ' BPH_READ_ROLE_RESTRICTED'
 from dba_tab_privs where grantee like upper('BPH_READ_ROLE') 
 and table_name in ('AMBLACKLIST','AMBLACKLIST_D','AMPAYMENTTRANSACTION','AMREPORTBLOCKDETAIL','ACCOUNTPOSTING') order by privilege;