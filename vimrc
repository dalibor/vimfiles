call pathogen#infect()

"turn on syntax highlighting
syntax on

"load ftplugins and indent files
filetype plugin indent on

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" change the mapleader from \ to ,
let mapleader = ","

"avoiding annoying CSApprox warning message
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

"add some line space for easy reading
set linespace=4

"disable visual bell
set visualbell t_vb=

" gvim
if has("autocmd")&&  has("gui")
  au GUIEnter * set t_vb=
endif

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" statusline setup (tail of the filename)
set statusline=%f
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

" Turn off toolbar on GVim
set guioptions-=T

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

" Indentation settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Folding settings
"fold based on indent
set foldmethod=indent

" set deepest folding to 3 levels
set foldnestmax=3

" don't fold by default
set nofoldenable

" Activate TAB auto-complete for file paths
"set wildmode=list:longest
set wildmode=longest,list

" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"allow backgrounding buffers without saving them
set hidden

" max 80 chars per line
set colorcolumn=81

if has("gui_running")
  "tell the term has 256 colors
  set t_Co=256
  set term=gnome-256color

  colorscheme railscasts
  " set guifont=Monospace\ Bold\ 12
  " colorscheme desert
  " colorscheme vividchalk

  " solarized
  " syntax enable
  " set background=light
  " set background=dark
  " colorscheme solarized
else
  "dont load csapprox if there is no gui support - silences an annoying warning
  "let g:CSApprox_loaded = 1

  set term=gnome-256color

  colorscheme railscasts
  " colorscheme desert
  " colorscheme vividchalk

  " colorscheme solarized
  " syntax enable
  " set background=light
  " set background=dark
  " colorscheme solarized
endif

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
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
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

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

"snipmate setup
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

"Command-T
let g:CommandTMaxHeight=5
let g:CommandTMatchWindowAtTop=1
"map <c-f> :CommandTFlush<cr>\|:CommandT<cr>
map <c-f> :CommandT<cr>
map <c-q> :CommandTFlush<cr>
map <leader>gv :CommandT app/views<cr>
map <leader>gc :CommandT app/controllers<cr>
map <leader>gm :CommandT app/models<cr>
map <leader>gh :CommandT app/helpers<cr>
map <leader>gl :CommandT lib<cr>
map <leader>gp :CommandT public<cr>
map <leader>gs :CommandT public/stylesheets/sass<cr>
map <leader>gf :CommandT features<cr>
map <leader>f :CommandT<cr>
map <leader>F :CommandT %%<cr>

" File types to ignore on tab auto-complete
"set wildignore+=*.o,*.obj,.git,*.png,*.PNG,*.JPG,*.jpg,*.GIF,*.gif,*.zip,*.ZIP,*.eot,*.svg,*.csv,*.ttf,*.svg,*.eof,*.ico,*.woff,vendor/**,coverage/**,tmp/**,rdoc/**,*.sqlite3

" View routes or Gemfile in large split
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft :split Gemfile<cr>
" map <leader>gg :topleft 100 :split Gemfile<cr>

" BufExplorer
"map <Leader>j :BufExplorer<CR>
"nmap <c-b> :BufExplorer<CR>
"nnoremap <leader>b :BufExplorer<cr>
" default mapings
"<leader>be (normal open)
"<leader>bs (force horizontal split open)
"<leader>bv (force vertical split open)

" NERDTree
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
"let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 40
" open file browser
map <leader>p :NERDTreeToggle<cr>
" Open NERDTree by default
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

" Rails
" open Rails model
map <Leader>m :Rmodel
" open Rails controller
map <Leader>c :Rcontroller
" open Rails view
map <Leader>v :Rview

" Ack
" Use Ack instead of grep
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
set grepprg=ack
" search for string in files
nmap <leader>f :Ack

" Scenario Outline align
vmap <c-a> :Align \|<CR>

" use :w!! to write to a file using sudo if you forgot to "sudo vim file"
cmap w!! %!sudo tee > /dev/null %

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" External copy/paste
"vmap <C-c> "+y
"map <C-v> "+gP<CR>
map <Leader>. "+y<CR>
map <Leader>; "+gP<CR>

" Paste/Replate mappings
" Paste last yanked text
nmap <c-p> "0p
" replace selected text with yanked text
vmap ; "_dP
vmap ' "_dp

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map ESC
imap jj <ESC>

" Buffers
" Switch between buffers
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>
" close buffer
"nmap <leader>d :bd<CR>
nmap <leader>d :bprevious<CR>:bdelete #<CR>
" close all buffers
nmap <leader>D :bufdo bd<CR>
" Switch between last two buffers
nnoremap <leader><leader> <c-^>

" Go to vim shell
map <leader>sh :sh<cr>

" Edit/View files relative to current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>re :edit %%
map <leader>rv :view %%

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

iabbrev ilor Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum

" Stolen from Gary Bernhardt
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Running tests
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-makegreen binds itself to ,t unless something else is bound to its
" function.
map <leader>\dontstealmymapsmakegreen :w\|:call MakeGreen('spec')<cr>

" autoclose binds itself to ,a unless something else is bound to its
" function.
nmap <Leader>\dontstealmymapsautoclose <Plug>ToggleAutoCloseMappings

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!bundle exec cucumber --drb " . a:filename . " --require features"
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
            " exec ":!bundle exec spec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
            " exec ":!spec --color " . a:filename
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>
map <leader>c :w\|:!bundle exec cucumber<cr>
map <leader>C :w\|:!bundle exec cucumber --profile wip<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! AckGrep()
  normal ebvey
  exec ":!ack-grep " . @"
endfunction

map ,aa :call AckGrep()<cr>

" xnoremap - mappings should apply to Visual mode, but not to Select mode
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

" Search for the current selection
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" " Search for the current selection
" :vmap n y/<C-R>"<CR>


" make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>


command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()

" populate the argument list with each of the files named in the quickfix list
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction


" Execute ctags
nnoremap <f5> :!ctags -R<CR>

" Automatically execute ctags each time a file is saved
" autocmd BufWritePost * call system("ctags -R")
