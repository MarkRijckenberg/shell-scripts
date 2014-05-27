#!/bin/ksh
# TYPE: Korn Shell script.
# PURPOSE: This korn shell script works for Temenos T24 V6 + JBASE 4.1.5.10 and JBASE 4.1.5.22 installs. This script is an ugly hack that is required when you are not allowed
#  to use deployment tools like puppet or chef and are not allowed to get root access to the AIX server :-)  All the configuration is handled via this file for 	all T24 environments.
# You just need to rename this file to  .profile and (automatically) copy this .profile file to the home directory of all your Temenos T24 application servers.
# I am pretty sure it is easy to re-use this script on Linux servers or other UNIX servers as well.
# SOFTWARE-VENDOR: http://www.temenos.com/
# REQUIRES: ksh, Temenos  T24 V6, JBASE 4.1.5.10 or JBASE 4.1.5.22, AIX v5.3.9, java 1.4.2, perl modules, perl libraries
# REVISED: 20130301
# Updated by: Mark Rijckenberg

##For korn shell (or bash), use trap to set up the shell to catch the error and run a command. The simplest command to run is "exit" or "exit $?" so that the script is aborted. #The following command should be executed somewhere early in the script, and will apply to all following commands (which don't have their exit value checked by inbuilt shell #control structures (if && || ! etc.)

#trap 'exit $?' ERR
# -------------------- Profile.Ksh ---------------------------------------------------------------------------------------------------------------------------

#

# -------------------- SIMPLE VARIABLE DECLARATION --------------------------------------------------------------------------------------------------------------------

# undefine common stty settings to avoid clash with some terminfo and jed controls 
stty quit ^- dsusp ^- susp ^- erase ^h 
alias X="stty $(stty -g)" 
umask 002 
ulimit -s 4194304 
ulimit -m unlimited 
ulimit -n 15000 
export HISTSIZE=1000 
## Configure default prompt 
PS1="$(uname)-\$PWD: "

export HOSTNAME=`hostname` 
export USERID=`whoami` 
export OSLEVEL="`oslevel -s`" 
export JAVAROOT=/usr/java14 
export MALLOCTYPE=buckets 
export PGPPATH=/data/se-ECPB/PGP/database

# MAYBE TO BE ENABLED IN THE FUTURE: export AIXTHREAD_SCOPE=S

# -------------------- COMPLEX/CONDITIONAL VARIABLE DECLARATION ---------------------------------------------------------------------------------------------------------

# ========================== ========================== ========================== ========================== ==========================

# define STARTPORTNO, ENDPORTNO, JBCPORTNO and ORACLE_SID for the T24 PROD,QA,DEV and INT servers

if [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t24" ]; then 
#    export JBCPORTNO=24000-24999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t241" ]; then 
#    export JBCPORTNO=41000-41999 
    export ORACLE_SID=ECPB05T 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t242" ]; then 
#    export JBCPORTNO=42000-42999 
    export ORACLE_SID=ECPB02T 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t243" ]; then 
#    export JBCPORTNO=43000-43999 
    export ORACLE_SID=ECPB03T 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "ecpb002t" ]; then 
#    export JBCPORTNO=43000-43999 
    export ORACLE_SID=ECPB03T 
    USERIDT24=t243 
    STARTPORTNO=`echo $USERIDT24|cut -b 3-`000 
    ENDPORTNO=`echo $USERIDT24|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t244" ]; then 
#    export JBCPORTNO=44000-44999 
    export ORACLE_SID=ECPB04T 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t245" ]; then 
#    export JBCPORTNO=45000-45999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t246" ]; then 
#    export JBCPORTNO=46000-46999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t247" ]; then 
#    export JBCPORTNO=47000-47999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t248" ]; then 
#    export JBCPORTNO=48000-48999 
    export ORACLE_SID=ECPB01T 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t249" ]; then 
#    export JBCPORTNO=48000-48999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t2410" ]; then 
#    export JBCPORTNO=48000-48999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t2411" ]; then 
#    export JBCPORTNO=48000-48999 
    export ORACLE_SID=ECNL02T 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t2415" ]; then 
#    export JBCPORTNO=15000-15999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST 
elif [ "$HOSTNAME" = "staa0268" ] && [ "$USERID" = "t2416" ]; then 
#    export JBCPORTNO=16000-16999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=TEST

elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t242" ]; then 
#    export JBCPORTNO=42000-42999 
    export ORACLE_SID=ECPB5D 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t243" ]; then 
#    export JBCPORTNO=43000-43999 
    export ORACLE_SID=CRDE3D 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t244" ]; then 
#    export JBCPORTNO=44000-44999 
    export ORACLE_SID=CRDE2D 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t245" ]; then 
#    export JBCPORTNO=45000-45999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t247" ]; then 
#    export JBCPORTNO=47000-47999 
    export ORACLE_SID=CRDED 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t248" ]; then 
#    export JBCPORTNO=48000-48999 
    export ORACLE_SID="ECPB6D" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t249" ]; then 
#    export JBCPORTNO=49000-49999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t2410" ]; then 
#    export JBCPORTNO=410000-410999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t2414" ]; then 
#    export JBCPORTNO=414000-414999 
    export ORACLE_SID="CRDE4D" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t2415" ]; then 
#    export JBCPORTNO=15000-15999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t2416" ]; then 
#    export JBCPORTNO=16000-16999 
    export ORACLE_SID=CRDE5D 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t24" ]; then 
#    export JBCPORTNO=24000-24999 
    export ORACLE_SID="" 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t241" ]; then 
#    export JBCPORTNO=24000-24999 
    export ORACLE_SID=ECPBD 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t246" ]; then 
#    export JBCPORTNO=46000-46999 
    export ORACLE_SID=ECPB07D 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV 
elif [ "$HOSTNAME" = "sdaa0226" ] && [ "$USERID" = "t2411" ]; then 
#    export JBCPORTNO=46000-46999 
    export ORACLE_SID=ECPB08D 
    STARTPORTNO=`echo $USERID|cut -b 3-`000 
    ENDPORTNO=`echo $USERID|cut -b 3-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=`pwd` 
    export VOCBACKUPDIR=/t24/"$USERID"backups 
    export ENVIRONMENT=DEV

