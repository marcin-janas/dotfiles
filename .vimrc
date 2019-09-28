" https://github.com/w0rp/ale.git
" https://github.com/Shougo/neocomplete.vim.git
" https://github.com/davidhalter/jedi-vim.git
" https://github.com/tell-k/vim-autopep8.git
" https://github.com/tpope/vim-fugitive.git
" https://github.com/mhinz/vim-signify.git

" @ the good beginning
    filetype plugin indent on
    set nocompatible
    set nowrap
    set title
    set magic
    set binary
    set lazyredraw
    set modelines=0
    set textwidth=119
    set winwidth=119
    set wildignore=*.swp,*.bak,*.pyc,*.class
    set ruler
    set scrolloff=0
    set backspace=2
    set autochdir
    " set exrc " read .vimrc from the current directory
    let &keywordprg=':help'

" change leader
    let mapleader = "\<Space>"

" make the keyboard fast
    set ttyfast
    set ttyscroll=3
    set timeout timeoutlen=500 ttimeoutlen=5

" vim show me more
    set showmode
    set showcmd
    set showtabline=2
    set laststatus=2
    set wildmenu
    set wildmode=longest:list,full

" match
    set showmatch
    set matchpairs+=<:>

" search in file
    set incsearch
    set hlsearch
    " case insensitive search
        set ignorecase
        set smartcase
    " press Enter to turn off search result highlighting
        nmap <silent> <cr> :nohlsearch<cr>:set foldmethod=indent<cr>:set nofoldenable<cr>
    " toggle_search
        augroup toggle_search
            autocmd!
            autocmd InsertEnter * set nohlsearch
            autocmd InsertLeave * set hlsearch
        augroup end

" search for files
    set path+=**
    " ctrl+f to find and ctrl+g to grep
        nmap <leader>f :find *
        nmap <leader>g :grep *

" split
    " set splitbelow
    set splitright

" shift
    set shiftround
    set shiftwidth=4
    " better working shifting blocks in visual mode
        vnoremap < <gv
        vnoremap > >gv

" indent & tab
    set smartindent
    set autoindent
    set copyindent
    set expandtab
    set smarttab
    set tabstop=4
    set softtabstop=4

" utf-8 everywhere
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8

" number
    set number
    set relativenumber
    set numberwidth=6
    " toggle_number
        augroup toggle_number
            autocmd!
            autocmd InsertEnter * set norelativenumber
            autocmd InsertLeave * set relativenumber
        augroup end

" cursor
    set cursorline
    set nocursorcolumn

" history & undo
    set history=10000
    set undolevels=10000

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
    set foldminlines=0
    set foldcolumn=1
    " better movement between folded lines
        nnoremap j gj
        nnoremap k gk

" show whitespace
    set list
    set listchars=tab:\│\ ,trail:\·,extends:>,precedes:< " without EOL
    " set list lcs=tab:\│\·
    " set listchars=eol:¶,tab:»·,trail:·,extends:>,precedes:< " with EOL

" netrw
    " let g:netrw_banner=0
    " let g:netrw_browse_split=2
    " let g:netrw_liststyle=3
    " let g:netrw_altv=1

    " let g:netrw_fastbrowse    = 2
    " let g:netrw_keepdir       = 0
    " let g:netrw_liststyle     = 2
    " let g:netrw_retmap        = 1
    " let g:netrw_silent        = 1
    " let g:netrw_special_syntax= 1


    " let g:netrw_banner = 0
    " let g:netrw_liststyle = 3
    " let g:netrw_browse_split = 2
    " let g:netrw_altv = 1
    " let g:netrw_winsize = 0
    " augroup ProjectDrawer
    "   autocmd!
    "   autocmd VimEnter * :Vexplore
    " augroup end

" buffer
    set hidden
    " autosave
        if !empty(@%)
            autocmd BufLeave * :wa
            autocmd TextChanged * :wa
            autocmd InsertLeave * :wa
        endif
    " better/faster buffer management
        nmap <leader>l :ls<cr>:b
        nmap <leader>p :bp<cr>
        nmap <leader>n :bn<cr>
        nmap <leader>d :bd<cr>

" tabline
    set tabline=
    set tabline+=%1*\ %{expand('%:p:h')}\ 
    set tabline+=%4*\ git:\%{strlen(FugitiveHead())?FugitiveHead():'none'}\ 
    set tabline+=%5*\ venv:%{systemlist('[[\ -n\ $VIRTUAL_ENV\ ]]\ \&\&\ basename\ $VIRTUAL_ENV\ \|\|\ echo\ none')[0]}\ 
    set tabline+=%1*\ 
    set tabline+=%=\ 

