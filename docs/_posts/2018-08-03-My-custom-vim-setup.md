---
layout: post
title:  "My custom vim setup"
date:   2018-08-01
categories: vim, unix
---

## My custom vim setup


Install tpope's stuff, its awesome: 

https://github.com/tpope/vim-pathogen

	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


https://github.com/VundleVim/Vundle.vim/blob/v0.10.2/doc/vundle.txt#L234-L254

start vim

run :PluginInstall


    syntax on
    execute pathogen#infect()
    colorscheme distinguished

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Let Vundle manage Vundle
    Plugin 'VundleVim/Vundle.vim'


    set tags=./tags,tags;$HOME
    "set runtimepath^=~/.vim/bundle/ctrlp.vim

    Bundle 'tpope/vim-dispatch'
    Bundle 'mklabs/grunt.vim'
    "Bundle 'elzr/vim-json'
    Bundle 'majutsushi/tagbar'
    "Bundle 'mhinz/vim-signify'
    "Plugin 'godlygeek/tabular'
    "Plugin 'plasticboy/vim-markdown'
    "Bundle 'Valloric/YouCompleteMe'
    "Bundle 'nanotech/jellybeans.vim'
    "Bundle 'Lokaltog/vim-powerline'
    Plugin 'bling/vim-airline'
    Bundle 'scrooloose/syntastic'
    Bundle 'scrooloose/nerdtree'
    Plugin 'maksimr/vim-jsbeautify'
    "Plugin 'jelera/vim-javascript-syntax'
    Plugin 'mileszs/ack.vim'
    "Plugin 'pangloss/vim-javascript'
    Plugin 'https://github.com/heavenshell/vim-jsdoc'

    call vundle#end()            " required

    "________________________________________________________________________________

    function! OpenCurrentDir()
        execute "!cygstart" . " " . getcwd()
    endfunction

    function! OpenCurrentFile()
        execute "!cygstart %"
    endfunction
    "________________________________________________________________________________

    "tern plugin
    "call tern#Disable()

    filetype plugin indent on    " required

    map <leader>cd :call OpenCurrentDir()<cr>
    map <leader>cf :call OpenCurrentFile()<cr>
    map <leader>ff :call JsBeautify()<cr>
    map <leader>d :w! ~/dump.txt<cr>
    map <leader>p :r ~/dump.txt<cr>
    "ack plugin
    let g:ackprg = "~/bin/ack"

    " Switch to alternate file - doesnt' work in screen/console
    map <c-Tab> :bnext<cr>
    map <c-S-Tab> :bprevious<cr>
    " try again
    map <c-i> :bnext<cr>
    map <c-u> :bprevious<cr>

    "color jellybeans
    command! Test Dispatch grunt test --filter %:t:r
    nnoremap <localleader>tt :Test<CR>

    set foldmethod=syntax
    "set foldlevelstart=1
    "folder level start to unreasonable high level so as to open folds, as by
    "default folds are close on 'start' (opening of buffer)
    set foldlevelstart=20

    "let javaScript_fold=1         " JavaScript

    :set tabstop=4
    :set shiftwidth=4
    :set expandtab

    :set smartcase

    "Airline
    "________________________________________________________________________________
    let g:airline#extensions#tabline#enabled = 1

    " jelera/vim-javascript-syntax
    "________________________________________________________________________________
    "au FileType javascript call JavaScriptFold()

    " pangloss/vim-javascript
    "________________________________________________________________________________
    set conceallevel=0
    "set conceallevel=1
    set concealcursor=nvic

    let b:javascript_fold=0
    let g:javascript_conceal_function   = "ƒ"
    let g:javascript_conceal_null       = "ø"
    let g:javascript_conceal_this       = "@"
    let g:javascript_conceal_return     = "<ret>"
    let g:javascript_conceal_undefined  = "<undef>"
    "let g:javascript_conceal_NaN        = "ℕ"
    "let g:javascript_conceal_prototype  = "¶"
    "let g:javascript_conceal_static     = "•"
    "let g:javascript_conceal_super      = "Ω"

    " Configure tagbar
    "________________________________________________________________________________
    "let g:tagbar_width = 30
    "let g:tagbar_ctags_bin = '/usr/bin/ctags'
    "let g:tagbar_autopreview = 1
    autocmd VimEnter * nested :TagbarOpen
    nmap <leader>t :TagbarToggle<CR>

    " netrw
    "________________________________________________________________________________
    "let mapleader=" "
    "map <leader>k :E<cr>
    "let g:netrw_liststyle=3
    "let g:netrw_browse_split=4
    "" do not display info on the top of window
    "let g:netrw_banner = 0
    "let g:netrw_altv = 1
    "let g:netrw_winsize = 25
    "
    "augroup ProjectDrawer
    "  autocmd!
    "  autocmd VimEnter * :Vexplore
    "augroup END

    "CTRLP
    "________________________________________________________________________________
    let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target\|bin'
    "g:ctrlp_match_window = 'min:4,max:72'
    "i" Use a leader instead of the actual named binding
    "nmap <leader>p :CtrlP<cr>
    "
    "" Easy bindings for its various modes
    nmap <leader>b :CtrlPBuffer<cr>
    nmap <leader>bm :CtrlPMixed<cr>
    nmap <leader>bs :CtrlPMRU<cr>

    "syntastic
    "________________________________________________________________________________

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_error_symbol = "✗"
    let g:syntastic_warning_symbol = "⚠"
    "let g:syntastic_javascript_checkers = ['jscs','jshint', 'eslint']
    let g:syntastic_javascript_checkers = ['jshint']
    "let g:syntastic_javascript_checkers = ['eslint']
    "
    let g:syntastic_aggregate_errors = 1

    " NERDTree
    "________________________________________________________________________________
    nmap <leader>n :NERDTreeToggle<CR>
    let NERDTreeHighlightCursorline=1
    "autocmd vimenter * NERDTree
    let NERDTreeIgnore = ['tmp', '.git', 'node_modules']
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

    "Plugin 'https://github.com/heavenshell/vim-jsdoc'
    let g:jsdoc_allow_input_prompt = 1
    let g:jsdoc_input_description = 1
    let g:jsdoc_return = 0
    let g:jsdoc_return_type = 0
    let g:jsdoc_return_description = 0


