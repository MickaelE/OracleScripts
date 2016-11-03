SELECT p.availability,
  b.bankname
FROM BPHADMIN.participant p,
  BPHADMIN.bankdepartment d,
  BPHADMIN.bank b
WHERE (p.externalId ='NDEADKK0'
OR p.externalId = 'NDEANOK0'
OR p.externalId = 'NDEASES0'
OR p.externalId = 'NDEAGB20'
OR p.externalId = 'SMARTI')
AND p.owningbankdepartmentkey = d.bankdepartmentkey
AND d.bankkey                 = b.bankkey
AND b.bankname                = 'SCT Interbank';