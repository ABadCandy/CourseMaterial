#Capture_Stats - Gather System Performance Statistics
##########################################################
# Set Script Variables
#
REPORT_FILE=/home/abadcandy/Documents/capstats.csv
DATE=`date +%m%d%Y`
TIME=`date +%k:%M:%S`
#
#########################################
# Gather Performance Statistics
#
USERS=`uptime | sed 's/users.*$//' | gawk '{print $NF}'`
LOAD=`uptime | gawk '{print $NF}'`
#
FREE=`vmstat 1 2 | sed -n '/[0-9]/p' | sed -n '2p' | gawk '{print $4}'`
IDLE=`vmstat 1 2 | sed -n '/[0-9]/p' | sed -n '2p' | gawk '{print $15}'`
#
#####################################
# Send Statistics to Report File
#
echo "$DATE,$TIME,$USERS,$LOAD,$FREE,$IDLE" >> $REPORT_FILE
#
