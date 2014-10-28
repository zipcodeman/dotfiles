syntax on
set t_Co=256

set nocp
filetype off

" Bundles
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'vim-scripts/vim-coffee-script'

Bundle 'Markdown'
Bundle 'atourino/jinja.vim'
au BufRead,BufNewFile *.j2 set filetype=jinja

Bundle 'scrooloose/nerdtree'
map <F2> :NERDTreeToggle<CR>

Bundle 'scrooloose/syntastic'
let g:syntastic_javascript_checkers=['jsxhint']

" Bundle 'klen/python-mode'
" let g:pymode_lint_write = 1
" let g:pymode_run_key = 'R'

" Bundle 'ervandew/supertab'
" au FileType python set omnifunc=pythoncomplete#Complete
" let g:SuperTabDefaultCompletionType = "context"

Bundle 'majutsushi/tagbar'
if filereadable("~/.vim/tagbar-coffeescript-config")
  so ~/.vim/tagbar-coffeescript-config
end
nmap <F8> :TagbarToggle<CR>

Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = "<C-p>"
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_max_files=0
let g:ctrlp_user_command =
    \ ['.git', 'cd %s && git ls-files . -co --exclude-standard']

Bundle 'fholgado/minibufexpl.vim'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'

Bundle "briancollins/vim-jst"

Bundle 'wting/rust.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'
" Bundle 'marijnh/tern_for_vim'
" let g:tern_map_keys=1
" let g:tern_show_argument_hints='on_hold'
" let g:tern#command=['tern', '--verbose']
Bundle 'elzr/vim-json'
Bundle 'digitaltoad/vim-jade'

Bundle 'Shougo/neocomplcache.vim'
Bundle 'Shougo/neosnippet.vim'
Bundle 'Shougo/neosnippet-snippets'

Bundle 'dart-lang/dart-vim-plugin'

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

Bundle 'altercation/vim-colors-solarized'
Bundle 'spf13/vim-colors'

Bundle 'honza/dockerfile.vim'

Bundle 'jnwhiteh/vim-golang'

Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set laststatus=2

Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
let g:gist_clip_command = 'pbcopy'
let g:gist_show_privates = 1
let g:gist_post_private = 1

syntax enable
set background=dark
colorscheme ir_black

filetype plugin on

set modelines=1

" General editor settings
set tw=100                    " wrap at 79 charcters
set colorcolumn=101           " create a colored column at 80 characters
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

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/