" statusline
    function! ActiveStatusLine()
        let statusline=''
        let statusline.="%5* %{toupper(mode())} "
        let statusline.="%6* %r %M %t "
        let statusline.="%6* %n\/%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))} "
        let statusline.="%h%w "
        if !empty(@%)
            let statusline.="%5* %Y "
        endif
        let statusline.="%4* %{''.(&fenc!=''?&fenc:&enc).''} "
        if !empty(&bomb)
            let statusline.="%4* %{(&bomb?\",BOM\":\"\")} "
        endif
        let statusline.="%3* %{&ff} "
        let statusline.="%2* %{&spelllang} "
        let statusline.="%6* %{synIDattr(synID(line('.'),col('.'),1),'name')} "
        let statusline.="%1*%= "
        let statusline.="%2* %c "
        let statusline.="%3* %l/%L "
        let statusline.="%4* %p%% "
        let statusline.="%5* %P "
        return statusline
    endfunction

    function! InactiveStatusLine()
        let statusline=''
        let statusline.="%r %M %t "
        return statusline
    endfunction

    augroup status_line
        set statusline=%!ActiveStatusLine()
        autocmd!
        autocmd WinEnter * setlocal statusline=%!ActiveStatusLine()
        autocmd WinLeave * setlocal statusline=%!InactiveStatusLine()
    augroup end

" mapping function keys
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
        nnoremap <F10> :set hlsearch<cr> :set foldmethod=expr<cr><bar>zM

" edit and reload .vimrc
    map <leader>ve :e $MYVIMRC<cr>
    map <leader>vs :source $MYVIMRC<cr> :echo "Reload .vimrc..."<cr>

" spell
    nmap <silent> <Leader>se :set spell spelllang=en_us<cr>
    nmap <silent> <Leader>sp :set spell spelllang=pl<cr>

" mapping for git/fugitive.vim plugin
    map <leader>gs :Gstatus<cr>
    map <leader>gc :Gcommit<cr>
    map <leader>gw :Gwrite<cr>
    map <leader>gd :Gdiff<cr>

" easier switching between windows
    nnoremap <c-h> <c-w>h
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-l> <c-w>l

