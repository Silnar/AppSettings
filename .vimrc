"    _____ _ __
"   / ___/(_) /___  ____ ______
"   \__ \/ / / __ \/ __ `/ ___/
"  ___/ / / / / / / /_/ / /
" /____/_/_/_/ /_/\__,_/_/
"
" Silnar Vim Configuration
" useful links:
" - Favorite vim plugins & scripts: http://stackoverflow.com/questions/21725/favorite-gvim-plugins-scripts
" - http://amix.dk/vim/vimrc.html
" - http://statico.github.io/vim.html
" - http://www.vimninjas.com/2012/08/26/10-vim-color-schemes-you-need-to-own/
" - https://github.com/haya14busa/dotfiles/blob/master/.vimrc
"
" Usefull tricks:
" - http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
"
" TODO:
" - multiple cursors: https://github.com/terryma/vim-multiple-cursors
" - unite:
"   http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
" - gtags:
"   http://www.farseer.cn/config/2013/11/26/ctags-cscope-gtags/
" - ag, grep searching
" - move mappings to one place
" - https://github.com/bling/dotvim
"
" - Fix neco-ghc, vim-latex config - add tap, snippet?

" Custom scripts {{{

function! Get_visual_selection() " {{{
  " Source: http://stackoverflow.com/a/6271254
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction " }}}

" }}}

" Startup {{{
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Echo startup time on starup
" if has('vim_starting') && has('reltime')
"   " Shell: vim --startuptime filename -q; vim filename
"   " Shell: vim --cmd 'profile start profile.txt' --cmd 'profile file $HOME/.vimrc' +q && vim profile.txt
"
"   let s:startuptime = reltime()
"   autocmd VimEnter * let s:startuptime = reltime(s:startuptime) | redraw
"   \ | echomsg 'startuptime: ' . reltimestr(s:startuptime)
" endif

" Clear main augroup {{{
augroup VimRC
  autocmd!
augroup END
" }}}

" }}}

" Install NeoBundle if not available {{{
if ! isdirectory(expand('~/.vim/bundle'))
  echon "Installing neobundle.vim..."
  silent call mkdir(expand('~/.vim/bundle'), 'p')
  silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
  echo "done."
  if v:shell_error
    echoerr "neobundle.vim installation has failed!"
    finish
  endif
endif
" }}}

" Load NeoBundle plugin {{{
if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath& runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" }}}

" Define bundles {{{
function! s:load_bundles()

" Libraries {{{

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \  'build' : {
      \    'windows' : 'make -f make_mingw32.mak',
      \    'cygwin'  : 'make -f make_cygwin.mak',
      \    'mac'     : 'make -f make_mac.mak',
      \    'unix'    : 'make -f make_unix.mak',
      \  },
      \}
" }}}

" Colorschemes {{{
NeoBundle 'morhetz/gruvbox'
NeoBundle 'zeis/vim-kolor'
NeoBundle 'Zenburn'
NeoBundle 'synic.vim'
NeoBundle 'github-theme'
NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'blerins/flattown'
NeoBundle 'vim-scripts/less.vim'
NeoBundle 'vim-scripts/strange'
NeoBundle 'cocopon/iceberg.vim'
NeoBundle 'vim-scripts/rdark'
NeoBundle 'djjcast/mirodark'
NeoBundle 'sjl/badwolf'
NeoBundle 'reedes/vim-colors-pencil'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'mrkn256.vim'
NeoBundle 'chriskempson/tomorrow-theme', {
      \  'rtp': "~/.vim/bundle/tomorrow-theme/vim/",
      \}
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'tango2'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'freeo/vim-kalisi'
NeoBundle 'abra/vim-abra'
NeoBundle 'Wombat'
NeoBundle 'altercation/vim-colors-solarized'

" }}}

" Basic functionality extensions {{{
NeoBundle 'tpope/vim-unimpaired'

NeoBundle 'tpope/vim-surround'

