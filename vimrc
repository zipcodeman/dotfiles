syntax on
set t_Co=256

set nocp
filetype off

" Bundles
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'vim-scripts/vim-coffee-script'

Plugin 'Markdown'
Plugin 'atourino/jinja.vim'
au BufRead,BufNewFile *.j2 set filetype=jinja

Plugin 'scrooloose/nerdtree'
map <F2> :NERDTreeToggle<CR>

Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers=['jsxhint']

" Plugin 'klen/python-mode'
" let g:pymode_lint_write = 1
" let g:pymode_run_key = 'R'

" Plugin 'ervandew/supertab'
" au FileType python set omnifunc=pythoncomplete#Complete
" let g:SuperTabDefaultCompletionType = "context"

Plugin 'majutsushi/tagbar'
if filereadable("~/.vim/tagbar-coffeescript-config")
  so ~/.vim/tagbar-coffeescript-config
end
nmap <F8> :TagbarToggle<CR>

Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = "<C-p>"
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_max_files=0
let g:ctrlp_user_command =
    \ ['.git', 'cd %s && git ls-files . -co --exclude-standard']

Plugin 'fholgado/minibufexpl.vim'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

Plugin 'briancollins/vim-jst'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" Plugin 'marijnh/tern_for_vim'
" let g:tern_map_keys=1
" let g:tern_show_argument_hints='on_hold'
" let g:tern#command=['tern', '--verbose']
Plugin 'elzr/vim-json'
Plugin 'digitaltoad/vim-jade'

Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'

Plugin 'dart-lang/dart-vim-plugin'

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_min_syntax_length = 1

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

Plugin 'altercation/vim-colors-solarized'
Plugin 'spf13/vim-colors'

Plugin 'honza/dockerfile.vim'

Plugin 'jnwhiteh/vim-golang'

" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'bling/vim-airline'
let g:airline_powerline_fonts = 1
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set laststatus=2

Plugin 'rust-lang/rust.vim'
let g:rust_conceal = 1
let g:rust_conceal_pub = 1

Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
let g:gist_clip_command = 'pbcopy'
let g:gist_show_privates = 1
let g:gist_post_private = 1

Plugin 'cespare/vim-toml'
Plugin 'vim-scripts/brainfuck-syntax'
Plugin 'leafgarland/typescript-vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'parkr/vim-jekyll'
Plugin 'tpope/vim-liquid'

call vundle#end()
filetype plugin indent on

syntax enable
set background=dark
colorscheme ir_black
hi clear Conceal

set modelines=1

" General editor settings
set tw=100                    " wrap at 100 charcters
if exists("&colorcolumn")
  set colorcolumn=101           " create a colored column at 101 characters
endif
highlight ColorColumn ctermbg=5
set tabstop=2                 " Set tab length to 2
autocmd FileType python set tabstop=4
set expandtab                 " <tab> key replaced by spaces
set shiftwidth=2              " How many spaces to change with << and >>
autocmd FileType python set shiftwidth=4
set autoindent                " Keep indents already made
set smartindent               " Indent source code automatically
set lbr                       " visually break long lines
set number                    " Number lines

autocmd FileType make set noexpandtab " makefiles require tabs
autocmd FileType tex set nosmartindent
autocmd FileType java set makeprg=ant\ -emacs

" Folding
set foldmethod=syntax
autocmd FileType python set foldmethod=indent
au BufNewFile,BufRead *.ejs set filetype=html

" Open/Close folds with Space
nnoremap <space> za
vnoremap <space> zf

" Build ctags for directory
map <C-F12> :!ctags -R --exclude=.git --exclude=log *<CR>
map <F9> :!rake spec SPEC=%<CR>
autocmd FileType c map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" VimLaTeX
let g:Tex_ViewRule_dvi='xdvi'
let g:Tex_ViewRule_pdf='xpdf'
let g:tex_flavor='latex'
au FileType tex TTarget pdf

" SyntaxHighlighting
set ofu=syntaxcomplete

autocmd FileType python nmap <F8> :let pyScratch=system('python '.expand('%'))<CR>:vne<CR>:put =pyScratch<CR> :set buftype=nofile<CR>

autocmd FileType gitcommit set tw=70
if exists("&colorcolumn")
  autocmd FileType gitcommit set colorcolumn=71
endif

autocmd BufRead *.aidl setf java
autocmd BufNewFile *.aidl setf java

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/
