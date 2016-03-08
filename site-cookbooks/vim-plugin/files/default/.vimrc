" Only vim, not compatibl# -*- coding: utf-8 -*-
" e with vi.
set nocompatible

call plug#begin('~/.vim/plugged')

" https://github.com/itchyny/dictionary.vim
Plug 'itchyny/dictionary.vim'
map <silent> ,d :Dictionary<Enter>

" https://github.com/vim-jp/vimdoc-ja
Plug 'vim-jp/vimdoc-ja'

" https://github.com/ConradIrwin/vim-bracketed-paste
Plug 'ConradIrwin/vim-bracketed-paste'

" https://github.com/Shougo/vimproc.vim
Plug 'Shougo/vimproc.vim', { 'dir': '~/.vim/plugged/vimproc.vim', 'do': 'make' }

" https://github.com/Shougo/vimshell.vim
Plug 'Shougo/vimshell', { 'on': 'VimShell' }

" https://github.com/Shougo/vimfiler.vim
Plug 'Shougo/vimfiler', { 'on': 'VimFiler' }
let g:vimfiler_safe_mode_by_default = 0 " セーフモードを無効化する

" https://github.com/Shougo/unite.vim
Plug 'Shougo/unite.vim'

" https://github.com/Shougo/neoyank.vim
Plug 'Shougo/neoyank.vim'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nmap <silent> ,uy :<C-u>Unite history/yank<CR>
nmap <silent> ,ub :<C-u>Unite buffer<CR>
nmap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

" https://github.com/basyura/unite-rails
Plug 'basyura/unite-rails', { 'for': 'ruby' }
function! UniteRailsSetting()
  nmap <buffer><C-H><C-H><C-H>  :<C-U>Unite rails/view<CR>
  nmap <buffer><C-H><C-H>       :<C-U>Unite rails/model<CR>
  nmap <buffer><C-H>            :<C-U>Unite rails/controller<CR>
  nmap <buffer><C-H>c           :<C-U>Unite rails/config<CR>
  nmap <buffer><C-H>s           :<C-U>Unite rails/spec<CR>
  nmap <buffer><C-H>m           :<C-U>Unite rails/db -input=migrate<CR>
  nmap <buffer><C-H>l           :<C-U>Unite rails/lib<CR>
  nmap <buffer><expr><C-H>g     ':e '.b:rails_root.'/Gemfile<CR>'
  nmap <buffer><expr><C-H>r     ':e '.b:rails_root.'/config/routes.rb<CR>'
  nmap <buffer><expr><C-H>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
  nmap <buffer><C-H>ra          :<C-U>Unite rails/rake<CR>
  nmap <buffer><C-H>h           :<C-U>Unite rails/heroku<CR>
endfunction
augroup UniteRails
  autocmd!
  autocmd User Rails call UniteRailsSetting()
augroup END

" https://github.com/jpalardy/vim-slime
Plug 'jpalardy/vim-slime'
let g:slime_target = "screen"
let g:slime_paste_file = "$HOME/.slime_paste"

" https://github.com/slim-template/vim-slim
Plug 'slim-template/vim-slim'

" https://github.com/scrooloose/syntastic
Plug 'scrooloose/syntastic'
" recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': ['ruby', 'javascript', 'coffeelint']}
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_coffee_checkers = ['coffeelint']
autocmd FileType ruby if exists('b:rails_root') |
  \ let b:syntastic_ruby_rubocop_options = '--rails' | endif

" https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
let g:NERDTreeWinPos    = "left"
let g:NERDTreeDirArrows = 1
let g:NERDTreeMinimalUI = 1
map <C-e> :NERDTreeToggle<CR>

" https://github.com/scrooloose/nerdtree
Plug 'Lokaltog/vim-easymotion'
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Gif config
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" https://github.com/szw/vim-tags
Plug 'szw/vim-tags', { 'for': 'ruby' }
function! SetVimTags()
  let g:vim_tags_auto_generate = 1
  let g:vim_tags_project_tags_command = "{CTAGS} -R --languages=+ruby,+coffee,-html,-javascript,-c,-c++ --exclude=vendor/bundle {OPTIONS} {DIRECTORY} 2>/dev/null"
  let g:vim_tags_gems_tags_command = "{CTAGS} -R --languages=+ruby,+coffee,-html,-javascript,-c,-c++ {OPTIONS} `bundle show --paths` 2>/dev/null"
  nmap <C-]> g<C-]>