NeoBundle 'bkad/CamelCaseMotion'

NeoBundle 'tommcdo/vim-exchange'

NeoBundle 'itchyny/lightline.vim'

NeoBundleLazy 'osyo-manga/vim-over', {
      \  "autoload": {
      \    "commands": ['OverCommandLine'],
      \  }
      \}

NeoBundleLazy 'sjl/gundo.vim', {
      \  "autoload": {
      \    "commands": ['GundoToggle'],
      \  }
      \}

NeoBundleLazy 'Shougo/vimfiler.vim', {
      \   'autoload' : {
      \    'commands' : [
      \       { 'name' : 'VimFiler',
      \         'complete' : 'customlist,vimfiler#complete' },
      \       { 'name' : 'VimFilerTab',
      \         'complete' : 'customlist,vimfiler#complete' },
      \       { 'name' : 'VimFilerBufferDir',
      \         'complete' : 'customlist,vimfiler#complete' },
      \       { 'name' : 'VimFilerExplorer',
      \         'complete' : 'customlist,vimfiler#complete' },
      \       { 'name' : 'Edit',
      \         'complete' : 'customlist,vimfiler#complete' },
      \       { 'name' : 'Write',
      \         'complete' : 'customlist,vimfiler#complete' },
      \       'Read', 'Source'],
      \    'mappings' : '<Plug>(vimfiler_',
      \    'explorer' : 1,
      \   }
      \}
" }}}

" Utils {{{
NeoBundleLazy 'Shougo/unite.vim', {
      \  'commands' : [
      \    { 'name' : 'Unite',
      \      'complete' : 'customlist,unite#complete_source'},
      \    { 'name' : 'UniteBookmarkAdd' }],
      \  'depends' : 'Shougo/neomru.vim',
      \}

NeoBundleLazy 'ujihisa/unite-colorscheme', {
      \  'autoload' : {
      \    'unite_sources' : [
      \      'colorscheme'
      \    ],
      \  }
      \}

NeoBundleLazy 'osyo-manga/unite-fold', {
      \  'autoload' : {
      \    'unite_sources' : [
      \      'fold'
      \    ],
      \  }
      \}

NeoBundleLazy 'osyo-manga/unite-quickfix', {
      \  'autoload' : {
      \    'unite_sources' : [
      \      'quickfix',
      \      'location_list'
      \    ],
      \  }
      \}

NeoBundleLazy 'Shougo/unite-outline', {
      \  'autoload' : {
      \    'unite_sources' : [
      \      'outline'
      \    ],
      \  }
      \}

NeoBundleLazy 'ryotakato/unite-outline-objc', {
      \  'autoload' : {
      \    'unite_sources' : [
      \      'outline'
      \    ],
      \  }
      \}

NeoBundleLazy 'vim-scripts/gtags.vim', {
      \  'autoload': {
      \    'commands' : [
      \      { 'name' : 'Gtags' },
      \      { 'name' : 'GtagsCursor' }
      \    ],
      \  }
      \}

NeoBundleLazy 'hewes/unite-gtags', {
      \  'autoload': {
      \    'unite_sources' : [
      \      'gtags/context',
      \      'gtags/ref',
      \      'gtags/def',
      \      'gtags/grep',
      \      'gtags/completion',
      \      'gtags/file'
      \    ],
      \  }
      \}

NeoBundle 'thinca/vim-qfreplace'

NeoBundleLazy 'godlygeek/tabular', {
      \  'commands' : [
      \    { 'name' : 'Tabularize' }],
      \}

NeoBundleLazy 'Shougo/vimshell.vim', {
      \  'commands' : [
      \    { 'name' : 'VimShell' }],
      \}

NeoBundle 'vim-scripts/ingo-library'
NeoBundle 'vim-scripts/TextTransform'

NeoBundleLazy 'gerw/vim-HiLinkTrace', {
      \  'commands' : [{ 'name' : 'HLT' }],
      \  'mappings' : ['\hlt'],
      \ }

