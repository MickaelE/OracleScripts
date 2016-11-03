    SET SERVEROUTPUT ON SIZE UNLIMITED
    SET LINESIZE 255
--'2019-02-01'
DECLARE
  vOwner         VARCHAR2(30) := 'BPHADMIN';
  vHashPartCount INT := '8';
  TYPE vArrayT IS VARRAY(1024) OF VARCHAR2(30);
  vArrayPart    vArrayT;
  vArraySubPart vArrayT;
  vYear         INT;
  vMonth        INT;
  vMonthStart   INT;
  vMonthEnd     INT;
BEGIN
  dbms_output.put_line('splitMonthlyPartitionsAndSubPartitions for ' ||
                       vOwner || ' started.');

  --calculate the month and year
  vYear       := to_char(SYSDATE, 'YYYY');
  vMonthStart := to_char(SYSDATE, 'MM');
  vMonthEnd   := vMonthStart + 8;
  vMonth      := vMonthStart;

  FOR i IN vMonthStart .. vMonthEnd LOOP

    FOR vTableName IN (SELECT table_name
                         FROM all_part_TABLES
                        WHERE owner = vOwner) LOOP
      dbms_output.put_line('splitMonthlyPartitions for ' || vTableName.Table_Name || ', vYear=' || vYear || ', vMonth=' || vMonth);
   --   BPHADMIN.NDA_CREATE_MONTH_PARTITION(vTableName.Table_name, vOwner, vYear, vMonth, vHashPartCount);
    END LOOP;
    --next month
    vMonth := vMonth + 1;
    IF (vMonth > 12) THEN
      vMonth := 1;
      vYear  := vYear + 1;
    END IF;
  END LOOP;

  dbms_output.put_line('splitMonthlyPartitionsAndSubPartitions for ' ||
                       vOwner || ' finished.');

END;
/