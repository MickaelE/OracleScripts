CREATE ROLE "ORM04_APP_ROLE" NOT IDENTIFIED;
 GRANT ALTER SESSION TO "ORM04_APP_ROLE";
 GRANT CREATE SESSION TO "ORM04_APP_ROLE";
 GRANT CREATE SYNONYM TO "ORM04_APP_ROLE";
 GRANT EXECUTE ON"SYS"."DBMS_LOB" TO "ORM04_APP_ROLE";
 GRANT EXECUTE ON"SYS"."DBMS_SYSTEM" TO "ORM04_APP_ROLE";