elif [ "$HOSTNAME" = "scaa0225" ]; then 
#   export JBCPORTNO=1-999 
    export ORACLE_SID=CRDEC 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=QA 
elif [ "$HOSTNAME" = "scaa0273" ]; then 
#    export JBCPORTNO=1000-1999 
    export ORACLE_SID=CRDEC 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=QA 
elif [ "$HOSTNAME" = "scaa0228" ]; then 
#    export JBCPORTNO=2000-2999 
    export ORACLE_SID=ECPB07C 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=QA 
elif [ "$HOSTNAME" = "scaa0253" ]; then 
#    export JBCPORTNO=3000-3999 
    export ORACLE_SID=ECPB5C 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=QA 
elif [ "$HOSTNAME" = "scaa0263" ]; then 
#    export JBCPORTNO=4000-4999 
    export ORACLE_SID=ECPB3C 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=QA 
elif [ "$HOSTNAME" = "scaa0272" ]; then 
#    export JBCPORTNO=5000-5999 
    export ORACLE_SID=ECPB3C 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=QA 
elif [ "$HOSTNAME" = "scaa0264" ]; then 
#    export JBCPORTNO=6000-6999 
    export ORACLE_SID=ECPB4C 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=QA 
elif [ "$HOSTNAME" = "scaa0269" ]; then 
#    export JBCPORTNO=7000-7999 
    export ORACLE_SID=ECPB6C 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=QA 
elif [ "$HOSTNAME" = "scaa0290" ]; then 
#    export JBCPORTNO=8000-8999 
    export ORACLE_SID=CRDE2C 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=QA 
elif [ "$HOSTNAME" = "spaa0246" ]; then 
#    export JBCPORTNO=1-999 
    export ORACLE_SID=ECPBP 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=PROD 
elif [ "$HOSTNAME" = "spaa0247" ]; then 
#    export JBCPORTNO=1000-1999 
    export ORACLE_SID=ECPBP 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=PROD 
elif [ "$HOSTNAME" = "spaa0248" ]; then 
#    export JBCPORTNO=2000-2999 
    export ORACLE_SID=ECPBP 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=PROD 
elif [ "$HOSTNAME" = "spaa0249" ]; then 
#    export JBCPORTNO=3000-3999 
    export ORACLE_SID=ECPBP 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=PROD 
elif [ "$HOSTNAME" = "spaa0250" ]; then 
#    export JBCPORTNO=4000-4999 
    export ORACLE_SID=ECPBP 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=PROD 
elif [ "$HOSTNAME" = "spaa0251" ]; then 
#    export JBCPORTNO=5000-5999 
    export ORACLE_SID=ECPBP 
    ############# STARTPORTNO=(hostname without the first 6 characters) * 1000 ########## 
    STARTPORTNO=`echo $HOSTNAME|cut -b 7-`000 
    ENDPORTNO=`echo $HOSTNAME|cut -b 7-`999 
    export JBCPORTNO=$STARTPORTNO-$ENDPORTNO 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
    export ENVIRONMENT=PROD 
else 
    echo "Default JBCPORTNO 63000-63999 taken" 
    export JBCPORTNO=63000-63999 
    export ORACLE_SID="" 
    export HOME=/t24/bnk/bnk.run 
    export VOCBACKUPDIR=/t24/t24backups 
fi 
# ========================== ========================== ========================== ========================== ==========================

if [ "$OSLEVEL" = "5300-07-01-0748" ]; then

      export PERLMODULES=/t24/PERL-AIX537 
      echo "AIX oslevel -s value is $OSLEVEL  Using perl modules directory $PERLMODULES"

elif [ "$OSLEVEL" = "5300-09-02-0849" ]; then

      export PERLMODULES=/t24/PERL-AIX539 
      echo "AIX oslevel -s value is $OSLEVEL  Using perl modules directory $PERLMODULES"

else 
      export PERLMODULES=/t24/PERL-AIX537 
      echo "Using perl modules directory $PERLMODULES" 
      echo "Make sure the symbolic link /t24/PERL is pointing to /t24/PERL-AIX537" 
      echo "AIX oslevel -s value is $OSLEVEL, but perl libraries in /t24/PERL-AIX537 were compiled against AIX oslevel 5300-07-01-0748. In case of perl errors in CTRL-M, please recompile the expat-2.0.1, libxml2-2.7.2, libwww-perl-5.816 and XML-Twig-3.33 perl libraries in /t24/PERL-AIX537 against the currently running AIX kernel to ensure that these perl modules keep running correctly"

fi


## ========================== ========================== ========================== ========================== ==========================

# -------------------- SIMPLE VARIABLE DECLARATION --------------------------------------------------------------------------------------------------------------------


# 
# Configure ENV for environment 
ENV=${HOME}/.env 
# default to vi editor and vi options and cd to home 
VISUAL=/usr/bin/vi 
set -o vi 
# check if logged in user is using a personal account or a t24 account 
export CHECKT24USER="`echo $USERID|grep t24|grep -v grep`" 
export ORACLEPORTNO=`tnsping $ORACLE_SID |grep -i port|cut -d"(" -f7|cut -d"=" -f2|cut -d")" -f1`

# ========================== ========================== ========================== ========================== ==========================

