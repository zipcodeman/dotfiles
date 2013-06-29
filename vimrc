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

Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set laststatus=2

Bundle 'tpope/vim-fugitive'

Bundle 'scrooloose/nerdtree'
map <F2> :NERDTreeToggle<CR>

Bundle 'scrooloose/syntastic'

Bundle 'klen/python-mode'
let g:pymode_lint_write = 1
let g:pymode_run_key = 'R'

Bundle 'ervandew/supertab'
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

Bundle 'majutsushi/tagbar'
if filereadable("~/.vim/tagbar-coffeescript-config")
  so ~/.vim/tagbar-coffeescript-config
end
nmap <F8> :TagbarToggle<CR>

Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = "<C-p>"
let g:ctrlp_cmd = 'CtrlPLastMode'

Bundle 'fholgado/minibufexpl.vim'
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'

filetype plugin on

" General editor settings
set tw=79                     " wrap at 79 charcters
set colorcolumn=80            " create a colored column at 80 characters
highlight ColorColumn ctermbg=5
set tabstop=2                 " Set tab length to 2
autocmd FileType python set tabstop=4
set expandtab                 " <tab> key replaced by spaces
set shiftwidth=2              " How many spaces to change with << and >>
autocmd FileType python set shiftwidth=4
set autoindent                " Keep indents already made
set smartindent               " Indent source code automatically
set lbr                       " visually break long lines

autocmd FileType make set noexpandtab " makefiles require tabs
autocmd FileType tex set nosmartindent
autocmd FileType java set makeprg=ant\ -emacs

" Folding
set foldmethod=syntax
set foldnestmax=2
autocmd FileType python set foldmethod=indent

  " Open/Close folds with Space
  nnoremap <space> zA
  vnoremap <space> zF

" Build ctags for directory
map <C-F12> :!ctags -R --exclude=.git --exclude=log *<CR>
map <F9> :!rake spec SPEC=%<CR>
autocmd FileType c, cpp map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" VimLaTeX
let g:Tex_ViewRule_dvi='xdvi'
let g:Tex_ViewRule_pdf='xpdf'
let g:tex_flavor='latex'
au FileType tex TTarget pdf

" SyntaxHighlighting
set ofu=syntaxcomplete

autocmd FileType python nmap <F8> :let pyScratch=system('python '.expand('%'))<CR>:vne<CR>:put =pyScratch<CR> :set buftype=nofile<CR>
