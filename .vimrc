" https://github.com/w0rp/ale.git
" https://github.com/Shougo/neocomplete.vim.git
" https://github.com/tell-k/vim-autopep8.git
" https://github.com/tpope/vim-fugitive.git
" https://github.com/mhinz/vim-signify.git
" https://github.com/bkad/CamelCaseMotion.git
" https://github.com/davidhalter/jedi-vim.git
" https://github.com/davidhalter/jedi.git
" https://github.com/davidhalter/parso.git

filetype plugin indent on
set nocompatible
set title
set nowrap
set ruler
set wildmenu
set hidden
set magic
set scrolloff=0
set backspace=2
set textwidth=119
set winwidth=119
set history=10000
set undolevels=10000
set path+=**
set wildignore=*.swp,*.bak,*.pyc,*.class

" vim show me more
    set showmode
    set showcmd
    set showmatch
    set showtabline=2
    set laststatus=2

" search
    set incsearch
    set hlsearch

" shift
    set shiftround
    set shiftwidth=4

" tab & indent
    set expandtab
    set smarttab
    set smartindent
    set autoindent
    set copyindent
    set tabstop=4
    set softtabstop=4

" utf-8 everywhere
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8

" number
    set number
    set relativenumber

" cursor
    set cursorline
    set nocursorcolumn

" backups
    set nobackup
    set nowritebackup
    set noswapfile
    set backupdir=
    set directory=

" nobells
    set novisualbell
    set noerrorbells

" fold options
    set nofoldenable
    set foldmethod=indent
    set foldcolumn=1
    set foldminlines=0

" show whitespace
    set list
    set listchars=tab:»·,trail:·,extends:>,precedes:< " without EOL
    " set listchars=eol:¶,tab:»·,trail:·,extends:>,precedes:< " with EOL

" case insensitive search
    set ignorecase
    set smartcase

