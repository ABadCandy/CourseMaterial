#Snapshot_States -produces a report for system stats
######################################################
#Set Script Variables
#
DATE=`date +%m%d%Y`
DISKS_TO_MONITOR="/dev/sda1 /dev/sda2"
MAIL=`which mutt`
MAIL_TO=user
REPORT=/home/abadcandy/Documents/Snapshot_States_$DATE.rpt
#
########################################################
#Create Report File
#
exec 3>$1 #Save file descriptor
#
exec 1> $REPORT 
#
####################################################
#
echo
echo -e "\t\tDaily System Report"
echo
#
#######################################################
# Date Stamp the Report
#
echo -e "Today is" `date +%m%d%Y`
echo
#
#################################################
# 1) Gather System Uptime Statistics
#
echo -e "System has been \c"
uptime | sed -n '/ ,/s/ ,/ /gp' | gawk '{if ($4 == "days" || $4 == "day") {print $2,$3,$4,$5} else {print $2,$3}}'
#
#############################################
# 2) Gather Disk Usage Statistics
#
echo
for DISK in $DISKS_TO_MONITOR
do 
    echo -e "$DISK usage: \c"
    df -h $DISK | sed -n '/% \//p' | gawk '{print $5}'
done
#
####################################
# 3) Gather Memory Usage Statistics
#
echo
echo -e "Memory Usage: \c"
#
free | sed -n '2p' | gawk 'x=int(($3 /$2) *100) {print x}' | sed 's/$/%/'
#
#############################################
# 4) Gather Number of Zombie Processes
#
echo
ZOMBIE_CHECK=`ps -al | gawk '{print $2,$4}`' | grep Z`
#
if [ "$ZOMBIE_CHECK" = "" ]
then 
    echo "No Zombie Process on System at this time"
else
    echo "Current System Zombie Processes"
    ps -al | gawk '{print $2,$4}' | grep Z
fi
echo
###########################################
#Restore File Descriptor & Mail Report
#
exec 1>&3
#
$MAIL -a $REPORT -s "System Statistics Report for $DATE"
-- $MAIL_TO < /dev/null
#
#################################################
#Clean up
#
rm -f $REPORT
#
