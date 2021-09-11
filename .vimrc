" https://github.com/tpope/vim-fugitive.git
" https://github.com/mhinz/vim-signify.git
" https://github.com/fatih/vim-go.git
" https://github.com/hashivim/vim-terraform.git

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
    set backspace=indent,eol,start
    set autochdir
    set autowrite
    set autoread
    set maxmempattern=20000
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

" quickfix
    map <C-n> :cnext<CR>
    map <C-p> :cprevious<CR>
    nnoremap <leader>a :cclose<CR>

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
    set tabline+=%{expand('%:p:h')}\ 
    set tabline+=\ \%{strlen(FugitiveHead())?FugitiveHead():'none'}\ 
    set tabline+=%=\ 

" statusline
    function! ActiveStatusLine()
        let statusline=''
        let statusline.="\ %{toupper(mode())}\ "
        let statusline.="%n\/%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))} "
        let statusline.="%r %M %t "
        let statusline.="%h%w "
        if !empty(@%)
            let statusline.=" %Y "
        endif
        let statusline.=" %{''.(&fenc!=''?&fenc:&enc).''} "
        if !empty(&bomb)
            let statusline.=" %{(&bomb?\",BOM\":\"\")} "
        endif
        let statusline.=" %{&ff} "
        let statusline.=" %{&spelllang} "
        let statusline.=" %{synIDattr(synID(line('.'),col('.'),1),'name')} "
        let statusline.="%= "
        let statusline.=" %c "
        let statusline.=" %l/%L "
        let statusline.=" %p%% "
        let statusline.=" %P "
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
        autocmd WinEnter * setlocal statusline=%!ActiveStatusLine() cursorline
        autocmd WinLeave * setlocal statusline=%!InactiveStatusLine() nocursorline
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

    " nnoremap <c-j> 10jzz
    " nnoremap <c-k> 10kzz