" }}}

" Writing {{{

NeoBundle 'terryma/vim-multiple-cursors'

NeoBundleLazy 'Shougo/neocomplete.vim', {
      \  'disabled' : !(has('lua') && v:version >= 703),
      \  'autoload' : {
      \    'insert' : 1,
      \  },
      \}

NeoBundleLazy 'Shougo/neocomplcache.vim', {
      \  'disabled' : has('lua') && v:version >= 703,
      \  'autoload' : {
      \    'insert' : 1,
      \  },
      \}

NeoBundleLazy 'Shougo/neosnippet.vim', {
      \  'depends' : [
      \    'Shougo/neosnippet-snippets',
      \    'Shougo/context_filetype.vim',
      \  ],
      \  'insert' : 1,
      \  'filetypes' : 'snippet',
      \  'commands' : ['NeoSnippetEdit'],
      \  'unite_sources' : [
      \    'neosnippet',
      \    'neosnippet/user',
      \    'neosnippet/runtime',
      \  ],
      \}

NeoBundle 'honza/vim-snippets'
" }}}

" Programming utils {{{
NeoBundleLazy 'Syntastic', {
      \  'autoload' : {
      \    'insert' : 1,
      \  }
      \}

NeoBundle 'tyru/caw.vim'

NeoBundleLazy 'tpope/vim-fugitive', {
      \  'augroup': 'fugitive',
      \  'autoload': {
      \    'commands': [
      \      'Git',
      \      'Gcd',
      \      'Glcd',
      \      'Gstatus',
      \      'Gcommit',
      \      'Ggrep',
      \      'Glgrep',
      \      'Glog',
      \      'Gllog',
      \      'Gedit',
      \      'Gsplit',
      \      'Gvsplit',
      \      'Gtabedit',
      \      'Gpedit',
      \      'Gread',
      \      'Gwrite',
      \      'Gwq',
      \      'Gdiff',
      \      'Gsdiff',
      \      'Gvdiff',
      \      'Gmove',
      \      'Gremove',
      \      'Gblame',
      \      'Gbrowse'
      \    ]
      \  }
      \}

NeoBundle 'derekwyatt/vim-fswitch'

NeoBundleLazy 'aklt/plantuml-syntax', {
      \  "autoload": {
      \    "filetypes": ['plantuml'],
      \  }
      \}
" }}}

" C/C++ {{{
if !has("neovim")
  NeoBundleLazy 'Rip-Rip/clang_complete', {
        \  "autoload": {
        \    "filetypes": ['c', 'cpp', 'objc', 'objcpp'],
        \  }
        \}
endif

NeoBundleLazy 'osyo-manga/vim-marching', {
      \  "autoload": {
      \    "filetypes": ['c', 'cpp', 'objc', 'objcpp'],
      \  }
      \}
" }}}

" Go {{{
NeoBundleLazy 'fatih/vim-go', {
      \  "autoload": {
      \    "filetypes": ['go'],
      \  }
      \}
" }}}

" Haskell {{{
NeoBundleLazy 'bitc/vim-hdevtools', {
      \  "autoload": {
      \    "filetypes": ['haskell'],
      \  }
      \}
NeoBundleLazy 'ujihisa/neco-ghc', {
      \  "autoload": {
      \    "filetypes": ['haskell'],
      \  }
      \}
NeoBundleLazy 'bitc/lushtags', {
      \  "autoload": {
      \    "filetypes": ['haskell'],
      \  }
      \}
" }}}

" Nim {{{
NeoBundleLazy 'zah/nimrod.vim', {
      \  "autoload": {
      \    "filetypes": ['nim'],
      \  }
      \}
" }}}

" Toml {{{
NeoBundleLazy 'cespare/vim-toml', {
        \  "autoload": {
        \    "filetypes": ['toml'],
        \  }
        \}
