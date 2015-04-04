set nocompatible                         " Выключаем совместимость с vi
set noswapfile
set mouse=a

" Change leader
let mapleader=','

map <F2> :w<CR>
map rr :e<CR>

map <F6> <ESC>:cprev<CR>
map <F7> <ESC>:cc<CR>
map <F8> <ESC>:cnext<CR>

map <F10> :tprev<CR>
map <F12> :tnext<CR>

map <PageUp> <C-U>
map <PageDown> <C-D>
map <C-PageUp> :bp<CR>
map <C-PageDown> :bn<CR>

" set autoread                             " Перечитывать открытые файлы если они были изменены извне

filetype on                              " Включаем распознавание типов файлов и типо-специфичные плагины
filetype plugin on
filetype indent plugin on

set encoding=utf-8                       " Кодировка по-умолчанию utf-8
set termencoding=utf-8                   " Кодировка терминала тоже utf-8
set fileencodings=utf-8,cp1251,koi8-r    " Список кодировок, которые vim будет перебирать при открытии файла

set novisualbell                         " Выключаем бибиканье и мигание
set t_vb=

syntax on                                " Включаем подсветку синтаксиса
" colorscheme bubblegum                    " Название используемой темы
set t_Co=256                             " Используемый терминал поддерживает 256 цветов (включить можно, но возможно…)

set number                               " Показывать номера строк
set showcmd
set wildmenu

" Tabulation settings 
set expandtab
set shiftwidth=4
set tabstop=4

" Enable backspace
set bs=2

function! ToggleCPPHeader()
    let current=expand("%")
    let header=substitute(current, "\.cpp$", ".h", "")
    if header==current
        let header=substitute(current, "\.h$", ".cpp", "")
    endif
    if filereadable(header)
        exec "edit " . header
    endif
endfunction    

map <leader>s :call ToggleCPPHeader()<CR>
map <leader>vr :e ~/.vimrc<CR>
map <leader>vc :e ./.vim.custom<CR>
map <leader>b :make\ VERBOSE=1<CR>
map <leader>cc :ccl<CR>
noremap <silent> <leader>hl :set hlsearch! hlsearch?<CR>
noremap <silent> <leader>i :set incsearch! incsearch?<CR>

" Whitespaces
noremap <silent> <leader>l :set list! list?<CR>

" Line wrapping
noremap <silent> <leader>w :set wrap! wrap?<CR>

" Up directory
map <leader>u :exec "edit " . system("dirname " . expand("%"))<CR>

" Make executable
map <leader>x :!chmod +x %<CR>

" MRU
map <leader>re :MRU<CR>

" Jedi configuration
let g:jedi#popup_on_dot=0
let g:jedi#popup_select_first=0
let g:jedi#show_call_signatures=0

" Completion settings
set completeopt=longest,menuone

" Docs
map tw :set tw=75<CR>
map tq :set tw=79<CR>

set laststatus=2 " Always display status line

" variable %{&encoding} doesn't work if vim is compiled without +multi-byte option
" I don't know how to check +multi-byte option, so check version instead
if v:version < 700
  set statusline=%<%f%h%m%r%=[%l,%v]\ format=%{&fileformat}\ file-enc=%{&fileencoding}\ %P
else
  set statusline=%<%f%h%m%r%=[%l,%v]\ format=%{&fileformat}\ enc=%{&encoding}\ file-enc=%{&fileencoding}\ %P
endif

" Semicolon to colon mapping
nmap ; :

" MBE
let g:miniBufExplVSplit=25
set hidden

" ATP (Latex Plugin)
let atp_DefaultDebugMode="Debug"
map <Leader>mk :Latexmk<CR>
map <Leader>b :MakeLatex<CR>

" c++ indentation
set cino=g0

map - ddko

nmap <ESC>[5;5~ <C-PageUp>
nmap <ESC>[6;5~ <C-PageDown>

function! SaveSession()
    execute 'mksession! ' . getcwd() . '/.vim.session'
endfunction

" auto load of .vimrc and removal of trailing spaces
if !exists("auto_cmds_loaded")
    let auto_cmds_loaded=1
    autocmd BufWritePost .vimrc :source /home/rizar/.vimrc
    autocmd BufWritePost .vim.custom :source .vim.custom
    autocmd FileType c,cpp,python,ruby,java autocmd BufWritePre <buffer> :%s/\s\+$//e
    autocmd VimLeave * call SaveSession()
    autocmd BufNewFile,BufRead *.ipy set filetype=python
endif

set ignorecase
set smartcase
set history=1000
set undolevels=1000
set shiftround
" better indentation
vnoremap < <gv 
" better indentation
vnoremap > >gv 

set foldmethod=indent
set nofoldenable

colorscheme calmar256-light

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '@'

function! CheckForCustomConfiguration()
    " Check for .vim.custom in the directory containing the newly opened file
    let custom_config_file = getcwd() . '/.vim.custom'
    if filereadable(custom_config_file)
        exe 'source' custom_config_file
    endif
endfunction
call CheckForCustomConfiguration()

call pathogen#infect()
call pathogen#helptags()
