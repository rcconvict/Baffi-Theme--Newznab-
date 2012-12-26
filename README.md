# Baffi - the theme for Newznab
A "theme" for newznab, it's more then the normal theme, this is a complete rewrite of the template files in effort to make a good theme.


## Status

Working on: `frontend`

######Not fully skinned:

Admin
* `ajax_release-edit`
 
Main
* `Download page via SAB`
* `Music`
* `Book`
* `Anime`
* `Console`
* `PreList`

## Preview

* [Series View](http://cl.ly/image/3i023e0M2f3h "Series View")
* [Movie List View](http://cl.ly/image/3C3D0X1D2t1M "Movie List View")


## Quick start

Two quick start options are available:

* [Download the latest release](https://github.com/Frikish/Baffi-Theme--Newznab-/zipball/master).
* Clone the repo: `git clone git://github.com/Frikish/Baffi-Theme--Newznab-.git`



## Installation

1. Copy the `baffi` folder to the path `../newznab/www/views/themes` within the application folder.
2. Rename the `templates` folder in `../newznab/www/views/` on the website, to `templates_old`.
3. Copy the `templates` folder to the path `../newznab/www/views/`.
4. Copy the `bootstrap.min.js` file located in `scripts` folder to the path `../newznab/www/views/scripts`.
5. Select the `baffi` theme under Admin -> Site edit 

## Revert to old.

1. Select some other theme then `baffi` under Admin -> Site edit and save/refresh (to see that the `baffi` theme is broken.)
2. Delete the `bootstrap.min.js` file located in `../newznab/www/views/scripts`.
3. Delete the `templates` folder located in `../newznab/www/views/`, and rename `templates_old` to `templates`.
4. Delete the `baffi` folder in `../newznab/www/views/themes`.
5. Delete any files in the folder `../newznab/www/lib/smarty/templates_c`, this is a cache issue, Thanks to sinfuljosh figuring it out.



## Thanks to

Themed with [Bootstrap](http://getbootstrap.com) and [FontAwesome](http://fortawesome.github.com/Font-Awesome/)

