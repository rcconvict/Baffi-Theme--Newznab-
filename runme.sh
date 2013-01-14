#!/bin/sh
set -e
# Define Install
Install () {
	echo -n "Is this folder located in the root of the newznab folder? [y/n] "
	read WISH1
	
	if [ $WISH1 = "n" ] ; then
		echo "Please put it in the ../newznab directory."
		exit
	fi
	
	echo -n "Is this a first time install? [y/n] "
	read WISH12
	
	if [ $WISH12 = "y" ] ; then
		echo "Copying the Baffi:Theme"
		cp -r baffi ../www/views/themes/
		cp -r baffi-green ../www/views/themes/
		cp -r baffi-red ../www/views/themes/
	
		cp bootstrap.js ../www/views/scripts/
		cp ../www/views/scripts/utils.js ../www/views/scripts/utils_old_original.js
		mv ../www/views/scripts/utils.js ../www/views/scripts/utils_old.js
		cp utils.js ../www/views/scripts/
		cp jquery.pnotify.js ../www/views/scripts/
		
		echo " "
		echo -n "Go and select the Baffi theme in admin->site edit. Have you done it? [y/n] "
		read WISH13
		
		if [ $WISH13 = "y" ] ; then
	
			echo "Copying the Baffi:Templates"
			cp -r templates_baffi ../www/views/
		
		
			echo "Backuping the basepage, and since this is a first time install, I make a super secret fall back file."
			cp ../www/lib/framework/basepage.php ../www/lib/framework/basepage_old.php 
			mv ../www/lib/framework/basepage.php ../www/lib/framework/basepage_old_original.php 
			
			
			echo "Feeding the Baffi:basepage"
			cp basepage.php ../www/lib/framework/
			
	
		fi
	
	else
		
		echo "Copying the Baffi:Theme"
		cp -r baffi ../www/views/themes/
		cp -r baffi-green ../www/views/themes/
		cp -r baffi-red ../www/views/themes/
	
		cp bootstrap.js ../www/views/scripts/
		mv ../www/views/scripts/utils.js ../www/views/scripts/utils_old.js
		cp utils.js ../www/views/scripts/
		
		cp jquery.pnotify.js ../www/views/scripts/
	
		echo " "
		echo -n "Go and select the Baffi theme in admin->site edit. Have you done it? [y/n] "
		read WISH14
		
		if [ $WISH14 = "y" ] ; then
	
			echo "Copying the Baffi:Templates"
			cp -r templates_baffi ../www/views/
		
			echo "Backuping the basepage"
			mv ../www/lib/framework/basepage.php ../www/lib/framework/basepage_old.php 

			echo "Feeding the Baffi:basepage"
			cp basepage.php ../www/lib/framework/
	
		fi
		
	fi
}

# Define Removal of the Baffi:theme files
Remove () {
	
	echo "Removing the Baffi:Theme"
	
	rm -r ../www/views/themes/baffi
	rm -r ../www/views/themes/baffi-green
	rm -r ../www/views/themes/baffi-red
	rm ../www/views/scripts/bootstrap.js
	rm ../www/views/scripts/utils.js
	mv ../www/views/scripts/utils_old.js ../www/views/scripts/utils.js
	rm ../www/views/scripts/jquery.pnotify.js
	
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

Cacheinfo () {
	echo " "
	echo "Reseting cache, if it failes it is just because there is no cache for the theme :)"
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
	
	Cacheinfo
	
	Reset
fi

if [ $WISH0 = "2" ] ; then
	Remove
	
	Cacheinfo
	
	Reset
fi

if [ $WISH0 = "3" ] ; then
	
	echo "Updating to the newest files from GitHub."
	git pull
	
	echo -n "Please run the script again and choose install :) "
fi

if [ $WISH0 = "4" ] ; then
	
	Cacheinfo
	
	Reset
fi

exit