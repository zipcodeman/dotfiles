syntax on
set t_Co=256

set nocp
filetype off

" Bundles
let plug_dir = "~/.vim/autoload/plug.vim"
let plugged_dir = "~/.vim/plugged"
if has('nvim')
  let plug_dir = "~/.local/share/nvim/site/autoload/plug.vim"
  let plugged_dir = "~/.local/share/nvim/plugged"
endif

if empty(glob(plug_dir))
  execute "silent !curl -fLo ".plug_dir." --create-dirs ".
          \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(plugged_dir)
" Plug 'scrooloose/syntastic'
" let g:syntastic_mode_map = { 'passive_filetypes': ['go'] }
" let g:syntastic_python_python_exec = 'python3'
" let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_javascript_eslint_exe = 'yarn run eslint'

Plug 'w0rp/ale'
let g:airline#extensions#ale#enabled = 1
let g:ale_cache_executable_check_failures = 1
let g:ale_linters = {'python': []}
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier']
\}
let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 1

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

Plug 'HerringtonDarkholme/yats.vim'
" Plug 'Quramy/tsuquyomi'

Plug 'briancollins/vim-jst'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2
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

Plug 'rust-lang/rust.vim'
" let g:rust_conceal = 1
" let g:rust_conceal_pub = 1
" let g:rust_conceal_mod_path = 0
let g:rustfmt_autosave = 1
let g:rustfmt_command = systemlist('rustc --print sysroot')[0]."/bin/rustfmt"
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }
  set hidden
  let g:racer_cmd = expand("~/.cargo/bin/racer")

  let g:deoplete#enable_at_startup = 1
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ 'cpp': [expand('~/Projects/cobalt/sysroot/bin/clangd')],
    \ 'python': [expand('~/.local/bin/pyls')],
    \ }

  " Automatically start language servers.
  let g:LanguageClient_autoStart = 1

  " Maps K to hover, gd to goto definition, F2 to rename
  nnoremap <silent> K :call LanguageClient_textDocument_hover()
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()
else
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }
  set hidden
  let g:racer_cmd = expand("~/.cargo/bin/racer")
  " let $RUST_SRC_PATH = expand("~/Projects/rust/src")
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
let g:formatter_yapf_style = 'google'
" au BufWrite * :Autoformat

Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'

Plug 'derekwyatt/vim-scala'

Plug 'vim-latex/vim-latex', { 'for': 'tex' }

Plug 'https://fuchsia.googlesource.com/fuchsia/', { 'rtp': 'garnet/public/lib/fidl/tools/vim' }

Plug 'vim-scripts/todo-txt.vim'

call plug#end()
filetype plugin indent on

syntax enable
set background=dark
" Try to set solarized them, but fail silently
silent! colorscheme solarized
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

" Try to call local_vimrc, but fail silently
silent! call lh#local_vimrc#munge('whitelist', $HOME.'/Projects')

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

function! s:Highlight_Matching_Pair()
endfunction

set formatoptions+=r
set formatoptions+=o

autocmd BufNewFile *.rs 0r ~/.vim-license-headers/apache-mit.txt.slash
autocmd BufNewFile *.js 0r ~/.vim-license-headers/apache-mit.txt.slash
autocmd BufNewFile *.jsx 0r ~/.vim-license-headers/apache-mit.txt.slash
autocmd BufNewFile *.ts 0r ~/.vim-license-headers/apache-mit.txt.slash
autocmd BufNewFile *.tsx 0r ~/.vim-license-headers/apache-mit.txt.slash
autocmd BufNewFile *.rb 0r ~/.vim-license-headers/apache-mit.txt.hash
autocmd BufNewFile *.vim 0r  ~/.vim-license-headers/apache-mit.txt.quote
autocmd BufNewFile *.tex 0r  ~/.vim-license-headers/apache-mit.txt.percent

set completeopt=menu,noinsert
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  "call deoplete#custom#option('auto_complete_delay', 200)
  call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)
endif
