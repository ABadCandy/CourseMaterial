#Hourly_Archive - Every hour create an archive
################################################
#
CONFIG_FILE=/home/abadcandy/archive/hourly/File_To_Backup
#
# Set Base Archive Destination Location
#
BASEDEST=/home/abadcandy/archive/hourly
#
# Gather Current Day, Month $ Time
#
DAY='date +%d'
MONTH='date +%m'
TIME='date +%k%M'
#
# Create Archive Destination Directory
#
mkdir -p $BASEDEST/$MONTH/$DAY
#
# BUild Archive Destination File Name
#
DESTINATION=$BASEDEST/$MONTH/$DAY/archive${TIME}.tar.gz
#
################################Main Script###############
#
#Check Backup Config file exists
#
if [ -f $CONFIG_FILE ]
then
    echo
else
    echo
    echo "$CONFIG_FILE does not exist."
    echo "Backup not completed due to missing Configuration File"
    echo
    exit
fi
#
#Build the names of all the files to backup
#
FILE_NO=1  # Start on Line 1 of Config File
exec < $CONFIG_FILE
#
read FILE_NAME
#
while [ $? -eq 0 ]
do
    # Make sure the file or directory exists.
    if [ -f $FILE_NAME -o -d $FILE_NAME ]
    then
        FILE_LIST="$FILE_LIST $FILE_NAME"
    else
        echo
        echo "$FILE_NAME, does not exist."
        echo "Obviously, I will not include it in this archive."
        echo "It is listed on line $FILE_NO of the config file."
        echo "Continuing to build archive list..."
        echo
    fi
#
    FILE_NO=$[$FILE_NO+1]
    read FILE_NAME
done
#
####################################################
#
# Backup to the files and Compress Archive
#
tar -czf $DESTINATION $FILE_LIST 2>/dev/null
#
