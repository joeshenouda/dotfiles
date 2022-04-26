" general
set autoread
set autowrite
set noswapfile
set nobackup
set encoding=utf-8
set fileencoding=utf-8
set number " show line numbers
set relativenumber
set showmatch " highlight matching
set backspace=indent,eol,start " fix backspace cuz it sucks
set mouse=nicr " mouse used only for scrolling
set ruler " show cursor position
"set lazyredraw " redraw only when we need to.
set ff=unix

if v:version >= 700
    set numberwidth=3
endif

set modeline

" search
set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase
set smartcase

" move vertically by visual line (wrapped text)
nnoremap j gj
nnoremap k gk

" quick and easy comment/uncomment
noremap <C-n> :norm

" color/theme
syntax on
set t_Co=256
set background=dark

" make sure to use term background regardless of colorscheme
highlight Normal ctermbg=NONE
highlight LineNr ctermbg=NONE
highlight nonText ctermbg=NONE

" indent 'n stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*xlsx
set cursorline
set showcmd
set colorcolumn=81
set breakindent


" Enable smart indenting
filetype plugin indent on
set autoindent

" split navigation with Alt + {j,k,l,h}
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

autocmd Syntax * syn match ExtraWhitespace /\S\s\+$/
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

function! InsertStatuslineColor(mode)
    if a:mode == 'i'
        hi statusline ctermfg=40 ctermbg=0
    elseif a:mode == 'r'
        hi statusline ctermfg=160 ctermbg=0
    else
        hi statusline ctermfg=1 ctermbg=0
    endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline ctermfg=4 ctermbg=0
hi statusline ctermfg=4 ctermbg=0

" Status Line {{{
set statusline =%#identifier#
set statusline+=[%f]    "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#warningmsg#
set statusline+=%m
set statusline+=%*


"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%*


set statusline+=%#warningmsg#
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2
