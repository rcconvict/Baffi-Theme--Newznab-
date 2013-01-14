# Baffi - the theme for Newznab
A "theme" for newznab, it's more then the normal theme, this is a complete rewrite of the template files in effort to make a good theme.

Join Synirc `#newznab-baffi` for more talk about the theme.

#### Status

Working on: `frontend`


#### Preview

* [Series View](http://cl.ly/image/3i023e0M2f3h "Series View")
* [Movie List View](http://cl.ly/image/2L1B2s1y2R2p "Movie List View")

#### Quick start

####### Recommended is the git-way, since the runme script can update via git.

* Clone the repo: `git clone git://github.com/Frikish/Baffi-Theme--Newznab-.git` inside the `/newznab` folder


## Installation and removal

1. Change dir : `cd Baffi-Theme--Newznab-`
2. Run the baffi.py script : `python baffi.py` with  install, uninstall, update, delcache as argument. eg. `python baffy.py install`
3. Follow the instructions

* To update do first `git pull` from inside the `Baffi-Theme--Newznab-`, then a `python baffy.py update`

####### NB! If you are using nginx, and the instalation ran smooth. But it's doesn't look like the previews. Try rebooting the nginx and php5..

####### If the site gets a smarty error after removal of the theme. There is a file named `basepage_old_original.php` that you have to use as the real `basepage.php`, located in the `/lib/framework/`.

### Thanks to

* [convict](https://github.com/rcconvict) @ #newznab-baffi for making the awesome install script in python.

### Themed with 

* [Bootstrap](http://getbootstrap.com)
* [FontAwesome](http://fortawesome.github.com/Font-Awesome/) 
* [Pines Notification](http://pinesframework.org/pnotify/).