" }}}

" Idris {{{
NeoBundleLazy 'idris-hackers/idris-vim', {
      \  "autoload": {
      \    "filetypes": ['idris'],
      \  }
      \}
" }}}

" LaTeX {{{
NeoBundleLazy 'vim-latex/vim-latex', {
      \  "autoload": {
      \    "filetypes": ['tex'],
      \  }
      \}
" }}}

" Taskpaper {{{
NeoBundleLazy 'taskpaper.vim', {
      \  "autoload": {
      \    "filetypes": ['taskpaper'],
      \  }
      \}
" }}}

endfunction
" }}}

" Load bundles {{{
call neobundle#begin(expand('~/.vim/bundle/'))

if neobundle#load_cache()
  call s:load_bundles()
  NeoBundleSaveCache
endif

call neobundle#end()
" }}}

filetype plugin on
filetype plugin indent on

" Vim options {{{
" Syntax highlighting
syntax on

" Code completion
set omnifunc=syntaxcomplete#Complete

" Gui options
set guioptions=c

if has("gui_running")
  if has("gui_macvim")
    set guifont=Monaco:h14
  else
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
  endif
endif

" Enable mouse support on terminals
if has("mouse")
  set mouse=a
endif

" Assume fast terminal connection
if !has("nvim")
  set ttyfast
endif

" Colorscheme
colorscheme mrkn256
hi CursorLine term=NONE cterm=NONE gui=NONE

" Highlight current line
set cursorline

" Show line numbers
set number

" Show file position
set ruler

" Show matching brackets
set showmatch
set matchtime=2

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Buffers
set autowrite
set hid

" Windows
set noequalalways
set laststatus=2
set splitbelow
set splitright

" Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Searching
set ignorecase
set smartcase
set incsearch
" set hlsearch

" Wild menu
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*~,*.pyc

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Persistence
set viminfo+=!

" Swap files
let s:swapDir = $HOME . "/.vimswap"
if !isdirectory(s:swapDir)
  call mkdir(s:swapDir)
endif

set directory-=.
let &directory = s:swapDir . '//,' . &directory

" Invisible symbols
set listchars=tab:▸\ ,eol:¬

" Statusline
" set statusline=%n\ %f%<
" set statusline+=\ %m%r%h%w%q
" set statusline+=%=
" set statusline+=%{fugitive#statusline()}
" set statusline+=\ %y
" set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
" set statusline+=[row:%l\ col:%v]

" Folding
" Based on: http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart(repeat(foldchar, (v:foldlevel-1)*2) . '▸' . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set fillchars=fold:\  " space
set foldtext=NeatFoldText()
" }}}

" Filetype & Autocommand {{{
" Tabs
autocmd VimRC Filetype haskell setlocal ts=2 sts=2 sw=2 et ai
autocmd VimRC Filetype taskpaper setlocal ts=2 sts=2 sw=2 ai

" Remove trailing whitespaces on write
autocmd VimRC BufWritePre * :%s/\s\+$//e
" }}}

" Plugin settings {{{

" terryma/vim-multiple-cursors {{{
if neobundle#tap('vim-multiple-cursors')
  " Called once right before you start selecting multiple cursors
  function! Multiple_cursors_before()
    if exists(':NeoCompleteLock')==2
      exe 'NeoCompleteLock'
    endif
  endfunction

  " Called once only when the multiple selection is canceled (default <Esc>)
  function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock')==2
      exe 'NeoCompleteUnlock'
    endif
  endfunction
  call neobundle#untap()
endif
" }}}

" Shougo/unite.vim {{{
if neobundle#tap('unite.vim')
  let g:unite_source_grep_max_candidates = 200

  if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
          \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
          \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('pt')
    " Use pt in unite grep source.
    " https://github.com/monochromegane/the_platinum_searcher
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('ack-grep')
    " Use ack in unite grep source.
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts =
          \ '-i --no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
  endif

  call neobundle#untap()
