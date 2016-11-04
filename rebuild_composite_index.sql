SET head OFF pagesize 0 linesize 100
SELECT 'ALTER INDEX '
  || index_owner
  || '.'
  || index_name
  || ' REBUILD SUBPARTITION '
  || subpartition_name
  || ';'
FROM dba_ind_subpartitions
WHERE index_owner='BPHADMIN'
AND status      !='USABLE' /
