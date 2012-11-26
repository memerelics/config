" Vundle ============================================ {{{1
" Vundle initialization {{{2

set nocompatible
filetype off "here off, and after vundle finish, on again.
set rtp+=~/.vim/bundle/vundle/
let g:vundle_default_git_proto='git'
call vundle#rc()

nmap <C-l> <Plug>(openbrowser-open)
Bundle 'gmarik/vundle'


" Vundle Define active plugins {{{2
Bundle 'fugitive.vim'
Bundle 'mattn/webapi-vim'
" Bundle 'Gist.vim' -- updated.
Bundle 'surround.vim'
Bundle 'Align'
Bundle 'quickrun.vim'
Bundle 'open-browser.vim'
Bundle 'snipMate'
Bundle 'TwitVim'
" Bundle 'daisuzu/facebook.vim'
Bundle 'zef/vim-cycle'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'ack.vim'
Bundle 'YankRing.vim'
Bundle 'kien/rainbow_parentheses.vim'

Bundle 'ref.vim'

Bundle 'textobj-user'
Bundle 'textobj-indent'
Bundle 'textobj-function'
Bundle 't9md/vim-textobj-function-ruby'


""" Unite, and new generation plugins {{{3
Bundle 'Shougo/unite.vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'sgur/unite-git_grep'
" Bundle 't9md/vim-unite-ack'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimfiler'


""" ColorSchemes, Syntax {{{3
Bundle 'altercation/vim-colors-solarized'
Bundle 'molokai'
Bundle 'Gentooish'
Bundle 'scrooloose/syntastic'

""" Filetypes -- depends on current work {{{3
Bundle 'ruby.vim'
Bundle 'taq/vim-rspec'
Bundle 'tpope/vim-markdown'
"Bundle 'mkitt/markdown-preview.vim'
Bundle 'tsaleh/vim-matchit'

" General ============================================ {{{1
" set someting {{{2
set shortmess=asIAWT "simpler messages
set t_Co=256
set encoding=utf8
set fileencoding=utf8
set autoindent
set expandtab
set foldmethod=marker
set foldlevel=1
set foldnestmax=2
set tags=./tags
set incsearch
set hlsearch
set ignorecase
set laststatus=2
set number
set statusline=%{fugitive#statusline()}%F%r%m%h%w%=%l/%L(%3p%%)\ %y\ enc:%{GetEFstatus()}
set shiftwidth=2
set tabstop=2
set noswapfile
set nowrapscan
set helplang=ja,en
set splitbelow
set splitright
set visualbell t_vb=
set cmdwinheight=12
set gdefault " all substitution
set backupdir=~/tmp,$VIM/tmp

" load my plugins under development.
set rtp+=~/.vim/dev/

"set clipboard=unnamed,autoselect

set formatoptions-=r
set formatoptions-=o

" filetype settings + additional {{{2
filetype plugin indent on
syntax on
" skeleton loading autocmd {{{3
augroup SkeletonLoad
    autocmd! SkeletonLoad
    autocmd BufNewFile *.html 0r $HOME/.vim/templates/skel.html
augroup END

" set Shebang line {{{3
augroup SetShebang
    autocmd! SetShebang
    autocmd BufNewFile *.rb 0put =\"# coding: utf-8\"|$
augroup END

" filetype autocmd {{{3
augroup MyAutoCmdFileType
    autocmd! MyAutoCmdFileType
    autocmd FileType ruby setl autoindent
    " smart indent is disabled when paste is on
    autocmd FileType ruby setl nopaste
    autocmd FileType ruby setl smartindent cinwords=if,elsif,else,for,begin,def,class
    autocmd FileType ruby setl fileencoding=utf-8
    autocmd FileType ruby.rspec setl smartindent cinwords=describe,it,expect
    " [Ruby] convert Hash style
    autocmd FileType vnoremap sh :s/:\([a-z_]*\)\s*=>/\1:/<CR>

    autocmd FileType help nnoremap <buffer> q <C-w>q
    autocmd FileType qf nnoremap <buffer> q :cclose<CR>
    autocmd BufRead,BufNewFile ^\.vimperatorrc$ set filetype=vim
    autocmd BufRead,BufNewFile *.applescript set filetype=applescript
    autocmd BufRead,BufWinEnter,BufNewFile *.erb set filetype=eruby.html
    autocmd BufRead,BufWinEnter,BufNewFile *.tpl set filetype=smarty.html
    autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o><ESC>==
    autocmd Filetype html inoremap <buffer> </ </<C-x><C-o><ESC>==
    autocmd Filetype haml IndentGuidesEnable

    " adding VimEnter, TermResponse... don't work as I expect.
    autocmd Filetype scheme RainbowParenthesesToggle
    autocmd Filetype scheme RainbowParenthesesLoadRound

    autocmd Filetype erlang syntax match erlangVariable /[A-Z]\+[a-zA-Z0-9]*/
    autocmd Filetype erlang highlight erlangVariable ctermfg=81
    autocmd Filetype erlang  inoremap <C-J><C-J> ()<LEFT>
    autocmd Filetype erlang  inoremap <C-J><C-K> {}<LEFT>
    autocmd Filetype int-erl inoremap <C-J><C-J> ()<LEFT>
    autocmd Filetype int-erl inoremap <C-J><C-K> {}<LEFT>
    " move cursor {a: b*} => {a: b}. * |or| self(*) => self(). *
    autocmd Filetype erlang  inoremap <C-J>. <RIGHT>.<Space>
    autocmd Filetype int-erl inoremap <C-J>. <RIGHT>.<Space>
augroup END



" omni completion setting {{{3
autocmd FileType *
\   if &l:omnifunc == ''
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif
" autocmd definitions {{{2
augroup MyAutoCmdGeneral
    autocmd! MyAutoCmdGeneral
    " automatically move to directory file exist
    " autocmd BufEnter * call ChangeDir()

    " automatically open quickfix window after :vimgrep
    autocmd QuickfixCmdPost vimgrep cw
    " automatically move to last line
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

    " automatically remove spaces end of the line
    autocmd BufWritePre * :%s/\s\+$//ge

    " automatically add timestamp to backup files
    autocmd BufWritePre * let &bex = '-' . strftime('%Y%m%d_%Hh') . '~'
augroup END

" New undo-persistence feature of vim73 {{{2
" FYI: how to check Vim version, extentions
" http://vim-users.jp/2010/01/hack115/
if has('persistent_undo')
    set undofile
    set undodir=./.undofiles,$VIM/.undofiles
endif

" Local .vimrc {{{2
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" settings for vimshell
if filereadable(expand('~/.vimrc.vimshell'))
    source ~/.vimrc.vimshell
endif

" Color/Layout Settings ============================================ {{{1
" colorscheme => ~/.vimrc.local

" highlight {{{2
" FYI: execute ':so $VIMRUNTIME/syntax/colortest.vim' to view sample colors
" change statusline color in insert mode
highlight StatusLine cterm=reverse,bold ctermfg=darkgreen ctermbg=black
autocmd InsertEnter * highlight StatusLine ctermfg=blue ctermbg=black
autocmd InsertLeave * highlight StatusLine ctermfg=darkgreen ctermbg=black

highlight clear CursorLine
highlight clear LineNr

" vim-indent-guides {{{3
" vim-indent-guides activated by <Leader>ig
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
augroup indentGuides
  autocmd! indentGuides
  autocmd WinEnter,BufRead * highlight IndentGuidesEven ctermbg=black
augroup END

" display listchars (spaces at end of line, tab etc) {{{2
set nolist " list or nolist
"set listchars=tab:>\ ,trail:X,nbsp:%,extends:>,precedes:<
" function! JISX0208SpaceHilight()
"     syntax match JISX0208Space "　" display containedin=ALL
"     highlight JISX0208Space term=underline ctermbg=brown
" endf

" highlight spaces at the end of line.
function! EOLSpaceHilight()
    syntax match EOLSpace " *$" display containedin=ALL
    highlight EOLSpace term=underline ctermbg=red
endf
augroup invisible
  autocmd! invisible
  " autocmd BufNew,BufRead * call JISX0208SpaceHilight()
  autocmd BufNew,BufRead * call EOLSpaceHilight()
augroup END

" [vim -b] binary edit (xxd) mode
augroup BinaryXXD
  autocmd!
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END


" Key remappings ============================================ {{{1
" general keys {{{2
"" <Nul> means <C-Space>
inoremap <Nul> <C-[>
cnoremap <Nul> <C-[>
vnoremap <Nul> <C-[>
nnoremap <Nul> <C-[>
nnoremap <F1> <C-[>
inoremap <F1> <C-[>
" always reset iminsert to zero when leaving Insert mode.
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
inoremap jj <ESC>jj
inoremap jk <ESC>
inoremap kj <ESC>

" Replace colon with semi-colon
nnoremap ; :
vnoremap ; :
nnoremap q; q:
vnoremap q; q:

" move by one display line
noremap j gj
noremap k gk
noremap 0 g0
noremap $ g$
noremap gj j
noremap gk k
noremap g0 0
noremap g$ $

" join without space
noremap gJ J
noremap J gJ

" don't include newline in visual mode
vnoremap $ $h

" cursor to the first char of the line, like Emacs.
nnoremap <C-a> 0w
nnoremap <C-e> $
inoremap <C-a> <ESC>0i
inoremap <C-e> <ESC>$a

" autocomplete (, [, {, ", '
" inoremap () ()<LEFT>
inoremap <> <><LEFT>
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap '' ''<LEFT>
inoremap "" ""<LEFT>

""" lazy symbols {{{3
" quote key is too far from my fingers
inoremap <C-F><C-D> ''<LEFT>
inoremap <C-F><C-F> ""<LEFT>
inoremap <C-F><C-J> -
inoremap <C-F><C-K> =
inoremap <C-F><C-L> _

" parentheses specific settings for test
inoremap <C-J> ()<LEFT>
" inoremap <C-J><C-J> []<LEFT>
" inoremap <C-J><C-F> {}<LEFT>
" inoremap <C-J><C-D> []<LEFT>

" move cursor (proc a b*) => (proc a b) *
inoremap <C-L> <RIGHT><Space>
" move cursor {a: b*} => {a: b}, * |or| self(*) => self(), *
inoremap <C-J>, <RIGHT>,<Space>

inoremap  _

" When searching, always move the cursor to center of window
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" go to another window
nnoremap <space>j <C-W>j
nnoremap <space>k <C-W>k
nnoremap <space>h <C-W>h
nnoremap <space>l <C-W>l
" move the window to another position
nnoremap <space>J <C-W>J
nnoremap <space>K <C-W>K
nnoremap <space>H <C-W>H
nnoremap <space>L <C-W>L
" window resizing
nnoremap <space>+ <C-W>5+
nnoremap <space>- <C-W>5-
nnoremap <space>> <C-W>10>
nnoremap <space>< <C-W>10<
nnoremap <space>= <C-W>=

" tabnew, tabmove
nnoremap <space>t :<C-u>tabnew <C-d>
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>

" Open/Close a fold.
nnoremap fo za
nnoremap FO zR
nnoremap fO zM

" tags
nnoremap tl  <C-]>
vnoremap tl  <C-]>
nnoremap tt  :<C-u>tag<CR>
nnoremap th  :<C-u>pop<CR>
nnoremap tj  :<C-u>tags<CR>

" select last modified line (gm has a original meaning)
nnoremap gm '.V

" mark, jump
nnoremap <space>ma :<C-u>marks<CR>
nnoremap <space>ms m'
nnoremap <space>mj ''zz

" Moving up/down by function, unfolding current function but folding all else
noremap [[ [[zMzvz.
noremap ]] ]]zMzvz.


" buffer control by arrow keys
"nnoremap <DOWN>  :<C-u>bdelete<CR>
"nnoremap <UP>    :<C-u>ls<CR>
"nnoremap <RIGHT> :<C-u>bnext<CR>
"nnoremap <LEFT>  :<C-u>bprevious<CR>

" save and quit
nnoremap <space>w :<C-u>update<CR>
nnoremap <space>q :<C-u>quit<CR>

" insert a blank line by 1 stroke
nnoremap <CR> o<ESC>

" yank from cursol to eol
nnoremap Y y$


" ======================================================================
" Map Leader (,) settings  {{{2
let mapleader=','

" insert date, time (from kana1)
inoremap <Leader>df <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>
inoremap <Leader>dd <C-R>=strftime('%Y%m%d')<CR>
cnoremap <Leader>dd <C-R>=strftime('%Y%m%d')<CR>
inoremap <Leader>dt <C-R>=strftime('%H:%M:%S')<CR>
" Copy/Paste via clipboard
vnoremap <Leader>cc "+y
vnoremap <Leader>cx "+y<Esc>gvd
nnoremap <Leader>cp "+p
" vimrc better handling
nnoremap <Leader>vl :source $MYVIMRC<CR>:source $HOME/.gvimrc<CR>
nnoremap <Leader>vs :vs $MYVIMRC<CR>

" show currently editing file name
nnoremap <Leader>fn :<C-u>echo expand("%")<CR>

" toggle nonumber (used often for copy&paste)
nnoremap <Leader>nn :<C-u>set number!<CR>

" Toggle set paste/nopaste
nnoremap <Space>p :set paste!<CR>

" set UTF-8
nnoremap <Leader>u8 :<C-u>e ++enc=UTF-8<CR>

" yank from line marked as 'a' to current line
nnoremap <Leader>ma :'a,.y<CR>

" open file has the filename under cursor in 'path'.
nnoremap <Space>f gf
nnoremap <Space>F <C-w>f

" select last pasted block
nnoremap <expr> <Leader>gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" plugins setting ============================================ {{{1
" QuickRun settings {{{2
" execute current window using QuickRun
augroup MyAutoCmdRSpec
    autocmd! MyAutoCmdRSpec
    autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
    autocmd BufNewFile,BufRead Gemfile       set filetype=ruby
    autocmd BufNewFile,BufRead Capfile       set filetype=ruby
    autocmd BufNewFile,BufRead *.watchr      set filetype=ruby
    autocmd BufNewFile,BufRead *.ru          set filetype=ruby
    autocmd BufNewFile,BufRead .pryrc        set filetype=ruby
augroup END
let g:quickrun_config = {}
if executable('bundle exec rspec')
    let g:quickrun_config['ruby.rspec'] = {'command': 'bundle exec rspec'}
else
    let g:quickrun_config['ruby.rspec'] = {'command': 'rspec'}
endif

" let g:quickrun_config['ruby'] = {
" \  'command': ''ruby',
" \  'exec': 'source $HOME/.rvm/scripts/rvm && source .rvmrc && ruby',
" \  'tempfile': '{tempname()}.rb'
" \ }

let g:Align_xstrlen=3

nnoremap <space>r :<C-u>QuickRun<CR>
vnoremap <space>r :<C-u>QuickRun<CR>
nnoremap <space>ro :<C-u>QuickRun -outputter browser<CR>

" if executable('gcc')
"   let g:quickrun_config['C'] = {'command': 'gcc'}
" end

" ref.vim {{{3
let g:ref_alc_start_linenumber = 44
let g:ref_alc_encoding = 'utf-8'
"let g:ref_no_default_key_mappings = 1

" ref.vim sources
let g:ref_jquery_path = $HOME . '/.vim/jquery_docs'


" RainbowParenthesesToggle {{{3
"   -- enabled by :RainbowParenthesesToggle, or Filetype autocmd
let g:rbpt_max = 7
let g:rbpt_loadcmd_toggle = 0
nnoremap <Leader>rp :<C-u>RainbowParenthesesToggle<CR>

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" Gist
"let g:gist_browser_command = 'firefox %URL% &'

" unite.vim settings {{{2
let g:unite_enable_start_insert=1
let g:unite_split_rule="topleft"
"let g:unite_enable_split_vertically=1
let g:unite_update_time=50
let g:unite_winheight=20
let g:unite_winwidth=50
"let g:unite_source_file_ignore_pattern='vendor/bundle'

let g:unite_source_file_mru_time_format = "(%a)%H:%M "
let g:unite_source_file_mru_filename_format = ":~:." "default

" auto save unite sessions for quick startup
let g:unite_source_session_enable_auto_save = 1

" UniteWithBufferDir -> initial input text is current buffer dir
nnoremap <silent> <Leader>j  :<C-u>Unite file -toggle -buffer-name=files -prompt=＼(^o^)／ <CR>
nnoremap <silent> <Leader>J  :<C-u>UniteWithBufferDir file file/new -toggle -buffer-name=files -prompt=＼(^o^)／ <CR>

nnoremap <silent> <Leader>ub :<C-u>Unite buffer -auto-preview -prompt=＼(^o^)／ <CR>
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register -auto-preview -prompt=＼(^o^)／ <CR>
nnoremap <silent> <Leader>uu :<C-u>Unite file_mru file -no-quit -toggle -buffer-name=mru&file -prompt=＼(^o^)／ <CR>
nnoremap <silent> <Leader>uo :<C-u>Unite outline -vertical -no-quit -auto-preview -prompt=＼(^o^)／ <CR>
nnoremap <silent> <Leader>um :<C-u>Unite mapping -auto-preview -prompt=＼(^o^)／ <CR>
nnoremap <silent> <Leader>ug :<C-u>Unite vcs_grep -here -auto-preview -winheight=250 -prompt=＼(^o^)／ <CR>
" nnoremap <silent> <Leader>ua :<C-u>Unite -horizontal -no-quit -auto-resize -buffer-name=ack  -prompt=＼(^o^)／ -auto-preview ack::<CR>

call unite#set_substitute_pattern('file', '\*\*\+', '*', -1)
"call unite#set_substitute_pattern('file', '[^~.]\zs/', '*/*', 20)
"call unite#set_substitute_pattern('file', '/\ze[^*]', '/*', 10)
call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " load saved unite session -- used with g:unite_source_session_enable_auto_save
  autocmd VimEnter * UniteSessionLoad

  highlight EOLSpace none
  imap <silent> <buffer> <C-h> <ESC><Plug>(unite_delete_backword_path)
  nmap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  nmap <buffer> <C-k> <Plug>(unite_select_previous_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
  nmap <buffer> <C-l> i/<ESC>
  imap <buffer> <C-l> /
  nmap <silent> <buffer> <expr> <C-y> unite#do_action('split')
  imap <silent> <buffer> <expr> <C-y> unite#do_action('split')
  nmap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  imap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <buffer> qq <Plug>(unite_exit)
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <silent> <buffer> <ESC><ESC> <Plug>(unite_exit)
endfunction

" vim-unite-ack
let g:unite_source_ack_command = "ack --ignore-dir=vendor"

" Vimfiler settings {{{2
let g:vimfiler_as_default_explorer = 1
call vimfiler#set_execute_file('vim,rb,md,txt,js,haml,html,yml', 'vim')
nnoremap <silent> ,vf :<C-u>VimFiler<CR>

" fugitive.vim settings {{{2
nnoremap <silent> <Space>gd :<C-u>Gdiff<Enter>
nnoremap <silent> <Space>gs :<C-u>Gstatus<Enter>
nnoremap <silent> <Space>gb :<C-u>Gblame<Enter>

" Openbrowser settings {{{2
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" buftabs settings {{{2
let g:buftabs_in_statusline=1
let g:buftabs_only_basename=1

" YankRing.vim settings {{{2
let g:yankring_history_dir = '$HOME/tmp'
" let g:yankring_paste_using_g = 0

" vim-cycle settings {{{2
" I added personal setting into vim-cycle plugin itseif
let g:cycle_no_mappings=1
nmap <C-C> <Plug>CycleNext

" sequence settings {{{2
nmap <Leader>sa <Plug>SequenceN_Increment
vmap <Leader>sa <Plug>SequenceV_Increment
nmap <Leader>sx <Plug>SequenceN_Decrement
vmap <Leader>sx <Plug>SequenceV_Decrement

""" facebook.vim settings {{{2
""let g:facebook_access_token_file = expand('~/.fb_access_token')
""let g:facebook_timezone = '+0900'

" Functions my/someone's ============================================ {{{1
" Automatic recognition of Encoding {{{2
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv') " :echo has('iconv') => 0
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
"  " check iconv can proccess eucIJ-ms or not
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
"  " check iconv can proccess JISX0213 or not
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
"  " constract fileencodings
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
"  " unlet vars
  unlet s:enc_euc
  unlet s:enc_jis
endif
"" if no Japanese, use encoding for fileencoding
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
set fileformats=unix,dos,mac
if exists('&ambiwidth')
  set ambiwidth=double
endif
"}}}2
function! GetEFstatus() " {{{2
" GetEFstatus is a function which get file encording and fileformat, then abbreviate them.
" modified...original-> http://memo.officebrook.net/20050512.html
    let str = ''
    let fenc = ''
    if &fileformat == 'unix'
        "let str = '[U]'
        let str = 'unix'
    else
        "let str = '[' . &fileformat . ']'
        let str = &fileformat
    endif
    if &fileencoding != ''
        if &fileencoding =~# 'iso-2022-jp'
            let fenc = 'iso'
        elseif &fileencoding == 'utf-8'
            let fenc = 'utf'
        elseif &fileencoding == 'cp932'
            let fenc = 'S'
        elseif &fileencoding =~# 'euc-jp'
            let fenc = 'euc'
        else
            let fenc = &fileencoding
        endif
        "let str = str . '[' . fenc . ']'
        let str = str . '-' . fenc
    else
        let str = str . '[-]'
    endif
    unlet fenc
    return str
endfunction


" move to current (opened file exists in) dir {{{2
function! ChangeDir()
    let _dir = expand("%:p:h")
    exec "cd " . _dir
    unlet _dir
endfunction

" search word and open result in splitt window {{{2
function! s:nameru()
  let word = input('search: ')
  if word == ""
    return
  endif
  try
    exec 'vimgrep /' . word . '/ %'
  catch /E480:\ No\ match/
    echomsg 'No match.'
    exec 'cclose'
  endtry
endfunction
command! -nargs=* Nameru call <sid>nameru(<f-args>)
nnoremap <Leader>na :Nameru<CR>

" Load settings for each location. {{{2
" http://d.hatena.ne.jp/thinca/20100216/1266294717
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('vimrc_local.vim', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" if g:loaded_vimrc == 0
"   call s:vimrc_local(getcwd())
" endif

" git-diff-aware version of gf commands. {{{2
" http://labs.timedia.co.jp/2011/04/git-diff-aware-gf-commands-for-vim.html
nnoremap <expr> gf  <SID>do_git_diff_aware_gf('gf')
nnoremap <expr> gF  <SID>do_git_diff_aware_gf('gF')
nnoremap <expr> <C-w>f  <SID>do_git_diff_aware_gf('<C-w>f')
nnoremap <expr> <C-w><C-f>  <SID>do_git_diff_aware_gf('<C-w><C-f>')
nnoremap <expr> <C-w>F  <SID>do_git_diff_aware_gf('<C-w>F')
nnoremap <expr> <C-w>gf  <SID>do_git_diff_aware_gf('<C-w>gf')
nnoremap <expr> <C-w>gF  <SID>do_git_diff_aware_gf('<C-w>gF')

function! s:do_git_diff_aware_gf(command)
  let target_path = expand('<cfile>')
  if target_path =~# '^[ab]/'  " with a peculiar prefix of git-diff(1)?
    if filereadable(target_path) || isdirectory(target_path)
      return a:command
    else
      " BUGS: Side effect - Cursor position is changed.
      let [_, c] = searchpos('\f\+', 'cenW')
      return c . '|' . 'v' . (len(target_path) - 2 - 1) . 'h' . a:command
    endif
  else
    return a:command
  endif
endfunction


