syntax on
set t_Co=256

set nocp
filetype off

" Bundles
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'passive_filetypes': ['go'] }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install \|\| yes \| ./install --32' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '40%' }
nnoremap <silent> <C-p> :Files<CR>

Plug 'fholgado/minibufexpl.vim'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_frontmatter = 1

Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-liquid'

Plug 'briancollins/vim-jst'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

Plug 'altercation/vim-colors-solarized'
Plug 'spf13/vim-colors'

Plug 'jnwhiteh/vim-golang', { 'for': 'go' }

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
let g:rust_conceal_mod_path = 0
let g:rustfmt_autosave = 1
let g:racer_cmd = expand("~/.vim/bundle/racer/target/release/racer")
let $RUST_SRC_PATH = expand("~/Projects/rustc/src")

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
let g:gist_clip_command = 'pbcopy'
let g:gist_show_privates = 1
let g:gist_post_private = 1

Plug 'cespare/vim-toml'
Plug 'maralla/vim-toml-enhance'
Plug 'parkr/vim-jekyll'

Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['git']

" For writing
Plug 'vim-scripts/vim-auto-save', { 'for': 'markdown' }
Plug 'reedes/vim-pencil', { 'for': 'markdown' }
Plug 'reedes/vim-wordy', { 'for': 'markdown' }

Plug 'Chiel92/vim-autoformat'

Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'

Plug 'jaxbot/semantic-highlight.vim'
let g:semanticTermColors = [29,202,11,13,14,9,10,34,196,231,197,214,27,253]

Plug 'derekwyatt/vim-scala'

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
" au BufNewFile,BufRead *.rs set filetype=rust

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