endfunction
augroup VimTags
  autocmd!
  autocmd filetype ruby call SetVimTags()
augroup END
  
" https://github.com/thinca/vim-quickrun
Plug 'thinca/vim-quickrun'
let g:quickrun_config = {
      \ '_': {
      \   'runner': 'vimproc',
      \   'runner/vimproc/updatetime': 100,
      \   'outputter': 'multi:buffer:quickfix',
      \   'outputter/buffer/split': '',
      \   'outputter/buffer/close_on_empty': 1
      \ }
      \ }

" markdown
Plug 'joker1007/vim-markdown-quote-syntax'
Plug 'rcmdnk/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
Plug 'timcharper/textile.vim'
Plug 'tyru/open-browser.vim'
Plug 'kannokanno/previm'
autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,mark*} set filetype=markdown
autocmd BufRead,BufNewFile *.textile set filetype=textile
map ,w :PrevimOpen<Enter>

" git
Plug 'tpope/vim-fugitive'

" repeat + surround
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'tsaleh/vim-tmux'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'sudo.vim'

" lightline & airline
Plug 'itchyny/lightline.vim'
Plug 'itchyny/lightline-powerful'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = '⭠'  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
" Plug 'bling/vim-airline'
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" indent guides
Plug 'nathanaelkane/vim-indent-guides'
" vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level           = 2
" 自動カラーを無効にする
let g:indent_guides_auto_colors           = 0
" ハイライト色の変化の幅
let g:indent_guides_color_change_percent  = 30
" ガイドの幅
let g:indent_guides_guide_size            = 1

" completion
Plug 'Shougo/neocomplete'
" note: this option must set it in .vimrc(_vimrc).
" not in .gvimrc(_gvimrc)!
" disable autocomplpop.
let g:acp_enableatstartup = 0
" use neocomplete.
let g:neocomplete#enable_at_startup = 1
" use smartcase.
let g:neocomplete#enable_smart_case = 1
" set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $home.'/.vimshell_hist',
    \ 'scheme' : $home.'/.gosh_completions'
    \ }

" define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" plugin key-mappings.
imap <expr><c-g>     neocomplete#undo_completion()
imap <expr><c-l>     neocomplete#complete_common_string()

" recommended key-mappings.
" <cr>: close popup and save indent.
" imap <silent> <cr> <c-r>=<sid>my_cr_function()<cr>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<cr>"
  " for no inserting <cr> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<cr>"
endfunction
" <tab>: completion.
imap <expr><tab>  pumvisible() ? "\<c-n>" : "\<tab>"
" <c-h>, <bs>: close popup and delete backword char.
imap <expr><c-h> neocomplete#smart_close_popup()."\<c-h>"
imap <expr><bs> neocomplete#smart_close_popup()."\<c-h>"
imap <expr><c-y>  neocomplete#close_popup()
imap <expr><c-e>  neocomplete#cancel_popup()
" close popup by <space>.
"imap <expr><space> pumvisible() ? neocomplete#close_popup() : "\<space>"

" for cursor moving in insert mode(not recommended)
"imap <expr><left>  neocomplete#close_popup() . "\<left>"
"imap <expr><right> neocomplete#close_popup() . "\<right>"
"imap <expr><up>    neocomplete#close_popup() . "\<up>"
"imap <expr><down>  neocomplete#close_popup() . "\<down>"
" or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" autocomplpop like behavior.
"let g:neocomplete#enable_auto_select = 1

" shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"imap <expr><tab>  pumvisible() ? "\<down>" : "\<c-x>\<c-u>"

" enable omni completion.
autocmd filetype css setlocal omnifunc=csscomplete#completecss
autocmd filetype html,markdown setlocal omnifunc=htmlcomplete#completetags
autocmd filetype javascript setlocal omnifunc=javascriptcomplete#completejs
autocmd filetype python setlocal omnifunc=pythoncomplete#complete
autocmd filetype xml setlocal omnifunc=xmlcomplete#completetags

" enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.c =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.cpp =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" for perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" For smart TAB completion.
"imap <expr><TAB>  pumvisible() ? "\<C-n>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ neocomplete#start_manual_complete()
"  function! s:check_back_space() "{{{
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"  endfunction"}}}
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'Shougo/neosnippet'
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet-snippets'
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

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'

