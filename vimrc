"" Pathogen -----------------------------------------------------------------
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

runtime macros/matchit.vim

"" Global settings ----------------------------------------------------------
set fileencoding=utf8
set nocompatible
filetype plugin on
filetype indent on
filetype on
syntax on
set showbreak=$
set guioptions=eg
set title

" visual clues for commands and navigation
set showcmd
set ruler

" Wildmenu bro!
set wildmenu
set wildmode=list:longest,full

" search --------------------------------------------------------------------
set incsearch
set ignorecase
set hlsearch

" No backups ----------------------------------------------------------------
" Vim crashes so rarely I don't feel like I need these
set nobackup
set nowritebackup
set noswapfile

" Folding ------------------------------------------------------------------
set foldmethod=syntax
set foldcolumn=1
set foldlevel=2
let g:f__olded = 0 " helper var, probably can be removed

" status line --------------------------------------------------------------
set statusline=
" file name
set statusline+=%f\ %2*%m\ %1*%h
" generic warning message
set statusline+=%#warningmsg#
" Syntastic status
set statusline+=%{SyntasticStatuslineFlag()}
" FuGITive status
set statusline+=%{fugitive#statusline()}
" span
set statusline+=%*
" [ encoding CR-type filetype]
set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]

" current column line and total number of lines
set statusline+=\ %12.(%c:%l/%L%)

" always show status line
set laststatus=2


" backspace mode -----------------------------------------------------------
set bs=2

" lines and margins --------------------------------------------------------
" highlight current line and add line numbers
set cursorline

set number
let g:___number_active=1 " helper variable used by relativelines switch
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" right margin settings
if version > 702
  set colorcolumn=80
endif

" set line length for all files at 78
autocmd FileType text setlocal textwidth=78


" colors -------------------------------------------------------------------
set background=dark
let &t_Co=256
colorscheme Monokai "zenburn
" XXX use these only if solarized dark is used!
" let g:solarized_termtrans  = 0
" let g:solarized_termcolors = 256
" hi Normal  ctermbg=NONE cterm=NONE
" hi Number  ctermbg=NONE cterm=NONE
" hi LineNr  ctermfg=darkgray    ctermbg=NONE        cterm=NONE


" indent --------------------------------------------------------------------
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

" Key mappings -------------------------------------------------------------
" borrowed from Emacs
noremap <C-a> ^
noremap <C-e> $

" make the command mode less annyoing
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-p> <Up>
cnoremap <c-n> <Down>
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
cnoremap <c-d> <Del>
cnoremap <c-k> <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>

" open a new split with a netrw buffer pointing to current files' dir
nmap <leader>D :e %:h<CR>

" Better split management, kept in sync with tmux' mappings
" (<prefix>| and <prefix>-)

"split horizontally and switch to new split
noremap <leader>- :sp<CR><C-w>j
"split vertically and switch to new split
noremap <leader>\| :vsp<CR><C-w>l


noremap <leader>z zO
noremap <leader>Z zc

" sudo write
map w! w !sudo tee % >/dev/null

" better esc
inoremap jj <esc>
cnoremap jj <c-c>

" tabs (not really optimal)
map <leader>[ :tabprevious<CR>
map <leader>] :tabnext<CR>

" disable arrows
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Borrowed from vimcasts, super useful----------------------------------------
" Bubble single lines
nmap <C-k> ddkP
nmap <C-j> ddp

" Bubble multiple lines
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" make tab key more better
noremap <tab> v>
noremap <s-tab> v<
vnoremap <tab> >gv
vnoremap <s-tab> <gv

"" Filetype specific --------------------------------------------------------
" python is weird

au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set expandtab

" ... and so is puppet
au BufNewFile,BufRead *.pp set tabstop=4
au BufNewFile,BufRead *.pp set softtabstop=4
au BufNewFile,BufRead *.pp set shiftwidth=4
au BufNewFile,BufRead *.pp set expandtab

" qml
au BufNewFile,BufRead  *.qml set filetype=qml

" json as javascript
au BufNewFile,BufRead  *.json set syntax=javascript
au BufNewFile,BufRead  *.js   set foldmethod=indent " Vim's JS support sux

