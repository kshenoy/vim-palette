" vim-palette is a simple plugin to sort colorschemes under 'Default',
" 'Dark' and 'Light' sub-menus.
"
" Maintainer:
"   Kartik Shenoy
"
" vim: fdm=marker:et:ts=4:sw=2:sts=2
"===============================================================================

" Exit when app has already been loaded (or "compatible" mode set)
if !has('gui_running') || exists("g:loaded_Palette") || &cp
  finish
endif
if !(has('unix') || has('win32'))
  finish
endif
let g:loaded_Palette = "1.2"  " Version Number



" Initialize variables"                             {{{1
if !exists( 'g:Palette' )
  let g:Palette = {}
endif
let s:Palette = {}


if !exists( "g:Palette['UseEditMenu']" )
  let g:Palette['UseEditMenu'] = 1
endif


if !exists("g:Palette['ClassifyDefaults']")
  let g:Palette['ClassifyDefaults'] = 0
endif


if !exists("g:Palette['MenuStruct']")
  if g:Palette['UseEditMenu']
    let g:Palette['MenuStruct'] = '20.440 Edit.C&olor\ Scheme'
  else
    let g:Palette['MenuStruct'] = 'P&lugin.&Palette'
  endif
endif


let s:home = substitute($HOME, '\', '\\\\', 'g')
let s:vimp = substitute($VIM, '\', '\\\\', 'g')
let s:vrtp = substitute($VIMRUNTIME, '\', '\\\\', 'g')

if !exists("g:Palette['ColorsDir']")
  let g:Palette['ColorsDir'] = []
endif
" Sanitise by escaping backslashes
if has('win32')
  for i in range(0, len(g:Palette['ColorsDir'])-1)
    let g:Palette['ColorsDir'][i] = substitute(g:Palette['ColorsDir'][i], '/', '\\', 'g')
    let g:Palette['ColorsDir'][i] = substitute(g:Palette['ColorsDir'][i], '$HOME', s:home, 'g')
    let g:Palette['ColorsDir'][i] = substitute(g:Palette['ColorsDir'][i], '$VIMRUNTIME', s:vrtp, 'g')
    let g:Palette['ColorsDir'][i] = substitute(g:Palette['ColorsDir'][i], '$VIM', s:vimp, 'g')
  endfor
endif

let s:Palette['ColorsDefault'] = [ '$VIMRUNTIME/colors' ]
if has( 'win32' )
  for i in range(0, len(s:Palette['ColorsDefault'])-1)
    let s:Palette['ColorsDefault'][i] = substitute(s:Palette['ColorsDefault'][i], '/', '\\', 'g')
    let s:Palette['ColorsDefault'][i] = substitute(s:Palette['ColorsDefault'][i], '$HOME', s:home, 'g')
    let s:Palette['ColorsDefault'][i] = substitute(s:Palette['ColorsDefault'][i], '$VIMRUNTIME', s:vrtp, 'g')
    let s:Palette['ColorsDefault'][i] = substitute(s:Palette['ColorsDefault'][i], '$VIM', s:vimp, 'g')
  endfor
endif "1}}}



function! s:GetThemes( loc_arr, bg_type ) "         {{{1
  " Description: Searches the list of specified locations for the type of specified colorscheme and adds it under a
  " submenu the name of which is provided as an argument
  "
  " Arguments:
  "   bg_type ( string ) : Type of colorscheme ie. Dark/Light
  "   loc_arr ( list )   : List of locations to check for colorschemes
  "
  " Return Val:
  "   ( list ) List of colorschemes of the type specified

  let l:colorschemes = []

  if has('unix')
    " Parse through all the colors dirs to identify themes of specified type ( dark/light )
    for l:loc in a:loc_arr
      let l:sys_out = system('\grep -PH "set\s+(background|bg)\s*=\s*' . a:bg_type . '" ' . l:loc . '/*.vim')

      for l:theme in split( l:sys_out, '\n' )
        let l:theme = split(l:theme, ':')[0]
        let l:theme = split(l:theme, '/')[-1]
        let l:theme = substitute(l:theme, '\.vim$', "", '')
        call add( l:colorschemes, l:theme )
      endfor
    endfor

  elseif has('win32')
    let l:themes = []

    " Parse through all the colors dirs to identify themes of specified type ( dark/light )
    for l:loc in a:loc_arr
      let l:sys_out = system('findstr /R /C:"set [ ]*background[ ]*=[ ]*' . a:bg_type . '" ' . shellescape(l:loc) . '\*.vim')
      call sort(extend(l:themes, split(l:sys_out, '\n')))
      let l:sys_out = system('findstr /R /C:"set [ ]*bg[ ]*=[ ]*' . a:bg_type . '" ' . shellescape(l:loc) . '\*.vim')
      call sort(extend(l:themes, split(l:sys_out, '\n')))
    endfor

    for l:theme in l:themes
      let l:theme = split(l:theme, ':')[1]
      let l:theme = split(l:theme, '\')[-1]
      let l:theme = substitute(l:theme, '\.vim$', "", '')
      call add( l:colorschemes, l:theme )
    endfor
  endif

  return sort( l:colorschemes )
endfunction



function! s:MakeMenu( colorschemes, submenu, bg_type ) "     {{{1
  " Description: Adds the provided list of colorschemes to the submenu entry
  "
  " Arguments:
  "   colorschemes ( list ) : List of locations to check for colorschemes
  "   submenu ( string )    : The name of the sub-menu under which the colorscheme should be added
  let l:bg = ""
  if ( a:bg_type != "" )
    let l:bg = '<Bar>set bg='
  endif
  for l:theme in a:colorschemes
    exec 'amenu ' . g:Palette['MenuStruct'] . '.' . a:submenu . '.' . l:theme . ' :colo ' . l:theme . l:bg . a:bg_type . '<CR>'
  endfor
endfunction "}}}1



" Remove default Edit > Color Scheme menu
if g:Palette['UseEditMenu']
  aunmenu Edit.Color\ Scheme
endif

" Parse through all the locations in &runtimepath and identify those directories which have a colors subdirectory
" Save these in s:Palette['ColorsDir']
let s:Palette['ColorsDir'] = deepcopy( g:Palette['ColorsDir'] )
for dir in split( &rtp, ',' )
  if ( isdirectory( dir . "/colors" ))
    call add( s:Palette['ColorsDir'], dir . "/colors" )
  endif
endfor


if ( g:Palette['ClassifyDefaults'] == 0 )
  if has('unix')
    call filter( s:Palette['ColorsDir'], 'v:val !~ $VIMRUNTIME' )
  else
    call filter( s:Palette['ColorsDir'], 'v:val !~ s:vimp' )
  endif
endif

" Get and classify themes as Default, Light or Dark
let g:Palette['DefaultThemes'] = s:GetThemes( s:Palette['ColorsDefault'], ""  )
let g:Palette['DarkThemes']    = s:GetThemes( s:Palette['ColorsDir'], "dark"  )
let g:Palette['LightThemes']   = s:GetThemes( s:Palette['ColorsDir'], "light" )

" Create menu entries
call s:MakeMenu( g:Palette['DefaultThemes'], "D&efault", "" )
exec 'amenu ' . g:Palette['MenuStruct'] . '.-s1- :'
call s:MakeMenu( g:Palette['DarkThemes'], "&Dark", "dark" )
call s:MakeMenu( g:Palette['LightThemes'], "&Light", "light" )
