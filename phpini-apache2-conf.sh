#!/bin/bash

# Set configuration for php.ini file inside apache2 http server.
# Intende for big upload size and increase the site performance.
# Supported by PHP 8.0 and up only.

# STEP -1: root check
if ! [ $(id -u) = 0 ]; then
    printf "Please run as root!\n"
    exit 1
fi

# STEP 0: first run
printf "\nPHP.ini apache2 tweaker script by https://github.com/bydzen/. Well managed.\n"
printf "Any issue? go to https://github.com/rayatiga/phpini-apache2-conf/issues/. Create new issue.\n"
printf "Visit more on https://github.com/rayatiga/phpini-apache2-conf/. GitHub repository.\n\n"

# STEP 1: backuping file php.ini original
while true; do
    printf "Recommended for backuping php.ini file incase the problem may occur!\n"
    read -p "Backup original php.ini file? (y/n): " yn
    case $yn in
    [Yy]*)
        cp php-conf.ini /etc/php/
        cd /etc/php/
        cd $(ls -d * | grep 8.*)
        cd apache2/
        printf "\nBackuping php.ini file..."
        sleep 1
        cp php.ini php.ini.$(date +%m-%d-%Y).bak
        cp php.ini ~/php.ini.$(date +%m-%d-%Y).bak
        printf "\nBackuped. ✓\n"
        sleep 1
        break
        ;;
    [Nn]*)
        printf "\nSkipped backup. ✓\n"
        sleep 1
        break
        ;;
    *) printf "Please answer 'Y/y' or 'N/n'.\n" ;;
    esac
done

# STEP 2: changing and replacing file php.ini
currentdir=$(pwd)

rm $currentdir/php.ini

sed -i 's/upload_max_filesize_here/2G/' $currentdir/php.ini
sed -i 's/post_max_size_here/8G/' $currentdir/php.ini
sed -i 's/max_execution_time_here/300/' $currentdir/php.ini
sed -i 's/memory_limit_here/4G/' $currentdir/php.ini
sed -i 's/max_file_uploads_here/250/' $currentdir/php.ini

# Below is under development
