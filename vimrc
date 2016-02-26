syntax on
set t_Co=256

set nocp
filetype off

" Bundles
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')

Plug 'gmarik/vundle'
Plug 'vim-scripts/vim-coffee-script'

Plug 'Markdown'
Plug 'atourino/jinja.vim'
au BufRead,BufNewFile *.j2 set filetype=jinja

" Plug 'scrooloose/nerdtree'
" map <F2> :NERDTreeToggle<CR>

Plug 'scrooloose/syntastic'
let g:syntastic_javascript_checkers=['jsxhint']
let g:syntastic_mode_map = { 'passive_filetypes': ['go'] }

" Plug 'klen/python-mode'
" let g:pymode_lint_write = 1
" let g:pymode_run_key = 'R'

" Plug 'ervandew/supertab'
" au FileType python set omnifunc=pythoncomplete#Complete
" let g:SuperTabDefaultCompletionType = "context"

Plug 'abudden/taghighlight-automirror'
Plug 'majutsushi/tagbar'
if filereadable("~/.vim/tagbar-coffeescript-config")
  so ~/.vim/tagbar-coffeescript-config
end
if ! exists('g:TagHighlightSettings')
  let g:TagHighlightSettings = {}
endif
let g:TagHighlightSettings['TagFileName'] = 'tags'
let g:TagHighlightSettings['CtagsExecutable'] = expand('~/Projects/ctags-rs/target/debug/ctags-rs')

nmap <F8> :TagbarToggle<CR>

 let g:tagbar_type_rust = {
     \ 'ctagstype' : 'rust',
     \ 'kinds' : [
         \'T:types,type definitions',
         \'f:functions,function definitions',
         \'g:enum,enumeration names',
         \'s:structure names',
         \'m:modules,module names',
         \'c:consts,static constants',
         \'t:traits,traits',
         \'i:impls,trait implementations',
     \]
     \}

" Plug 'kien/ctrlp.vim'
" let g:ctrlp_map = "<C-p>"
" let g:ctrlp_cmd = 'CtrlPLastMode'
" let g:ctrlp_max_files=0
" let g:ctrlp_user_command =
"     \ ['.git', 'cd %s && git ls-files . -co --exclude-standard']
" let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      " \ --ignore .git
      " \ --ignore .svn
      " \ --ignore .hg
      " \ --ignore .DS_Store
      " \ --ignore "**/*.pyc"
      " \ --ignore .git5_specs
      " \ --ignore review
      " \ -g ""'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '40%' }
nnoremap <silent> <C-p> :Files<CR>

Plug 'fholgado/minibufexpl.vim'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'briancollins/vim-jst'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'marijnh/tern_for_vim'
" let g:tern_map_keys=1
" let g:tern_show_argument_hints='on_hold'
" let g:tern#command=['tern', '--verbose']
Plug 'elzr/vim-json'
Plug 'digitaltoad/vim-jade'

" Plug 'Shougo/neocomplete.vim'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" " Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" 
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 1
" 
" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
    " let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" 
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
        " \ <SID>check_back_space() ? "\<TAB>" :
        " \ neocomplete#start_manual_complete()
  " function! s:check_back_space() "{{{
    " let col = col('.') - 1
    " return !col || getline('.')[col - 1]  =~ '\s'
  " endfunction"}}}
" 
" " if patter matches, local omnifunc will be called
" if !exists('g:neocomplete#sources#omni#input_patterns')
    " let g:neocomplete#sources#omni#input_patterns = {}
" endif
" let g:neocomplete#sources#omni#input_patterns.rust = '[^.[:digit:] *\t]\%(\.\|\::\)\%(\h\w*\)\?'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

Plug 'dart-lang/dart-vim-plugin'

Plug 'altercation/vim-colors-solarized'
Plug 'spf13/vim-colors'

Plug 'honza/dockerfile.vim'

Plug 'jnwhiteh/vim-golang'

" Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set laststatus=2

Plug 'rust-lang/rust.vim'
Plug 'phildawes/racer', { 'for': 'rust' }
set hidden
let g:rust_conceal = 1
let g:rust_conceal_pub = 1
let g:racer_cmd = expand("~/.vim/bundle/racer/target/release/racer")
let $RUST_SRC_PATH = expand("~/Projects/rustc/src")

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
let g:gist_clip_command = 'pbcopy'
let g:gist_show_privates = 1
let g:gist_post_private = 1

Plug 'cespare/vim-toml'
Plug 'vim-scripts/brainfuck-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'derekwyatt/vim-scala'
Plug 'parkr/vim-jekyll'
Plug 'tpope/vim-liquid'

Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['git']

call plug#end()
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
autocmd FileType go match ExtraWhitespace /\s\+$/
autocmd FileType go set tabstop=2

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

function! s:Highlight_Matching_Pair()
endfunction