" automatically closing quotation mark, brackets etc.
    inoremap " ""<left>
    inoremap "<space> "<space>
    inoremap "<cr> "<cr>

    inoremap ' ''<left>
    inoremap '<space> '<space>
    inoremap '<cr> '<cr>

    inoremap ( ()<left>
    inoremap (<space> (<space>
    inoremap (<cr> (<cr>

    inoremap [ []<left>
    inoremap [<space> [<space>
    inoremap [<cr> [<cr>

    inoremap < <><left>
    inoremap <<space> <<space>
    inoremap <<cr> <<cr>

    inoremap { {}<left>
    inoremap {<space> {<space>
    inoremap {<cr> {<cr><cr>}<left><bs><up><tab><tab>
    inoremap {;<cr> {<cr><cr>};<left><left><bs><up><tab><tab>

" custom comma motion mapping
    nmap di, f,dT,
    nmap ci, f,cT,
    nmap da, f,ld2F,i,<ESC>l
    nmap ca, f,ld2F,i,<ESC>a

" custom underscore motion mapping
    nmap di_ f_dT_
    nmap ci_ f_cT_

" quick jump to shell
    nmap <silent> <leader>s :shell<cr>

" autoreload .vimrc and *.vim
    autocmd! BufWritePost .vimrc source %
    autocmd! BufWrite *.vim :source %

" remember cursor position and open file in this same place
    set viminfo='10,\"100,:20,%,n~/.viminfo
    au BufReadPost * if line("'\"") > 0|if line("'\"") <=line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" before save remove whitespace
    " autocmd BufWritePre * :%s/\s\+$//e

" use semicolon ;) as colon :)
    " nnoremap ; :
    " nnoremap : ;

" trans
    xnoremap <silent> <leader>te <esc>:'<,'>:!trans -j -b pl:en<CR>
    xnoremap <silent> <leader>tp <esc>:'<,'>:!trans -j -b en:pl<CR>

" ^functions
" CopyModeToggle()
    function! CopyModeToggle()
        if !exists("g:copy_mode_enabled")
            let g:copy_mode_enabled = 0
        endif
        if !g:copy_mode_enabled
            let g:copy_mode_enabled = 1
            set nonumber
            set norelativenumber
            set nofoldenable
            set foldcolumn=0
            set showtabline=0
            set laststatus=0
            SignifyDisable
        else
            let g:copy_mode_enabled = 0
            set number
            set relativenumber
            " set foldenable
            set foldcolumn=1
            set showtabline=2
            set laststatus=2
            SignifyEnable
        endif
        echo g:copy_mode_enabled
    endfunction
    command! -nargs=0 CopyModeToggle call CopyModeToggle()
" functions$

" ^plugins
" ^ale
    packloadall
    silent! helptags ALL
    let b:ale_linters = ['flake8', 'pylint']
    let b:ale_fixers = ['autopep8', 'yapf']
    let g:ale_completion_enabled = 1
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
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
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

" special options for Python
    let python_highlight_all=1
    au FileType python syn keyword pythonDecorator self False class finally is return None continue for lambda try True from nonlocal while and del global not with as elif if or yield assert else import pass break except in raise async await
    au BufRead,BufNewFile *.py set shiftwidth=4
    au BufRead,BufNewFile *.py set softtabstop=4
    au BufRead,BufNewFile *.py set expandtab
    au BufRead,BufNewFile *.py iab ifm if __name__ == '__main__':<del><del>

" special options for Yaml
    au BufRead,BufNewFile *.{yml,yaml} set shiftwidth=2
    au BufRead,BufNewFile *.{yml,yaml} set softtabstop=2
    au BufRead,BufNewFile *.{yml,yaml} set expandtab

" special options for Jinja2
    au BufRead,BufNewFile *.{j2} iab % % %<left><left>

" special options for C/C++
    au BufRead,BufNewFile *.{c,cpp,h,hpp} set shiftwidth=4
    au BufRead,BufNewFile *.{c,cpp,h,hpp} set softtabstop=4
    au BufRead,BufNewFile * iab #i #include <><del><del>
    inoremap /* /*  */<left><left><left>

" special options for Perl
    au BufRead,BufNewFile *.{pl,pm} set shiftwidth=4
    au BufRead,BufNewFile *.{pl,pm} set softtabstop=4
    au BufRead,BufNewFile *.{pl,pm} set noexpandtab

" special options for Ruby
    au BufRead,BufNewFile *.{rb,rake} set shiftwidth=2
    au BufRead,BufNewFile *.{rb,rake} set softtabstop=2
    au BufRead,BufNewFile *.{rb,rake} set expandtab

" ^colorscheme
    hi clear
    set background=light
    set t_Co=256

    " call matchadd('ColorColumn', '\%81v', 100)
    call matchadd('DiffDelete', '\%81v', 100)

    " identify and show the syntax highlighting group used at the cursor
    nnoremap <silent><leader><leader> :let name_of_syntax_item_under_cursor=synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<cr>:execute "hi " name_of_syntax_item_under_cursor<cr>

    " syntax
        syntax on
        syntax enable
        syntax reset

    hi Normal cterm=none ctermbg=255 ctermfg=243
    hi NonText cterm=none ctermfg=243
    hi VertSplit cterm=none ctermbg=255 ctermfg=0
    hi ColorColumn cterm=none ctermbg=255
    hi WildMenu cterm=none ctermfg=0 ctermbg=15
    hi Error cterm=none ctermfg=0 ctermbg=224
    hi ErrorMsg cterm=none ctermfg=1 ctermbg=255
    hi WarningMsg cterm=none ctermfg=1 ctermbg=255
    hi ModeMsg cterm=none ctermfg=243
    hi Identifier cterm=none ctermfg=209
    hi Operator cterm=none ctermfg=241
    hi PreProc cterm=none ctermfg=26
    hi Function cterm=none ctermfg=209
    hi Visual cterm=none ctermbg=254
    hi Comment cterm=none ctermfg=246
    hi Constant cterm=none ctermfg=none
    hi Todo cterm=none ctermfg=brown ctermbg=255
    hi Type cterm=none ctermfg=99
    hi Special cterm=none ctermfg=none
    hi SpecialKey cterm=none ctermfg=253 ctermbg=none
    hi Conceal cterm=none ctermfg=255
    hi Underlined cterm=none ctermfg=none
    hi String cterm=none ctermfg=36
    hi Number cterm=none ctermfg=197
    hi Keyword cterm=none ctermfg=26
    hi Statement cterm=none ctermfg=26
    " hi link Statement Keyword
    hi Search cterm=none ctermbg=15
    hi MatchParen cterm=none ctermfg=none ctermbg=15
    hi ModeMsg cterm=none ctermfg=0

    " line & cursor
        hi CursorLine cterm=none ctermbg=254 ctermfg=none
        hi CursorColumn cterm=none ctermbg=254 ctermfg=none
        hi LineNr cterm=none ctermbg=255 ctermfg=248
        hi CursorLineNr cterm=none ctermbg=254 ctermfg=none

    " tabline
        hi TabLine cterm=none ctermbg=255 ctermfg=0
        hi TabLineSel cterm=none ctermbg=255 ctermfg=0
        hi TabLineFill cterm=none ctermbg=255 ctermfg=0

    " statusline
        hi StatusLine cterm=none ctermbg=255 ctermfg=0
        hi StatusLineNC cterm=none

    " fold
        hi Folded cterm=none ctermbg=254 ctermfg=244
        hi FoldColumn cterm=none ctermfg=240 ctermbg=255

    " pmenu
        hi Pmenu cterm=none ctermfg=0 ctermbg=254
        hi PmenuSel cterm=none ctermfg=none ctermbg=15
        hi PmenuSbar cterm=none ctermfg=0 ctermbg=253
        hi PmenuThumb cterm=none ctermfg=15 ctermbg=245

    " diff
        hi DiffAdd cterm=none ctermfg=none ctermbg=121
        hi DiffChange cterm=none ctermbg=230 ctermfg=none
        hi DiffDelete cterm=none ctermfg=none ctermbg=224
        hi DiffText cterm=none ctermfg=none ctermbg=229

    " signify
        hi SignColumn cterm=none ctermbg=255 ctermfg=0
        hi SignifyLineAdd cterm=none ctermbg=253 ctermfg=0
        hi SignifyLineChange cterm=none ctermbg=253 ctermfg=0
        hi SignifyLineDelete cterm=none ctermbg=253 ctermfg=0
        hi SignifyLineChangeDelete cterm=none ctermbg=253 ctermfg=0
        hi SignifyLineDeleteFirstLine cterm=none ctermbg=253 ctermfg=0
        hi SignifySignAdd cterm=none ctermbg=121 ctermfg=0
        hi SignifySignChange cterm=none ctermbg=229 ctermfg=0
        hi SignifySignDelete cterm=none ctermbg=224 ctermfg=0
        hi SignifySignChangeDelete cterm=none ctermbg=253 ctermfg=0
        hi SignifySignDeleteFirstLine cterm=none ctermbg=253 ctermfg=0

    " user
        hi User1 ctermfg=240 ctermbg=255 cterm=none
        hi User2 ctermfg=240 ctermbg=253 cterm=none
        hi User3 ctermfg=242 ctermbg=251 cterm=none
        hi User4 ctermfg=255 ctermbg=249 cterm=none
        hi User5 ctermfg=255 ctermbg=245 cterm=none
        hi User6 ctermfg=240 ctermbg=7 cterm=none
        hi User7 ctermfg=235 ctermbg=15 cterm=none
        hi User8 ctermfg=26 ctermbg=15 cterm=none
        hi User9 ctermfg=magenta ctermbg=15 cterm=none

    " vim
        hi vimHiAttrib cterm=none ctermfg=cyan ctermbg=none
        hi vimGroup cterm=none ctermfg=0 ctermbg=none
        hi link vimWarn ErrorMsg
        hi link vimHiCtermColor vimHiAttrib
        hi link vimGroupName vimGroup

    " python
        hi pythonExceptions ctermfg=0 cterm=none
        hi pythonDecoratorName cterm=none ctermfg=brown

    " sh
        hi shVariable ctermfg=240 cterm=none
        hi shDerefSimple ctermfg=240 cterm=none

    " yaml
        hi yamlBlockMappingKey cterm=none
        hi Title cterm=none ctermfg=240
        hi htmlTagName cterm=none ctermfg=242
        hi htmlTag cterm=none ctermfg=gray
        hi htmlEndTag cterm=none ctermfg=gray
        hi htmlArg cterm=none  ctermfg=26

    " perl
        hi perlConditional cterm=none

    " link
        hi link User0 Normal
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
        hi link kshSpecialVariables shVariable
        hi link cssColor cssUnitDecorators
" colorscheme$