" tabline & statusline
    set tabline=%4*\ %n\/%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}\ %{expand('%:p')}\ %m
    if has("statusline")
        set statusline=
        set statusline+=%1*\ %y\                               "FileType
        set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}\  "Encoding
        set statusline+=%2*\ %{(&bomb?\",BOM\":\"\")}\         "BOM
        set statusline+=%3*\ %{&ff}\                           "FileFormat (dos/unix..)
        set statusline+=%5*\ %{&spelllang}\                    "Spellanguage
        set statusline+=%=\ (%p%%)\ %l/%L\                     "Rownumber/total (%)
        set statusline+=%c\                                    "Colnr
        set statusline+=%r%w\ %P\ \                            "Modified? Readonly? Top/bot.
    endif

" map Fx
    " F2 - toggle copy mode
        nnoremap <F2> :CopyModeToggle<cr>

    " F3 - toggle folding
        nnoremap <F3> :set foldenable!<cr>

    " F4 - toggle whitespace
        nnoremap <F4> :set nolist!<cr>

    " F5 - toggle cursorcolumn
        nnoremap <F5> :set cursorcolumn!<cr>

    " F6 - s/\t/    /g - Tab to Space
        nnoremap <F6> :retab <cr> :wq! <cr>

    " F7 - remove whitespace
        nnoremap <F7> :%s/\s\+$//<cr>

    " F8 - better copy & past
        set pastetoggle=<F8>
        set clipboard=unnamed

    " F9 - dos to unix
        nnoremap <F9> :e ++ff=unix<cr> :%s/\r//g<cr>

    " F10 - fold lines without search pattern
        set foldexpr=getline(v:lnum)!~@/
        nnoremap <F10> :set foldmethod=expr<CR><Bar>zM

" map leader
    let mapleader = "\<Space>"

" map edit and reload .vimrc
    map <leader>ve :e $MYVIMRC<cr>
    map <leader>vs :source $MYVIMRC<cr> :echo "Reload .vimrc..."<cr>

" map spell
    nmap <silent> <Leader>se :set spell spelllang=en_us<CR>
    nmap <silent> <Leader>sp :set spell spelllang=pl<CR>

" map git
    map <leader>gs :Gstatus<cr>
    map <leader>gc :Gcommit<cr>
    map <leader>gw :Gwrite<cr>
    map <leader>gd :Gdiff<cr>

" use semicolon ;) as colon :)
    " nnoremap ; :
    " nnoremap : ;

" better working shifting blocks in visual mode
    vnoremap < <gv
    vnoremap > >gv

" better movement between folded lines
    nnoremap j gj
    nnoremap k gk

" better/faster buffer management
    nmap <silent> <leader>l :ls<cr>:b
    nmap <silent> <leader>p :bp<cr>
    nmap <silent> <leader>n :bn<cr>
    nmap <silent> <leader>d :bd<cr>

" ctrl+f to find and ctrl+g to grep
    nmap <leader>f :find *
    nmap <leader>g :grep *

" press Enter to turn off search result highlighting
    nmap <silent> <cr> :nohlsearch<cr>

" quick jump to shell
    nmap <silent> <leader><leader> :shell<cr>

" before save remove whitespace
    autocmd BufWritePre * :%s/\s\+$//e

" autoreload .vimrc and *.vim
    autocmd! BufWritePost .vimrc source %
    autocmd! BufWrite *.vim :source %

" remember cursor position and open in this same place
    set viminfo='10,\"100,:20,%,n~/.viminfo
    au BufReadPost * if line("'\"") > 0|if line("'\"") <=line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" ^functions
" CopyModeToggle()
    function! CopyModeToggle()
        if !exists("g:copy_mode_enabled")
            let g:copy_mode_enabled = 0
        endif
        if !g:copy_mode_enabled
            let g:copy_mode_enabled = 1
            :NumbersDisable
            :set nonumber
            :set nofoldenable
            :set foldcolumn=0
            :set showtabline=0
            :set laststatus=0
        else
            let g:copy_mode_enabled = 0
            :NumbersEnable
            :set number
            :set foldenable
            :set foldcolumn=1
            :set showtabline=2
            :set laststatus=2
        endif
        echo g:copy_mode_enabled
    endfunction
    command! -nargs=0 CopyModeToggle call CopyModeToggle()
" functions$

" ^plugins
" ^ale
    " Check Python files with flake8 and pylint.
    let b:ale_linters = ['flake8', 'pylint']
    " " Fix Python files with autopep8 and yapf.
    let b:ale_fixers = ['autopep8', 'yapf']
" ale$

" ^neocomplete
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
" neocomplete$

" ^jedi-vim
    let g:jedi#use_splits_not_buffers = 'left'
    " Completion <C-Space>
    " Goto assignments <leader>g (typical goto function)
    " Goto definitions <leader>d (follow identifier as far as possible, includes imports and statements)
    " Show Documentation/Pydoc K (shows a popup with assignments)
    " Renaming <leader>r
    " Usages <leader>n (shows all the usages of a name)
    " Open module, e.g. :Pyimport os (opens the os module)
" jedi-vim$

" ^autopep8
    " Set maximum allowed line length (default: 79)
    let g:autopep8_max_line_length=119

    " Chose diff window type. (default: horizontal)
    " let g:autopep8_diff_type='horizontal'
    let g:autopep8_diff_type='vertical'

    " Enable possibly unsafe changes (E711, E712) (default: non defined)
    let g:autopep8_aggressive=2

    " Number of spaces per indent level (default: 4)
    " let g:autopep8_indent_size=2

    " Disable show diff window
    " let g:autopep8_disable_show_diff=1
" autopep8$
" plugins$

"  Omni completion
    set omnifunc=syntaxcomplete#Complete

" special options for * .py
    let python_highlight_all = 1
    au FileType python syn keyword pythonDecorator self False class finally is return None continue for lambda try True from nonlocal while and del global not with as elif if or yield assert else import pass break except in raise async await
    au BufRead,BufNewFile *.py set shiftwidth=4
    au BufRead,BufNewFile *.py set softtabstop=4
    au BufRead,BufNewFile *.py set expandtab
    au BufRead,BufNewFile *.py iab ifm if __name__ == '__main__':

" special options for * .c
    au BufRead,BufNewFile *.c set shiftwidth=4
    au BufRead,BufNewFile *.c set softtabstop=4

" special options for * .h
    au BufRead,BufNewFile *.h set shiftwidth=4
    au BufRead,BufNewFile *.h set softtabstop=4

" special options for * .pm
    au BufRead,BufNewFile *.pm set shiftwidth=4
    au BufRead,BufNewFile *.pm set softtabstop=4
    au BufRead,BufNewFile *.pm set noexpandtab

" special options for * .pl
    au BufRead,BufNewFile *.pl set shiftwidth=4
    au BufRead,BufNewFile *.pl set softtabstop=4
    au BufRead,BufNewFile *.pl set noexpandtab

" ^colorscheme
    hi clear
    set background=light
    set t_Co=256

    " call matchadd('ColorColumn', '\%81v', 100)
    call matchadd('DiffDelete', '\%81v', 100)

    " Syntax
        syntax on
        syntax enable
        syntax reset


    hi Normal cterm=none ctermbg=lightgray ctermfg=darkgray
    hi NonText cterm=none ctermfg=darkred
    hi LineNr cterm=none ctermbg=white ctermfg=gray
    hi VertSplit cterm=none ctermbg=white ctermfg=black
    hi ColorColumn cterm=none ctermbg=white
    hi WildMenu cterm=none ctermfg=black ctermbg=white
    hi Error cterm=none ctermfg=black ctermbg=224
    hi ErrorMsg cterm=none ctermfg=white ctermbg=darkred
    hi WarningMsg cterm=none ctermfg=white ctermbg=darkred
    hi ModeMsg cterm=none ctermfg=white
    hi Identifier cterm=none ctermfg=darkgray
    hi Operator cterm=bold ctermfg=darkgray
    hi PreProc cterm=bold ctermfg=darkgrey
    hi Function cterm=bold ctermfg=blue
    hi Visual cterm=none ctermbg=white
    hi Comment cterm=none ctermfg=gray
    hi Constant cterm=bold ctermfg=none
    hi Todo cterm=bold ctermfg=none
    hi Type cterm=bold ctermfg=none
    hi Special cterm=bold ctermfg=none
    hi Underlined cterm=none ctermfg=none
    hi SpecialKey cterm=none ctermbg=none ctermfg=248
    hi String cterm=bold ctermfg=cyan
    hi Number cterm=bold ctermfg=red
    hi Keyword cterm=bold ctermfg=none
    hi Statement cterm=bold ctermfg=none
    hi Search cterm=none ctermbg=white
    hi MatchParen cterm=none ctermfg=lightgray ctermbg=darkgray
    hi ModeMsg cterm=bold ctermfg=black

    " Cursor
        hi CursorLine cterm=none ctermbg=253 ctermfg=none
        hi CursorLineNr cterm=bold ctermbg=253 ctermfg=none
        hi CursorColumn cterm=none ctermbg=253 ctermfg=none

    " TabLine
        hi TabLine cterm=none ctermfg=blue
        hi TabLineFill cterm=none ctermbg=lightgray ctermfg=black

    " StatusLine
        hi StatusLine cterm=bold ctermbg=white ctermfg=black
        hi StatusLineNC cterm=reverse

    " Fold
        hi Folded cterm=bold ctermbg=white ctermfg=darkgray
        hi FoldColumn cterm=none ctermfg=darkgray ctermbg=white

    " Pmenu
        hi Pmenu cterm=none ctermfg=black ctermbg=white
        hi PmenuSel cterm=none ctermfg=black ctermbg=lightgray
        hi PmenuSbar cterm=none ctermfg=black ctermbg=white

    " Diff
        hi DiffAdd cterm=none ctermfg=none ctermbg=121
        hi DiffChange cterm=none ctermbg=229 ctermfg=none
        hi DiffDelete cterm=none ctermfg=none ctermbg=224
        hi DiffText cterm=bold ctermfg=none ctermbg=226

    " Signify
        hi SignColumn cterm=none ctermbg=15 ctermfg=black
        hi SignifyLineAdd cterm=none ctermbg=15 ctermfg=black
        hi SignifyLineChange cterm=none ctermbg=15 ctermfg=black
        hi SignifyLineDelete cterm=none ctermbg=15 ctermfg=black
        hi SignifyLineChangeDelete cterm=none ctermbg=15 ctermfg=black
        hi SignifyLineDeleteFirstLine cterm=none ctermbg=15 ctermfg=black
        hi SignifySignAdd cterm=none ctermbg=2 ctermfg=black
        hi SignifySignChange cterm=none ctermbg=3 ctermfg=black
        hi SignifySignDelete cterm=none ctermbg=1 ctermfg=black
        hi SignifySignChangeDelete cterm=none ctermbg=15 ctermfg=black
        hi SignifySignDeleteFirstLine cterm=none ctermbg=15 ctermfg=black

    " User
        hi User0 ctermfg=black ctermbg=gray cterm=bold
        hi User1 ctermfg=white ctermbg=8 cterm=bold
        hi User2 ctermfg=white ctermbg=darkgray cterm=bold
        hi User3 ctermfg=black ctermbg=gray cterm=bold
        hi User4 ctermfg=black ctermbg=lightgray cterm=bold
        hi User5 ctermfg=black ctermbg=white cterm=none
        hi User7 ctermfg=gray ctermbg=white cterm=bold
        hi User8 ctermfg=blue ctermbg=white cterm=bold
        hi User9 ctermfg=magenta ctermbg=white cterm=bold

    " Vim
        hi vimHiAttrib cterm=bold ctermfg=cyan ctermbg=none
        hi vimGroup cterm=bold ctermfg=blue ctermbg=none
        hi link vimWarn ErrorMsg
        hi link vimHiCtermColor vimHiAttrib
        hi link vimGroupName vimGroup

    " Python
        hi pythonExceptions ctermfg=black cterm=bold
        hi pythonDecoratorName cterm=bold ctermfg=brown

    " HTML
        hi Title cterm=none ctermfg=darkgray
        hi htmlTagName cterm=bold ctermfg=black
        hi htmlTag cterm=bold ctermfg=gray
        hi htmlEndTag cterm=bold ctermfg=gray
        hi htmlArg cterm=bold  ctermfg=blue

    " Perl
        hi perlConditional cterm=bold

    " Links
        hi link Character String
        hi link Boolean Number
        hi link Float Number
        hi link Include PreProc
        hi link Define PreProc
        hi link Macro PreProc
        hi link PreCondit PreProc
        hi link StorageClass Type
        hi link Structure Type
        hi link Typedef Type
        hi link Debug Special
        hi link Delimiter Special
        hi link Repeat Statement
        hi link Label Statement
        hi link Exception Statement
        hi link Tag Keyword
        hi link SpecialChar Special
        hi link SpecialComment Comment
        hi link WarningMsg ErrorMsg
" colorscheme$
