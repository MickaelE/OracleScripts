
set head off pagesize 0 linesize 100

select 'ALTER INDEX ' || index_owner || '.' || index_name || ' REBUILD SUBPARTITION ' ||
subpartition_name || ';'
from dba_ind_subpartitions
where  index_owner='BPHADMIN'
and status !='USABLE'
/