export EXPATLIB=$PERLMODULES/expat-2.0.1/.libs:$PERLMODULES/expat-2.0.1/xmlwf/.libs 
export LIBXMLLIB=$PERLMODULES/libxml2-2.7.2/.libs 
#Modification on 20081008 for PERLLIB 
export PERLLIB=$EXPATLIB:$LIBXMLLIB:$PERLMODULES/lib:$PERLMODULES/bin:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/auto/HTML/Tagset:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/auto/HTML:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/auto:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi:$PERLMODULES/lib/site_perl/5.8.2:$PERLMODULES/lib/site_perl:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/HTML:$PERLMODULES/lib/5.8.2:$PERLMODULES/bin/5.8.2:$PERLMODULES/lib/5.8.2/aix-thread-multi/auto/MIME/Base64:$PERLMODULES/lib/5.8.2/aix-thread-multi/auto/MIME:$PERLMODULES/lib/5.8.2/aix-thread-multi/MIME:$PERLMODULES/lib/site_perl/5.8.2/URI:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/auto/IO/Compress/Zlib:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/auto/IO/Compress:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/auto/IO:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/IO/Compress/Zlib:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/IO/Compress:$PERLMODULES/include/libxml2/libxml:$PERLMODULES/include/libxml2:$PERLMODULES/include:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/auto/XML/LibXML/Common:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/auto/XML/LibXML:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/auto/XML:$PERLMODULES/XML-LibXML-Common-0.13/blib/arch/auto/XML/LibXML/Common:$PERLMODULES/XML-LibXML-Common-0.13/blib/arch/auto/XML/LibXML:$PERLMODULES/XML-LibXML-Common-0.13/blib/arch/auto/XML:$PERLMODULES/XML-LibXML-Common-0.13/blib/arch/auto:$PERLMODULES/XML-LibXML-Common-0.13/blib/arch:$PERLMODULES/XML-LibXML-Common-0.13/blib:$PERLMODULES/XML-LibXML-Common-0.13:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/XML/LibXML:$PERLMODULES/lib/site_perl/5.8.2/aix-thread-multi/XML:$LIBXMLLIB:$PERLMODULES/libxml2-2.7.2

# ========================== ========================== ========================== ========================== ==========================

export ORACLE_HOME=/oracle00/home/10.2.0.1 
export ORACLE_BASE=/oracle00/home 
# define location of jspooler and jbase and VOCBACKUP directories 
export JBCSPOOLERDIR=$HOME/../jspooler 
export JSPOOLLOG=$JBCSPOOLERDIR/jspool_log 
# specify location of currently used XMLORACLE driver 
export DRIVER_HOME=$HOME/../driver 
export JBCOBJECTLIST=$DRIVER_HOME/lib:$HOME/lib:$HOME/globuslib 
export JBCDIR=$JBCSPOOLERDIR 
export JBCRELEASEDIR=$HOME/../jbase 
export JBCGLOBALDIR=$JBCRELEASEDIR 
export JBCDATADIR=$HOME/jbase_data 
# Set up the path to the SAVEDLIST file 
export JBCLISTFILE=$HOME/\&SAVEDLISTS\& 
export VOCBACKUPDATEDIR=$VOCBACKUPDIR/`date +%Y%m%d` 
# ask user to create and populate jspooler directory if it does not exist in the right location 
# change default value of BACKUPSTUBFILES from 0 to 1 if you want to enable automatic daily backups of stubfiles 
# warning: each daily stub backup can take up to 28 MB of diskspace 
export BACKUPSTUBFILES="0" 
# determine currently running version of JBASE (Major and Minor release version numbers) to determine which correct version of java to use:

export JBASEMAJORRELEASEVERSION=`$HOME/../jbase/bin/jdiag |grep "RELEASE Information"|cut -c 37-39` 
export JBASEMINORRELEASEVERSION=`$HOME/../jbase/bin/jdiag |grep "RELEASE Information"|cut -c 49-52` 
#export JEDI_XMLORACLE_TRACE=TRUE 
export NLSPATH=/usr/lib/nls/msg/%L/%N:/usr/lib/nls/msg/%L/%N.cat 
export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1 
export ORA_NLS33=/oracle00/home/10.2.0.1/ocommon/nls/admin/data 
export JAVA_HOME=$HOME/../jbase/jdk 
export SHLIB_PATH=${SHLIB_PATH:-/usr/lib:/lib}:$JRELIB:$JBCRELEASEDIR/lib 
export JEDI_XMLORACLE_NVL_INDEX=1 
export JEDI_RECYCLEPURGE_ACTIVATED=1 
# Set up path of where to find data files. By default if the JEDIFILEPATH 
# is not set then files will be looked for first in the $HOME directory and 
# if not found then in the "." current directory. 
export JEDIFILEPATH=$HOME 
# Set up where the MD and SYSTEM files can be found. 
# By default, the MD and SYSTEM files are undefined, so Q pointers 
# and other considerations (such as PQ procs from jsh) will not work. 
export JEDIFILENAME_MD=$HOME/VOC 
export JEDIFILENAME_SYSTEM=$JBCRELEASEDIR/src/SYSTEM

export CLASSPATH=$JBCRELEASEDIR/java/lib/javaobjex.jar:$JBCRELEASEDIR/java/lib/jbase.jar:$HOME/FB.LOCAL.API:$HOME/JAVA.BP:$HOME/JAVA.BP/company-specific-xmlutils.jar:$HOME/JAVA.BP/company-specific-soap.jar:$HOME/JAVA.BP/company-specific-mqwrap.jar:$HOME/JAVA.BP/company-specific-pdfutil.jar:$HOME/JAVA.BP/company-specific-CarinaWSClient.jar:$HOME/../tcserver/lib/basicmqbridge.jar:$HOME/../tcserver/ext/connector.jar:$HOME/../tcserver/ext/com.ibm.mq.jar:$CLASSPATH

