" Wild Menu (commands autocompletion on tab)
set path+=**
set wildmenu
set wildmode=longest:full,full
set wildignore=*.swp,*.o,*~,*.pyc
set wildignorecase

" Always show 2 lines of context around the cursor
set scrolloff=2

" Always show current position in document
set ruler

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch

" Show matching brackets
set showmatch

" Syntax coloring
syntax on
set background=dark
colorscheme peachpuff

" Show line number and relative number
set number relativenumber

" Automatically toggle relative numbering
augroup togglerelativenumbering
  autocmd!
  autocmd BufEnter,WinEnter,FocusGained,Insertleave * set relativenumber
  autocmd BufLeave,WinLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Indentation settings
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
set autoindent
set smartindent

" Character encoding
set termencoding=utf-8
set fileencoding=utf-8
set encoding=utf-8

" Folding
set foldmethod=manual " Use zf to create a fold from current selection, use za to unfold/fold

" Omnicompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete
inoremap <c-space> <c-x><c-o>
" Some terminals don't properly report ctrl-space
inoremap <c-@> <c-x><c-o>
" Close the preview and go back to insert mode
inoremap <leader>cp <c-o>:pclose<cr>

"
" Limit Git commit messages to an acceptable width, and spellcheck them
autocmd Filetype gitcommit setlocal spell textwidth=72

" Use the space key as the command leader
let mapleader=" "
let g:mapleader=" "

" Splits
set splitbelow
set splitright
map <leader>v :split<cr>
map <leader>> :vsplit<cr>
map <c-u> :split<cr>
map <c-i> :vsplit<cr>
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
" Maximize height
map <leader>_ <c-w>_
" Maximize width
map <leader>\| <c-w>\|
" Normalize sizes
map <leader>= <c-w>=
" Pop out current split into a new tab
map <leader>e <c-w>T
" Close all other splits
map <leader>o <c-w>o

" Tabs
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tm :tabmove<cr>
noremap <a-h> gT
noremap <a-l> gt

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Clipboard
vnoremap <C-c> "+y
map <C-v> "+p

" Spell-checking
set spelllang=en_us
" Toggle spell-checking
map <leader>ss :setlocal spell!<cr>
" Go to next error
map <leader>sn ]s
" Go to previous error
map <leader>sp [s
" Add to personal dictionary
map <leader>sa zg
" Correction suggestions
map <leader>s? z=

" Toggle search results highlighting
map <leader>hl :setlocal hlsearch!<cr>

" File explorer
let netrw_liststyle=3
let g:netrw_liststyle=3
map <leader>f :Explore<cr>

" Shell
" escape to shell
map <leader>sh :sh<cr>
" expand in shell
map <leader>SH !!sh<cr>

" Greek letters
map! <C-g>GA Γ
map! <C-g>DE Δ
map! <C-g>TH Θ
map! <C-g>LA Λ
map! <C-g>XI Ξ
map! <C-g>PI Π
map! <C-g>SI Σ
map! <C-g>PH Φ
map! <C-g>PS Ψ
map! <C-g>OM Ω
map! <C-g>al α
map! <C-g>be β
map! <C-g>ga γ
map! <C-g>de δ
map! <C-g>ep ε
map! <C-g>ze ζ
map! <C-g>et η
map! <C-g>th θ
map! <C-g>io ι
map! <C-g>ka κ
map! <C-g>la λ
map! <C-g>mu μ
map! <C-g>nu ν
map! <C-g>xi ξ
map! <C-g>pi π
map! <C-g>rh ρ
map! <C-g>si σ
map! <C-g>ta τ
map! <C-g>up υ
map! <C-g>ph φ
map! <C-g>ch χ
map! <C-g>ps ψ
map! <C-g>om ω
