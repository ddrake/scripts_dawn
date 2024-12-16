#! /usr/bin/bash
# Backup the live database locally (good to have it two places)

# Remove old backups
if [ -z "$BKPATH" ]
then
    echo "\$BKPATH is empty. Make sure the virtualenv is activated!"
else
    find $BKPATH -mtime +8 -exec rm {} \;
    # Backup and gzip database
    TODAY=`date -I`
    FILEPATH=$BKPATH/dawn_$TODAY.sql.gz
    pg_dump -U $DB_USER  -h $DB_HOST -p $DB_PORT $DB_DATABASE | gzip > $FILEPATH
fi
