-- Script to generate lock-commands
select 'alter user '||username||' account unlock;' lock_command from dba_users 
where account_status like '%LOCK%'
and username not in
('ANONYMOUS', 'APPQOSSYS', 'BI', 'CTXSYS', 'DBSNMP', 'DIP', 'DMSYS',
'EXFSYS', 'HR', 'IX', 'LBACSYS', 'MDDATA', 'MDSYS', 'MGMT_VIEW',
'ODM', 'ODM_MTR', 'OE', 'OLAPSYS', 'ORACLE_OCM', 'ORDDATA', 'ORDPLUGINS', 
 'ORDSYS', 'OUTLN', 'PM', 'PUBLIC', 'SCOTT', 'SH', 'SI_INFORMTN_SCHEMA',
'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'SYS', 'SYSMAN', 
 'SYSTEM', 'TRACESRV', 'TSMSYS', 'MTSSYS', 'OASPUBLIC', 'OLAPSYS', 'OWBSYS',
'OWBSYS_AUDIT', 'WEBSYS', 'WK_PROXY', 'WKSYS', 'WK_TEST', 'WMSYS', 'XS$NULL',
'XDB', 'OSE$HTTP$ADMIN', 'AURORA$JIS$UTILITY$', 'AURORA$ORB$UNAUTHENTICATED' ) -- Oracle internal accounts
and username not in ('BPHADMIN', 'GGSMGR', 'GGSMGR1')
order by 1
/

select 'alter user '||username||' account unlock;' lock_command from dba_users 
where account_status  like '%LOCK%'
and username not in
('ANONYMOUS', 'APPQOSSYS', 'BI', 'CTXSYS', 'DBSNMP', 'DIP', 'DMSYS',
'EXFSYS', 'HR', 'IX', 'LBACSYS', 'MDDATA', 'MDSYS', 'MGMT_VIEW',
'ODM', 'ODM_MTR', 'OE', 'OLAPSYS', 'ORACLE_OCM', 'ORDDATA', 'ORDPLUGINS', 
 'ORDSYS', 'OUTLN', 'PM', 'PUBLIC', 'SCOTT', 'SH', 'SI_INFORMTN_SCHEMA',
'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'SYS', 'SYSMAN', 
 'SYSTEM', 'TRACESRV', 'TSMSYS', 'MTSSYS', 'OASPUBLIC', 'OLAPSYS', 'OWBSYS',
'OWBSYS_AUDIT', 'WEBSYS', 'WK_PROXY', 'WKSYS', 'WK_TEST', 'WMSYS', 'XS$NULL',
'XDB', 'OSE$HTTP$ADMIN', 'AURORA$JIS$UTILITY$', 'AURORA$ORB$UNAUTHENTICATED' ) -- Oracle internal accounts
and username not in ('SCT_BPHADMIN', 'GGSMGR', 'GGSMGR1')
order by 1
/

-- Check
select username, account_status from dba_users order by 1;
