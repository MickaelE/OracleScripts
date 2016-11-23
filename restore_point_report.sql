SET UNDERLINE '='
TTITLE CENTER 'Restore points' SKIP 2
COLUMN host_name HEADING 'Host' FORMAT A15 
COLUMN instance_name HEADING 'Instance' FORMAT A10
COLUMN name HEADING 'Name' FORMAT A20
COLUMN time HEADING 'Date' FORMAT a10
select i.host_name, i.instance_name, r.name, TO_CHAR(r.time,'YYYY/MM/DD') as time from v$instance i, v$restore_point r order by r.time;
exit
