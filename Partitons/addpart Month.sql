DECLARE
  PTABLENAME VARCHAR2(200);
  POWNER VARCHAR2(200);
  PYEAR NUMBER;
  PMONTH NUMBER;
  PHASHPARTCOUNT VARCHAR2(200);
BEGIN
  PTABLENAME := 'PAYMENTRECONCILIATION';
  POWNER := 'BPHADMIN';
  PYEAR := 2016;
  PMONTH := 6;
  PHASHPARTCOUNT := 8;
 for i in 1..9 loop
  BPHADMIN.NDA_CREATE_MONTH_PARTITION(
    PTABLENAME => PTABLENAME,
    POWNER => POWNER,
    PYEAR => PYEAR,
    PMONTH => i,
    PHASHPARTCOUNT => PHASHPARTCOUNT
  );
  end loop;
END;
