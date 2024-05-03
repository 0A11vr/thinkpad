" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

Plug 'fehawen/sl.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

Plug 'godlygeek/tabular'

Plug 'lervag/vimtex'
call plug#end()
syntax on
colorscheme bruin

se mouse+=a
set clipboard=unnamedplus
set relativenumber number

let g:mkdp_highlight_css = '/home/m/Templates/grayscale.css'


" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
 let g:vimtex_compiler_method = 'latexmk'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","

let g:vimtex_quickfix_open_on_warning = 0

if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif



augroup VimCompletesMeTex
  autocmd!
  autocmd FileType tex
      \ let b:vcm_omni_pattern = g:vimtex#re#neocomplete
augroup END
