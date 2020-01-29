" My mostly borrowed, slightly repurposed vim configuration.
" Author: Kevin Halliday
"
" Leader mappings {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}
" Global config {{{


function! AlacrittySetBackground()
  if !v:shell_error
    let g:alacritty_background = system('alacritty-which-colorscheme')
    let &background = g:alacritty_background
  else
    echo 'error calling "alacritty-which-colorscheme"'
    echo 'default to set background=dark'
    set background=dark
  endif
endfunction

function! SetGlobalConfig()
  " Code Completion:
  set completeopt=menuone,longest
  set wildmode=longest,list,full
  set wildmenu

  " Hidden Buffer: enable instead of having to write each buffer
  set hidden

  " Mouse: enable GUI mouse support in all modes
  set mouse=a

  " SwapFiles: prevent their creation
  set nobackup
  set noswapfile

  " Line Wrapping: do not wrap lines by default
  set nowrap

  " Highlight Search: do that
  set incsearch
  set inccommand=nosplit
  augroup sroeca_incsearch_highlight
    autocmd!
    autocmd CmdlineEnter /,\? set hlsearch
    autocmd CmdlineLeave /,\? set nohlsearch
  augroup END

  filetype plugin indent on

  " Spell Checking:
  set dictionary=$HOME/.american-english-with-propcase.txt
  set spelllang=en_us

  " Single Space After Punctuation: useful when doing :%j (the opposite of gq)
  set nojoinspaces

  set showtabline=2

  set autoread

  set grepprg=rg\ --vimgrep

  " Paste: this is actually typed <C-/>, but term nvim thinks this is <C-_>
  set pastetoggle=<C-_>

  set notimeout   " don't timeout on mappings
  set ttimeout    " do timeout on terminal key codes

  " Local Vimrc: If exrc is set, the current directory is searched for 3 files
  " in order (Unix), using the first it finds: '.nvimrc', '_nvimrc', '.exrc'
  set exrc

  " Default Shell:
  set shell=$SHELL

  " Numbering:
  set number

  " Window Splitting: Set split settings (options: splitright, splitbelow)
  set splitright

  " Redraw Window:
  augroup redraw_on_refocus
    autocmd!
    autocmd FocusGained * redraw!
  augroup END

  " Terminal Color Support: only set guicursor if truecolor
  if $COLORTERM ==# 'truecolor'
    set termguicolors
  else
    set guicursor=
  endif

  " Set Background: for PaperColor, also sets handler
  call AlacrittySetBackground()
  call jobstart(
        \ 'ls ' . $HOME . '/.alacritty.yml | entr -ps "echo alacritty_change"',
        \ {'on_stdout': { j, d, e -> AlacrittySetBackground() }})

  " Status Line: specifics for custom status line
  set laststatus=2
  set ttimeoutlen=50
  set noshowmode

  " ShowCommand: turn off character printing to vim status line
  set noshowcmd

  " Configure Updatetime: time Vim waits to do something after I stop moving
  set updatetime=750

  " Linux Dev Path: system libraries
  set path+=/usr/include/x86_64-linux-gnu/

  " Vim history for command line; can't imagine that more than 100 is needed
  set history=100
endfunction
call SetGlobalConfig()

" }}}
" Util Functions {{{

function! s:warn(message)
  echohl WarningMsg
  echom a:message
  echohl None
  return 0
endfunction

function! s:get_git_root()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction

function! s:has_git_root()
  let root = s:get_git_root()
  return empty(root) ? 0 : 1
endfunction

" }}}
" Plugin Install {{{

call plug#begin('~/.vim/plugged')

" Fonts
Plug 'ryanoasis/vim-devicons'

" Commands run in vim's virtual screen and don't pollute main shell
Plug 'fcpg/vim-altscreen'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" File Navigation
" Plug 'Xuyuanp/nerdtree-git-plugin'
" removing this because it looks weird with vim-devicons, and we get all updated files using fzf
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-rooter' " base vim root at github root
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Auto-Completion
Plug 'Shougo/neco-vim'
Plug 'Shougo/echodoc.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Writing
Plug 'junegunn/limelight.vim' " highlight text (for Goyo)
Plug 'junegunn/goyo.vim' " Distraction-free writing

