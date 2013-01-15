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

def backupFiles():
	backup = {'utils.js' : os.path.join('..', 'www', 'views', 'scripts'),
		'basepage.php' : os.path.join('..', 'www', 'lib', 'framework'),
		'utils-admin.js' : os.path.join('..', 'www', 'views', 'scripts')}

	for filename, folder in backup.iteritems():
		try:
			if not os.path.isfile(os.path.join(folder, filename+'.old')):
				shutil.copy(os.path.join(folder, filename), os.path.join(folder, filename+'.oldoriginal'))
				os.rename(os.path.join(folder, filename), os.path.join(folder, filename+'.old'))
		except OSError, e:
			print 'Error copying/renaming %s. Message: %s' % (os.path.join(folder, filename), e)

def install(update=False):
	# copy theme folders
	folders = ['baffi', 'baffi-green', 'baffi-red']
	for fname in folders:
		destination = os.path.join('..', 'www', 'views', 'themes', fname)
		try:
			shutil.copytree(fname, destination)
		except OSError, e:
			print 'Error copying theme folders: %s' % e

	# give user a chance to switch themes
	if update == False:
		raw_input('Go and select the baffi theme in admin->site edit. Press enter to continue...')

	# copy files to www/views/scripts
	scriptFiles = ['bootstrap.js', 'utils.js', 'jquery.pnotify.js', 'utils-admin.js']
	for fname in scriptFiles:
		destination = os.path.join('..', 'www', 'views', 'scripts', fname)
		try:
			shutil.copy(fname, destination)
		except OSError, e:
			print 'Error copying %s: %s' % (fname, e)

	# copy over baffi template folder and basepage.php
	try:
		shutil.copytree('templates_baffi', os.path.join('..', 'www', 'views', 'templates_baffi'))
		shutil.copy('basepage.php', os.path.join('..', 'www', 'lib', 'framework'))
	except OSError, e:
			print 'Error copying template/basepage: %s' % e
	if update == False: print 'Installation finished.'

def uninstall(update=False):
	# remove old theme folders
	try:
		folders = ['baffi', 'baffi-green', 'baffi-red']
		for fname in folders:
			shutil.rmtree(os.path.join('..', 'www', 'views', 'themes', fname))
	except OSError, e:
		print 'Error removing themes: %s' % e

	# remove old scripts
	try:
		scriptFiles = ['bootstrap.js', 'utils.js', 'jquery.pnotify.js', 'utils-admin.js']
		for fname in scriptFiles:
			os.remove(os.path.join('..', 'www', 'views', 'scripts', fname))
	except OSError, e:
		print 'Error removing %s: %s' % (fname, e)

	# remove baffi:templates and basepage
	try:
		if platform.system().lower() == 'windows':
			shutil.rmtree(os.path.join('..', 'www', 'views', 'templates_baffi'))
			os.remove(os.path.join('..', 'www', 'lib', 'framework', 'basepage.php'))
	except OSError, e:
		print 'Error removing templates/basepage: %s' % e

	# If this is an update, we don't want to revert old files
	if update == False:
		try:
			#revert to basepage backup
			os.rename(os.path.join('..', 'www', 'lib', 'framework', 'basepage.php.old'), os.path.join('..', 'www', 'lib', 'framework', 'basepage.php'))
			#revert utils.js
			os.rename(os.path.join('..', 'www', 'views', 'scripts', 'utils.js.old'), os.path.join('..', 'www', 'views', 'scripts', 'utils.js'))
			#revert utils-admin.js
			os.rename(os.path.join('..', 'www', 'views', 'scripts', 'utils-admin.js.old'), os.path.join('..', 'www', 'views', 'scripts', 'utils-admin.js'))
		except OSError, e:
			print 'Unable to revert to old files: %s' % e
		print 'Uninstall finished.'

def update():
	comm = commitsBehind()
	if comm > 0:
		print 'You are %s commits behind. It\'s recommended to run "git pull" then re-run python baffi.py update' % comm
	backupFiles()
	uninstall(True)
	install(True)
	print 'Update finished.'

def preflight():
	dirs = [os.path.join('..', 'www'),
		os.path.join('..', 'www', 'views'),
		os.path.join('..', 'www', 'views', 'scripts'),
		os.path.join('..', 'www', 'lib', 'framework'),
		os.path.join('..', 'www', 'lib', 'smarty', 'templates_c')]

	for folder in dirs:
		if os.path.isdir(folder) != True:
			sys.exit('ERROR: %s is not a directory. Are you calling this script from the right folder?' % folder)

def delcache():
	cache_dir = os.path.join('..', 'www', 'lib', 'smarty', 'templates_c')
	for root, dirs, filenames in os.walk(cache_dir):
		for name in filenames:
			try:
				os.remove(os.path.join(root, name))
			except OSError, e:
				sys.exit('Warning: Could not clear smarty cache: %s' % e)
	print 'Smarty cache deletion completed.'

def main(switch):
	preflight()
	if switch == 'install':
		install()
	if switch == 'uninstall':
		uninstall()
	if switch == 'update':
		update()
	if switch == 'delcache':
		delcache()

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
