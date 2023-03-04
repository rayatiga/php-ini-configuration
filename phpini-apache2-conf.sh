#!/bin/bash

# Set configuration for php.ini file inside apache2 http server.
# Intende for big upload size and increase the site performance.

coloroff='\033[0m'
red='\033[0;31m' 
green='\033[0;32m'

# STEP -1: root check
if ! [ $(id -u) = 0 ]; then
    printf "Please run as root!\n"
    exit 1
fi

# STEP 0: first run
printf "\nPHP.ini apache2 tweaker script by https://github.com/bydzen/. Well managed.\n"
printf "Any issue? go to https://github.com/rayatiga/phpini-apache2-conf/issues/. Create new issue.\n"
printf "Visit more on https://github.com/rayatiga/phpini-apache2-conf/. GitHub repository.\n\n"
$currentdir = $(pwd)

# STEP 1: creating php.ini file with custom config
printf "Your current custom config .ini file: ./php-conf.ini\n"
printf "Create a custom specification for your config.\n"

read -p "Enter upload max size (e.g. 2G): " upmax
read -p "Enter post max size (e.g. 4G): " postmax
read -p "Enter max exec time (without second) (e.g. 120): " exectime
read -p "Enter memory limit (e.g. 2G): " memlimit
read -p "Enter max file upload (e.g. 100): " upfile

# STEP 2: giving information about custom config
printf "\nCustom config saved. Here the information: \n"
printf "Upload max size = ${green}$upmax${coloroff}
        Post max size = ${green}$postmax${coloroff}
        Max execution time = ${green}$exectime${coloroff}
        Memory limit = ${green}$memlimit${coloroff}
        Max file upload = ${green}$upfile${coloroff}\n\n"

sed -i 's/upload_max_filesize_here/$upmax/' php-conf.ini
sed -i 's/post_max_size_here/$postmax/' php-conf.ini
sed -i 's/max_execution_time_here/$exectime/' php-conf.ini
sed -i 's/memory_limit_here/$memlimit/' php-conf.ini
sed -i 's/max_file_uploads_here/$upfile/' php-conf.ini

cp php-conf.ini php.ini
rm php-cong.ini

# STEP 3: information about copying custom php.ini
printf "Copy and replace your php.ini file from ${green}$currentdir/php.ini${coloroff} to ${green}/etc/php/(your-php-version)/apache2/php.ini${coloroff}\n"
printf "${red}Important!${coloroff} please backup your default/current active php.ini config incase the problem occurs.\n\n"

printf "Done. Program terminated."