" Linting
Plug 'w0rp/ale'

" Basic coloring
Plug 'rafi/awesome-vim-colorschemes'

" Status line
Plug 'itchyny/lightline.vim'

" Previewers
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" Utils
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'ckarnell/Antonys-macro-repeater'
Plug 'alvan/vim-closetag'
Plug 'wincent/ferret' " multi file search
Plug 'easymotion/vim-easymotion' " moving around in a file

" Syntax highlighting
Plug 'derekwyatt/vim-scala',
Plug 'rust-lang/rust.vim'
Plug 'hdima/python-syntax',
Plug 'autowitch/hive.vim'
Plug 'elzr/vim-json',
Plug 'vimoutliner/vimoutliner'
Plug 'cespare/vim-toml'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ElmCast/elm-vim'
Plug 'mopp/rik_octave.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'StanAngeloff/php.vim'
Plug 'vim-scripts/SAS-Syntax'
Plug 'neovimhaskell/haskell-vim'
Plug 'aklt/plantuml-syntax'
Plug 'NLKNguyen/c-syntax.vim'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-vagrant'
Plug 'lervag/vimtex'
Plug 'tomlion/vim-solidity'
Plug 'jparise/vim-graphql'
Plug 'magicalbanana/sql-syntax-vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'groenewege/vim-less'
Plug 'farfanoide/vim-kivy'
Plug 'raimon49/requirements.txt.vim'
Plug 'chr4/nginx.vim'
Plug 'othree/html5.vim'
Plug 'khalliday7/Jenkinsfile-vim-syntax'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rdolgushin/groovy.vim'
Plug 'khalliday7/Kevinsfile-vim-syntax'
Plug 'lepture/vim-jinja'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'

" Code prettifiers
Plug 'pappasam/vim-filetype-formatter'

" Indentation
Plug 'hynek/vim-python-pep8-indent'
Plug 'vim-scripts/groovyindent-unix'

" Tagbar:
Plug 'majutsushi/tagbar'
Plug 'lvht/tagbar-markdown'

call plug#end()
" }}}
"  Plugin Configuration {{{

" Python: highlighting
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1

" change color of preview window
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000

" VimJavascript:
let g:javascript_plugin_flow = 1

" SQLFormat:
" relies on 'pip install sqlformat'
let g:sqlfmt_auto = 0
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "--keywords=upper --identifiers=lower --use_space_around_operators"

" Terrform:
let g:terraform_align = 1
let g:terraform_fold_sections = 1
let g:terraform_remap_spacebar = 1

" Go: Remove annoying go neovim warning
let g:go_version_warning = 0

" Ferret:
" disable default mappings
let g:FerretMap = v:false

" Seoul256:
" dark:
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
" light:
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
" set in Syntax Highlighting section
" colo seoul256
let g:seoul256_background = 233

"  Vim-Plug: {{{
" Plug update and upgrade
function! _PU()
  exec 'PlugUpdate'
  exec 'PlugUpgrade'
endfunction
command! PU call _PU()

"  }}}
" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \     'gitbranch': 'fugitive#head'
      \   },
      \ }

command! LightlineReload call LightlineReload()

function! LightlineReload()
  let g:lightline.colorscheme = 'PaperColor'
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
" }}}
"  Preview {{{
function! _Preview()
  if &filetype ==? 'rst'
    exec 'terminal restview %'
    exec "normal \<C-O>"
  elseif &filetype ==? 'markdown'
    " from markdown-preview.vim
    exec 'MarkdownPreview'
  elseif &filetype ==? 'dot'
    " from wmgraphviz.vim
    exec 'GraphvizInteractive'
  elseif &filetype ==? 'plantuml'
    " from plantuml-previewer.vim
    exec 'PlantumlOpen'
  elseif &filetype ==? 'html'
    exec 'silent !google-chrome % &'
  else
    echo 'Preview not supported for this filetype'
  endif
