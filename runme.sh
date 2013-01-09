#!/bin/sh
set -e
# Define Install
Install () {
	clear
	echo -n "Is this folder located in the root of the newznab folder? [y/n] "
	read WISH1
	if [ $WISH1 = "n" ] ; then
		echo "Please put it in the ../newznab directory."
		exit
	fi
	
	echo "Copying the Baffi:Theme"
	cp -r baffi ../www/views/themes/baffi
	cp -r baffi-green ../www/views/themes/baffi-green
	cp -r baffi-red ../www/views/themes/baffi-red
	
	cp bootstrap.js ../www/views/scripts/bootstrap.js
	
	clear
	echo -n "Go and select the Baffi theme in admin->site edit. Have you done it? [y/n] "
	read WISH12
	if [ $WISH12 = "y" ] ; then
	
		echo "Copying the Baffi:Templates"
		cp -r templates_baffi ../www/views/templates_baffi
		
		echo "Backuping the basepage"
		mv ../www/lib/framework/basepage.php ../www/lib/framework/basepage_old.php 

		echo "Feeding the Baffi:basepage"
		cp basepage.php ../www/lib/framework/basepage.php 
	
	fi

}
# Define Removal of the Baffi:theme files
Remove () {
	clear	
	echo "Removing the Baffi:Theme"
	
	rm -r ../www/views/themes/baffi
	rm -r ../www/views/themes/baffi-green
	rm -r ../www/views/themes/baffi-red
	rm ../www/views/scripts/bootstrap.js
	
	echo "Removing the Baffi:Templates"
	
	rm -r ../www/views/templates_baffi

	echo "Removing the Baffi:basepage"
	rm ../www/lib/framework/basepage.php 

	echo "Reverting back to the backup of the basepage"
	mv ../www/lib/framework/basepage_old.php ../www/lib/framework/basepage.php 


}
# Define Resting of the cache
Reset () {
	rm -r ../www/lib/smarty/templates_c/*
}

clear

echo "1. Install baffi:theme "
echo "2. Remove baffi:theme "
echo "3. Update baffi:theme (Need git)"
echo "4. Clear cache "
echo ""
echo -n "What do you want? "
read WISH0

if [ $WISH0 = "1" ] ; then
	Install
fi

if [ $WISH0 = "2" ] ; then
	Remove
fi

if [ $WISH0 = "3" ] ; then
	
	clear
	echo -n "Is Baffi:theme installed? [y/n] "
	read WISH3
	if [ $WISH3 = "y" ] ; then
	
		clear
		echo "Removing old"
		rm -r ../www/views/themes/baffi
		rm -r ../www/views/themes/baffi-green
		rm -r ../www/views/themes/baffi-red
		rm ../www/views/scripts/bootstrap.js
		rm -r ../www/views/templates_baffi
		rm ../www/lib/framework/basepage.php 
		mv ../www/lib/framework/basepage_old.php ../www/lib/framework/basepage.php 
		
		clear
		echo "Updating"
	
		git pull
	
		clear
		echo "Installing"
	
		cp -r baffi ../www/views/themes/baffi
		cp -r baffi-green ../www/views/themes/baffi-green
		cp -r baffi-red ../www/views/themes/baffi-red
		cp bootstrap.js ../www/views/scripts/bootstrap.js
		cp -r templates_baffi ../www/views/templates_baffi
		mv ../www/lib/framework/basepage.php ../www/lib/framework/basepage_old.php 
		cp basepage.php ../www/lib/framework/basepage.php 
	
		clear
	
		Reset
	
		clear
		echo "Done"
	fi
	
	clear
	echo "Updating"
	
	git pull
	
	clear
	 
	Install
	
	clear
	
	Reset
	
	clear
	echo "Done"
	
	
fi

if [ $WISH0 = "4" ] ; then
	Reset
fi

exit