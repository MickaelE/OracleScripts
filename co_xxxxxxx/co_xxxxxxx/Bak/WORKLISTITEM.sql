CREATE OR REPLACE VIEW BPHADMIN.AMWORKLISTITEMKEY( WORKLISTITEMKEY,
  EVENTCODE,
  TARGETENTITYKEY,
  TARGETENTITYTYPE,
  TARGETENTITYDISPLAYID,
  PERSONID,
  PERSONNAME,
  DISPLAYIDENTIFIER,
  BANKKEY,
  BANKGROUPID,
  CREATIONDATETIME,
  CLAIMDATETIME,
  COMPLETIONDATETIME,
  STATUS,
  --NARRATIVE,
  INFORMATIONFLAG,
  VERSION,
  WHENMODIFIED,
  MSGDOMAIN,
  MSGNUMBER,
 /* TOKEN1,
  TOKEN2,
  TOKEN3,
  TOKEN4,
  TOKEN5,
  TOKEN6,
  TOKEN7,
  TOKEN8,
  TOKEN9,
  TOKEN10,
  MSGTEXT,*/
  PRIORITY,
  CATEGORY,
  REVIEWEES,
  EQUIVALENTAMOUNT,
  LATESTSUBMISSIONTIME,
  PAYMENTAMOUNT,
  PAYMENTCURRENCY,
  PAYMENTPRIORITYLEVEL,
  NEXTEVALUATIONTIMESTAMP,
  PAYMENTIMPORTANCE,
  WORKQUEUEKEY)
AS
SELECT WORKLISTITEMKEY,
  EVENTCODE,
  TARGETENTITYKEY,
  TARGETENTITYTYPE,
  TARGETENTITYDISPLAYID,
  PERSONID,
  PERSONNAME,
  DISPLAYIDENTIFIER,
  BANKKEY,
  BANKGROUPID,
  CREATIONDATETIME,
  CLAIMDATETIME,
  COMPLETIONDATETIME,
  STATUS,
  --NARRATIVE,
  INFORMATIONFLAG,
  VERSION,
  WHENMODIFIED,
  MSGDOMAIN,
  MSGNUMBER,
 /* TOKEN1,
  TOKEN2,
  TOKEN3,
  TOKEN4,
  TOKEN5,
  TOKEN6,
  TOKEN7,
  TOKEN8,
  TOKEN9,
  TOKEN10,
  MSGTEXT,*/
  PRIORITY,
  CATEGORY,
  REVIEWEES,
  EQUIVALENTAMOUNT,
  LATESTSUBMISSIONTIME,
  PAYMENTAMOUNT,
  PAYMENTCURRENCY,
  PAYMENTPRIORITYLEVEL,
  NEXTEVALUATIONTIMESTAMP,
  PAYMENTIMPORTANCE,
  WORKQUEUEKEY
FROM BPHADMIN.WORKLISTITEM ;
quit;
