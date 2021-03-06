#!/bin/bash
_os="`uname`"
_now=$(date +"%m_%d_%Y")
_file="dump-data/data_$_now.sql"

# Export dump
cd ..
EXPORT_COMMAND='exec mysqldump "$MYSQL_DATABASE" -uroot -p"$MYSQL_ROOT_PASSWORD"'
docker-compose exec mysql sh -c "$EXPORT_COMMAND" > $_file

if [[ $_os == "Darwin"* ]] ; then
  sed -i '.bak' 1,1d $_file
else
  sed -i 1,1d $_file # Removes the password warning from the file
fi

# Copy www moodledata
tar cfz ./dump-data/joomla3-www_$_now.tar.gz ./joomla3-www