endif
" }}}

" tpope/vim-unimpaired {{{
if neobundle#tap('vim-unimpaired')
  function! neobundle#tapped.hooks.on_post_source(bundle)
    " Switch to prev/next tab
    nmap <silent> [t gT
    nmap <silent> ]t gt

    " Move tab backward/forward
    nnoremap <silent> [T :tabmove -1<CR>
    nnoremap <silent> ]T :tabmove +1<CR>
  endfunction

  call neobundle#untap()
endif
" }}}

" Shougo/neosnippet.vim  {{{
if neobundle#tap('neosnippet.vim')
  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1

    " Remove snippets marker automatically
    " Autocmd InsertLeave * :NeoSnippetClearMarkers

    " Prioratise snippet
    " call neocomplete#custom#source('neosnippet', 'rank', 400)

    " snoremap <Esc> <Esc>:NeoSnippetClearMarkers<CR>
  endfunction "}}}

  let g:neosnippet#snippets_directory = "~/.vim/snippets"

  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: "\<TAB>"

  call neobundle#untap()
endif
" }}}

" Shougo/neocomplete.vim {{{
if neobundle#tap('neocomplete.vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#enable_underbar_completion = 1

    " Use fuzzy completion.
    let g:neocomplete#enable_fuzzy_completion = 1

    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    " Set auto completion length.
    let g:neocomplete#auto_completion_start_length = 2
    " Set manual completion length.
    let g:neocomplete#manual_completion_start_length = 0
    " Set minimum keyword length.
    let g:neocomplete#min_keyword_length = 3

    " Set neosnippet competion length.
    call neocomplete#custom#source('neosnippet', 'min_pattern_length', 1)

    let g:neocomplete#disable_auto_select_buffer_name_pattern =
          \ '\[Command Line\]'

    " Enable omni completion.
    " autocmd css setlocal omnifunc=csscomplete#CompleteCSS
    " autocmd html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    " autocmd javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    " autocmd javascript setlocal omnifunc=tern#Complete
    " autocmd coffee setlocal omnifunc=javascriptcomplete#CompleteJS
    " autocmd xml setlocal omnifunc=xmlcomplete#CompleteTags
    " autocmd python setlocal omnifunc=jedi#completions
  endfunction

  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1

  " Plugin key-mappings.
  " inoremap <expr><C-g>     neocomplete#undo_completion()
  " inoremap <expr><C-l>     neocomplete#complete_common_string()

  " <Tab>: completion
  " inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  " inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " <C-f>, <C-b>: page move.
  " inoremap <expr><C-f>  pumvisible() ? "\<PageDown>" : "\<Right>"
  " inoremap <expr><C-b>  pumvisible() ? "\<PageUp>"   : "\<Left>"
  " <C-y>: paste.
  " inoremap <expr><C-y>  pumvisible() ? neocomplete#close_popup() :  "\<C-r>\""
  " <C-e>: close popup.
  " inoremap <expr><C-e>  pumvisible() ? neocomplete#cancel_popup() : "\<End>"

  call neobundle#untap()
endif
" }}}

" Shougo/neocomplcache.vim {{{
if neobundle#tap('neocomplcache.vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:neocomplcache_enable_smart_case = 1
  endfunction
  call neobundle#untap()
endif
" }}}

" Shougo/VimFiler {{{
if neobundle#tap('vimfiler.vim')
  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    let g:vimfiler_as_default_explorer = 1

    " Enable file operation commands.
    " let g:vimfiler_safe_mode_by_default = 0

    " Like Textmate icons.
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_marked_file_icon = '*'

    autocmd VimRC FileType vimfiler nmap <silent><buffer> <2-LeftMouse> <Plug>(vimfiler_smart_l)
  endfunction "}}}
  call neobundle#untap()
endif

