" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'Townk/vim-autoclose' 
Plug 'tpope/vim-commentary' 
Plug 'pangloss/vim-javascript' 
Plug 'tpope/vim-surround' 
Plug 'tpope/vim-fugitive' 
Plug 'tpope/vim-abolish' 
Plug 'scrooloose/nerdtree' 
Plug 'scrooloose/syntastic' 
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'dracula/vim'
Plug 'vimwiki/vimwiki'
Plug 'davidhalter/jedi-vim'
Plug 'micha/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

" Non-dev plugins
" Plug 'https://github.com/twitvim/twitvim.git'

" html / templates
Plug 'mattn/emmet-vim', { 'for': 'html' } " emmet support for vim - easily create markdup wth CSS-like syntax
Plug 'gregsexton/MatchTag', { 'for': 'html' } " match tags in html, similar to paren support
Plug 'othree/html5.vim', { 'for': 'html' } " html5 support
Plug 'mustache/vim-mustache-handlebars' " mustach support
Plug 'digitaltoad/vim-jade', { 'for': ['jade', 'pug'] } " jade support

" JavaScript
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' } " JavaScript indent support
Plug 'moll/vim-node', { 'for': 'javascript' } " node support
Plug 'othree/yajs.vim', { 'for': 'javascript' } " JavaScript syntax plugin
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' } " ES6 and beyond syntax
Plug 'mxw/vim-jsx', { 'for': ['jsx', 'javascript'] } " JSX support

" TypeScript
" Plug 'Quramy/tsuquyomi', { 'for': 'typescript', 'do': 'npm install' } " extended typescript support - works as a client for TSServer
" Plug 'clausreinke/typescript-tools.vim', { 'for': 'typescript' } " typescript tools
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' } " typescript support

call plug#end()


" Settings {{{

" make the most of 256-color terminals
if ($TERM == "screen" || $TERM =~ "256")
    set t_Co=256 t_kb=
endif

" " this block is for Terminology, to disable alt-screen switching
if ($TERMINOLOGY == "1")
    set t_ti= t_te=
endif

" if v:progname == "vim"
"     set modeline
"     set number
" else
"     set nomodeline
"     set nonumber
" endif

" if has('folding')
"     set foldmethod=indent
" endif

" "I never use a white terminal
if !has('gui_running')
    set background=dark
endif

" "sort this block with the following command:
" .,/endsettings/-1sort /^"\?set\s\(no\)\?/
set autoindent
" set autowrite "writes file before I :make it
set backspace=indent,eol,start "lets you use backspace on previously inserted words
set nobackup
set diffopt=filler,icase,iwhite
set nocindent
" set comments=s1:/*,mbx:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:- " is this right?
set cpoptions=BadFAces
set cursorline
set noexpandtab
set formatoptions=tcqron
set grepformat=%f:%l:%m
set grepprg=grep\ -HnEi
set hlsearch
set ignorecase
set incsearch
set keymodel=startsel,stopsel
set laststatus=2 "make sure status line always appears, regardless of splits
set matchpairs=(:),{:},[:],<:>
set matchtime=3
set mouse=
set nrformats=hex
set ruler
set shiftwidth=4
set shortmess=aoOTt
set showcmd
set smartcase
set smartindent
" set spellfile=$HOME/.vim/spell/local.en.add
set spellsuggest=best,15
set splitbelow splitright
set nostartofline
" set statusline=%<%m%f:%l\ _%{winnr()}_\ %y%r%=<%b\ 0x%B>\ \ %c%V\ %P
" set statusline=%m%f:%l/%L\ %P\ %<<%-3b\ 0x%-2B>\ %y%r%w%=b:%n\ w:%{winnr()}
set tabstop=4
set tags=tags
set undodir=~/.vim/undo
set undofile
set whichwrap=b,s,<,>,[,]
set nowildmenu
set wildmode=list:longest,full
set wrap
" "endsettings

" "settings to fix dreaded un-indenting of lines beginning with # 
set autoindent
inoremap # X#