# To see jBASE man pages enable and export the MANPATH environment variable 
# and set pager to "pg" or "more" as required. 
export MANPATH=$JBCRELEASEDIR/man 
#export PAGER=pg 
# Set the environment variable JBCDEV_LIB & JBCDEV_BIN. These 
# variable will decide the place where the bin and lib directories 
# will reside in your environment. Any development done in jbase 
# will be placed into these locations. If the source being compiled 
# is an executable it will be placed into the bin folder and if it is 
# a subroutine it will be placed into a shared library in the lib folder 
# 
export JBCDEV_BIN=$HOME/bin 
export JBCDEV_LIB=$HOME/lib 
export JBASEUNIQUE=$HOME/jBASEWORK 
export LANG=en_US 
# This variable sets the jBASE emulation to be prime. 
export JBCEMULATE=prime 
export JBASE_WARNLEVEL=30 
export JBASE_INHIBIT_ZERO_USED=1 
export JEDIENABLEQ2Q=1 
# Internationalization settings 
JBASE_TIMEZONE=Europe/Brussels 
# The following environment variable is added to set the allowable open file descriptors 
#export JBASE_MAX_OPEN_FILES=10000 
export JBC_UNLOCK_LASTCLOSE=1 
export JBC_SOB_NOCLOSE=1 
export LDR_CNTRL=MAXDATA=0x80000000 
export JBASE_ERRMSG_DIVIDE_ZERO=19 
export JBASE_ERRMSG_NON_NUMERI=19 
export JBASE_ERRMSG_ZERO_USED=35 
# Internationalisation should NOT be enabled yet: 
#export JBASE_I18N=1 
#export JBASE_NOCOLLATION=1 
#export JBASE_LOCALE=en_US 
export LDR_CNTRL=USERREGS@MAXDATA=0x80000000 
export TCSERVERPROCESS="`ps -ef|grep $USERID|grep erver|grep java`" 
export NFSRGYDPROCESS="`ps -ef|grep nfsrgyd|grep -v grep`"

# -------------------- COMPLEX/CONDITIONAL VARIABLE DECLARATION ---------------------------------------------------------------------------------------------------------

    if [ -n "$CHECKT24USER" ]; then 
        export T24ACCOUNT=YES 
    else 
        export T24ACCOUNT=NO 
    fi 
# ========================== ========================== ========================== ========================== ==========================

if [ "$JBASEMAJORRELEASEVERSION" = "4.1" ] && [ "$JBASEMINORRELEASEVERSION" = "5.6 " ]; then 
      
      export JREDIR=/t24/java142-20050609/jre 
      export JRELIB=$JREDIR/bin:$JREDIR/bin/classic 
      export LD_LIBRARY_PATH=$DRIVER_HOME/lib:$EXPATLIB:$LIBXMLLIB:$JRELIB:$JBCRELEASEDIR/lib:/usr/ccs/lib:/usr/lib:/oracle00/home/10.2.0.1/lib32:/oracle00/home/10.2.0.1/lib

      export LIBPATH=$LD_LIBRARY_PATH 
      echo "JBASE version is $JBASEMAJORRELEASEVERSION $JBASEMINORRELEASEVERSION  Using java directory $JREDIR "

elif [ "$JBASEMAJORRELEASEVERSION" = "4.1" ] && [ "$JBASEMINORRELEASEVERSION" = "5.10" ] && [ "$OSLEVEL" = "5300-07-01-0748" ]; then

      export JREDIR=$JAVAROOT/jre 
      export JRELIB=$JREDIR/bin:$JREDIR/bin/classic 
      export LD_LIBRARY_PATH=$DRIVER_HOME/lib:$EXPATLIB:$LIBXMLLIB:$JRELIB:$JBCRELEASEDIR/lib:/usr/ccs/lib:/usr/lib:/oracle00/home/10.2.0.1/lib32:/oracle00/home/10.2.0.1/lib

      export LIBPATH=$LD_LIBRARY_PATH 
      echo "JBASE version is $JBASEMAJORRELEASEVERSION $JBASEMINORRELEASEVERSION  Using java directory $JREDIR "

elif [ "$JBASEMAJORRELEASEVERSION" = "4.1" ] && [ "$JBASEMINORRELEASEVERSION" = "5.10" ] && [ "$OSLEVEL" = "5300-09-02-0849" ]; then

      export JREDIR=$JAVAROOT/jre 
      export JRELIB=$JREDIR/bin:$JREDIR/bin/classic 
      export LD_LIBRARY_PATH=$DRIVER_HOME/lib:$EXPATLIB:$LIBXMLLIB:$JRELIB:$JBCRELEASEDIR/lib:/usr/ccs/lib:/usr/lib:/oracle00/home/10.2.0.1/lib32:/oracle00/home/10.2.0.1/lib

      export LIBPATH=$LD_LIBRARY_PATH 
      echo "JBASE version is $JBASEMAJORRELEASEVERSION $JBASEMINORRELEASEVERSION  Using java directory $JREDIR "


elif [ "$JBASEMAJORRELEASEVERSION" = "4.1" ] && [ "$JBASEMINORRELEASEVERSION" = "5.11" ]; then

      export JREDIR=/t24/java142-20050609/jre 
      export JRELIB=$JREDIR/bin:$JREDIR/bin/classic 
      export LD_LIBRARY_PATH=$DRIVER_HOME/lib:$EXPATLIB:$LIBXMLLIB:$JRELIB:$JBCRELEASEDIR/lib:/usr/ccs/lib:/usr/lib:/oracle00/home/10.2.0.1/lib32:/oracle00/home/10.2.0.1/lib

      export LIBPATH=$LD_LIBRARY_PATH 
      echo "JBASE version is $JBASEMAJORRELEASEVERSION $JBASEMINORRELEASEVERSION  Using java directory $JREDIR "

elif [ "$JBASEMAJORRELEASEVERSION" = "4.1" ] && [ "$JBASEMINORRELEASEVERSION" = "5.20" ]; then

      export JREDIR=/t24/java142-20070317/jre 
      export JRELIB=$JREDIR/bin:$JREDIR/bin/classic 
      export LD_LIBRARY_PATH=$DRIVER_HOME/lib:$EXPATLIB:$LIBXMLLIB:$JRELIB:$JBCRELEASEDIR/lib:/usr/ccs/lib:/usr/lib:/oracle00/home/10.2.0.1/lib32:/oracle00/home/10.2.0.1/lib

      export LIBPATH=$LD_LIBRARY_PATH 
      echo "JBASE version is $JBASEMAJORRELEASEVERSION $JBASEMINORRELEASEVERSION  Using java directory $JREDIR "

