# vim-palette

vim-palette is a simple plugin to enhance the manner in which colorschemes are displayed in the Edit menu.  
It creates 'Default', 'Dark' and 'Light' sub-menus and categorizes the colorschemes accordingly.  
Note, this plugin depends upon `set background` being set inside the theme file to recognize if the theme is a dark or a light theme.

### Screenshots
[Click](http://imgur.com/a/wwXjm)


## Requirements
Currently, vim-palette supports only unix and windows.


## Installation
I highly recommend using Pathogen or Vundler to do the dirty work for you. If
for some reason, you do not want to use any of these excellent plugin, then
download and unzip it to your ~/.vim directory. You know how it goes...  


## Customization
By default, the Edit > Color Schemes menu will be replaced.  

* `g:PaletteUseEditMenu` ( Default : 1 )  
   Set this to 0 to preserve the original Color Schemes menu and instead create a new one.  
   The new menu will be created as Plugin > Palette if `g:PaletteMenuStruct` is not defined.  

* `g:PaletteMenuStruct` ( Default : "P&lugin.&Palette" )  
   When `g:PaletteUseEditMenu` is set to 0, a new menu will be created instead.  
   The location of the menu can be specified using this variable. For details, type
````
   :h usr_42.txt
````

* `g:PaletteColorsDir` ( Default : [ "$HOME/.vim/colors" ] )  
   By default, vim-palette searches for colorschemes in ~/.vim/colors directory.  
   Change this variable to change the location to search for. 
   If multiple locations are specified, it will search each one.  
   Note that this variable must be an array.  

* `g:PaletteColorsDefault` ( Default : [ "$VIMRUNTIME/colors" ] )  
   Directory containing the default colorschemes. As above, must be an array.  

* `g:PaletteClassifyDefaults` ( Default : 0 )  
   Should the default colorschemes be classified as dark or light?  


## ToDo
* If the theme file does not contain `set bg=` setting, put under new 'Misc' sub-menu.  
