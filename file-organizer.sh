#!/usr/bin/env bash
#
# file-organizer.sh - Organize files according it's type.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - The script will move e.g. *.jpg files of '/Downloads' to corresponding folder '/jpg'
#  - It can be easily tweaked to any other folders e.g. /Documents
#
#  Exemplos:
#      $ bash file-organizer.sh
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/12/2021, Edvaldo:
#     - Organize files according it's type.
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- -#

# ------------------------------- VARIABLES --------------------------------------------- #
TIME_STAMP=$(date +%F,%H:%M:%S)
LOGFILE=~/Scripts/FILEorganizer_$CURRENT_DATE.log
# ------------------------------- EXECUTION --------------------------------------------- #
cd ~/Downloads

# directories exist ?
[ ! -d csv,docx,jpg,log,mis,pdf,png,txt,xlsx ] && \
mkdir {csv,docx,jpg,log,mis,pdf,png,txt,xlsx} 1> /dev/null 2>&1

# list FILEs only
FILE_LIST=$(find . -maxdepth 1 -type f | awk -F / '{ print $2 }')

echo " " >> $LOGFILE
echo "$TIME_STAMP ********* Start of Script *********" >> $LOGFILE
echo " " >> $LOGFILE

# loop through the FILE list and moving FILEs according FILE type
for FILE in $FILE_LIST
do
  case $FILE in
    *.csv)  mv -v $FILE csv/$FILE  | awk -F " " '{ print "moving " $2 $3 $4 }' >> $LOGFILE ;;
    *.doc*) mv -v $FILE docx/$FILE | awk -F " " '{ print "moving " $2 $3 $4 }' >> $LOGFILE ;;
    *.jpg)  mv -v $FILE jpg/$FILE  | awk -F " " '{ print "moving " $2 $3 $4 }' >> $LOGFILE ;;
    *.log)  mv -v $FILE log/$FILE  | awk -F " " '{ print "moving " $2 $3 $4 }' >> $LOGFILE ;;
    *.pdf)  mv -v $FILE pdf/$FILE  | awk -F " " '{ print "moving " $2 $3 $4 }' >> $LOGFILE ;;
    *.png)  mv -v $FILE png/$FILE  | awk -F " " '{ print "moving " $2 $3 $4 }' >> $LOGFILE ;;
    *.txt)  mv -v $FILE txt/$FILE  | awk -F " " '{ print "moving " $2 $3 $4 }' >> $LOGFILE ;;
    *.xls*) mv -v $FILE xlsx/$FILE | awk -F " " '{ print "moving " $2 $3 $4 }' >> $LOGFILE ;;
    *)      mv -v $FILE mis/$FILE  | awk -F " " '{ print "moving " $2 $3 $4 }' >> $LOGFILE ;;
  esac
done

echo " "       >> $LOGFILE
echo "exit $?" >> $LOGFILE
echo " "       >> $LOGFILE
echo "$TIME_STAMP ********* End of Script *********" >> $LOGFILE
echo " "       >> $LOGFILE