elif [ "$JBASEMAJORRELEASEVERSION" = "4.1" ] && [ "$JBASEMINORRELEASEVERSION" = "5.22" ]; then

      export JREDIR=/t24/java142-20070317/jre 
      export JRELIB=$JREDIR/bin:$JREDIR/bin/classic 
      export LD_LIBRARY_PATH=$DRIVER_HOME/lib:$EXPATLIB:$LIBXMLLIB:$JRELIB:$JBCRELEASEDIR/lib:/usr/ccs/lib:/usr/lib:/oracle00/home/10.2.0.1/lib32:/oracle00/home/10.2.0.1/lib

      export LIBPATH=$LD_LIBRARY_PATH 
      echo "JBASE version is $JBASEMAJORRELEASEVERSION $JBASEMINORRELEASEVERSION  Using java directory $JREDIR "


elif [ "$JBASEMAJORRELEASEVERSION" = "5.0" ]; then

      export JREDIR=/t24/java150-20061003/jre 
      export JRELIB=$JREDIR/bin:$JREDIR/bin/classic 
      export LD_LIBRARY_PATH=$DRIVER_HOME/lib:$EXPATLIB:$LIBXMLLIB:$JRELIB:$JBCRELEASEDIR/lib:/usr/ccs/lib:/usr/lib:/oracle00/home/10.2.0.1/lib32:/oracle00/home/10.2.0.1/lib

      export LIBPATH=$LD_LIBRARY_PATH 
      echo "JBASE version is $JBASEMAJORRELEASEVERSION $JBASEMINORRELEASEVERSION  Using java directory $JREDIR "

else 
      echo "Cannot determine which java version to use. Please run jdiag and use JBASE version info to manually determine correct java version. Using default values"

      export JREDIR=$JAVAROOT/jre 
      export JRELIB=$JREDIR/bin:$JREDIR/bin/classic 
      export LD_LIBRARY_PATH=$DRIVER_HOME/lib:$EXPATLIB:$LIBXMLLIB:$JRELIB:$JBCRELEASEDIR/lib:/usr/ccs/lib:/usr/lib:/oracle00/home/10.2.0.1/lib32:/oracle00/home/10.2.0.1/lib

      export LIBPATH=$LD_LIBRARY_PATH 
      echo "JBASE version is $JBASEMAJORRELEASEVERSION $JBASEMINORRELEASEVERSION  Using java directory $JREDIR "

fi

# recommend restarting tcserver if tcserver process was restarted before last modification date of .profile

     if [ -e "$HOME/../tcserver/conf/TCServer/tcserver.xml" ]; then 
         export TELNETD_PORT=`cat $HOME/../tcserver/conf/TCServer/tcserver.xml |grep TELNETD |cut -d"> " -f2 |cut -d" <" -f2`

     else 
         export TELNETD_PORT="Use valid T24 account to determine valid TELNETD_PORT" 
     fi 
# ========================== ========================== ========================== ========================== ==========================

     if [ -e "$HOME/../tcserver/bin/tcserver.pid" ] && [ "$T24ACCOUNT" = YES ]; then 
         export TCSERVERPIDEXISTS=1 
     else 
         export TCSERVERPIDEXISTS=0 
     fi  
# ========================== ========================== ========================== ========================== ==========================

# -------------------- SIMPLE VARIABLE DECLARATION --------------------------------------------------------------------------------------------------------------------

export HARVESTHOME=/opt/CA/harvest 
export RT_FORCE_NODE_NAME=$HOSTNAME 
export PATH=$DRIVER_HOME/bin:$DRIVER_HOME/lib:$JREDIR/bin:$EXPATLIB:$LIBXMLLIB:/usr/vac/bin:$JBCRELEASEDIR/bin:$JBCRELEASEDIR/config:.:$HOME/bin:$PERLMODULES/bin:$HOME/globusbin:/usr/ccs/bin:/usr/ucb:$ORACLE_HOME/bin:$JREDIR/bin:/usr/bin:/etc:/usr/sbin:/usr/ucb:$HOME/bin:/usr/bin/X11:/sbin:/usr/vac/bin:/usr/vacpp/bin:${HARVESTHOME}/bin:${HARVESTHOME}:/opt/CA/CAcrypto:/opt/CA/pec:${HARVESTHOME}/lib:/sys_mgmt





# .profile template for korn shell to execute j shell 
# after configuring the environment 
# After creating a user and his home directory you 
# should append this file to the .profile in ${HOME} 
# 
#         ######     #     #####  ####### 
#       # #     #   # #   #     # # 
#       # #     #  #   #  #       # 
#       # ######  #     #  #####  ##### 
#       # #     # #######       # # 
#  #    # #     # #     # #     # # 
#   ####  ######  #     #  #####  ####### 
# 
# Set up the port, if it ever goes wild, then typing a single "X" 
# should hopefully put it back, using the sequence Ctrl-J (^J), X, Ctrl-J (^J) 
# whereby Ctrl-J means new line. 
# 
# Certain control characters used in some system stty settings may clash with 
# control characters used within the JED/JSH programs, thus making the function 
# appear not to work. In this case the clashing stty settings can be safely set 
# to undefined thus allowing the control character to be processed by JED/JSH. 
# e.g. Undefine stty "flush" character. stty flush ^-, where ^ is uparrow and 
# - is the minus character. Alternatively JED can be configured to use alternative 
# control characters via the .jedsrc file. See knowledge base. 
# 
# stty intr ^C kill icanon opost echo echoe echok onlcr -lcase tab3 
#

# 
# 
# To set the default umask to 002. This allows the CREATE-FILE to create files with 
# default permissions of 664. i.e. rw-rw-r--. 
# Read/Write User, Read/Write Group, ReadOnly Others 
# This enables file access permissions to be more easily controlled via user groups. 
# Also in the case of network file access, unix locks required read/write access. 
# 
# 
# Set up the directory of where jBASE is being run from. 
# The JBCRELEASEDIR shows where the executables, libraries, scripts etc. 
# can be found for the particular release you want to run. The 
# JBCGLOBALDIR shows where a few of the global constants can be 
# found, such as the configuration file for the record locking 
# mechanism -- these should be common to all releases running on 
# the same system 
# 
# If undefined, they will resort to /usr/jbc as a default. However, they 
# are initialised in this script to the default, so that if you move 
# to another test release at a later stage, it makes it very easy to 
# update the JBCRELEASEDIR variable to say /usr/testjbc and all the 
# other variables fall in to place. 
#

