" README:             {{{1
" vim-palette, version 1.0
" 
" Description:        {{{2
" vim-palette is a simple plugin to enhance the manner in which colorschemes
" are displayed in the Edit menu. It creates 'Default', 'Dark' and 'Light' 
" sub-menus and categorizes the colorschemes accordingly.  
"
" Note, this plugin depends upon `set background` being set inside the theme
" file to know if the theme is a dark or a light theme. If the theme file does
" not contain this value, it will be put under the 'Misc' sub-menu.  
"
" ### Screenshots
" [Click]()
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
"    The location of the menu can be specified using this variable.  
"
" * `g:PaletteColorsDir` ( Default : [ "~/.vim/colors" ] )
"    By default, vim-palette searches for colorschemes in ~/.vim/colors directory.
"    Change this variable to change the location to search for. If multiple
"    locations are specified, it will search each one. Note that this variable
"    must be an array.  
"
"
" Maintainer:         {{{2
"   Kartik Shenoy
" 
" Changelist:
"   2012-07-25:
"     - Created
"
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
  let g:PaletteUseEditMenu = 0
endif
if !exists('g:PaletteMenuStruct')
  if g:PaletteUseEditMenu
    let g:PaletteMenuStruct = '20.440 Edit.C&olor\ Scheme'
  else
    let g:PaletteMenuStruct = 'P&lugins.&Palette'
  endif
endif
if !exists('g:PaletteColorsDir')
  let g:PaletteColorsDir = [ "~/.vim/colors" ]
endif


" Remove default Edit > Color Scheme menu
if g:PaletteUseEditMenu
  aunmenu Edit.Color\ Scheme
endif


" Default schemes
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Blue :colo blue<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.DarkBlue :colo darkblue<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Default :colo default<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Delek :colo delek<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Desert :colo desert<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.ElfLord :colo elflord<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Evening :colo evening<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Koehler :colo koehler<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Morning :colo morning<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Murphy :colo murphy<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Pablo :colo pablo<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.PeachPuff :colo peachpuff<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Ron :colo ron<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Shine :colo shine<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Slate :colo slate<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Torte :colo torte<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.D&efault.Zellner :colo zellner<CR>'

exec 'amenu ' . g:PaletteMenuStruct . '.-s1- :'


" Dark Themes
let s:dark_themes = []
for s:loc in g:PaletteColorsDir
  let s:sys_out     = system('\grep -P "set\s+background\s*=\s*dark" ' . s:loc . '/*')
  let s:dark_themes = sort(extend(s:dark_themes, split(s:sys_out, '\n')))
  let s:sys_out     = system('\grep -P "set\s+bg\s*=\s*dark" ' . s:loc . '/*')
  let s:dark_themes = sort(extend(s:dark_themes, split(s:sys_out, '\n')))
endfor
for s:theme in s:dark_themes
  let s:theme = split(s:theme, ':')[0]
  let s:theme = split(s:theme, '/')[-1]
  let s:theme = substitute(s:theme, '\.vim$', "", "")
  exec 'amenu ' . g:PaletteMenuStruct . '.&Dark.' . s:theme . ' :colo ' . s:theme . '<CR>'
endfor


" Light Themes
let s:light_themes = []
for s:loc in g:PaletteColorsDir
  let s:sys_out      = system('\grep -P "set\s+background\s*=\s*light" ' . s:loc . '/*')
  let s:light_themes = sort(extend(s:light_themes, split(s:sys_out, '\n')))
  let s:sys_out      = system('\grep -P "set\s+bg\s*=\s*light" ' . s:loc . '/*')
  let s:light_themes = sort(extend(s:light_themes, split(s:sys_out, '\n')))
endfor
for s:theme in s:light_themes
  let s:theme = split(s:theme, ':')[0]
  let s:theme = split(s:theme, '/')[-1]
  let s:theme = substitute(s:theme, '\.vim$', "", "")
  exec 'amenu ' . g:PaletteMenuStruct . '.&Light.' . s:theme . ' :colo ' . s:theme . '<CR>'
endfor



"===============================================================================
let &cpo = s:save_cpo
unlet s:save_cpo
