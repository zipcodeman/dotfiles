syntax on
set t_Co=256

set nocp
filetype off

" Bundles
if has('nvim')
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif
endif

if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
" Plug 'scrooloose/syntastic'
" let g:syntastic_mode_map = { 'passive_filetypes': ['go'] }
" let g:syntastic_python_python_exec = 'python3'
" let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_javascript_eslint_exe = 'yarn run eslint'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
endif

Plug 'w0rp/ale'
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'python': []}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install \|\| yes \| ./install --32' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '40%' }
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-y> :Find<CR>


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

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set laststatus=2
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'

Plug 'rust-lang/rust.vim', { 'for': 'rust' }
let g:rust_conceal = 1
let g:rust_conceal_pub = 1
let g:rust_conceal_mod_path = 0
let g:rustfmt_autosave = 1
let g:rustfmt_command = "rustup run nightly rustfmt"
if has('nvim')
  Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }

  let g:deoplete#sources#rust#racer_binary=expand('~/.cargo/bin/racer')
  let g:deoplete#sources#rust#rust_source_path=expand('~/Projects/rust/src')
else
  Plug 'phildawes/racer', { 'for': 'rust' }
  set hidden
  let g:racer_cmd = expand("~/.cargo/bin/racer")
  let $RUST_SRC_PATH = expand("~/Projects/rust/src")
endif

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

Plug 'derekwyatt/vim-scala'

call plug#end()
filetype plugin indent on

syntax enable
set background=dark
colorscheme solarized
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

" autocmd FileType python nmap <F8> :let pyScratch=system('python '.expand('%'))<CR>:vne<CR>:put =pyScratch<CR> :set buftype=nofile<CR>

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

call lh#local_vimrc#munge('whitelist', $HOME.'/Projects')

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

function! s:Highlight_Matching_Pair()
endfunction

autocmd BufNewFile *.rs 0r ~/.vim-license-headers/apache-mit.txt.slash
autocmd BufNewFile *.js 0r ~/.vim-license-headers/apache-mit.txt.slash
autocmd BufNewFile *.jsx 0r ~/.vim-license-headers/apache-mit.txt.slash
autocmd BufNewFile *.rb 0r ~/.vim-license-headers/apache-mit.txt.hash
autocmd BufNewFile *.vim 0r  ~/.vim-license-headers/apache-mit.txt.quote
autocmd BufNewFile *.tex 0r  ~/.vim-license-headers/apache-mit.txt.percent

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
