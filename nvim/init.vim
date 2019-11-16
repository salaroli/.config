let mapleader="\<space>"
call plug#begin()
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-emmet', 
  \ 'coc-css', 
  \ 'coc-html', 
  \ 'coc-highlight', 
  \ ]

" prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }

" nerdtree config
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"syntax hightlight
Plug 'sheerun/vim-polyglot'

"lint
Plug 'w0rp/ale'

"theme
Plug 'morhetz/gruvbox'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'

"ctrl-p
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" editing
" Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
" Plug 'mattn/emmet-vim'

"other
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'gorodinskiy/vim-coloresque'
Plug 'kassio/neoterm'
Plug 'machakann/vim-highlightedyank'

" ultimo plugin sempre
Plug 'ryanoasis/vim-devicons'
call plug#end()

source ~/.config/nvim/coc.vim

"Padrão
set autoindent
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set breakindent
set clipboard=unnamed
set encoding=utf-8
set expandtab
set fileencodings=utf-8
set hidden
set history=200
set hlsearch    " highlight search patterns
set inccommand=split
set incsearch    " enable incremental search
set lazyredraw    " don't redraw screen while executing macros/mappings
set mouse=a
set nostartofline  " keep cursor in the same column if possible
set nrformats=
set number
set pastetoggle=<F3>
set relativenumber
set ruler    " show the cursor position all the time
set scrolloff=1    " minimal number of screen lines to keep above and below the cursor
set shiftwidth=2
set showbreak=...
set showcmd    " display incomplete commands
set ignorecase
set smartcase    " ignore case when the pattern contains lowercase letters only
set smarttab
set cindent
set softtabstop=2
set tabstop=2
set virtualedit=block  " allow virtual editing in Visual block mode
set whichwrap=b,s,[,],<,>,h,l " allow cursor to wrap between lines
set winaltkeys=no  " allow mapping of alt (meta) key shortcuts
syntax on    " enable syntax highlighting
set termguicolors
let g:jsx_ext_required=0

" Theme
colorscheme gruvbox
set background=dark
let g:airline_theme='laederon'
let g:airline_powerline_fonts=1
let g:Powerline_symbols='unicode'
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:bufferline_show_bufnr = 1
let g:bufferline_echo = 0

"Nerdtree
noremap <C-e> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeIgnore = [
      \ '\.vim$',
      \ '\~$',
      \ '\.beam',
      \ 'elm-stuff',
      \ 'deps',
      \ '_build',
      \ '.git',
      \ 'node_modules',
      \ 'tags',
      \ ]

"FZF
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()

" let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --color=always -E .git --ignore-file ~/.gitignore'
let $FZF_DEFAULT_OPTS='--ansi --layout=reverse'
let g:fzf_files_options = '--preview "(bat --color \"always\" --line-range 0:100 {} || head -'.&lines.' {})"'


if has('nvim') && exists('&winblend') && &termguicolors
  set winblend=10

  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif

  function! FloatingFZF()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.6)
    let opts = {
          \  'relative': 'editor',
          \  'row': (&lines - height) / 2,
          \  'col': (&columns - width) / 2,
          \  'width': width,
          \  'height': height
          \ }

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

command! -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

fun! FZFOpen()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun

nnoremap <silent> <C-p> :call FZFOpen()<CR>
nnoremap <C-f> :Ag<cr>
nnoremap <C-b> :Buffers<cr>


" EMMET -----------------------------------------
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-a>'


" Easymotion
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)


" Prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#quickfix_auto_focus = 0

"Vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Terminal"
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <Esc> <C-\><C-n>
nnoremap <C-t> :botright Ttoggle<cr><C-w>j
tnoremap <C-t> :Ttoggle<cr>

" Other
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source~/.config/nvim/init.vim<cr>
nnoremap <leader>p :Prettier<cr>
nnoremap <leader>k :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
