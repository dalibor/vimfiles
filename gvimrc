"When the GUI starts, t_vb is reset to its default value.
"Reassert that no flash or beep is wanted.
set visualbell t_vb=

if has("autocmd") && has("gui")
  au GUIEnter * set t_vb=
endif

" Turn off toolbar
set guioptions-=T