if has('syntax')
    syntax on
    highlight Folded     term=bold ctermfg=12 ctermbg=None
    "highlight CursorLine term=underline cterm=underline ctermbg=None ctermfg=11
endif

" if has('eval')
"     filetype plugin indent on
" endif
" "}}}

" " Mappings {{{

" "emulate eclipse and VS build hotkey
" map          <F4> :sign unplace *<CR> <bar>:ccl<CR>
" imap         <F4> <C-O>:sign unplace *<CR>
" map          <F5> :make<CR>
" imap         <F5> <C-O>:make<CR>

" execute the current line of text as a shell command
noremap      Q !!$SHELL<CR>

" Use <C-L> to clear search highlighting as well as refresh the screen
noremap      <silent> <C-l> :nohlsearch <bar> redraw<CR>
inoremap     <silent> <C-l> <C-O>:nohlsearch <bar> redraw<CR>

if has("win32")
    map      <F1>   :silent !start explorer.exe /select,% <CR>
    map      <S-F1> :silent !start cmd.exe <CR>
    noremap  <F6>   :silent !start ctags -R<CR>
    imap     <F6>   <C-O>:silent !start ctags -R<CR>
elseif has("unix")
    noremap  <F6>   :silent !ctags -R<CR>
    imap     <F6>   <C-O>:silent !ctags -R<CR>
endif

nmap <C-I> :NERDTreeToggle<CR>


" " Cycle between line numbers, relative numbers, no numbers
if exists('+relativenumber')
  "CTRL-N is traditionally mapped to move the cursor down;
  "I never use it that way, and there are already four other
  "ways to do that
  nnoremap <expr> <C-N> CycleLNum()
  xnoremap <expr> <C-N> CycleLNum()
  onoremap <expr> <C-N> CycleLNum()

  " function to cycle between normal, relative, and no line numbering
  function! CycleLNum()
    if &l:rnu
      setlocal nonu nornu
    elseif &l:nu
      setlocal nu rnu
    else
      setlocal nu
    endif
    " sometimes (like in op-pending mode) the redraw doesn't happen
    " automatically
    redraw
    " do nothing, even in op-pending mode
    return ""
  endfunc
endif


" " File Changed Shell Handler {{{
" " Explains what has happened when Vim notices that the file you are editing
" " was changed by another program

if has('eval') && has('autocmd')
    augroup FCSHandler
        au FileChangedShell * call FCSHandler(expand("<afile>:p"))
    augroup END

    function! FCSHandler(name)
        let msg = 'File "'.a:name.'"'
        let v:fcs_choice = ''
        if v:fcs_reason == 'deleted'
            let msg .= " no longer available - 'modified' set"
            call setbufvar(expand(a:name), '&modified', '1')
        elseif v:fcs_reason == 'time'
            let msg .= ' timestamp changed'
        elseif v:fcs_reason == 'mode'
            let msg .= ' permissions changed'
        elseif v:fcs_reason == 'changed'
            let msg .= ' contents changed'
            let v:fcs_choice = 'ask'
        elseif v:fcs_reason == 'conflict'
            let msg .= ' CONFLICT --'
            let msg .= ' is modified, but'
            let msg .= ' was changed outside Vim'
            let v:fcs_choice = 'ask'
            echohl Error
        else  " unknown values (future Vim versions?)
            let msg .= ' FileChangedShell reason='
            let msg .= v:fcs_reason
            let v:fcs_choice = 'ask'
        endif
        redraw!
        echomsg msg
        echohl None
    endfunction
endif

"===================================
" Mark Edits
"===================================
let macvim_skip_colorscheme=1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
set background=dark
" colorscheme elflord
colorscheme slate
set clipboard+=unnamed
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png

let g:syntastic_python_checkers = ['flake8']

let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Remap leader to comma
let mapleader=","

" EasyMotion
"""""""""""""""""""""""""""""""""""
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" two character search
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

" hjkl motions
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" FZF config
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

imap jj <Esc>