" align
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)
" Repeat alignment in visual mode with . key
vmap . <Plug>(EasyAlignRepeat)
Plug 'godlygeek/tabular'
imap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" ruby
Plug 'NigoroJr/rsense', { 'for': 'ruby' }
Plug 'supermomonga/neocomplete-rsense.vim', { 'for': 'ruby' }
let g:neocomplete#sources#rsense#home_directory = '/usr/local/bin/rsense'
" augroup load_rsense
"   autocmd!
"   autocmd InsertEnter * call plug#load('neocomplete-rsense.vim') | autocmd! load_rsense
" augroup END
  
source $VIMRUNTIME/macros/matchit.vim
Plug 'vimtaku/hl_matchit.vim'
" for hl_matchit
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft = 'html\|vim\|ruby\|sh'
" augroup matchit
"   autocmd!
"   autocmd fileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
" augroup END

" magic comment
function! MagicComment()
  let magic_comment = "# -*- coding: utf-8 -*-\n"
  let pos = getpos(".")
  call cursor(1, 0)
  execute ":normal i" . magic_comment
  call setpos(".", pos)
endfunction
map <silent> <F8> :call MagicComment()<CR>

Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }

function! VimRailsSetting()
  let g:rails_default_file='config/database.yml'
  let g:rails_level=4
  let g:rails_mappings=1
  let g:rails_modelines=0
  " let g:rails_some_option = 1
  " let g:rails_statusline = 1
  " let g:rails_subversion=0
  " let g:rails_syntax = 1
  " let g:rails_url='http://localhost:3000'
  " let g:rails_ctags_arguments='--languages=-javascript'
  " let g:rails_ctags_arguments = ''

  nmap <buffer><Space>r :R<CR>
  nmap <buffer><Space>a :A<CR>
  nmap <buffer><Space>m :Rmodel<Space>
  nmap <buffer><Space>c :Rcontroller<Space>
  nmap <buffer><Space>v :Rview<Space>
  nmap <buffer><Space>p :Rpreview<CR>
endfunction

augroup VimRails
  autocmd!
  autocmd User Rails call VimRailsSetting()
augroup END

Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-cucumber', { 'for': 'ruby' }
Plug 'tpope/vim-haml', { 'for': 'ruby' }

" RSpec.vim mappings
Plug 'tpope/vim-dispatch'
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }

function! SetVimRspec()
  map ,c :call RunCurrentSpecFile()<CR>
  map ,n :call RunNearestSpec()<CR>
  map ,l :call RunLastSpec()<CR>
  map ,a :call RunAllSpecs()<CR>
  let g:rspec_command = "Dispatch bin/rspec {spec}"
  " iTerm instead of Terminal
  let g:rspec_runner = "os_x_iterm"
endfunction

augroup VimRspec
  autocmd!
  autocmd filetype ruby call SetVimRspec() 
augroup END

Plug 'thinca/vim-ref', { 'for': 'ruby' }
Plug 'depuracao/vim-rdoc', { 'for': 'ruby' }

" javascript
Plug 'jelera/vim-javascript-syntax'
Plug 'kchmck/vim-coffee-script'
map <silent> cf :CoffeeWatch vert<CR>
Plug 'JavaScript-Indent'
autocmd BufRead,BufNewFile *.ejs set filetype=html

" css
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
source ~/.vimrc_scss_indent

" colorscheme
Plug 'nanotech/jellybeans.vim'
Plug 'Lokaltog/vim-distinguished'
Plug 'mopp/mopkai.vim'
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'croaky/vim-colors-github'
Plug 'MaxSt/FlatColor'
Plug 'vim-scripts/grishin-color-scheme'
Plug 'nelstrom/vim-mac-classic-theme'
Plug 'tpope/vim-vividchalk'

" tagbar & taglist
Plug 'majutsushi/tagbar'
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }
let g:tagbar_type_coffee = {
    \ 'ctagstype' : 'coffee',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'm:methods',
        \ 'f:functions',
        \ 'v:variables',
        \ 'f:fields',
    \ ]
