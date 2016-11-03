UPDATE BPHADMIN.participant
SET availability = 'T'
  -- ALL participants for SCT Finland
WHERE (owningbankdepartmentkey =
  (SELECT bankdepartmentkey
  FROM BPHADMIN.bankdepartment
  WHERE bankkey =
    ( SELECT bankkey FROM BPHADMIN.bank WHERE bankname = 'SCT Finland'
    )
  )
AND availability != 'T' )
OR (
  -- Nordea Finland for SCT Interbank:
  -- NDEAFIHH for PROD
  -- NDEAFIH0 for TEST
  externalid               IN ('NDEAFIHH', 'NDEAFIH0')
AND owningbankdepartmentkey =
  (SELECT bankdepartmentkey
  FROM BPHADMIN.bankdepartment
  WHERE bankkey =
    ( SELECT bankkey FROM BPHADMIN.bank WHERE bankname = 'SCT Interbank'
    )
  )
AND availability != 'T' ) ;
