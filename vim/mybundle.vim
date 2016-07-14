" Let Vundle manage Vundle.
filetype off
call plug#begin('~/.vim/plugged')

" Usage -------------------- {{{
Plug 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_mode_map = { 'passive_filetypes': ['html', 'java'] }
nnoremap <silent> <leader>e/ :Errors<cr>

Plug 'nathanaelkane/vim-indent-guides'
Plug 'ciaranm/detectindent'
augroup detect_indent
  autocmd!
  autocmd BufReadPost * :DetectIndent
augroup END

Plug 'tpope/vim-fugitive'

Plug 'vim-scripts/PreserveNoEOL'
let g:PreserveNoEOL = 1

Plug 'jiangmiao/auto-pairs'
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = 'µ'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:bufferline_echo = 0
if has("gui_running") 
  let g:airline_theme="luna"
endif
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ }
set laststatus=2
set noshowmode
" }}}

" Mappings ----------------- {{{
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'

Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <leader>f <Plug>(easymotion-bd-f)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

Plug 'godlygeek/tabular'
nnoremap <leader>a= :Tabularize /=<cr>
vnoremap <leader>a= :Tabularize /=<cr>
nnoremap <leader>a: :Tabularize /:<cr>
vnoremap <leader>a: :Tabularize /:<cr>
nnoremap <leader>a; :Tabularize /:<cr>
vnoremap <leader>a; :Tabularize /:<cr>

Plug 'dahu/vim-fanfingtastic'
let g:fanfingtastic_ignorecase = 1

Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'lfilho/cosco.vim'
augroup cosco
  autocmd!
  autocmd FileType javascript,css nnoremap <silent> ;; :call cosco#commaOrSemiColon()<CR>
  autocmd FileType javascript,css inoremap <silent> ;; <c-o>:call cosco#commaOrSemiColon()<CR>
augroup END

Plug 'jeetsukumaran/vim-indentwise'
" }}}

" Environemnts ------------- {{{
Plug 'moll/vim-node'
Plug 'maksimr/vim-jsbeautify'

Plug 'fatih/vim-go'
let g:go_doc_keywordprg_enabled = 0
augroup filetype_go
  autocmd!
  autocmd filetype go nnoremap <buffer> <localleader>d
    \ :split <cr>:exe "GoDef"<cr>
augroup END

Plug 'JamshedVesuna/vim-markdown-preview'
let vim_markdown_preview_github=1
" }}}

" Syntax Highlighting ------ {{{
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_initial_foldlevel=5

Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"

Plug 'jelera/vim-javascript-syntax'
Plug 'elzr/vim-json'

"Plug 'lukaszb/vim-web-indent'

Plug 'kchmck/vim-coffee-script'
augroup coffeescript
  autocmd!
  autocmd FileType coffee
    \ nnoremap <buffer> <localleader>c :CoffeeCompile<cr>
  autocmd FileType coffee
    \ vnoremap <buffer> <localleader>c :CoffeeCompile<cr>
augroup END

Plug 'vim-scripts/applescript.vim'
Plug 'othree/xml.vim'
Plug 'leafgarland/typescript-vim'
Plug 'groenewege/vim-less'
Plug 'mustache/vim-mustache-handlebars'
" }}}

" Color schemes ------------ {{{
Plug 'goatslacker/mango.vim'
Plug 'croaker/mustang-vim'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'jonathanfilip/vim-lucius'
Plug 'chriskempson/base16-vim'
Plug 'fent/vim-frozen'
Plug 'junegunn/seoul256.vim'
" }}}

" Dev ---------------------- {{{
Plug 'chrisbra/Colorizer'
nmap <leader>h :ColorToggle<cr>
" }}}

" Misc --------------------- {{{
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'junegunn/vim-emoji'
" }}}

" This had to be disabled for vundle.
call plug#end()
filetype plugin indent on
