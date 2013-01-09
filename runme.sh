#!/bin/sh
set -e
# Define Install
Install () {
	clear
	echo " "
	echo -n " Is this folder located in the root of the newznab folder? [y/n] "
	read WISH1
	if [ $WISH1 = "n" ] ; then
		echo " Please put it in the ../newznab directory."
		exit
	fi
	
	echo " "
	echo " Copying the Baffi:Theme"
	cp -r baffi ../www/views/themes/baffi
	cp -r baffi-green ../www/views/themes/baffi-green
	cp -r baffi-red ../www/views/themes/baffi-red
	
	cp bootstrap.js ../www/views/scripts/bootstrap.js
	
	clear
	echo " "
	echo -n " Go and select the Baffi theme in admin->site edit. Have you done it? [y/n] "
	read WISH12
	if [ $WISH12 = "y" ] ; then
	
		rm -r ../www/lib/smarty/templates_c/*
	
		echo " "
		echo " Copying the Baffi:Templates"
		cp -r templates_baffi ../www/views/templates_baffi
		
		echo " "
		echo " Backuping the basepage"
		mv ../www/lib/framework/basepage.php ../www/lib/framework/basepage_old.php 

		echo " "
		echo " Feeding the Baffi:basepage"
		cp basepage.php ../www/lib/framework/basepage.php 
	
	fi

	echo " "
	echo " I think we are about done for now."
	echo " "
}

Remove () {
	clear	
	echo " "
	echo " Removing the Baffi:Theme"
	rm -r ../www/views/themes/baffi
	rm -r ../www/views/themes/baffi-green
	rm -r ../www/views/themes/baffi-red
	rm ../www/views/scripts/bootstrap.js
	
	echo " "
	echo " Removing the Baffi:Templates"
	rm -r ../www/views/templates_baffi

	echo " "
	echo " Removing the Baffi:basepage"
	rm ../www/lib/framework/basepage.php 

	echo " "
	echo " Reverting back to the backup of the basepage"
	mv ../www/lib/framework/basepage_old.php ../www/lib/framework/basepage.php 

	echo " "
	echo " Reseting the cache"
	rm -r ../www/lib/smarty/templates_c/*
	
	echo " "
	echo " I think we are about done for now."
	echo " "
}


clear
echo " "
echo " 1. Install baffi:theme "
echo " 2. Remove baffi:theme "
echo " 3. Update baffi:theme [Not yet implemented]"
echo " "
echo -n " What do you want? "
read WISH0

if [ $WISH0 = "1" ] ; then
	Install
fi

if [ $WISH0 = "2" ] ; then
	Remove
fi

if [ $WISH0 = "3" ] ; then
	Remove
	
	clear
	
	echo " "
	echo " Updating"
	
	git pull
	
	clear
	
	Install
	
fi


exit