" mustache templates
au BufNewFile,BufRead  *.mustache set filetype=mustache

" markdown
au BufNewFile,BufRead  *.md,*.mkd,*.markdown set filetype=markdown

" non ruby files which are ruby
au BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile,Rakefile,*.rake set filetype=ruby

" reject! and responds_to? are methods in ruby
autocmd FileType ruby setlocal iskeyword+=!,?,@

" make rspec stuff part of ruby syntax
autocmd BufNewFile,BufRead *_spec.rb syn keyword ruby describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function

" tmux
au BufNewFile,BufRead *tmux.conf set syntax=tmux

" Plugins settings ----------------------------------------------------------

" Rainbo parens EVERYWHERE, DOUBLE RAINBOW OMG
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" screen.vim
let g:ScreenImpl='Tmux'
noremap <leader>S :ScreenShell
vnoremap <leader>s :ScreenSend<CR>
noremap <leader>s :ScreenSend<CR>

" syntastic
let g:syntastic_auto_loc_lis=1
let g:syntastic_enable_signs=1

" gist vim
let g:gist_show_privates=1
let g:gist_open_browser_after_post = 1

" Tagbar
noremap <leader>t :TagbarToggle<CR>

set tags=tags,TAGS,ctags,./**/*.ctags

" add a definition for Objective-C to tagbar
" requires HEAD ctags installed
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }


" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|release$\|dojo$\|dijit$\|dojox$\|util$',
  \}

" Abbreviations  ------------------------------------------------------------
" 'cause snippets are overkill
iabbr me_ Łukasz
iabbr sig_ -- <CR>Łukasz

" pry abbrev, delimitmate handles inserting missing pairs
iabbr pry_ require 'pry'; binding.pry
iabbr pry__ require 'pry';   binding.pry if ENV['WITH_PRY

iabbr pry= require 'pry'; require 'pry-nav'; binding.pry
iabbr pry== require 'pry'; require 'pry-nav';  binding.pry if ENV['WITH_PRY

" Ruby
autocmd Filetype ruby iabbr cls class<CR>end<ESC>?class<ESC>$a
autocmd Filetype ruby iabbr mod module<CR>end<ESC>?module<ESC>$a
autocmd Filetype ruby iabbr d= def<CR>end<ESC>?def<ESC>$a
autocmd Filetype ruby iabbr d_ do<CR>end<ESC>O
autocmd Filetype ruby iabbr d- do \|\|<CR>end<ESC>k$i

" Rspec yeah
autocmd Filetype ruby iabbr desc_ describe  do<CR>end<ESC>?describe<ESC>wi
autocmd Filetype ruby iabbr it- it "" do<CR>end<ESC>?""<ESC>a
autocmd Filetype ruby iabbr cont- context "" do<CR>end<ESC>?""<ESC>a
autocmd Filetype ruby iabbr sub- subject "" do<CR>end<ESC>?""<ESC>a

" Javascript
autocmd Filetype javascript iabbr f_ function(){<CR>}<ESC>?{<ESC>o
autocmd Filetype javascript iabbr f- function(){}<ESC>?{<ESC>a

" Functions ----------------------------------------------------------------

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

fun! ToggleFolds()
  if g:f__olded == 0
    let g:f__olded = 1
    set foldlevel=9999
  else
    let g:f__olded = 0
    set foldlevel=2
  endif
endfun
noremap <leader>f :call ToggleFolds()<CR>
vnoremap <leader>f :call ToggleFolds()<CR>

fun! PastedFromTmux()
  s/\\015/\r/g
endfun
command!  -nargs=0 FromTmux call PastedFromTmux(<args>)

" reload file from disk and discard changes
command!  -nargs=0 R e! %

" quickly switch between absolute and relative line numbers
" "number" option was set at the beginning of the file

function! NumSwap()
  if g:___number_active
    set relativenumber
    let g:___number_active = 0
  else
    set number
    let g:___number_active = 1
  endif
endf

nmap <silent> <leader>l :call NumSwap()<cr>
vmap <silent> <leader>l :call NumSwap()<cr>gv
