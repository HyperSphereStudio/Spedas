#!/bin/csh

#An muser cronjob for the STA L2 regeneration, this reprocesses files
#that are 14 and 30 days old, using the current L2 files as input
# Run once per day
# 19 7 * * * /bin/csh /home/muser/export_socware/idl_socware/projects/maven/l2gen/muser_sta_l2reprocess.sh >/dev/null 2>&1
source /usr/local/setup/setup_idl8.5.1		# IDL
setenv BASE_DATA_DIR /disks/data/
setenv ROOT_DATA_DIR /disks/data/
#IDL SETUP for MAVEN
if !( $?IDL_BASE_DIR ) then
    setenv IDL_BASE_DIR ~/export_socware/idl_socware
endif

if !( $?IDL_PATH ) then
   setenv IDL_PATH '<IDL_DEFAULT>'
endif

setenv IDL_PATH $IDL_PATH':'+$IDL_BASE_DIR

# Set path for tmp files
setenv CDF_TMP /mydisks/home/maven

# create a date to append to batch otput
setenv datestr `date +%Y%m%d%H%M%S`
set suffix="$datestr"

#check for lock file(s) here
if (! -e /mydisks/home/maven/muser/STAL2lock.txt && ! -e /mydisks/home/maven/muser/STAL2Rlock.txt) then
    cd /mydisks/home/maven
    rm -f run_sta_l2reprocess.bm
    rm -f /mydisks/home/maven/stalog/run_sta_l2reprocess.txt$suffix

    set line="rerun_sta_l2gen"
    echo $line > run_sta_l2reprocess.bm
    echo exit >> run_sta_l2reprocess.bm

    idl run_sta_l2reprocess.bm > /mydisks/home/maven/stalog/run_sta_l2reprocess.txt$suffix &
#else close quietly
endif 


