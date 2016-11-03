UPDATE BPHADMIN.participant
SET availability            = 'F'
WHERE externalId           IN ('NDEADKK0', 'NDEANOK0', 'NDEASES0', 'NDEAGB20', 'SMARTI')
AND owningbankdepartmentkey =
  (SELECT bankdepartmentkey
  FROM BPHADMIN.bankdepartment
  WHERE bankkey =
    ( SELECT bankkey FROM BPHADMIN.bank WHERE bankname = 'SCT Interbank'
    )
  );