endfunction
command! Preview call _Preview()
"  }}}
"  NERDTree {{{

let g:NERDTreeMapOpenInTab = '<C-t>'
let g:NERDTreeMapOpenInTabSilent = ''
let g:NERDTreeMapOpenSplit = '<C-s>'
let g:NERDTreeMapOpenVSplit = '<C-v>'
let g:NERDTreeMapJumpNextSibling = '<C-n>'
let g:NERDTreeMapJumpPrevSibling = '<C-p>'
let g:NERDTreeMapJumpFirstChild = '<C-k>'
let g:NERDTreeMapJumpLastChild = '<C-j>'

let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeCaseSensitiveSort = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 31
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeSortOrder = ['*', '\/$']
let g:NERDTreeIgnore=[
      \'venv$[[dir]]',
      \'.venv$[[dir]]',
      \'__pycache__$[[dir]]',
      \'.egg-info$[[dir]]',
      \'node_modules$[[dir]]',
      \'elm-stuff$[[dir]]',
      \'\.aux$[[file]]',
      \'\.toc$[[file]]',
      \'\.pdf$[[file]]',
      \'\.out$[[file]]',
      \'\.o$[[file]]',
      \]

function! NERDTreeToggleCustom()
  if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
    " if NERDTree is open in window in current tab...
    exec 'NERDTreeClose'
  else
    exec 'NERDTree %'
  endif
endfunction

function! s:CloseIfOnlyControlWinLeft()
  if winnr("$") != 1
    return
  endif
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        \ || &buftype == 'quickfix'
    q
  endif
endfunction

augroup CloseIfOnlyControlWinLeft
  au!
  au BufEnter * call s:CloseIfOnlyControlWinLeft()
augroup END


" Key Remappings:
nnoremap <silent> <space>j :NERDTreeToggle<CR>
nnoremap <silent> <space>J :call NERDTreeToggleCustom()<CR>
nnoremap <silent> <space>k :NERDTreeFind<cr>

"  }}}
"  Vim Ale {{{

" Vim Ale:
"Limit linters used for JavaScript.
let g:ale_linters = {
      \   'javascript': ['eslint', 'flow'],
      \   'typescript': ['tsserver'],
      \   'python': ['pylint', 'mypy']
      \}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
" let g:ale_sign_style_error =
" let g:ale_sign_style_warning =

let g:ale_enabled = 0

augroup mapping_ale_fix
  autocmd FileType python,javascript,javascript.jsx,typescript,
        \ nnoremap  <space>ap :ALEPreviousWrap<cr> |
        \ nnoremap  <space>an :ALENextWrap<cr> |
        \ nnoremap  <space>at :ALEToggle<cr>
augroup END
" }}}
"  Vim Filetype Formatter {{{

" " code formatting, thanks sam
" let g:vim_filetype_formatter_verbose = 1
let g:vim_filetype_formatter_commands = {
      \ 'python': 'black - -q --line-length 79',
      \ 'javascript': 'npx -q prettier --parser flow --stdin',
      \ 'javascript.jsx': 'npx -q prettier --parser flow --stdin',
      \ 'typescript': 'npx -q prettier --parser typescript --stdin',
      \ 'typescript.tsx': 'npx -q prettier --parser typescript --stdin',
      \ 'css': 'npx -q prettier --parser css --stdin',
      \ 'less': 'npx -q prettier --parser less --stdin',
      \ 'html': 'npx -q prettier --parser html --stdin',
      \ 'vue': 'npx -q prettier --html-whitespace-sensitivity ignore --parser vue --stdin'
      \}

nnoremap <leader>f :FiletypeFormat<cr>
vnoremap <leader>f :FiletypeFormat<cr>