" autocmd FileType vimfiler nmap <buffer><silent> <Enter>
"       \ :<C-u>execute "normal " . vimfiler#mappings#smart_cursor_map(
"       \  "\<Plug>(vimfiler_cd_file)",
"       \  "\<Plug>(vimfiler_edit_file)")<CR>
"
" autocmd FileType vimfiler nmap <buffer><silent> <2-LeftMouse> :call <SID>vimfiler_on_double_click()<CR>
" function! s:vimfiler_on_double_click() "{{{
"   let context = vimfiler#get_context()
"
"   if context.explorer
"     let mapping = vimfiler#mappings#smart_cursor_map(
"           \ "\<Plug>(vimfiler_expand_tree)",
"           \ "\<Plug>(vimfiler_edit_file)"
"           \ )
"   else
"     let mapping = vimfiler#mappings#smart_cursor_map(
"           \ "\<Plug>(vimfiler_cd_file)",
"           \ "\<Plug>(vimfiler_edit_file)"
"           \ )
"   endif
"
"   execute "normal " . mapping
" endfunction"}}}
"
" let s:vimfilerexplorer = {
"       \ 'description' : 'open vimfiler explorer here',
"       \ }
" function! s:vimfilerexplorer.func(candidate) "{{{
"   if !exists(':VimFilerExplorer')
"     echo 'vimfiler is not installed.'
"     return
"   endif
"
"   if !s:check_is_directory(a:candidate.action__directory)
"     return
"   endif
"
"   execute 'VimFilerExplorer' escape(a:candidate.action__directory, '\ ')
"
"   if has_key(a:candidate, 'action__path')
"         \ && a:candidate.action__directory !=# a:candidate.action__path
"     " Move cursor.
"     call vimfiler#mappings#search_cursor(a:candidate.action__path)
"     call s:move_vimfiler_cursor(a:candidate)
"   endif
" endfunction"}}}
"
" function! s:move_vimfiler_cursor(candidate) "{{{
"   if &filetype !=# 'vimfiler'
"     return
"   endif
"
"   if has_key(a:candidate, 'action__path')
"         \ && a:candidate.action__directory !=# a:candidate.action__path
"     " Move cursor.
"     call vimfiler#mappings#search_cursor(a:candidate.action__path)
"   endif
" endfunction"}}}
"
" function! s:check_is_directory(directory) "{{{
"   if !isdirectory(a:directory)
"     let yesno = input(printf(
"           \ 'Directory path "%s" is not exists. Create? : ', a:directory))
"     redraw
"     if yesno !~ '^y\%[es]$'
"       echo 'Canceled.'
"       return 0
"     endif
"
"     call mkdir(a:directory, 'p')
"   endif
"
"   return 1
" endfunction
" "}}}
"
" call unite#custom#action('cdable', 'vimfilerexplorer', s:vimfilerexplorer)
" }}}

" tpope/vim-fugitive {{{
if neobundle#tap('vim-fugitive')
  function! neobundle#tapped.hooks.on_post_source(bundle)
    doautoall fugitive BufNewFile
  endfunction
endif
"}}}

" aklt/plantuml-syntax {{{
if neobundle#tap('plantuml-syntax')
  function! neobundle#tapped.hooks.on_post_source(bundle)
    " Force setting makeprg
    doautocmd FileType
  endfunction

  call neobundle#untap()
endif
" }}}

" Rip-Rip/clang_complete {{{
if neobundle#tap('clang_complete')
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.c =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
  let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  let g:neocomplete#force_omni_input_patterns.objc =
        \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)'
  let g:neocomplete#force_omni_input_patterns.objcpp =
        \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)\|\h\w*::\w*'
  let g:clang_complete_auto = 0
  let g:clang_auto_select = 0
  "let g:clang_use_library = 1

  call neobundle#untap()
endif
" }}}

