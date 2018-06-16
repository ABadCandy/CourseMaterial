#Dairy_Archive - Archive designated files & directories
#########################################################
#
#Gather Current Date
#
DATE='date +%y%m%d'
#
#Set Archive File Name
#
FILE=archive${DATE}.tar.gz
#
#Set Configuration and Destination File
#
CONFIG_FILE=/home/abadcandy/archive/Files_To_Backup
DESTINATION=/home/abadcandy/archive/$FILE
#
###############################Main Script################
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

