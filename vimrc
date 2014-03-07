""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Point to pathogen autoload file
runtime bundle/vim-pathogen/autoload/pathogen.vim

" Load pathogen bundled plugins
execute pathogen#infect()

" Turn on syntax highlighting
syntax on

" Load ftplugins and indent files
filetype plugin indent on

" Break away from old vi compatibility
set nocompatible

" Use X11 clipboard for yank and paste
set clipboard=unnamedplus

" Change the mapleader from \ to ,
let mapleader = ","

" Avoid annoying CSApprox warning message
let g:CSApprox_verbose_level = 0

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set command line history limit
set history=1000

" Show the cursor position all the time
set ruler

" Show incomplete commands at the bottom
set showcmd

" Show current mode at the bottom
set showmode

" Highlight search matches
set hlsearch

" Highlight search match as you type
set incsearch

" Display line numbers
set number

" Display ... as wrap break
set showbreak=...

" Proper wrapping
set wrap linebreak nolist

" Add some line space for easy reading
set linespace=4

" Disable visual bell
set visualbell t_vb=

" Gvim
if has("autocmd") && has("gui")
  au GUIEnter * set t_vb=
endif

" Turn off toolbar on GVim
set guioptions-=T

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Indentation settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Folding settings
set foldmethod=indent

" Set deepest folding to 3 levels
set foldnestmax=3

" Don't fold by default
set nofoldenable

" Activate TAB auto-complete for file paths
set wildmode=longest,list

" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" Some stuff to get the mouse going in term
" set mouse=a
" set ttymouse=xterm2

" Allow backgrounding buffers without saving them
set hidden

" Max 80 chars per line
set colorcolumn=81

" Colorscheme
if has("gui_running")
  " Tell the term has 256 colors
  set t_Co=256
  set term=gnome-256color
  colorscheme railscasts

  " solarized
  " colorscheme solarized
  " syntax enable
  " set background=light
  " set background=dark
else
  set term=xterm-256color
  colorscheme jellybeans

  " solarized
  " colorscheme solarized
  " let g:solarized_termcolors=256
  " syntax enable
  " set background=dark
  " set background=light
endif

" Use Ack instead of grep
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
set grepprg=ack


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Use :w!! to write to a file using sudo if you forgot to "sudo vim file"
cmap w!! %!sudo tee > /dev/null %

" Window navigation
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Tab navigation
noremap <S-h> gT
noremap <S-l> gt

" Map ESC
imap jj <ESC>
imap <c-c> <ESC>

" Switch between last two buffers
nnoremap <leader><leader> <c-^>

" Go to vim shell
map <leader>sh :sh<cr>

" Disable arrow keys
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" Make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" Paste last yanked text
map <c-p> "0p

" Edit/View files relative to current directory
cnoremap %% <c-R>=expand('%:h').'/'<cr>
map <leader>re :edit %%
map <leader>rv :view %%

" Ctags
nnoremap <f5> :!ctags -R --exclude=.git --exclude=log *<cr>

" View routes or Gemfile in large split
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft :split Gemfile<cr>
" map <leader>gg :topleft 100 :split Gemfile<cr>

" Scenario Outline align
vmap <c-a> :Align \|<cr>

" insert =>
imap <c-l> <space>=><space>

" Switch between buffers
noremap <tab> :bn<cr>
noremap <S-tab> :bp<cr>

" Close buffer
nmap <leader>bd :bprevious<cr>:bdelete #<cr>

" Close all buffers
nmap <leader>bD :bufdo bd<cr>

" Clear the search buffer when hitting return
:nnoremap <cr> :nohlsearch<cr>

" xnoremap - mappings should apply to Visual mode, but not to Select mode
xnoremap * :<c-u>call <SID>VSetSearch()<cr>/<c-R>=@/<cr><cr>
xnoremap # :<c-u>call <SID>VSetSearch()<cr>?<c-R>=@/<cr><cr>

" Generate html from the file with syntax highligh
nmap <leader>ss :runtime! syntax/2html.vim<cr>

" Execute current ruby file
nmap <leader>E :!ruby %<cr>

" Open vimrc file
map <leader>v :e ~/.vim/vimrc<cr>

" Personal dropbox mappings
map <leader>di :e ~/Dropbox/notes/improve.txt<cr>
map <leader>dt :e ~/Dropbox/notes/todo.txt<cr>
map <leader>dp :sp ~/Dropbox/notes/project-notes.txt<cr>
map <leader>dj :CtrlP ~/Dropbox/notes/<cr>

" Automatically execute ctags each time a file is saved
" autocmd BufWritePost * call system("ctags -R")

" Source the vimrc file after saving it
" if has("autocmd")
"   autocmd BufWritePost vimrc source $MYVIMRC
" endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%f       "tail of the filename
" set statusline+=%h      "help file flag
" set statusline+=%y      "filetype
" set statusline+=%r      "read only flag
" set statusline+=%m      "modified flag

" Display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '[\s]'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction


"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning =  '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    else
      let b:statusline_tab_warning = ''
    endif
  endif
  return b:statusline_tab_warning
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>t= :Tabularize /=<CR>
vmap <leader>t= :Tabularize /=<CR>
nmap <leader>t: :Tabularize /:\zs<CR>
vmap <leader>t: :Tabularize /:\zs<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-f>'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.gif,*.png,*.pdf
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$',
      \ 'file': '\.png$\|\.gif$\|\.jpg$',
      \ }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
