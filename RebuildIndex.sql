SELECT  'alter index ' || index_owner|| '.' ||  index_name || ' rebuild partition ' ||  partition_name ||';'
FROM   dba_ind_PARTITIONS
WHERE  status = 'UNUSABLE';
/
SELECT 'ALTER INDEX ' || a.index_name || ' REBUILD;'
FROM   dba_indexes a
WHERE  status = 'UNUSABLE';
/