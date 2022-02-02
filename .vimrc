set nocompatible              " be iMproved, required
filetype off                  " required
set nu
set rnu

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'reedes/vim-pencil'
Plugin 'junegunn/goyo.vim' " Full screen writing mode
Plugin 'dpelle/vim-LanguageTool'
Plugin 'vim-scripts/loremipsum'
Plugin 'dracula/vim', { 'name': 'dracula' }

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

augroup pencil
  autocmd!
		autocmd filetype markdown,mkd call pencil#init()
				"\ | call lexical#init()
				"\ | call litecorrect#init()
				\ | setl spell spl=de_de fdl=4 noru nonu nornu
				\ | setl fdo+=search
			augroup END
			 " Pencil / Writing Controls {{{
				 let g:pencil#wrapModeDefault = 'soft'
				 let g:pencil#textwidth = 88
				 let g:pencil#joinspaces = 0
				 let g:pencil#cursorwrap = 1
				 let g:pencil#conceallevel = 0
				 let g:pencil#concealcursor = 'c'
				 let g:pencil#softDetectSample = 20
				 let g:pencil#softDetectThreshold = 130
			 " }}}

let g:languagetool_jar='$HOME/local/LanguageTool/languagetool-commandline.jar'
let g:languagetool_lang='de-DE --word2vecmodel /home/hoopdoc/Dokumente/word2vec'

set title
colorscheme dracula
set background=dark
set linespace=2 
set shiftwidth=2
set tabstop=4
syntax on
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set incsearch           " Incremental search
set hidden              " Hide buffers when they are abandoned

:set guicursor=
" Workaround some broken plugins which set guicursor indiscriminately.
:autocmd OptionSet guicursor noautocmd set guicursor=

let g:goyo_height = '100%'
let g:goyo_margin_top = 1
let g:goyo_margin_bottom = 1

nnoremap <Leader>g :Goyo<CR>
nnoremap <Leader>l :LanguageToolCheck<CR>
nnoremap <Leader>L :LanguageToolClear<CR>

" Insert current date
:nnoremap <F5> "=strftime("%F")<CR>P
:inoremap <F5> <C-R>=strftime("%F")<CR>
:nnoremap <F6> "=strftime("%y%m%d")<CR>P
:inoremap <F6> <C-R>=strftime("%y%m%d")

autocmd! User GoyoEnter :Goyo 88x100%
"au FileType markdown let g:goyo_height = '100%' | Goyo | :Goyo x100%
autocmd! VimEnter * :SoftPencil
