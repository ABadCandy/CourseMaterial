#Report_States - Generates Rpt from Captured Perf Stats
##########################################################
# Set Script Variables
#
REPORT_FILE=/home/abadcandy/Documents/capstats.csv
TEMP_FILE=/home/abadcandy/Documents/capstats.html
#
DATE=`date +%m%d%Y`
#
MAIL=`which mutt`
MAIL_TO=user
#
##############################################################
# Create Report Header
#
echo "<html><body><h2>Report for $DATE</h2>" > $TEMP_FILE
echo "<table border=\"1\">" >> $TEMP_FILE
echo "<tr><td>Date</td><td>Time</td><td>Users</td>" >> $TEMP_FILE
echo "<td>Load</td><td>Free Memory</td><td>%CPU Idle</td></tr>" >> $TEMP_FILE
#
###############################################################
# Place Performaneces Stats in Report
cat $REPORT_FILE | gawk -F. '{ printf "<tr><td>%s</td><td>%s</td><td>%s</td>", $1, $2, $3; printf "<td>%s</td><td>%s</td><td>%s</td>\n</tr>\n", $4, $5, $6; }' >> $TEMP_FILE
#
echo "</table></body></html>" >> $TEMP_FILE
#
###########################################################
#Mail Performance Report & Clean up
#
#MAIL -a $TEMP_FILE -s "Performance Report $DATE" -- $MAIL_TO < /dev/null
#
rm -f $TEMP_FILE
#