# ========================== ========================== ========================== ========================== ==========================

    if  ! test -d "${JBCDIR}" && [ $T24ACCOUNT = YES ]; then 
             echo "$JBCSPOOLERDIR not created yet. Please execute jshell command SP-NEWTAB and choose option C" 
    fi 
# ========================== ========================== ========================== ========================== ==========================

    if  ! test -e "${JSPOOLLOG}" && [ $T24ACCOUNT = YES ]; then 
             echo "$JSPOOLLOG not created yet. Please execute jshell command SP-NEWTAB and choose option C" 
    fi 
# ========================== ========================== ========================== ========================== ==========================

# create and populate VOCBACKUP and VOCBACKUPDATEDIR directories if it does not exist in the right location for the current date

    if  ! test -d "${VOCBACKUPDIR}"; then 
            mkdir $VOCBACKUPDIR 
    fi 
# ========================== ========================== ========================== ========================== ==========================

# create DRIVER_HOME directories if it does not exist in the right location for the current date 
    if  ! test -d "${DRIVER_HOME}"; then 
            mkdir $DRIVER_HOME 
            mkdir $DRIVER_HOME/lib 
            mkdir $DRIVER_HOME/bin 
    fi 
# ========================== ========================== ========================== ========================== ==========================

     if  ! test -d "${VOCBACKUPDATEDIR}"; then 
          echo "Critical T24 config files have not been backed up yet today. Backup to $VOCBACKUPDATEDIR now automatically running..."

          mkdir $VOCBACKUPDATEDIR 
          tar chf - $HOME/VOC* |bzip2 -9 - >$VOCBACKUPDATEDIR/VOC-backup.tar.bz2 & 
          tar chf - $HOME/jedi* |bzip2 -9 - >$VOCBACKUPDATEDIR/jedi_config-backup.tar.bz2 & 
          tar chf - $HOME/../scripts |bzip2 -9 - >$VOCBACKUPDATEDIR/scripts-backup.tar.bz2 & 
  
          if  "$BACKUPSTUBFILES" = "1"; then 
                tar chf - $HOME/../bnk.data | bzip2 -9 >$VOCBACKUPDATEDIR/stubfiles.tar.bz2 & 
          fi 
     
          cp $HOME/.profile $VOCBACKUPDATEDIR 
          cp $HOME/../tcserver/conf/TCServer/tcserver.xml $VOCBACKUPDATEDIR 
          cp $HOME/../tcserver/bin/TCServer.sh $VOCBACKUPDATEDIR 
          cp $JBCRELEASEDIR/config/system.properties $VOCBACKUPDATEDIR 
     else 
          echo "Critical T24 config files have already been backed up today. No new backup to $VOCBACKUPDATEDIR required..."

     fi

# ========================== ========================== ========================== ========================== ==========================

# Set permissions on MQLOGS directories - replaced by crontab (20091204) 
# ========================== ========================== ========================== ========================== ==========================

##       if  [ "$USERID" = "t24" ] ; then 
##              if [ "$HOSTNAME" = "scaa0225" ] || [ "$HOSTNAME" = "spaa0250" ]; then 
##                      test -e $VOCBACKUPDATEDIR/MQLOGSCHMOD.err.log || ( echo "Fixing MQLOGS, errors are in $VOCBACKUPDATEDIR/MQLOGSCHMOD.err.log " ;  find /data/se-ECPB/MQLOGS/ -mtime -2 | xargs -i chmod -R 777 {} 2> $VOCBACKUPDATEDIR/MQLOGSCHMOD.err.log & )

##              fi 
##      fi 
# ========================== ========================== ========================== ========================== ==========================

# delete backups that are older than 40 days 
     find $VOCBACKUPDIR -name "*"  -mtime +40 | xargs rm -rf 
# ========================== ========================== ========================== ========================== ==========================

# ensure the necessary Riposte directories exist

     if  ! test -d "$HOME/FB.INITIAL.LOAD" && [ $T24ACCOUNT = YES ]; then 
             mkdir $HOME/FB.INITIAL.LOAD 
     fi

     if  ! test -d "$HOME/WEB" && [ $T24ACCOUNT = YES ]; then 
             mkdir $HOME/WEB 
     fi

     if  ! test -d "$HOME/RIP.OFS.IN" && [ $T24ACCOUNT = YES ]; then 
             mkdir $HOME/RIP.OFS.IN 
     fi

     if  ! test -d "$HOME/RIPERR" && [ $T24ACCOUNT = YES ]; then 
             mkdir $HOME/RIPERR 
     fi

     if  ! test -d "$HOME/RIPOUT" && [ $T24ACCOUNT = YES ]; then 
             mkdir $HOME/RIPOUT 
     fi

     if  ! test -d "$HOME/RIPIN" && [ $T24ACCOUNT = YES ]; then 
             mkdir $HOME/RIPIN 
     fi

     if  ! test -d "$HOME/RIPLOG" && [ $T24ACCOUNT = YES ]; then 
             mkdir $HOME/RIPLOG 
     fi

     if  ! test -d "$HOME/../bnk.data/eb/&HOLD&" && [ $T24ACCOUNT = YES ]; then 
             mkdir "$HOME/../bnk.data/eb/&HOLD&" 
     fi

# ========================== ========================== ========================== ========================== ==========================

# ensure the necessary Business Object directories exist

     if  ! test -d "/data/se-ECPB/bus.obj.extract" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/bus.obj.extract 
     fi


     if  ! test -d "/data/se-ECPB/bus.obj.temp" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/bus.obj.temp 
     fi


     if  ! test -d "/data/se-ECPB/bus.obj.temp/pb.bus.obj.extr.adhoc" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/bus.obj.temp/pb.bus.obj.extr.adhoc 
     fi


     if  ! test -d "/data/se-ECPB/bus.obj.temp/pb.bus.obj.extr" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/bus.obj.temp/pb.bus.obj.extr 
     fi


     if  ! test -d "/data/se-ECPB/bus.obj.temp/pb.bus.obj.extr.his" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/bus.obj.temp/pb.bus.obj.extr.his 
     fi

     if  ! test -d "/data/se-ECPB/bus.obj.temp/pb.bus.obj.extr.precob" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/bus.obj.temp/pb.bus.obj.extr.precob 
     fi




