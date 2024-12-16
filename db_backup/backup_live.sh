#! /usr/bin/bash
# TODO: Backup the live database locally (good to have it two places)
# (not working yet...)

# Remove old backups
if [ -z "$BKPATH_LIVE" ]
then
    echo "\$BKPATH_LIVE is empty. Make sure the virtualenv is activated!"
else
    find $BKPATH_LIVE -mtime +8 -exec rm {} \;
    # Backup and gzip database
    TODAY=`date -I`
    FILEPATH=$BKPATH_LIVE/dawn_$TODAY.sql.gz
    PGPASSWORD=$DB_PASSWORD_LIVE pg_dump -U $DB_USER_LIVE \
    -h $DB_HOST_LIVE -p $DB_PORT_LIVE $DB_DATABASE_LIVE | gzip > $FILEPATH
fi