" automatically closing quotation mark, brackets etc.
    inoremap " ""<left>
    inoremap "<space> "<space>
    inoremap "<cr> "<cr>

    inoremap ' ''<left>
    inoremap '<space> '<space>
    inoremap '<cr> '<cr>

    inoremap ( ()<left>
    inoremap (( (
    inoremap (<space> (<space>
    inoremap (<cr> (<cr>

    inoremap [ []<left>
    inoremap [[ [
    inoremap [<space> [<space>
    inoremap [<cr> [<cr>

    inoremap < <><left>
    inoremap << <
    inoremap <<space> <<space>
    inoremap <<cr> <<cr>

    inoremap { {}<left>
    inoremap {{ {
    inoremap {<space> {<space>
    inoremap {<cr> {<cr>

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

" special options for vim-signify
    let g:signify_sign_change="~"

" special options for Go
    au BufRead,BufNewFile *.go iab ti type interface {{<cr>}<esc>k0ea
    au BufRead,BufNewFile *.go iab ts type struct {{<cr>}<esc>k0ea
    au BufRead,BufNewFile *.go iab ife if err != nil {{<cr><cr>}<esc>ki
    au BufRead,BufNewFile *.go iab fu func(() {{<cr>}<esc>k0f(i
    au BufRead,BufNewFile *.go iab fm func main(() {{<cr><cr>}<esc>ki
    au BufRead,BufNewFile *.go iab fe func(() error {{<cr>}<esc>k0f(i
    au BufRead,BufNewFile *.go iab pkg package

	augroup go
		autocmd!
		autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
		autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
		autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)
		autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)
		autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
		autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
		autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
		autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
		autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
		autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)
		autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)
	augroup END

    " special options for vim-go
    let g:go_fmt_fail_silently = 1
    let g:go_fmt_command = "goimports"
    let g:go_list_type = "quickfix"
    let g:go_metalinter_autosave = 1
    let g:go_metalinter_deadline = "5s"
    let g:go_autodetect_gopath = 1
    let g:go_def_mode='gopls'
    let g:go_info_mode='gopls'
    " let g:go_metalinter_enabled = ["deadcode", "errcheck", "gosimple", "ineffassign", "staticcheck", "structcheck", "typecheck", "unused", "varcheck"]
    let g:go_metalinter_autosave_enabled = ["vet", "gocritic", "golint", "errcheck"]
    let g:go_metalinter_command = "golangci-lint"

" special options for Terraform
    au BufWritePre *.tf :%s/\"\.\/modules/\"\.\.\/modules/e
    let g:terraform_fmt_on_save=1

" special options for Yaml
    au BufRead,BufNewFile *.{yml,yaml} set shiftwidth=2
    au BufRead,BufNewFile *.{yml,yaml} set softtabstop=2
    au BufRead,BufNewFile *.{yml,yaml} set expandtab

" colorscheme
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

    hi normal cterm=none ctermbg=255 ctermfg=243
    hi nontext cterm=none ctermfg=243
    hi vertsplit cterm=none ctermbg=255 ctermfg=0
    hi colorcolumn cterm=none ctermbg=255
    hi wildmenu cterm=none ctermfg=0 ctermbg=15
    hi error cterm=none ctermfg=0 ctermbg=224
    hi errormsg cterm=none ctermfg=1 ctermbg=255
    hi warningmsg cterm=none ctermfg=1 ctermbg=255
    hi modemsg cterm=none ctermfg=243
    hi identifier cterm=none ctermfg=209
    hi operator cterm=none ctermfg=241
    hi preproc cterm=none ctermfg=27
    hi function cterm=none ctermfg=209
    hi visual cterm=none ctermbg=254
    hi comment cterm=none ctermfg=246
    hi constant cterm=none ctermfg=none
    hi todo cterm=none ctermfg=brown ctermbg=255
    hi type cterm=none ctermfg=99
    hi special cterm=none ctermfg=none
    hi specialkey cterm=none ctermfg=253 ctermbg=none
    hi conceal cterm=none ctermfg=255
    hi underlined cterm=none ctermfg=none
    hi string cterm=none ctermfg=36
    hi number cterm=none ctermfg=197
    hi keyword cterm=none ctermfg=27
    hi statement cterm=none ctermfg=27
    " hi link statement keyword
    hi search cterm=none ctermbg=15
    hi matchparen cterm=none ctermfg=none ctermbg=15
    hi modemsg cterm=none ctermfg=0

    " line & cursor
        hi cursorline cterm=none ctermbg=254 ctermfg=none
        hi cursorcolumn cterm=none ctermbg=254 ctermfg=none
        hi linenr cterm=none ctermbg=255 ctermfg=248
        hi cursorlinenr cterm=none ctermbg=254 ctermfg=none

    " tabline
        hi tabline cterm=none ctermbg=255 ctermfg=0
        hi tablinesel cterm=none ctermbg=255 ctermfg=0
        hi tablinefill cterm=none ctermbg=254 ctermfg=0

    " statusline
        hi statusline cterm=none ctermbg=254 ctermfg=0
        hi statuslinenc cterm=none

    " fold
        hi folded cterm=none ctermbg=254 ctermfg=244
        hi foldcolumn cterm=none ctermfg=240 ctermbg=255

    " pmenu
        hi pmenu cterm=none ctermfg=0 ctermbg=254
        hi pmenusel cterm=none ctermfg=none ctermbg=15
        hi pmenusbar cterm=none ctermfg=0 ctermbg=253
        hi pmenuthumb cterm=none ctermfg=15 ctermbg=245

    " diff
        hi diffadd cterm=none ctermfg=none ctermbg=121
        hi diffchange cterm=none ctermbg=230 ctermfg=none
        hi diffdelete cterm=none ctermfg=none ctermbg=224
        hi difftext cterm=none ctermfg=none ctermbg=229
        hi diffadded cterm=none ctermfg=36 ctermbg=none
        hi diffremoved cterm=none ctermfg=197 ctermbg=none

    " signify
        hi signcolumn cterm=none ctermbg=255 ctermfg=0
        hi signifylineadd cterm=none ctermbg=253 ctermfg=0
        hi signifylinechange cterm=none ctermbg=253 ctermfg=0
        hi signifylinedelete cterm=none ctermbg=253 ctermfg=0
        hi signifylinechangedelete cterm=none ctermbg=253 ctermfg=0
        hi signifylinedeletefirstline cterm=none ctermbg=253 ctermfg=0
        hi signifysignadd cterm=none ctermbg=none ctermfg=14
        hi signifysignchange cterm=none ctermbg=none ctermfg=209
        hi signifysigndelete cterm=none ctermbg=none ctermfg=197
        hi signifysignchangedelete cterm=none ctermbg=none ctermfg=243
        hi signifysigndeletefirstline cterm=none ctermbg=none ctermfg=243

    " user
        hi user1 ctermfg=240 ctermbg=255 cterm=none
        hi user2 ctermfg=240 ctermbg=253 cterm=none
        hi user3 ctermfg=242 ctermbg=251 cterm=none
        hi user4 ctermfg=255 ctermbg=249 cterm=none
        hi user5 ctermfg=255 ctermbg=245 cterm=none
        hi user6 ctermfg=240 ctermbg=7 cterm=none
        hi user7 ctermfg=235 ctermbg=15 cterm=none
        hi user8 ctermfg=27 ctermbg=15 cterm=none
        hi user9 ctermfg=magenta ctermbg=15 cterm=none

    " vim
        hi vimhiattrib cterm=none ctermfg=cyan ctermbg=none
        hi vimgroup cterm=none ctermfg=0 ctermbg=none
        hi link vimwarn errormsg
        hi link vimhictermcolor vimhiattrib
        hi link vimgroupname vimgroup

    " sh
        hi shvariable ctermfg=240 cterm=none
        hi shderefsimple ctermfg=240 cterm=none

    " yaml
        hi yamlblockmappingkey cterm=none
        hi title cterm=none ctermfg=240
        hi htmltagname cterm=none ctermfg=242
        hi htmltag cterm=none ctermfg=gray
        hi htmlendtag cterm=none ctermfg=gray
        hi htmlarg cterm=none  ctermfg=27

    " link
        hi link user0 normal
        hi link character string
        hi link boolean number
        hi link float number
        hi link include preproc
        hi link define preproc
        hi link macro preproc
        hi link precondit preproc
        hi link storageclass type
        hi link structure type
        hi link typedef type
        hi link debug special
        hi link delimiter special
        hi link repeat statement
        hi link label statement
        hi link exception statement
        hi link tag keyword
        hi link specialchar special
        hi link specialcomment comment
        hi link warningmsg errormsg
        hi link kshspecialvariables shvariable
        hi link csscolor cssunitdecorators