# ========================== ========================== ========================== ========================== ==========================

# ensure the necessary PPSN directories exist

     if  ! test -d "/data/se-ECPB/PPSN" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/PPSN 
     fi

     if  ! test -d "/data/se-ECPB/PPSN/in" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/PPSN/in 
     fi

     if  ! test -d "/data/se-ECPB/PPSN/out" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/PPSN/out 
     fi

     if  ! test -d "/data/se-ECPB/PPSN/in-archive" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/PPSN/in-archive 
     fi

     if  ! test -d "/data/se-ECPB/PPSN/out-archive" && [ $T24ACCOUNT = YES ]; then 
             mkdir /data/se-ECPB/PPSN/out-archive 
     fi

# ========================== ========================== ========================== ========================== ==========================

# ensure the necessary sepa directories exist (for JBASE 4.1.5.22) 
# 
#     if  ! test -d "$HOME/sepabin" && [ $T24ACCOUNT = YES ]; then 
#             mkdir $HOME/sepabin 
#     fi 
# 
#     if  ! test -d "$HOME/sepalib" && [ $T24ACCOUNT = YES ]; then 
#             mkdir $HOME/sepalib 
#     fi 
# ========================== ========================== ========================== ===================================================

# ensure symbolic link to Harvest directory exists in $HOME/TEMP (to be used by AB.PACK.MAN.PLUS) 
# The correct NFS mount in PROD, QA, DEV and INT is 
# spaa0131 /HarvestXBorderShare/deployment /HarvestBuild    nfs4   May 09 11:46 bg,soft,intr,vers=4,sec=sys,rw

     if  ! test -h "$HOME/TEMP/TAF-HARVEST" && [ $T24ACCOUNT = YES ]; then 
             ln -s /HarvestBuild/$ENVIRONMENT/ECPB/Deploy $HOME/TEMP/TAF-HARVEST    
     fi

# ========================== ========================== ========================== ========================== ==========================

# 
# 
#    Set up the shared object file name where we will resolve 
#    all the calls to subroutines made via. the CALL @Var() statements. 
#    The default is $HOME/lib. If you want to use shared objects other 
#    than in the default, set up a : delimited path of directory names 
#    and/or object name to search in, by setting the JBCOBJECTLIST variable. 
# 
#    NOTE: When executing programs the PATH environment variable is used. 
#    When locating subroutines the JBCOBJECTLIST environment variable is used 
#    else by default the $HOME/lib directory. Therefore when cataloging ensure 
#        that either the default $HOME/bin or $HOME/lib directories areused to store 
#    the executables and shared libraries or else the environment variables 
#        JBCDEV_BIN and JBCDEV_LIB are configured to match PATH and JBCOBJECTLIST. 
# 
#        e.g. If JBCOBJECTLIST were configured below then the directory /apps/myapp/lib 
#        would be used to locate any subroutines called by my main program. In this case 
#        the subroutines should of been cataloged with JBC_DEVLIB=/app1/myapp/lib also. 
# 
# ========================== ========================== ========================== ========================== ==========================

# create jbase_data directory if it does not exist in the right location 
     if  ! test -d "${JBCDATADIR}" && [ $USERID = "t24" ]; then 
             mkdir $JBCDATADIR 
             echo "$JBCDATADIR not created yet. Creating $JBCDATADIR directory..." 
     fi 
# ========================== ========================== ========================== ========================== ==========================

# 
# 
#    During the search for a shared object, if an object is specified 
#    without a path component, e.g. "libsubroutines.so" , then AIX 
#    will use LIBPATH to find out what directory the object is in, 
#    and SVR4 systems will use LD_LIBRARY_PATH and HPUX the SHLIB_PATH. 
#

# 
#

# 
# 
# Set up base directory where we keep the spooler (default == /usr/jspooler) 
#

# 
#

# 
# 
# Setup the Unix PATH environment variable. This variable specifies the location and 
# order in which directories will be search to find the command line executable. 
# 
# 
#

# 
# Tell jBASE where to create the tmp folder that it uses 
# 
# 
#

# 
#


# 
# 
#

# We have now set up all the environment variable requried by jBASE. 
# We must run the jbcconnect command, so that these variables remain 
# for the entire session (unless purposely amended). 
# 
#



# should we use   export JBASE_CODEPAGE=utf8  or  JBASE_CODEPAGE=ISO-8859-1 in .profile for JBASE 4 and JBASE 5  ??? 
# export JBASE_CODEPAGE=utf8 
# 
# We have now set up all the environment variable requried by jBASE. 
# We must run the jbcconnect command, so that these variables remain 
# for the entire session (unless purposely amended). 
# 
# 
#The following environment variable is added to set the allowable open 
#file descriptors



# 
#  ====================== 
#   Company Modifications 
#   - modify PATH for Java 
#   - test on UserID, only interactive for t24 user 
# 

# ========================== ========================== ========================== ========================== ==========================

