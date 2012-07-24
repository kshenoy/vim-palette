"===============================================================================

" Exit when app has already been loaded (or "compatible" mode set)
if exists("g:loaded_Signature") || &cp
    finish
endif
let g:loaded_Signature = "1.1"  " Version Number
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
exec 'amenu ' . g:PaletteMenuStruct . '.&Dark.Badwolf :colo badwolf<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.&Dark.Jellybeans :colo jellybeans<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.&Dark.Moria :colo moria<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.&Dark.TIR\ Black :colo tir_black<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.&Dark.Torte++ :colo torte++<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.&Dark.Wombat :colo wombat<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.&Dark.Xoria :colo xoria<CR>'

" Light Themes
exec 'amenu ' . g:PaletteMenuStruct . '.&Light.Eclipse :colo eclipse<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.&Light.Eclipse_my :colo eclipse_my<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.&Light.Tolerable :colo tolerable<CR>'
exec 'amenu ' . g:PaletteMenuStruct . '.&Light.VC :colo vc<CR>'


"===============================================================================
let &cpo = s:save_cpo
unlet s:save_cpo
