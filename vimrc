" Silnar Vim Configuration
" useful links:
" - Favorite vim plugins & scripts: http://stackoverflow.com/questions/21725/favorite-gvim-plugins-scripts
" - http://amix.dk/vim/vimrc.html
" - http://statico.github.io/vim.html
" - http://www.vimninjas.com/2012/08/26/10-vim-color-schemes-you-need-to-own/

" Vundle {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'morhetz/gruvbox'
Bundle 'zeis/vim-kolor'
Bundle 'Zenburn'
Bundle 'synic.vim'
Bundle 'github-theme'
Bundle 'Solarized'
Bundle 'twilight'
Bundle 'Wombat'

Bundle 'unimpaired.vim'
Bundle 'surround.vim'
Bundle 'DfrankUtil'
Bundle 'Gundo'

Bundle 'ctrlp.vim'
Bundle 'The-NERD-tree'

Bundle 'vimprj'
Bundle 'Tagbar'
Bundle 'Syntastic'
Bundle 'tComment'
Bundle 'indexer.tar.gz'
Bundle 'fugitive.vim'

Bundle 'taskpaper.vim'
Bundle 'bitc/vim-hdevtools'
Bundle 'ujihisa/neco-ghc'
Bundle 'bitc/lushtags'
" }}}

" Vim: Functions {{{
" http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
" }}}

" Vim: Behavior {{{
filetype plugin indent on

set omnifunc=syntaxcomplete#Complete

set autowrite
set noequalalways

" Don't redraw while executing macros (good performance config)
set lazyredraw

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Swap files
let s:swapDir = $HOME . "/.vimswap"
if !isdirectory(s:swapDir)
  call mkdir(s:swapDir)
endif

set directory-=.
let &directory = s:swapDir . '//,' . &directory
" }}}

" Vim: Tabs {{{
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" }}}

" Vim: Tab settings per filetype {{{
autocmd Filetype haskell setlocal ts=2 sts=2 sw=2 et ai
autocmd Filetype taskpaper setlocal ts=2 sts=2 sw=2 ai
" }}}

" Vim: Searching {{{
set ignorecase
set smartcase
set incsearch
set hlsearch
" }}}

" Vim: UI {{{
syntax on

if has("gui_running")
  colorscheme gruvbox
  set bg=dark
else
  colorscheme elflord
  set bg=dark
endif

set cursorline

set number

" Configure statusline
set statusline=%n\ %f%<
set statusline+=\ %m%r%h%w%q
set statusline+=%=
set statusline+=%{fugitive#statusline()}
set statusline+=\ %y
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=[row:%l\ col:%v]

"Always show current position
set ruler

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

set foldtext=NeatFoldText()

set laststatus=2

" Gui options
" set go-=T
" set go-=l
" set go-=L
" set go-=R
" set go-=r
" set go-=e
set guioptions=
set guifont=DejaVu\ Sans\ Mono\ 10
" }}}

" Vim: Wild menu {{{
" Turn on the Wild menu
set wildmenu
set wildmode=longest:full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
" }}}

" Vim: Tags {{{
set tags+=~/.vim/tags/c.tags
" }}}

" Vim: Remove trailing whitespaces on write {{{
autocmd BufWritePre * :%s/\s\+$//e
" }}}

" Global mappings {{{
" Explore
nmap <Leader>e :NERDTreeToggle<CR>

" Outline
nmap <Leader>o :TagbarToggle<CR>

" CtrlP
nmap <Leader>p :CtrlPMixed<CR>

" Item info
au FileType haskell nmap <Leader>i :HdevtoolsInfo<CR>
au FileType haskell nmap <Leader>t :HdevtoolsType<CR>
au FileType haskell nmap <Leader>c :HdevtoolsClear<CR>

" Write file
nmap <C-S> :w<CR>
nmap <Leader>w :w<CR>

" Hide search highlight
nmap <Leader>q :nohlsearch<CR>

" Show invisibles
nmap <leader>l :set list!<CR>

" Edit preferences
nmap <Leader>. :edit ~/.vimrc<CR>
nmap <Leader>> :source ~/.vimrc<CR>

" Insert new line
nmap <Leader>n o<Esc>
nmap <Leader>N O<Esc>

" Set background
nmap <Leader>bd :set background=dark<CR>
nmap <Leader>bl :set background=light<CR>

" Run Gundo
nmap <Leader>u :GundoToggle<CR>
" }}}

" Commandline mappings {{{
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
" cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
" cnoremap <M-d>  <S-right><Delete>
" cnoremap <Esc>b <S-Left>
" cnoremap <Esc>f <S-Right>
" cnoremap <Esc>d <S-right><Delete>
" cnoremap <C-g>  <C-c>
" }}}

" Filetype plugin {{{
au FileType haskell setlocal omnifunc=necoghc#omnifunc
" }}}

" CtrlP {{{
let g:ctrlp_map = ''
let g:ctrlp_cmd = ''
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|6|pyc|hi|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
" }}}

" TComment plugin {{{
let g:tcomment#replacements_c = {
            \     '/*': '#<{(|',
            \     '*/': '|)}>#',
            \ }
let g:tcommentLineC = {
            \ 'commentstring': '// %s',
            \ 'replacements': g:tcomment#replacements_c
            \ }
" }}}

" Go plugin {{{
set rtp+=$GOROOT/misc/vim
" }}}

" vim:foldmethod=marker
