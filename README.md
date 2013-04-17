# vim-palette

vim-palette is a simple plugin to enhance the manner in which colorschemes are displayed in the Edit menu.  
It creates 'Default', 'Dark' and 'Light' sub-menus and categorizes the colorschemes accordingly.  
Note, this plugin depends upon `set background` being used inside the theme file to recognize if the theme is a dark or a light theme.

### Screenshots
[Click](http://imgur.com/a/wwXjm)


## Requirements
Currently, vim-palette supports only unix and windows.


## Installation
I highly recommend using Pathogen or Vundler to do the dirty work for you. If
for some reason, you do not want to use any of these excellent plugin, then
download and unzip it to your ~/.vim directory. You know how it goes...  


## Customization
By default, the "Edit > Color Scheme" menu will be replaced and default colorschemes won't be classified.  
To change these settings or for further details refer the [help]()


## ToDo
* If the theme file does not contain `set bg=` setting, put under new 'Misc' sub-menu.  