\ }
let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }
map <silent> tt :TagbarToggle<CR>
" Plug 'taglist.vim'
" let Tlist_Ctags_Cmd        = 'ctags'
" let Tlist_Show_One_File    = 1 " 現在表示中のファイルのみのタグしか表示しない
" let Tlist_Use_Right_Window = 1 " 右側にtag listのウインドうを表示する
" let Tlist_Exit_OnlyWindow  = 1 " taglistのウインドウだけならVimを閉じる
" " \lでtaglistウインドウを開いたり閉じたり出来るショートカット
" map <silent> <C-l> :TlistToggle<CR>

call plug#end()

" 読み込んだプラグインも含め、ファイルタイプを検出、
" ファイルタイプ別プラグイン、インデントを有効化する。
filetype plugin indent on

" 256カラーを使う。
set t_Co=256
set term=xterm-256color

" カラースキムを定義する。
" colorscheme jellybeans
" colorscheme distinguished 
" colorscheme mopkai
" colorscheme monokai
" colorscheme molokai
" colorscheme Tomorrow
" colorscheme github
" colorscheme flatcolor
" colorscheme grishin
" colorscheme mac_classic
" colorscheme vividchalk

" 日本語文字コード自動判別と文字コード交換
" vimが内部で用いるエンコーディングを指定
set encoding=utf-8
" 端末の出力に用いられるエンコーディングを指定
set termencoding=utf-8
" ファイルを開く時、適切なエンコーディングを自動的に判定
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
" 想定される改行の種類を指定
set fileformats=unix,mac,dos

" 選択した範囲のインデントサイズを連続変更
vnoremap < <gv
vnoremap > >gv

" 構文ハイライト有効
syntax on

" インクリメンタル検索を有効
set incsearch
" 検索のとき大小文字無視
set ignorecase
" 検索ハイライト有効
set hlsearch
" ex)
" foobar: 大小文字区分しない。
" FOOBAR: される。
" FooBar: される。
set smartcase
" ESCキー連打でさりげなく色を消す。
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 折り返しをしない。
set nowrap
" オートインデントを使用するため必要
set nopaste
" 行番号を表示する。
set number
" カーソルを左右に移動させる。
set whichwrap=b,s,h,l,[,],<,>,~

" indent
" タブ入れを複数の空白入力に置き換える。
set expandtab
" 画面上でタグ文字が占める幅
set tabstop=2
" 自動インデントでずれる幅
set shiftwidth=2
" 連続した空白に対してタグキーやバックスペースキーでカーソルが動く幅
set softtabstop=2
" 改行の時に前の行のインデントを継続する。
set autoindent
" 改行の時に入力された行の末尾に合わせて次の行のインデントを増減する。
set smartindent

" mouse
" normal(n), visual(v), insert(i), command(c) = all(a)
set mouse=a
" enable mouse drag
set ttymouse=xterm2

" backspace
" start: インサートモードの開始位置より前の文字列の削除を許可する。。
" indent: 自動インデントを行った場合、インデント部分の削除を許可する。
" eol: 改行文字の削除を許可する。
set backspace=start,indent,eol

" backup
set backup
set swapfile
set backupdir=~/.vim/backup
set directory=~/.vim/swap

" folding
" zc: close, zo: open, zC: close all, zO: open all
set foldmethod=syntax
set foldlevel=100

" ファイル間移動
nmap <silent> <C-n>      :update<CR>:bn<CR>
imap <silent> <C-n> <ESC>:update<CR>:bn<CR>
vmap <silent> <C-n> <ESC>:update<CR>:bn<CR>
cmap <silent> <C-n> <ESC>:update<CR>:bn<CR>

" vimrc 読み込み
noremap <Space>. :<C-u>edit $MYVIMRC<Enter>
noremap <Space>s. :<C-u>source $MYVIMRC<Enter>

" Make color when visual mode used
hi Visual ctermfg=Black ctermbg=Cyan
" Make colorscheme to dark
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
hi colorcolumn ctermbg=235
" Make colorscheme to light
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=255
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=254
" hi colorcolumn ctermbg=253
execute "set colorcolumn=" . join(range(81, 81), ',')

" buffer
nmap <silent>bp :bprevious<CR>
nmap <silent>bn :bnext<CR>
nmap <silent>bb :b#<CR>
nmap <silent>bf :bf<CR>
nmap <silent>bl :bl<CR>
nmap <silent>bm :bm<CR>
nmap <silent>bd :bdelete<CR>
