" README:             {{{1
" vim-palette, version 1.0
" 
" Description:        {{{2
" vim-palette is a simple plugin to enhance the manner in which colorschemes
" are displayed in the Edit menu. It creates 'Default', 'Dark' and 'Light' 
" sub-menus and categorizes the colorschemes accordingly.  
"
" Note, this plugin depends upon `set background` being set inside the theme
" file to know if the theme is a dark or a light theme.
"
" ### Screenshots
" [Click](http://imgur.com/a/wwXjm)
"
"
" Requirements:       {{{2
" Currently, vim-palette uses the grep and ls commands and thus, is limited to
" platforms that support these instructions.  
"
"
" Installation:       {{{2
" I highly recommend using Pathogen or Vundler to do the dirty work for you. If
" for some reason, you do not want to use any of these excellent plugins, then
" download and unzip it to your ~/.vim directory. You know how it goes...  
"
"
" Customization:      {{{2
" By default, the Edit > Color Schemes menu will be replaced.  
"
" * `g:PaletteUseEditMenu` ( Default : 1 )  
"    Set this to 0 to preserve the original Color Schemes menu and instead create
"    a new one. The new menu will be created as Plugins > Palette if
"    g:PaletteMenuStruct is not defined.  
"
" * `g:PaletteMenuStruct` ( Default : "P&lugins.&Palette" )  
"    When `g:PaletteUseEditMenu` is set to 0, a new menu will be created instead.
"    The location of the menu can be specified using this variable. For details, type 
" ````
"    :h usr_42.txt
" ````
"
" * `g:PaletteColorsDir` ( Default : [ "$HOME/.vim/colors" ] )
"    By default, vim-palette searches for colorschemes in ~/.vim/colors directory.
"    Change this variable to change the location to search for. If multiple
"    locations are specified, it will search each one. Note that this variable
"    must be an array.  
"
" * `g:PaletteColorsDefault` ( Default : [ "$VIMRUNTIME/colors" ] )
"    Directory containing the default colorschemes. As above, must be an array.  
"
" * `g:PaletteClassifyDefaults` ( Default : 0 )
"    Should the default colorschemes be classified as dark or light?
"
"
" ToDo: "             {{{2
" * If the theme file does not contain "set bg=" setting, put under new 'Misc' sub-menu.  


" Maintainer:         {{{2
"   Kartik Shenoy
" 
" Changelist:
"   2012-07-25:
"     - Created
"
" }}}1
"===============================================================================

" Exit when app has already been loaded (or "compatible" mode set)
if exists("g:loaded_Palette") || &cp
  finish
endif
let g:loaded_Palette = "1.0"  " Version Number
let s:save_cpo         = &cpo
set cpo&vim


" Initialize variables
if !exists('g:PaletteUseEditMenu')
  let g:PaletteUseEditMenu = 1
endif

if !exists('g:PaletteMenuStruct')
  if g:PaletteUseEditMenu
    let g:PaletteMenuStruct = '20.440 Edit.C&olor\ Scheme'
  else
    let g:PaletteMenuStruct = 'P&lugins.&Palette'
  endif
endif

if !exists('g:PaletteColorsDefault')
  let g:PaletteColorsDefault = [ "$VIMRUNTIME/colors" ]
endif

if !exists('g:PaletteColorsDir')
  let g:PaletteColorsDir = [ "$HOME/.vim/colors" ]
endif

if !exists('g:PaletteClassifyDefaults')
  let g:PaletteClassifyDefaults = 0
endif


" Remove default Edit > Color Scheme menu
if g:PaletteUseEditMenu
  aunmenu Edit.Color\ Scheme
endif


" Extract themes from locations and create menu
function! s:MakeMenu(search, type, loc_arr)
  let l:themes = []
  for l:loc in a:loc_arr
    let l:sys_out = system('\grep -P "set\s+(background|bg)\s*=\s*' . a:search . '" ' . l:loc . '/*.vim')
    call sort(extend(l:themes, split(l:sys_out, '\n')))
  endfor
  for l:theme in l:themes
    let l:theme = split(l:theme, ':')[0]
    let l:theme = split(l:theme, '/')[-1]
    let l:theme = substitute(l:theme, '\.vim$', "", "")
    exec 'amenu ' . g:PaletteMenuStruct . '.' . a:type . '.' . l:theme . ' :colo ' . l:theme . '<CR>'
  endfor
endfunction


if g:PaletteClassifyDefaults
  let s:PaletteColorsDir = g:PaletteColorsDir + g:PaletteColorsDefault
else
  let s:PaletteColorsDir = g:PaletteColorsDir
endif


call s:MakeMenu("", "D&efault", g:PaletteColorsDefault)
exec 'amenu ' . g:PaletteMenuStruct . '.-s1- :'
call s:MakeMenu("dark", "&Dark", s:PaletteColorsDir)
call s:MakeMenu("light", "&Light", s:PaletteColorsDir)



"===============================================================================
let &cpo = s:save_cpo
unlet s:save_cpo
