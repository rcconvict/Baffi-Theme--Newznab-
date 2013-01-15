#!/usr/bin/env python

# Written by convict

import sys, os, shutil
import platform, subprocess, re, os, json, urllib2

def runGit(args):
	git_locations = ['git']
	run_dir = os.getcwd()
	
	if platform.system().lower() == 'darwin':
		git_locations.append('/usr/local/git/bin/git')
	
	output = err = None
	for cur_git in git_locations:
		cmd = cur_git + ' ' + args
		try:
			p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, shell=True, cwd=run_dir)
			output, err = p.communicate()
		except OSError:
			print 'Command "%s" did not work. Could not find git.' % cmd
			continue
	
		if 'not found' in output or 'not recognized as an internal or external command' in output:
			print 'Unable to find git with command "%s"' % cmd
			output = None
		elif 'fatal:' in output or err:
			print 'Git returned bad info. Are you sure this is a git installation?'
			output = None
		elif output:
			break
	return (output, err)

def gitCurrentVersion():
	output, err = runGit('rev-parse HEAD')

	if not output:
		print 'Could not find latest installed version with git.'
		return None

	current_commit = output.strip()

	if not re.match('^[a-z0-9]+$', current_commit):
		print 'Git output does not look like a hash, not using it.'
		return None

	return current_commit

def latestCommit():
	url = 'https://api.github.com/repos/Frikish/Baffi-Theme--Newznab-/commits/master'
	result = urllib2.urlopen(url).read()
	git = json.JSONDecoder().decode(result)
	return git['sha']

def commitsBehind():
	url = 'https://api.github.com/repos/Frikish/Baffi-Theme--Newznab-/compare/%s...%s' % (gitCurrentVersion(), latestCommit())
	result = urllib2.urlopen(url).read()
	git = json.JSONDecoder().decode(result)
	return git['total_commits']

def install(update=False):
	# copy theme folders
	folders = ['baffi', 'baffi-green', 'baffi-red']
	for fname in folders:
		destination = os.path.join('../www/views/themes/', fname)
		try:
			shutil.copytree(fname, destination)
		except OSError, e:
			print 'Error copying theme folders: %s' % e

	# if this is not an update then backup pre-existing files
	if update == False:
		raw_input('Go and select the baffi theme in admin->site edit. Press enter to continue...')

	# make sure backups are in place
	try:
		if not os.path.isfile('../www/views/scripts/utils_old_original.js'):
			shutil.copy('../www/views/scripts/utils.js', '../www/views/scripts/utils_old_original.js')
			os.rename('../www/views/scripts/utils.js', '../www/views/scripts/utils_old.js')
		if not os.path.isfile('../www/lib/framework/basepage_old_original.php'):
			shutil.copy('../www/lib/framework/basepage.php', '../www/lib/framework/basepage_old_original.php')
			os.rename('../www/lib/framework/basepage.php', '../www/lib/framework/basepage_old.php')
		if not os.path.isfile('../www/views/scripts/utils-admin_old_original.js'):
			shutil.copy('../www/views/scripts/utils-admin.js', '../www/views/scripts/utils-admin_old_original.js')
			os.rename('../www/views/scripts/utils-admin.js', '../www/views/scripts/utils-admin_old.js')
	except OSError, e:
		print 'Error copying/renaming frameworks: %s' % e
	except IOError, e:
		sys.exit('ERROR! Files are missing. Go to your newznab folder and run "svn up" to restore them. %s' % e)

	# copy files to www/views/scripts
	files = ['bootstrap.js', 'utils.js', 'jquery.pnotify.js', 'utils-admin.js']
	for fname in files:
		destination = os.path.join('../www/views/scripts/', fname)
		try:
			shutil.copy(fname, destination)
		except OSError, e:
			print 'Error copying scripts: %s' % e

	# copy over baffi template folder and basepage.php
	try:
		shutil.copytree('templates_baffi', '../www/views/templates_baffi')
		shutil.copy('basepage.php', '../www/lib/framework/')
	except OSError, e:
			print 'Error copying template/basepage: %s' % e

def uninstall(update=False):
	# remove old theme folders
	try:
		folders = ['baffi', 'baffi-green', 'baffi-red']
		for fname in folders:
			shutil.rmtree(os.path.join('../www/views/themes/', fname))
	except OSError, e:
		print 'Error removing themes: %s' % e
	# remove old scripts
	try:
		files = ['bootstrap.js', 'utils.js', 'jquery.pnotify.js', 'utils-admin.js']
		for fname in files:
			os.remove(os.path.join('../www/views/scripts/', fname))
	except OSError, e:
		print 'Error removing old scripts: %s' % e
	# remove baffi:templates and basepage
	try:
		shutil.rmtree('../www/views/templates_baffi')
		os.remove('../www/lib/framework/basepage.php')
	except OSError, e:
		print 'Error removing templates/basepage: %s' % e

	# If this is an update, we don't want to revert old files
	if update == False:
		try:
			#revert to basepage backup
			os.rename('../www/lib/framework/basepage_old.php', '../www/lib/framework/basepage.php')
			#revert utils.js
			os.rename('../www/views/scripts/utils_old.js', '../www/views/scripts/utils.js')
			#revert utils-admin.js
			os.rename('../www/views/scripts/utils-admin_old.js', '../www/views/scripts/utils-admin.js')
		except OSError, e:
			print 'Unable to revert to old files: %s' % e

def preflight():
	if os.name != 'posix':
		sys.exit('This script is designed for linux. If you run this on windows and ask why it does not work I will come into your home and make a mess of your pots and pans.')
	if  os.geteuid() != 0:
		print "If you're having troubles or errors with this script please run it as root to see if the problem persists."
	dirs = ['../www/views/', '../www/views/scripts', '../www/views/themes', '../www/lib/', '../www/lib/framework', '../www/lib/smarty/templates_c']
	for folder in dirs:
		if os.path.isdir(folder) != True:
			sys.exit('ERROR: %s is not a directory. Are you calling this script from the right folder?' % folder)

def delcache():
	cache_dir = '../www/lib/smarty/templates_c'
	for root, dirs, files in os.walk(cache_dir):
		for name in files:
			try:
				os.remove(os.path.join(root, name))
			except OSError, e:
				sys.exit('Warning: Could not clear smarty cache: %s' % e)

def main(switch):
	preflight()
	if switch == 'install':
		install()
		print 'Installation finished.'
	if switch == 'uninstall':
		uninstall()
		print 'Uninstall finished.'
	if switch == 'update':
		comm = commitsBehind()
		if comm > 0:
			print 'You are %s commits behind. It\'s recommended to run "git pull" then re-run python baffi.py update' % comm
		uninstall(True)
		install(True)
		print 'Update finished.'
	if switch == 'delcache':
		delcache()
		print 'Smarty cache deletion completed.'

if __name__ == '__main__':
	args = ['install', 'uninstall', 'update', 'delcache']
	usage = '''python baffi.py [install, uninstall, update, delcache]
	This folder must be located in the root of the newznab folder to run properly!'''

	if len(sys.argv) < 2:
		sys.exit(usage)
	if sys.argv[1] in args:
		main(sys.argv[1])
	else:
		sys.exit(usage)