" }}}
" AutoPairs {{{
" unmap CR due to incompatibility with clang-complete
let g:AutoPairsMapCR = 0
let g:AutoPairs = {
      \ '(':')',
      \ '[':']',
      \ '{':'}',
      \ "'":"'",
      \ '"':'"',
      \ '`':'`'
      \ }
augroup autopairs_filetype_overrides
   autocmd FileType python let b:AutoPairs = {
      \ '(':')',
      \ '[':']',
      \ '{':'}',
      \ "'":"'",
      \ '"':'"',
      \ '`':'`',
      \ '"""': '"""',
      \ "'''": "'''",
      \ }
  autocmd FileType rust let b:AutoPairs = {
        \ '(':')',
        \ '[':']',
        \ '{':'}',
        \ '"':'"',
        \ '`':'`'
        \ }
   autocmd FileType markdown let b:AutoPairs = {
        \ '(':')',
        \ '[':']',
        \ '{':'}',
        \ "'":"'",
        \ '"':'"',
        \ '`':'`',
        \ '"""': '"""',
        \ "'''": "'''",
        \ '```': '```',
        \ }
  autocmd FileType plantuml let b:AutoPairs = {
        \ '{':'}',
        \ '"':'"',
        \ '`':'`'
        \ }
  autocmd FileType tex let b:AutoPairs = {
        \ '(':')',
        \ '[':']',
        \ '{':'}',
        \ '`': "'"
        \ }
  autocmd FileType vim let b:AutoPairs = {
        \ '(':')',
        \ '[':']',
        \ '{':'}',
        \ "'":"'",
        \ '`':'`',
        \ }
augroup END

" Key Remappings:
imap <silent><CR> <CR><Plug>AutoPairsReturn

"  }}}
" close-tag {{{
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,*.vue,*.ts,*tsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,javascript,javascript.jsx,jsx,vue,typescript,typescript.tsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive
" (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript': 'jsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
" }}}
" Deoplete {{{

let g:deoplete#enable_at_startup = v:true

function! CustomDeopleteConfig()
  if !exists('g:loaded_deoplete')
    echom 'Deoplete not installed, skipping...'
    return
  endif
  " Deoplete Defaults:
  call deoplete#custom#option({
        \ 'auto_complete': v:true,
        \ 'auto_complete_delay': 50,
        \ 'max_list': 500,
        \ 'num_processes': 2,
        \ })

  " Source Defaults:
  call deoplete#custom#option('ignore_sources', {
        \ '_': ['buffer', 'around'],
        \ 'markdown': ['buffer', 'around', 'neosnippet'],
        \ })
  call deoplete#custom#source('_', 'min_pattern_length', 1)
  call deoplete#custom#source('_', 'converters', ['converter_remove_paren'])

  " Source Overrides: examples below
  " call deoplete#custom#source('LanguageClient', 'min_pattern_length', 4)
  " call deoplete#custom#source('neosnippet', 'min_pattern_length', 2)
endfunction
augroup deoplete_on_vim_startup
  autocmd!
  autocmd VimEnter * call CustomDeopleteConfig()
augroup END

" }}}
" Language Server Client {{{

let g:LanguageClient_serverCommands = {
      \ 'haskell': ['stack', 'exec', 'hie-wrapper'],
      \ 'javascript': ['npx', '--no-install', 'flow', 'lsp'],
      \ 'javascript.jsx': ['npx', '--no-install', 'flow', 'lsp'],
      \ 'python': ['pyls'],
      \ 'python.jinja2': ['pyls'],
      \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
      \ 'ruby': ['solargraph', 'stdio'],
      \ 'rust': ['rls'],
      \ 'typescript': ['npx', '--no-install', '-q', 'typescript-language-server', '--stdio'],
      \ 'typescript.tsx': ['npx', '--no-install', '-q', 'typescript-language-server', '--stdio'],
      \ }

