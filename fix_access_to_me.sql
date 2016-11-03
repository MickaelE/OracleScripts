-- Version "2016-02-17"
-- ...added "BPHRPT:BPH_READ_ROLE" as valid owner-grantee pair
create or replace
procedure fix_access_to_me
  ( p_schema varchar2, p_read_grantee varchar2 default user,
    p_incl_private_synonyms boolean default true,
    p_excl_type_list varchar2 default null, p_excl_obj_list varchar2 default null )
is
  -- Only "object owners - reader schema" pairs are allowed
  -- Example 'OWNERSCH1:ReaderSchA,OWNERSCH1:ReaderSchB,OWNERSCH2:ReaderSchB'
  C_ALLOWED_OWNER_READER_PAIRS constant varchar2(4000) :=
    'BPHADMIN:BPH_READ_ROLE,BPH:BPH_READ_ROLE,BPHRPT:BPH_READ_ROLE,BPHADMIN:GpeDbRead,SCT03_BPHADMIN:GpeDbRead03,SCT03_BPHADMIN:SCT03_BPH_READ_ROLE,SCT04_BPHADMIN:GpeDbRead04,SCT04_BPHADMIN:SCT04_BPH_READ_ROLE';
  l_own_read_pair varchar2(70);
  l_access_allowed boolean := false;
  l_excls varchar2(4000);
  l_obj_sql varchar2(32767) :=
    'select object_type, object_name from dba_objects '
      ||'where owner = '''||upper(p_schema)
      ||''' and object_type in (''TABLE'',''VIEW'',''MATERIALIZED VIEW'')';
  l_object_type varchar2(30);
  l_object varchar2(30);
  l_ddl varchar2(4000);
  l_obj_cnt number := 0;
  l_tab_cnt number := 0;
  l_view_cnt number := 0;
  l_mview_cnt number := 0;
  l_cnt number;
        l_grantee varchar2(30) := upper(p_read_grantee);
  rc_objs sys_refcursor;
  --
  function itm_cnt(p_str varchar2, p_del varchar2 default ',') return number is
  begin
    return regexp_count(p_str||p_del,',');
  end itm_cnt;
  function itm_at(p_str varchar2, p_ix number, p_del varchar2 default ',') return varchar2 is
  begin
    return regexp_substr(p_str||p_del, '([^'||p_del||']*)'||p_del||'|$', 1, p_ix, NULL, 1);
  end itm_at;
  procedure log(p_str varchar2) is
  begin
    dbms_output.put_line(p_str);
  end log;
begin --------------------------------------------------------------------------
  dbms_output.enable(1000000);
  -- First check it the chosen grantee exists
  with v_grantees as
  (select username g from dba_users union all select role g from dba_roles)
  select count(*) into l_cnt from v_grantees where g = l_grantee;
  if l_cnt = 0 then
    log('The role or user '||l_grantee||' doesn''t exist!');
    return;
  end if;
  -- Then check if acccess to chosen schema is allowed for the chosen grantee
  for i in 1..itm_cnt(C_ALLOWED_OWNER_READER_PAIRS) loop
    l_own_read_pair := upper( itm_at(C_ALLOWED_OWNER_READER_PAIRS,i) );
    l_access_allowed := upper(p_schema)||':'||l_grantee = l_own_read_pair;
    exit when l_access_allowed;
  end loop;
  if NOT l_access_allowed then
    log('Granting privileges on objects owned by '||itm_at(p_schema,1,':')||' to '||l_grantee||' NOT allowed using this procedure!');
  else -- acces was allowed. DO THE WORK -------------
    -- Allowed to fix privs on this requested schema for current user
    if p_excl_type_list is not null then
      log('Excluding object type(s): '||upper(p_excl_type_list));
      l_excls := ''''||replace(upper(p_excl_type_list),',',''',''')||'''';
      l_obj_sql := l_obj_sql||' and object_type not in ('||l_excls||')';
    end if;
    if p_excl_obj_list is not null then
      log('Excluding object(s): '||upper(p_excl_obj_list));
      l_excls := ''''||replace(upper(p_excl_obj_list),',',''',''')||'''';
      l_obj_sql := l_obj_sql||' and object_name not in ('||l_excls||')';
    end if;
    open rc_objs for l_obj_sql||' order by 1, 2';
    fetch rc_objs into l_object_type, l_object;
    while rc_objs%FOUND loop
      l_obj_cnt := l_obj_cnt + 1;
      l_tab_cnt :=  l_tab_cnt + case when l_object_type = 'TABLE' then 1 else 0 end;
      l_view_cnt :=  l_view_cnt + case when l_object_type = 'VIEW' then 1 else 0 end;
      l_mview_cnt :=  l_mview_cnt + case when l_object_type = 'MATERIALIZED VIEW' then 1 else 0 end;
      l_ddl := 'grant select on '||p_schema||'.'||l_object||' to '||l_grantee;
      begin
        execute immediate l_ddl;
      exception
        when others then
          log('Error granting select on '||p_schema||'.'||l_object||' to '||l_grantee||' ('||SQLERRM||')');
      end;
      if p_incl_private_synonyms then
        l_ddl := 'create or replace synonym '||user||'.'||l_object||' for '||p_schema||'.'||l_object;
        begin
          execute immediate l_ddl;
        exception
          when others then
              log('Error creating synonym for '||p_schema||'.'||l_object||' in schema '||user);
        end;
      end if;
      fetch rc_objs into l_object_type, l_object;
    end loop;
                -- Grant the given role to the current user as well (if that hasn't been done already)
                if user != l_grantee then -- The grantee is a role
                        begin
                                execute immediate 'grant '||l_grantee||' to '||user;
                        exception
                                when others then
                                        log('Error granting role '||l_grantee||' to '||user);
                        end;
                end if;
    -- Show results
    log('Granting select on '||upper(p_schema)||' to '||l_grantee
    ||case when p_incl_private_synonyms = true then ' and creating synonyms' end
    ||' succeeded :)' );
    log(l_obj_cnt||' objects handled:');
    log('...'||l_tab_cnt||' tables');
    log('...'||l_view_cnt||' views');
    log('...'||l_mview_cnt||' materialized views');
  end if;

exception
  when others then
    log('Unhandled expetion :(  '||SQLERRM||'  )');
    raise_application_error(-20001, 'Unhandled exception :(  '||SQLERRM||'  )');
end fix_access_to_me;
/