# copy new environment variable values to $HOME/../tcserver/conf/TCServer/environment.vars , only if .profile is newer than environment.vars

     if  [ "$HOME/.profile" -nt "$HOME/../tcserver/conf/TCServer/environment.vars" ] && [ "$T24ACCOUNT" = YES ] ; then 
          echo "$HOME/.profile is more recent than $HOME/../tcserver/conf/TCServer/environment.vars, exporting new .profile variables to environment.vars..."

          mv $HOME/../tcserver/conf/TCServer/environment.vars $HOME/../tcserver/conf/TCServer/environment.varsBACKUP 
          env > $HOME/../tcserver/conf/TCServer/environment.vars 
     elif  [ "$HOME/.profile" -nt "$HOME/../tcserver/conf/TCServer/environment.vars" ] && [ "$T24ACCOUNT" = NO ] ; then

          echo "Please login using a valid T24 account to verify if T24 file .profile is more recent than environment.vars file"

          echo "You can use the command jsh to switch from ksh to jshell mode." 
     else 
          echo "$HOME/.profile is NOT more recent than $HOME/../tcserver/conf/TCServer/environment.vars, NOT regenerating the environment.vars..."

     fi




    if [ -z "$TCSERVERPROCESS" ] && [ "$T24ACCOUNT" = YES ]; then 
          rm "$HOME/../tcserver/bin/tcserver.pid" 
          echo "tcserver process is NOT running for this environment" 
    fi         
       
       
       
        

     if  [ "$HOME/.profile" -nt "$HOME/../tcserver/bin/tcserver.pid" ] && [ "$T24ACCOUNT" = YES ] && [ $TCSERVERPIDEXISTS = 1 ]; then

          echo "$HOME/.profile is more recent than $HOME/../tcserver/bin/tcserver.pid ..." 
          echo "Please restart tcserver process in order to take regeneration of .profile file into account" 
             if  [ -f "${HOME}/../tcserver/conf/TCServer/tcserver.xml" ] && [ $TCSERVERPIDEXISTS = 1 ]; then 
                   echo "Use command telnet localhost $TELNETD_PORT and choose option 1 to first stop the tcserver process..."

             fi 
  
     elif  [ "$HOME/.profile" -nt "$HOME/../tcserver/bin/tcserver.pid" ] && [ "$T24ACCOUNT" = YES ] && [ $TCSERVERPIDEXISTS = 0 ]; then

          echo "$HOME/.profile is more recent than $HOME/../tcserver/bin/tcserver.pid ..." 
          echo "tcserver process not started yet. Please start tcserver process in order to take regeneration of .profile file into account"

     elif [ "$T24ACCOUNT" = NO ]; then 
          echo "Please login using a valid T24 account to verify if T24 file .profile is more recent than tcserver.pid" 
     else 
          echo "$HOME/.profile is NOT more recent than $HOME/../tcserver/bin/tcserver.pid..." 
          echo "Restart of tcserver is NOT required" 
     fi 
# ========================== ========================== ========================== ========================== ==========================

# send warning message if the /usr/sbin/nfsrgyd process is running

    if [ -n "$NFSRGYDPROCESS" ] && [ "$T24ACCOUNT" = YES ]; then 
          echo "WARNING: THE PROCESS $NFSRGYDPROCESS IS RUNNING WHICH WILL SEVERELY INCREASE THE COB DURATION TO AROUND 12 HOURS, IF THE T24 STUBFILES ARE STORED ON AN NFSV3 SHARE. PLEASE RUN THE DAILY COB ON ANOTHER SERVER, IF POSSIBLE. OR ELSE ASK THE AIX TEAM TO KILL THIS PROCESS"

    fi         
# ========================== ========================== ========================== ========================== ==========================

echo "If you are experiencing performance issues, please do a cleanup of the $JBCSPOOLERDIR directory (using jbase command SP-NEWTAB) and a cleanup of the '$HOME/&COMO&' directory at regular intervals"   

# ========================== ========================== ========================== ========================== ==========================

# set correct permissions on VOC file to prevent COB crash

chmod 777 $HOME/VOC*

# ========================== ========================== ========================== ========================== ==========================

# 
#   End custom modifications 
#  ========================== 
# 
# You can now start to add any jBASE programs in your .profile at this stage. 
# TERM 80,10,,,,132,60 
# SP-ASSIGN =PRINTRONIX 
# 
# Now we work out if we want to go straight into GLOBUS or go to jBASE 
# 
# If you wish to use OFS online via EB.AUTO.INIT.PROCESS, uncomment 
# the following four lines of script: 
# First we check if there are any auto processes to run. The program 
# EB.AUTO.INIT.PROCESS checks the table EB.AUTO.PROCESS for a record 
# with an id of the user. If this is found (defined in OFS.SOURCE) 
# the EB.AUTO.INIT.PROCESS will run the routine, an ultimately logout 
# Where nothing is found, the routine terminates normally. 
# Hence we examine the $? code. A non zero seems to indicate that the 
# process DID something, so get out. This will need to be tested 
# on a site by site basis. 
# 
#EB.AUTO.INIT.PROCESS 
# if [ $? != 0 ]; then 
#     exit 
# fi 
# 
# Now we ask our traditional question. 
# 
#echo "\nSTART GLOBUS Y/N=\c" 
#read answer 
# 
# If we want to start GLOBUS, do so and then exit. This prevents: 
# a) Too many processes being spawned and 
# b) Processes being left "hanging" 
# 
#if [ "$answer" = Y -o "$answer" = y ]; then 
# start GLOBUS here! 
#    EBS.TERMINAL.SELECT 
#    EX 
#    exit 
#fi 
# Otherwise we just start the jshell... 
# 
#--------------- End of Profile.Ksh ----------------- 
# Now enter the jsh to complete the login..>

echo $USER

if [ $T24ACCOUNT = YES -o `whoami` = "SHNT001" ] ; then 
       echo "There are currently `ps -ef|grep "$USERID"|grep tSS|wc -l` simultaneous tSS connections to the Oracle database $ORACLE_SID via this AIX account $USERID."

       echo "There are currently `netstat -n|grep ".$ORACLEPORTNO"|wc -l` simultaneous Oracle connections to the Oracle database $ORACLE_SID via this AIX account $USERID."

       echo "Oracle portnumber is $ORACLEPORTNO" 
        exec $JBCRELEASEDIR/bin/jpqn $JEDIFILENAME_MD/loginproc 
       jsh -s jsh 
# manual procedure for accessing jshell using non-t24 accounts 
#else 
#       cd /t24/bnk/bnk.run 
#       . ./.profile 
#       exec $JBCRELEASEDIR/bin/jpqn $JEDIFILENAME_MD/loginproc 
#       jsh -s jsh 
fi