" Language server configuration here
let g:LanguageClient_autoStart = 1
let g:LanguageClient_hoverPreview = 'Auto'
let g:LanguageClient_diagnosticsEnable = 0
" let g:LanguageClient_selectionUI = 'quickfix'
function! CustomLanguageClientConfig()
  nnoremap <buffer> <C-]> :call LanguageClient#textDocument_definition()<CR>
  nnoremap <buffer> <leader>sd :call LanguageClient#textDocument_hover()<CR>
  nnoremap <buffer> <leader>sr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <buffer> <leader>sf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <buffer> <leader>su :call LanguageClient#textDocument_references()<CR>
  nnoremap <buffer> <leader>sa :call LanguageClient#textDocument_codeAction()<CR>
  nnoremap <buffer> <leader>ss :call LanguageClient#textDocument_documentSymbol()<CR>
  nnoremap <buffer> <leader>sc :call LanguageClient_contextMenu()<CR>
  setlocal omnifunc=LanguageClient#complete
endfunction
augroup languageclient_on_vim_startup
  autocmd!
  execute 'autocmd FileType '
        \ . join(keys(g:LanguageClient_serverCommands), ',')
        \ . ' call CustomLanguageClientConfig()'
augroup END
"  }}}
"  Fzf {{{

command! -bang -nargs=* Grep call fzf#vim#grep('rg --column --line-number --no-heading --no-messages --fixed-strings --case-sensitive --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
command! -bang -nargs=* GrepIgnoreCase call fzf#vim#grep('rg --column --line-number --no-heading --no-messages --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

let g:fzf_action = {
      \ 'ctrl-o': 'edit',
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }


function! s:fzf_edit_file(items)
  let items = a:items
  let i = 1
  let ln = len(items)
  while i < ln
    let item = items[i]
    let parts = split(item, ' ')
    let file_path = get(parts, 1, '')
    let items[i] = file_path
    let i += 1
  endwhile
  call s:Sink(items)
endfunction

function! FzfWithDevIcons(command, preview)
  let l:fzf_files_options = ' -m --bind ctrl-n:preview-page-down,ctrl-p:preview-page-up --preview "'.a:preview.'"'
  let opts = fzf#wrap({})
  let opts.source = a:command.'| devicon-lookup'
  let s:Sink = opts['sink*']
  let opts['sink*'] = function('s:fzf_edit_file')
  let opts.options .= l:fzf_files_options
  call fzf#run(opts)
endfunction

function! FzfFiles()
  let l:fzf_preview = 'bat --color always --style plain {2..}'
  let l:fzf_command = $FZF_DEFAULT_COMMAND
  call FzfWithDevIcons(l:fzf_command, l:fzf_preview)
endfunction

function! FzfHomeFiles()
  let l:fzf_preview = 'bat --color always --style plain {2..}'
  let l:fzf_command = 'rg --files --no-ignore --no-messages --hidden --follow --glob "!.git/*" $HOME'
  call FzfWithDevIcons(l:fzf_command, l:fzf_preview)
endfunction

function! FzfGitFiles()
  if !s:has_git_root()
    call s:warn('Not in a git directoy')
    return
  endif

  let l:fzf_preview = 'bat --color always --style plain {2..}'
  " can pipe to uniq because git ls-files returns an ordered list
  let l:fzf_command = 'git ls-files | uniq'
  call FzfWithDevIcons(l:fzf_command, l:fzf_preview)
endfunction

function! FzfDiffFiles()
  if !s:has_git_root()
    call s:warn('Not in a git directoy')
    return
  endif

  let l:fzf_preview = 'bat --color always --style changes {2..}'
  let l:fzf_command = 'git ls-files --modified --others --exclude-standard | uniq'
  call FzfWithDevIcons(l:fzf_command, l:fzf_preview)
endfunction


