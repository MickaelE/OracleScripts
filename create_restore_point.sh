#!/bin/bash
##############################################################################
#
#       script: create_restore_point.ksh  
#
#       Date: 20161018
#
#       Description: Creates an restore point.
#
#       Parameters:
#
#       Variables:
#
# History       Date      Name      Reason
#               ----      ----      ------
#               01/11/16  ME        First version
#               03/1116   ME        Updated stb db handling
#
#############################################################################
#
# Set-up Script.
#

#GEt Git Version
NEWEST_TAG=$(git describe --abbrev=0 --tags)

SCRIPT_VERSION=$(grep "^version=" myscript | awk -F= '{print $2}')

if [ x$NEWEST_TAG != x$SCRIPT_VERSION ]; then
    git tag -a $SCRIPT_VERSION -m "version $SCRIPT_VERSION"
fi

RESTORE_NAME=$1_`date +%d%b%Y`
create="create restore point $RESTORE_NAME GUARANTEE FLASHBACK DATABASE;"
switchLog="alter system switch logfile;"
stby=$(dgmgrl / "show configuration"| grep  Physical | sed 's/ - Physical standby database//g' | sed 's/ //g')

###################################################################
#Get database name                                                #
###################################################################
get_name () {
    sqlplus -s '/ as sysdba'  <<!
    set heading off
    set feedback off
    set pages 0
    select ora_database_name from dual; 
!
}

#####################################################################
# Get databaserole (stb, primary)                                   #
#####################################################################
get_type () {
    sqlplus -s '/ as sysdba'  <<!
    set heading off
    set feedback off
    set pages 0
    select database_role from v\$database;
!
}

######################################################################
# Set Dataguard off                                                  #
######################################################################
set_state_off() {
	# Set dataguard to off.
	echo -e  '\n Setting state to Apply off \n'

        dgmgrl <<-! | grep SUCCESS
        connect /
        show configuration verbose;
        edit database '$stby' set state='APPLY-OFF';
!
}

#####################################################################
# Set Dataguard on                                                  #
#####################################################################
set_state_on() {
        # Set dataguard to off.
	echo -e  '\n Setting state to on  \n'
        dgmgrl <<-! | grep SUCCESS
        connect /
        show configuration verbose;
        edit database '$stby' set state='APPLY-ON';
!
}

#####################################################################
#               Create restorepoint in primary                      #
#####################################################################
run_rpointP() {
# Run create restore point.
echo "sys/$2@$1 as sysdba"
        sqlplus -s "sys/"$2"@"$1" as sysdba" << EOF
                $switchLog
		$create
                exit;
EOF
}

#####################################################################
#               Create restorepoint in stby                         #
#####################################################################
run_rpointS() {
# Run create restore point.
echo "sys/$2@$1 as sysdba"
        sqlplus -s "sys/"$2"@"$1" as sysdba" << EOF
                $create
                exit;
EOF
}

######################################################################
#                   Main                                             #
######################################################################

# Set variables.
dbname=$(get_name)
role=$(get_type)
argument=$1
pwd=$2

# Check input
if [ -z $argument ] ; then
echo $0: usage: create_restore_point.sh name Password	
exit 1
fi

echo "Databasename  ${dbname} Standby ${stby}"
echo "pwd: ${pwd}"
echo "** Checking the Data Guard Broker status ...."
dgmgrl <<-! | grep SUCCESS
    connect /
    show configuration verbose;
!

# Check if dataguard is configured
  if [[ $? -ne 0  && $role = "PRIMARY" ]] ; then
   echo -e  '\n The Data Guard not configured or this is the primary \n'

# Run create restore point.
	run_rpointP ${dbname} ${pwd}
else
	echo -e  '\n The Data Guard configured \n'
	#Restore point on primary
	run_rpointP ${dbname} ${pwd} 
	set_state_off 
	#Restore point on stby
	run_rpointS ${stby} ${pwd} 
	set_state_on
fi