" osyo-manga/vim-marching {{{
if neobundle#tap('vim-marching')
  let g:marching_enable_neocomplete = 1

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif

  let g:neocomplete#force_omni_input_patterns.c =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
  let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  let g:neocomplete#force_omni_input_patterns.objc =
        \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)'
  let g:neocomplete#force_omni_input_patterns.objcpp =
        \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)\|\h\w*::\w*'

  " set updatetime=200
  " imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)
  " imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)

  call neobundle#untap()
endif
" }}}

" ujihisa/neco-ghc {{{
if neobundle#tap("neco-ghc")
  let g:necoghc_enable_detailed_browse = 1
  call neobundle#untap()
endif
" }}}

" vim-latex/vim-latex {{{
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='okular'
" }}}

" }}}

" Mappings {{{

" Helpers {{{
" Example:
" RunUnite("Buffer", [['buffer']], 1, "search_string", "input"]
" RunUnite("Grep", [['grep', '.', '', '']], 0, "search_string", "param:0:3"]
function! RunUnite(bufname, sources, start_insert, text, text_dst)
  let input = ""
  let sources = a:sources

  if a:text_dst == 'input'
    let input = a:text
  elseif match(a:text_dst, "^param:") != -1
    let [_, srcIdx, paramIdx] = split(a:text_dst, ':')
    let sources[srcIdx][paramIdx] = a:text
  endif

  if a:start_insert
    let start_insert_arg = "-start-insert"
  else
    let start_insert_arg = ""
  endif

  let srcs = []
  for src in sources
    let escaped_src = map(src, "escape(v:val, ' ')")
    call add(srcs, join(escaped_src, ':'))
  endfor
  let src_arg = join(srcs, ' ')
  echo src_arg

  if len(input) > 0
    let input_arg = "-input=" . escape(input, ' ')
  else
    let input_arg = ""
  endif

  execute "Unite"
        \ "-buffer-name=" . a:bufname
        \ "-wipe"
        \ "-no-split"
        \ start_insert_arg
        \ input_arg
        \ src_arg
endfunction

function! UniteDefineTargetFunction(bufname, sources, start_insert, text_dst)
  if a:start_insert
    let fn_name = "Find" . a:bufname . "I"
  else
    let fn_name = "Find" . a:bufname
  endif

  execute "function! " . fn_name . "(text)\n"
        \ "let bufname = '" . a:bufname . "'\n"
        \ "let sources = " . string(a:sources) . "\n"
        \ "let start_insert = " . a:start_insert . "\n"
        \ "let text_dst = '" . a:text_dst . "'\n"
        \ "call RunUnite(bufname, sources, start_insert, a:text, text_dst)\n"
        \ "endfunction"
  return fn_name
endfunction

function! Define_Unite_Mapping(bufname, mapping_char, sources, text_dst)
  let fn_name_normal = UniteDefineTargetFunction(a:bufname, a:sources, 0, a:text_dst)
  execute "nnoremap <silent> <Leader>f" . a:mapping_char . " :<C-u>call " . fn_name_normal . "('')<CR>"
  call TextTransform#MakeMappings('<silent>', ",f" . a:mapping_char, fn_name_normal)

  let fn_name_start_insert = UniteDefineTargetFunction(a:bufname, a:sources, 1, a:text_dst)
  execute "nnoremap <silent> <Leader>F" . a:mapping_char . " :<C-u>call " . fn_name_start_insert . "('')<CR>"
  call TextTransform#MakeMappings('<silent>', ",F" . a:mapping_char, fn_name_start_insert)
endfunction
" }}}

let maplocalleader = "\\l"

nmap <silent> <Leader>t :tabnew<CR>
nmap <silent> <Leader>e :<C-u>VimFiler -toggle<CR>
nmap <silent> <Leader>E :<C-u>VimFilerExplorer -toggle<CR>
nmap <silent> <Leader>u :<C-u>GundoToggle<CR>
nmap <silent> <Leader>. :edit ~/.vimrc<CR>
nmap <silent> <Leader>> :source ~/.vimrc<CR>
nmap <silent> go :<C-u>FSHere<CR>