" Key Remappings:
nnoremap <C-p> :call FzfFiles()<CR>
nnoremap <leader><C-p> :call FzfHomeFiles()<CR>
nnoremap <C-g> :call FzfGitFiles()<CR>
nnoremap <C-d> :call FzfDiffFiles()<CR>
nnoremap <C-n> yiw:Grep <C-r>"<CR>
vnoremap <C-n> y:Grep <C-r>"<CR>
nnoremap <leader><C-n> yiw:GrepIgnoreCase <C-r>"<CR>
vnoremap <leader><C-n> y:GrepIgnoreCase <C-r>"<CR>

" }}}
" Echodoc {{{

let g:echodoc#enable_at_startup = v:true
let g:echodoc#type = 'floating'
let g:echodoc#highlight_identifier = 'Identifier'
let g:echodoc#highlight_arguments = 'QuickScopePrimary'
let g:echodoc#highlight_trailing = 'Type'

" }}}
" Tagbar {{{

let g:tagbar_map_showproto = '`'
let g:tagbar_show_linenumbers = -1
let g:tagbar_autofocus = v:true
let g:tagbar_indent = 1
let g:tagbar_sort = v:false  " order by order in sort file
let g:tagbar_case_insensitive = v:true
let g:tagbar_width = 37
let g:tagbar_silent = v:true
let g:tagbar_foldlevel = 0

nnoremap <leader>t :TagbarToggle<CR>

" }}}

"  }}}
" Filetype specification {{{

augroup filetype_recognition
  autocmd!
  autocmd BufNewFile,BufRead,BufEnter *.hql,*.q set filetype=hive
  autocmd BufNewFile,BufRead,BufEnter *.config,*.yaml,*.yml set filetype=yaml
  autocmd BufNewFile,BufRead,BufEnter *.bowerrc,*.babelrc,*.eslintrc
        \ set filetype=json
  autocmd BufNewFile,BufRead,BufEnter *.slack-term,*.prettierrc,*.graphqlconfig
        \ set filetype=json
  autocmd BufNewFile,BufRead,BufEnter *.handlebars set filetype=html
  autocmd BufNewFile,BufRead,BufEnter *.ejs set filetype=html
  autocmd BufNewFile,BufRead,BufEnter *.m,*.oct set filetype=octave
  autocmd BufNewFile,BufRead,BufEnter *.jsx,*.flow set filetype=javascript.jsx
  autocmd BufNewFile,BufRead,BufEnter *.ts, set filetype=typescript
  autocmd BufNewFile,BufRead,BufEnter *.tsx, set filetype=typescript.tsx
  autocmd BufNewFile,BufRead,BufEnter *.cfg,*.ini,.coveragerc,.pylintrc
        \ set filetype=dosini
  autocmd BufNewFile,BufRead,BufEnter *.tsv set filetype=tsv
  autocmd BufNewFile,BufRead,BufEnter Dockerfile.* set filetype=Dockerfile
  autocmd BufNewFile,BufRead,BufEnter Makefile.* set filetype=make
  autocmd BufNewFile,BufRead,BufEnter *.groovy  set filetype=groovy
  autocmd BufNewFile,BufRead,BufEnter *.vue  set filetype=vue
  autocmd BufNewFile,BufRead,BufEnter *.rs  set filetype=rust
augroup END


" }}}
" Indentation (tabs, spaces, width, etc) {{{

" Note -> apparently BufRead, BufNewFile trumps Filetype
" Eg, if BufRead,BufNewFile * ignores any Filetype overwrites
" This is why default settings are chosen with Filetype *
set expandtab shiftwidth=2 softtabstop=2 tabstop=8
augroup indentation_sr
  autocmd!
  autocmd Filetype python,c,haskell,markdown,rust,rst,kv,nginx,asm,nasm,gdscript3
        \ setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype dot setlocal autoindent cindent
  autocmd Filetype make,tsv,votl,go
        \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
  " Prevent auto-indenting from occuring
  autocmd Filetype yaml setlocal indentkeys-=<:>

  autocmd Filetype ron setlocal cindent
        \ cinkeys=0{,0},0(,0),0[,0],:,0#,!^F,o,O,e
        \ cinoptions+='(s,m2'
        \ cinoptions+='(s,U1'
        \ cinoptions+='j1'
        \ cinoptions+='J1'
