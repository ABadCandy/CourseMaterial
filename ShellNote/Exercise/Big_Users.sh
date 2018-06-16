#Big_Users - find big disk space users in various directories
#############################################################
#Parameters for Script
#
CHECK_DIRECTORIES="/mnt/f/Shell /mnt/d/Course" 
#
########################Main Script##########################
#
DATE=$(date '+%m%d%y')
#
exec > disk_space_$DATE.rpt
#
echo "Top Ten Disk Space Usage"
echo "for $CHECK_DIRECTORIES Directories"
#
for DIR_CHECK in $CHECK_DIRECTORIES
do
    echo ""
    echo "The $DIR_CHECK Directory:"
#
#Create a listing of top ten disk spcace users
    du -S $DIR_CHECK 2>/dev/null | sort -rn | sed '{11,$D; =}' | sed 'N; s/\n/ /' | gawk '{printf $1 ":" "\t" $2 "\t" $3 "\n"}'
#
done
#