" nmap <silent> <Leader>f\ :<C-u>UniteResume<CR>
call Define_Unite_Mapping("Bookmark", "k", [['bookmark']], "input")
call Define_Unite_Mapping("Colorscheme", "h", [['colorscheme']], "input")
call Define_Unite_Mapping("File", "f", [['file_rec/async', '!']], "input")
call Define_Unite_Mapping("FileGit", "g", [['file_rec/git']], "input")
call Define_Unite_Mapping("FileMru", "u", [['file_mru']], "input")
call Define_Unite_Mapping("Outline", "o", [['outline']], "input")
call Define_Unite_Mapping("Snippet", "s", [['neosnippet']], "input")
call Define_Unite_Mapping("Fold", "z", [['fold']], "input")
call Define_Unite_Mapping("Jump", "j", [['jump']], "input")
call Define_Unite_Mapping("Buffer", "b", [['buffer']], "input")
call Define_Unite_Mapping("QuickFix", "q", [['quickfix']], "input")
call Define_Unite_Mapping("LocationList", "l", [['location_list']], "input")
call Define_Unite_Mapping("Tab", "t", [['tab']], "input")
call Define_Unite_Mapping("Window", "w", [['window']], "input")
call Define_Unite_Mapping("Command", "c", [['command']], "input")
call Define_Unite_Mapping("Mapping", "m", [['mapping']], "input")
call Define_Unite_Mapping("Function", "n", [['function']], "input")
call Define_Unite_Mapping("Register", "r", [['register']], "input")
call Define_Unite_Mapping("GrepLocal", "/", [['grep', '%', '-s', '']], "param:0:3")
call Define_Unite_Mapping("GrepLocalS", "?", [['grep', '%', '-i', '']], "param:0:3")
call Define_Unite_Mapping("GrepProject", ".", [['grep', '.', '-s', '']], "param:0:3")
call Define_Unite_Mapping("GrepProjectS", ">", [['grep', '.', '-i', '']], "param:0:3")
call Define_Unite_Mapping("Anything", "<Space>",
      \ [['file_rec/async', '!'], ['file_mru'], ['buffer'], ['bookmark'], ['outline'], ['fold']], "input")


" " Item info"
" au FileType haskell nmap <Leader>i :HdevtoolsInfo<CR>
" au FileType haskell nmap <Leader>t :HdevtoolsType<CR>
" au FileType haskell nmap <Leader>c :HdevtoolsClear<CR>

" Search and replace {{{

" Replace word under cursor
if exists(":OverCommandLine")
  nnoremap <Leader>S :<C-u>OverCommandLine %s/\<<C-R><C-W>\>/<CR>
else
  nnoremap <Leader>S :<C-u>%s/\<<C-R><C-W>\>/<CR>
endif

" Replace selected text
if exists(":OverCommandLine")
  vnoremap <Leader>s :<C-u>OverCommandLine %s/<C-R>=Get_visual_selection()<CR>/<CR>
else
  vnoremap <Leader>s :<C-u>%s/<C-R>=Get_visual_selection()<CR>/
endif

" Replace selected text (treat it as one word)
if exists(":OverCommandLine")
  vnoremap <Leader>S :<C-u>OverCommandLine %s/\<<C-R>=Get_visual_selection()<CR>\>/<CR>
else
  vnoremap <Leader>S :<C-u>%s/\<<C-R>=Get_visual_selection()<CR>\>/<CR>
endif
" }}}

" Commandline mappings {{{
cmap <C-a> <Home>
cmap <C-h> <Left>
cmap <C-l> <Right>
cmap <C-j> <Up>
cmap <C-k> <Down>
" }}}

" }}}

" Finally {{{
NeoBundleCheck

if !has('vim_starting')
  call neobundle#call_hook('on_source')
endif

set secure
" }}}

" vim:foldmethod=marker