augroup END


" }}}
" Writing (non-coding) {{{

" Notes:
"   indenting and de-indenting in insert mode are:
"     <C-t> and <C-d>
"   formatting hard line breaks
"     NORMAL
"       gqap => format current paragraph
"       gq => format selection
"     VISUAL
"       J => join all lines

augroup writing
  autocmd!
  autocmd FileType markdown :setlocal wrap linebreak nolist
  autocmd BufNewFile,BufRead *.html,*.txt,*.tex :setlocal wrap linebreak nolist
  autocmd BufNewFile,BufRead *.html,*.txt :setlocal colorcolumn=0
augroup END

" }}}
" Folding Settings {{{

augroup fold_settings
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevelstart=0
  autocmd FileType * setlocal foldnestmax=1
  autocmd FileType yaml,python setlocal foldmethod=indent nofoldenable
  autocmd BufNewFile,BufRead .zprofile,.profile,.bashrc,.bash_profile,.zshrc,.tmux.conf setlocal foldmethod=marker
  autocmd BufNewFile,BufRead .zprofile,.profile,.bashrc,.bash_profile,.zshrc,.tmux.conf setlocal foldlevelstart=0
augroup END

" }}}
" Trailing whitespace {{{

" This section should go before syntax highlighting
" because autocommands must be declared before syntax library is loaded
function! TrimWhitespace()
  if &ft == 'markdown'
    return
  endif
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

highlight EOLWS ctermbg=red guibg=red
match EOLWS /\s\+$/
augroup whitespace_color
  autocmd!
  autocmd ColorScheme * highlight EOLWS ctermbg=red guibg=red
  autocmd InsertEnter * highlight EOLWS NONE
  autocmd InsertLeave * highlight EOLWS ctermbg=red guibg=red
augroup END

augroup fix_whitespace_save
  autocmd!
  autocmd BufWritePre * call TrimWhitespace()
augroup END

" }}}
" Syntax highlighting {{{

" Python: Highlight args and kwargs, since they are conventionally special
augroup python_syntax
  autocmd!
  autocmd FileType python syntax keyword pythonBuiltinObj args
  autocmd FileType python syntax keyword pythonBuiltinObj kwargs
augroup end

" Javascript:
augroup javascript_syntax
  autocmd!
  " autocmd FileType javascript syntax keyword jsBooleanTrue this
  " For vim-styled-components, prefer syntax highlighting over speed
  " autocmd FileType javascript,javascript.jsx :syntax sync fromstart
  " autocmd FileType javascript,javascript.jsx :syntax sync clear
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  " this resets when I leave and I don't like that
  " autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
augroup end

" QuickScope: choose primary and secondary colors
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='LimeGreen' ctermfg=Green gui=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='turquoise1' ctermfg=Cyan gui=underline
augroup END

" Spell Checking:
augroup spelling_options
  autocmd!
  autocmd ColorScheme * highlight clear SpellBad
  autocmd ColorScheme * highlight clear SpellRare
  autocmd ColorScheme * highlight clear SpellCap
  autocmd ColorScheme * highlight clear SpellLocal
  autocmd ColorScheme * highlight SpellBad ctermfg=DarkRed guifg='red1' gui=underline,italic
  autocmd ColorScheme * highlight SpellRare ctermfg=DarkGreen guifg='ForestGreen' gui=underline,italic
  autocmd ColorScheme * highlight SpellCap ctermfg=Yellow guifg='yellow' gui=underline,italic
  autocmd ColorScheme * highlight SpellLocal ctermfg=DarkMagenta guifg='magenta' gui=underline,italic
augroup END

