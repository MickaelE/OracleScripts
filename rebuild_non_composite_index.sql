alter index "BPHADMIN"."I_INTCHG_DISPLAYID" REBUILD  PARTITION "SYS_P54062" ;

select * from dba_ind_partitions
select 'alter index '|| index_owner||'.'||index_name ||' REBUILD  PARTITION  "' || partition_name || '";' 
from dba_ind_partitions where index_owner='BPHADMIN' and status !='USABLE';

select * from dba_ind_partitions where index_name='I_INTCHG_DISPLAYID';

set head off pagesize 0 linesize 100

select 'ALTER INDEX ' || index_owner || '.' || index_name || ' REBUILD SUBPARTITION ' ||
subpartition_name || ';'
from dba_ind_subpartitions
where  index_owner='BPHADMIN'
and status !='USABLE'
/
