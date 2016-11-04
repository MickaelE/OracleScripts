SET head OFF pagesize 0 linesize 100
SELECT 'alter index '
  || index_owner
  ||'.'
  ||index_name
  ||' REBUILD  PARTITION  "'
  || partition_name
  || '";'
FROM dba_ind_partitions
WHERE index_owner='BPHADMIN'
AND status      !='USABLE'
AND composite    ='NO';