" Trailing Whitespace: (initial highlight below doesn't matter)
highlight EOLWS ctermbg=DarkCyan
match EOLWS /\s\+$/
augroup whitespace_color
  autocmd!
  " mkdLineBreak is a link group; special 'link' syntax required here
  autocmd ColorScheme * highlight link mkdLineBreak NONE
  autocmd ColorScheme * highlight EOLWS guibg='CornflowerBlue' ctermbg=DarkCyan

  autocmd InsertEnter * highlight clear EOLWS
  autocmd InsertLeave * highlight EOLWS guibg='CornflowerBlue' ctermbg=DarkCyan

  autocmd FileType defx highlight clear EOLWS
augroup END

" Cursorline: disable, then override if necessary
highlight CursorLine cterm=NONE
augroup cursorline_setting
  autocmd!
  autocmd FileType tagbar setlocal cursorline
augroup END

" ********************************************************************
" Papercolor: options
" ********************************************************************
let g:PaperColor_Theme_Options = {}
let g:PaperColor_Theme_Options.theme = {}

" Bold And Italics:
let g:PaperColor_Theme_Options.theme.default = {
      \ 'allow_bold': 1,
      \ 'allow_italic': 1,
      \ }

" Folds And Highlights:
let g:PaperColor_Theme_Options.theme['default.dark'] = {}
let g:PaperColor_Theme_Options.theme['default.dark'].override = {
      \ 'folded_bg' : ['gray22', '0'],
      \ 'folded_fg' : ['gray69', '6'],
      \ 'visual_fg' : ['gray12', '0'],
      \ 'visual_bg' : ['gray', '6'],
      \ }
" Language Specific Overrides:
let g:PaperColor_Theme_Options.language = {
      \    'python': {
      \      'highlight_builtins' : 1,
      \    },
      \    'cpp': {
      \      'highlight_standard_library': 1,
      \    },
      \    'c': {
      \      'highlight_builtins' : 1,
      \    }
      \ }

" Load:
try
  colorscheme PaperColor
catch
  echo 'An error occured while configuring PaperColor'
endtry

" }}}
" Key remappings {{{
"
" Omnicompletion:
" <C-@> is signal sent by terminal when pressing <C-Space>
" Need to include <C-Space> as well for neovim sometimes
inoremap <C-@> <C-x><C-o>
inoremap <C-space> <C-x><C-o>

" Emacs:
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A

" Copy to clipboard
" <C-e> moves page up without moving cursor.
" <C-y> does the opposite, we remap it to <A-e>
nnoremap <A-e> <C-y>

" Copy to clipboard
nnoremap <C-y> "+y
vnoremap <C-y> "+y

" Paste:
inoremap <C-v> <esc>pa

" Escape:
" Make escape also clear highlighting
nnoremap <silent> <esc> :noh<return><esc>
inoremap jk <esc>

" MoveVisual: up and down visually only if count is specified before
" Otherwise, you want to move up lines numerically
" e.g. ignoring wrapped lines
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" MoveTabs: moving forward, backward, and to number with vim tabs
nnoremap <silent> L gt
nnoremap <silent> H gT
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt

" MoveLines:
" nnoremap <A-j> :m .+1<CR>==
" nnoremap <A-k> :m .-2<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv

" BuffersAndWindows:
" Move from one window to another
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
" Scroll screen up, down, left, and right
" left: zh, right: zl
" nnoremap <silent> K <c-e>
" nnoremap <silent> J <c-y> we like when J autowraps text
" Move cursor to top, bottom, and middle of screen
nnoremap <silent> gJ L
nnoremap <silent> gK H
nnoremap <silent> gM M
"
" QuickChangeFiletype:
nnoremap <leader>jx :set filetype=javascript.jsx<CR>
nnoremap <leader>jj :set filetype=javascript<CR>

" SnakeCase: Convert each name_like_this to nameLikeThis in current line.
nnoremap <leader>cc :s#_\(\l\)#\u\1#g<CR>
vnoremap <leader>cc :s#_\(\l\)#\u\1#g<CR>


" }}}
" Cleanup {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless they’re owned by you.
set secure

" ShowCommand: turn off character printing to vim status line
set noshowcmd

" }}}