"let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 40
map <leader>p :NERDTreeToggle<cr>
" Open NERDTree by default
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rails.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>rg :Rgenerate 
map <leader>rd :Rdestroy 

map <leader>em :Emodel 
map <leader>ev :Eview 
map <leader>ec :Econtroller 
map <leader>eh :Ehelper 
map <leader>el :Elib 
map <leader>er :Emailer 

map <leader>ej :Ejavascript 
map <leader>es :Estylesheet 
map <leader>ey :Elayout 

map <leader>ee :Eenvironment 
map <leader>ei :Einitializer 
map <leader>ew :Emigration 
map <leader>ed :Eschema 

map <leader>ef :Efixtures 
map <leader>eu :Eunittest 
map <leader>et :Efunctionaltest 

" :Espec
" :Elocale
" :Etask
" :Eintegrationtest

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>Tt <Plug>SendTestToTmux
map <leader>TT <Plug>SendFocusedTestToTmux
map <leader>at :call VimuxRunCommand('bundle exec rspec --color') <cr>
let g:VimuxHeight = "55"
let g:VimuxOrientation = "h"

" Prompt forca command to run
map <leader>rp :PromptVimTmuxCommand<cr>

" Run last ccmmand executed by RunVimTmuxCommand
map <leader>rl :RunLastVimTmuxCommand<cr>

" Inspect runner pane
map <leader>ri :InspectVimTmuxRunner<cr>

" Close all other tmux panes in current window
map <leader>rc :CloseVimTmuxPanes<cr>

" Interrupt any command running in the runner pane
map <leader>rs :InterruptVimTmuxRunner<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vroom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vroom_use_bundle_exec = 0 " don't use bundle exec
let g:vroom_spec_command = 'spring rspec'
let g:vroom_map_keys = 0 " don't use default mapping <leader>r and <leader>R
map <leader>rr :VroomRunTestFile<cr>
map <leader>rR :VroomRunNearestTest<cr>
" let g:vroom_use_vimux = 1 " use vimux

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nmap ,rr :w\|!rspec spec/file_spec.rb<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_leader_key = '<space>'
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configured used javascript libs
let g:used_javascript_libs = 'angularjs'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search for string in files
function! AckGrep()
  normal ebvey
  exec ":Ack " . @"
endfunction
map <leader>ag :call AckGrep()<cr>
nmap <leader>af :Ack 


" Jump to last cursor position when opening a file except when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfunction


" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" autocmd BufWritePre *.rb :call <SID>StripTrailingWhitespaces()
autocmd FileType c,cpp,scss,css,html,erb,java,php,ruby,python,javascript autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
nnoremap <leader>cs :call <SID>StripTrailingWhitespaces()<cr>


" Show routes
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>


" Snipmate setup
source ~/.vim/snippets/support_functions.vim
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()
  "if we're in a rails env then read in the rails snippets
  if filereadable("./config/environment.rb")
    call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
    call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
  endif

  call ExtractSnips("~/.vim/snippets/html", "eruby")
  call ExtractSnips("~/.vim/snippets/html", "xhtml")
endfunction


" Work-around to copy selected text to system clipboard
" and prevent it from clearing clipboard when using ctrl + z (depends on xsel)
function! CopyText()
  normal gv"+y
  :call system('xsel -ib', getreg('+'))
endfunction
vmap <leader>y :call CopyText()<cr>


" Search for the current selection
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction


" Populate the argument list with each of the files named in the quickfix list
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()


" Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>rf :call RenameFile()<cr>


" Promote variable to RSpec let
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>let :PromoteToLet<cr>


function! OpenURL(url)
  if has("win32")
    exe "!start cmd /cstart /b ".a:url.""
  elseif $DISPLAY !~ '^\w'
    exe "silent !sensible-browser \"".a:url."\""
  else
    exe "silent !sensible-browser -T \"".a:url."\""
  endif
  redraw!
endfunction
command! -nargs=1 OpenURL :call OpenURL(<q-args>)
nnoremap <leader>gu :OpenURL <cfile><cr>
nnoremap gG :OpenURL http://www.google.com/search?q=<cword><cr>
nnoremap gU :OpenURL http://www.urbandictionary.com/define.php?term=<cword><cr>


" function! ExtractVar()
"   normal ^*``
"   normal ww
"   normal "zDdd``
"   normal cwz
" endfunction
" map ,gt :call ExtractVar()<cr>

function! ViewHtmlText(url)
  if !empty(a:url)
    new
    setlocal buftype=nofile bufhidden=hide noswapfile
    execute 'r !elinks ' . a:url . ' -dump -dump-width ' . winwidth(0)
    1d
  endif
endfunction
" Save and view text for current html file.
nnoremap <Leader>H :update<Bar>call ViewHtmlText(expand('%:p'))<CR>
" View text for visually selected url.
vnoremap <Leader>h y:call ViewHtmlText(@@)<CR>
" View text for URL from clipboard.
" On Linux, use @* for current selection or @+ for text in clipboard.
nnoremap <Leader>h :call ViewHtmlText(@+)<CR>
