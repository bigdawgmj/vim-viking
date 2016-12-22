execute pathogen#infect()

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

filetype plugin on
au BufRead,BufNewFile *.ts        setlocal filetype=typescript
set rtp+=~/.vim/bundle/typescript-tools.vim/

let g:TSS = ['tss','--module','commonjs']
if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
set completeopt-=preview

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Townk/vim-autoclose' 
Plugin 'tpope/vim-commentary' 
Plugin 'pangloss/vim-javascript' 
Plugin 'tpope/vim-surround' 
Plugin 'tpope/vim-fugitive' 
Plugin 'scrooloose/nerdtree' 
Plugin 'scrooloose/syntastic' 
Plugin 'vim-airline/vim-airline' 
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'dracula/vim'
Plugin 'micha/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'

" html / templates
Plugin 'mattn/emmet-vim', { 'for': 'html' } " emmet support for vim - easily create markdup wth CSS-like syntax
Plugin 'gregsexton/MatchTag', { 'for': 'html' } " match tags in html, similar to paren support
Plugin 'othree/html5.vim', { 'for': 'html' } " html5 support
Plugin 'mustache/vim-mustache-handlebars' " mustach support
Plugin 'digitaltoad/vim-jade', { 'for': ['jade', 'pug'] } " jade support
" Plug 'juvenn/mustache.vim', { 'for': 'mustache' } " mustache support

" JavaScript
Plugin 'gavocanov/vim-js-indent', { 'for': 'javascript' } " JavaScript indent support
Plugin 'moll/vim-node', { 'for': 'javascript' } " node support
Plugin 'othree/yajs.vim', { 'for': 'javascript' } " JavaScript syntax plugin
Plugin 'othree/es.next.syntax.vim', { 'for': 'javascript' } " ES6 and beyond syntax
Plugin 'mxw/vim-jsx', { 'for': ['jsx', 'javascript'] } " JSX support

" TypeScript
" Plug 'Quramy/tsuquyomi', { 'for': 'typescript', 'do': 'npm install' } " extended typescript support - works as a client for TSServer
" Plug 'clausreinke/typescript-tools.vim', { 'for': 'typescript' } " typescript tools
Plugin 'leafgarland/typescript-vim', { 'for': 'typescript' } " typescript support

call vundle#end()
filetype plugin indent on

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

" " Map alt-v in command-line mode to replace the commandline
" " with the Ex command-line beneath the cursor in the buffer
" cnoremap     <Esc>v <C-\>esubstitute(getline('.'), '^\s*\(' . escape(substitute(&commentstring, '%s.*$', '', ''), '*') . '\)*\s*:*' , '', '')<CR>

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

map          <F7> :TlistTogglstToggle<CR>
map          <F9> :Scratch<CR>
map <C-k> :NERDTreeToggle<CR>

" "}}}

" " Global variables {{{
" if has('eval')
" let g:obviousModeInsertHi = 'gui=reverse'
" let g:ZO_syntaxhighlight = 1
" let g:ZO_sleepdelay = '50m'

" let g:showfuncctagsbin='/usr/bin/exuberant-ctags'
" let g:showfunc_width_pct=45
" let g:errormarker_errorgroup = "Error"
" let g:errormarker_warninggroup = "Todo"

" "git branch info
" let g:git_branch_status_nogit=""

" endif
" "}}}

" "commands/aliases {{{
" if has('user_commands')
" command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" command! -nargs=1 -complete=help Help      :help <args>
" command! -nargs=1 -complete=help HElp      :help <args>
" command! -nargs=* -bar -bang Ls            :ls<bang>
" command! -nargs=0 Noh       :noh
" command! -nargs=0 Date      :put ='* ' . strftime('%b %d, %Y %I:%M %p')
" command! -nargs=? -bar      Underline    :put =repeat( len('<args>') > 0 ? '<args>' : '=', len(getline('.')))
" command! -nargs=0 Max       :let [s:lines, s:columns] = [&lines, &columns] | set lines=999 columns=999
" command! -nargs=0 Taller    :let [s:lines, s:columns] = [&lines, &columns] |set lines=999
" command! -nargs=0 Wider     :let [s:lines, s:columns] = [&lines, &columns] |set columns=999
" command! -nargs=0 Restore  :let [s:lines, s:columns, &lines, &columns] = [&lines, &columns, s:lines, s:columns]
" command! -nargs=0 Merge /^\(<\|=\|>\)\{7}\ze\(\s\|$\)/
" endif
" "}}}

" " Autocommands {{{
" if has('autocmd')
" 	autocmd BufRead *.xsl,*.xslt,*.xml,*.htm,*.html,*.xsd,*.tas set filetype=xml
"     autocmd BufRead *.java set filetype=java
" 	autocmd FileType {xml,xslt} setlocal iskeyword=$,@,-,\:,48-57,_,128-167,224-235 
" 	autocmd FileType {xml,xslt} setlocal noexpandtab

"     " automatically re-source .vimrc after saving it
"     augroup RE_SOURCE_ON_WRITE
"         autocmd! BufWritePost .vimrc nested source <afile>
"     augroup END
" endif "has('autocmd')
" "}}}

" " Functions {{{
" if has('eval')

"     function! Urldecode(str)
"       let retval = a:str
"       let retval = substitute(retval, '+', ' ', 'g')
"       let retval = substitute(retval, '%\(\x\x\)', '\=nr2char("0x".submatch(1))', 'g')
"       return retval
"     endfunction

"     " Map F1 key to print the list of syntax items the character under the
"     " cursor is painted with
"     if v:version > 700
"         function! ShowSynStack()
"             for id in synstack(line('.'), col('.'))
"                 echo synIDattr(id, "name")
"             endfor
"         endfunction

"         map <F1> :call ShowSynStack()<CR>
"     endif

"     if ! exists("g:running_ReSourceVimrc") 
"         function! ReSourceVimrc() 
"             let g:running_ReSourceVimrc = 1
"             let l:this_session = v:this_session
"             source ~/.vimrc
"             let v:this_session = l:this_session
"             unlet g:running_ReSourceVimrc
"             redraw | echomsg "Re-sourced .vimrc"
"         endfunction 
"     endif

" endif


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

"}}}

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
" }}}

" vim:filetype=vim sw=4 foldmethod=marker tw=78 expandtab:

" Mark Edits
let macvim_skip_colorscheme=1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
syntax enable
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
set clipboard=unnamed
" autocmd VimEnter * NERDTree | wincmd p
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
