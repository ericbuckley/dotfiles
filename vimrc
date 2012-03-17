" initialize pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

set nocompatible

set encoding=utf-8
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set cursorline
set ttyfast
set ruler
set relativenumber
set undofile
syntax on
set laststatus=2

" Whitespace stuff
set wrap
set textwidth=85
set formatoptions=qrn1
set colorcolumn+=1
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set list listchars=tab:\ \ ,trail:·
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Searching
nnoremap / /\v
vnoremap / /\v
set gdefault
set incsearch
set showmatch
set hlsearch
set ignorecase
set smartcase
nnoremap <leader><space> :noh<cr>

" Wildmenu completion {{{
set wildmenu
set wildmode=list:longest

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store?                      " OSX bullshit
" }}}

" Status line {{{
set statusline=%F%m%r%h%w
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=(%{&ff}/%Y)
set statusline+=\ (line\ %l\/%L,\ col\ %c)
let g:Powerline_symbols = 'unicode'
" }}}

" Backups {{{
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
" }}}

" Custom leader button
let mapleader = ","

" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" ack shortcut
nnoremap <leader>a :Ack
" html fold tag
nnoremap <leader>ft Vatzf
" sort css propperties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" reselect text that was just pasted
nnoremap <leader>v V`]
" open .vimrc file in vertical split
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" clear highlighted matches
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Color Scheme {{{
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
set gfn=Menlo:h12
call togglebg#map('<F5>')
" }}}
"
" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" }}}

" Syntastic settings {{{
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['python', 'django', 'javascript', 'css'],
                           \ 'passive_filetypes': ['htmldjango'] }
let g:syntastic_javascript_checker = 'jshint'
" }}}

" CtrlP settings {{{
let g:ctrlp_working_path_mode = 2
let g:ctrlp_match_window_reversed = 0
" }}}

" Ack settings {{{
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
" }}}

" Django {{{
au BufNewFile,BufRead admin.py     setlocal filetype=python.django
au BufNewFile,BufRead urls.py      setlocal filetype=python.django
au BufNewFile,BufRead models.py    setlocal filetype=python.django
au BufNewFile,BufRead views.py     setlocal filetype=python.django
au BufNewFile,BufRead forms.py     setlocal filetype=python.django
" }}}

" HTML and HTMLDjango {{{
au BufNewFile,BufRead *.html setlocal filetype=htmldjango.html
au FileType html,jinja,htmldjango setlocal foldmethod=manual

" Use <localleader>f to fold the current tag.
au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

" Use Shift-Return to turn this:
"     <tag>|</tag>
"
" into this:
"     <tag>
"         |
"     </tag>
au FileType html,jinja,htmldjango nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>
"" }}}

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <F8> :!/opt/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Remember last location in file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
    filetype on

    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " The following line sets the smartindent mode for *.py files. 
    " It means that after typing lines which start with any of the
    " keywords in the list (ie. def, class, if, etc) the next line
    " will automatically indent itself to the next level of indentation:
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

    " Many people like to remove any extra whitespace from the 
    " ends of lines. Here is one way to do it when saving your file.
    autocmd BufWritePre *.py normal m`:%s/\s\+$//e``
endif
