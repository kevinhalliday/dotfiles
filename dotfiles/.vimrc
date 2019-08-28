" My lovely, mostly plagiarized, slightly repurposed vim configuration.
"
" Author: Kevin Halliday
"
" Leader mappings -------------------- {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}
" Global config ------------ {{{

"A comma separated list of options for Insert mode completion
"   menuone  Use the popup menu also when there is only one match.
"            Useful when there is additional information about the
"            match, e.g., what file it comes from.

"   longest  Only insert the longest common text of the matches.  If
"            the menu is displayed you can use CTRL-L to add more
"            characters.  Whether case is ignored depends on the kind
"            of completion.  For buffer text the 'ignorecase' option is
"            used.

"   preview  Show extra information about the currently selected
"            completion in the preview window.  Only works in
"            combination with 'menu' or 'menuone'.
set completeopt=menuone,longest,preview

" Enable buffer deletion instead of having to write each buffer
set hidden

" Mouse: enable GUI mouse support in all modes
set mouse=a

" SwapFiles: prevent their creation
set nobackup
set noswapfile

" Do not wrap lines by default
set nowrap

" Set column to light grey at 80 characters
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

" Remove query for terminal version
" This prevents un-editable garbage characters from being printed
" after the 80 character highlight line
set t_RV=

filetype plugin indent on

augroup cursorline_setting
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

set spelllang=en_us

set showtabline=2

set autoread

" When you type the first tab hit will complete as much as possible,
" the second tab hit will provide a list, the third and subsequent tabs
" will cycle through completion options so you can complete the file
" without further keys
set wildmode=longest,list,full
set wildmenu

" AirlineSettings: specifics due to airline
set laststatus=2
set ttimeoutlen=50
set noshowmode

" Pasting: enable pasting without having to do 'set paste'
" NOTE: this is actually typed <C-/>, but vim thinks this is <C-_>
set pastetoggle=<C-_>

" Turn off complete vi compatibility
set nocompatible

" Enable using local vimrc
set exrc

" Make sure numbering is set
set number

" Set split settings (options: splitright, splitbelow)
set splitright

" Redraw window whenever I've regained focus
augroup redraw_on_refocus
  au FocusGained * :redraw!
augroup END

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" }}}
" Plugin Install --------------------- {{{

call plug#begin('~/.vim/plugged')

" Commands run in vim's virtual screen and don't pollute main shell
Plug 'fcpg/vim-altscreen'

" File Navigation
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-rooter'

" Auto-Completion
Plug 'davidhalter/jedi-vim'
" Plug 'marijnh/tern_for_vim', { 'do': 'npm install'  }  " for javascript
Plug 'Rip-Rip/clang_complete'
Plug 'xaizek/vim-inccomplete'
Plug 'eagletmt/neco-ghc'
Plug 'racer-rust/vim-racer'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go'
Plug 'wannesm/wmgraphviz.vim'  " dotlanguage
Plug 'juliosueiras/vim-terraform-completion'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Linting
Plug 'w0rp/ale'

" Basic coloring
Plug 'NLKNguyen/papercolor-theme'
Plug 'tomasr/molokai'

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
Plug 'fatih/vim-go'
Plug 'rdolgushin/groovy.vim'
Plug 'khalliday7/Kevinsfile-vim-syntax'
Plug 'lepture/vim-jinja'

" Code prettifiers
Plug 'pappasam/vim-filetype-formatter'

" Indentation
Plug 'hynek/vim-python-pep8-indent'
Plug 'vim-scripts/groovyindent-unix'

call plug#end()
" }}}
"  Plugin Configuration ------------ {{{

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

" Remove annoying go neovim warning
let g:go_version_warning = 0

"  Vim-Plug --- {{{
" Plug update and upgrade
function! _PU()
  exec 'PlugUpdate'
  exec 'PlugUpgrade'
endfunction
command! PU call _PU()

"  }}}
"  Preview --- {{{
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
" AutoCompletion config and key remappings ------------ {{{

" VimScript:
" Autocompletion and show definition is built in to Vim
" Set the same shortcuts as usual to find them
augroup vimscript_complete
  autocmd!
  autocmd FileType vim nnoremap <buffer> <C-]> yiw:help <C-r>"<CR>
  autocmd FileType vim inoremap <buffer> <C-@> <C-x><C-v>
  autocmd FileType vim inoremap <buffer> <C-space> <C-x><C-v>
augroup END

" Python:
" Open module, e.g. :Pyimport os (opens the os module)
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0
let g:jedi#auto_close_doc = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#force_py_version = 3

" mappings
" auto_vim_configuration creates space between where vim is opened and
" closed in my bash terminal. This is annoying, so I disable and manually
" configure. See 'set completeopt' in my global config for my settings
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_command = "<C-]>"
let g:jedi#documentation_command = "<leader>sd"
let g:jedi#usages_command = "<leader>su"
let g:jedi#rename_command = "<leader>r"

" removing tern in favor of LanguageClient + flow lsp combo
" Javascript:
" This slows scroll over first function in file
" let g:tern_show_argument_hints = 'on_move'
" let g:tern_show_signature_in_pum = 1
" let g:tern#command = ['npx', 'tern']
" augroup javascript_complete
"   autocmd!
"   autocmd FileType javascript nnoremap <buffer> <C-]> :TernDef<CR>
"   autocmd FileType javascript nnoremap <buffer> <leader>sd :TernDoc<CR>
"   autocmd FileType javascript nnoremap <buffer> <leader>sp :TernDefPreview<CR>
"   autocmd FileType javascript nnoremap <buffer> <leader>ss :TernDefSplit<CR>
"   autocmd FileType javascript nnoremap <buffer> <leader>st :TernDefTab<CR>
"   autocmd FileType javascript nnoremap <buffer> <leader>su :TernRefs<CR>
"   autocmd FileType javascript nnoremap <buffer> <leader>r :TernRename<CR>
" augroup END

" Elm:
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 0
augroup elm_complete
  autocmd!
  autocmd FileType elm nnoremap <buffer> <C-]> :ElmShowDocs<CR>
augroup END

" C_CPP:
" Jumping back defaults to <C-O> or <C-T> (in is <C-I> per usual)
" Defaults to <C-]> for goto definition
" Additionally, jumping to Header file under cursor: gd
let g:clang_library_path = '/usr/lib/llvm-6.0/lib'
let g:clang_auto_user_options = 'compile_commands.json, path, .clang_complete'
let g:clang_complete_auto = 0
let g:clang_complete_macros = 1
let g:clang_jumpto_declaration_key = "<C-]>"

" Haskell:
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1
augroup haskell_complete
  autocmd!
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

" Rust:
" rustup install racer
let g:racer_cmd = $HOME . '/.cargo/bin/racer'
" rustup component add rust-src
let $RUST_SRC_PATH = $HOME .
      \'/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/' .
      \'lib/rustlib/src/rust/src'
let g:racer_experimental_completer = 1
augroup rust_complete
  autocmd!
  " needs to be nmap; does not work with nnoremap
  autocmd FileType rust nmap <buffer> <C-]> <Plug>(rust-def)
augroup END

" Writing: writing document
" currently only supports markdown
" jump to word definition for several text editors (including markdown)
augroup writing_complete
  autocmd FileType markdown,tex,rst,txt nnoremap <buffer> <C-]> :Def <cword><CR>
augroup END

" Terraform
augroup terraform_complete
  autocmd FileType terraform setlocal omnifunc=terraformcomplete#Complete
augroup END

"  }}}
"  NERDTree --- {{{

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

"  }}}
"  Vim Ale --- {{{

" Vim Ale:
"Limit linters used for JavaScript.
let g:ale_linters = {
      \   'javascript': ['eslint', 'flow'],
      \   'python': ['pylint', 'mypy']
      \}
" highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
" highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '?'
let g:ale_statusline_format = ['X %d', '? %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'
" turn off ale on open, turn on with Toggle
let g:ale_enabled = 0
" only run on save
" let g:ale_lint_on_text_changed = 'never' -- not using currently, because
" we can toggle ALE on and off with space at
" Map keys to navigate between lines with errors and warnings.

augroup mapping_ale_fix
  autocmd FileType python,javascript,javascript.jsx,
        \ nnoremap  <space>ap :ALEPreviousWrap<cr> |
        \ nnoremap  <space>an :ALENextWrap<cr> |
        \ nnoremap  <space>at :ALEToggle<cr>
augroup END
" }}}
"  Vim Filetype Formatter --- {{{

" " code formatting, thanks sam
" let g:vim_filetype_formatter_verbose = 1
let g:vim_filetype_formatter_commands = {
      \ 'python': 'black - -q --line-length 79',
      \ 'javascript': 'npx prettier --parser flow --stdin',
      \ 'javascript.jsx': 'npx prettier --parser flow --stdin',
      \ 'css': 'npx prettier --parser css --stdin',
      \ 'less': 'npx prettier --parser less --stdin',
      \ 'html': 'npx prettier --parser html --stdin',
      \}

augroup mapping_vim_filetype_formatter
  autocmd FileType python,javascript,javascript.jsx,css,less,json,html
        \ nnoremap <silent> <buffer> <leader>f :FiletypeFormat<cr>
augroup END

" }}}
" AutoPairs --- {{{
" AutoPairs:
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

"  }}}
" Ctrl P --- {{{

" move ctrl p up to last .git dir
let g:ctrlp_working_path_mode = 'rw' " start from cwd
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" open first in current window and others as hidden
let g:ctrlp_open_multiple_files = '1r'
let g:ctrlp_use_caching = 0

"  }}}
" close-tag {{{
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,javascript,javascript.jsx,jsx'

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
" Language Server Client {{{

" deoplete will asynchronously add autocompletion popups
" TODO: it's mildly annoying but the only thing that works with flow lsp
let g:deoplete#enable_at_startup = 1

" Excluding python in favor of jedi-vim \ 'python': ['pyls'],
let g:LanguageClient_serverCommands = {
      \ 'javascript': ['npx', 'flow', 'lsp'],
      \ 'javascript.jsx': ['npx', 'flow', 'lsp'],
      \ 'svelte': ['svelteserver'],
      \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_hoverPreview = 'Auto'
let g:LanguageClient_diagnosticsEnable = 0

function! ConfigureLanguageClient()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <C-]> :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <leader>sd :call LanguageClient#textDocument_hover()<CR>
    nnoremap <buffer> <leader>sr :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer> <leader>su :call LanguageClient#textDocument_references()<CR>
    setlocal omnifunc=LanguageClient#complete
  endif
endfunction

augroup language_servers
  autocmd FileType * call ConfigureLanguageClient()
augroup END

"  }}}
"  }}}
" Filetype specification ------------ {{{

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
  autocmd BufNewFile,BufRead,BufEnter *.cfg,*.ini,.coveragerc,.pylintrc
        \ set filetype=dosini
  autocmd BufNewFile,BufRead,BufEnter *.tsv set filetype=tsv
  autocmd BufNewFile,BufRead,BufEnter Dockerfile.* set filetype=Dockerfile
  autocmd BufNewFile,BufRead,BufEnter Makefile.* set filetype=make
  autocmd BufNewFile,BufRead,BufEnter *.groovy  set filetype=groovy
augroup END


" }}}
" Indentation (tabs, spaces, width, etc)------------- {{{

" Note -> apparently BufRead, BufNewFile trumps Filetype
" Eg, if BufRead,BufNewFile * ignores any Filetype overwrites
" This is why default settings are chosen with Filetype *
augroup indentation_sr
  autocmd!
  autocmd Filetype * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8
  autocmd Filetype yaml setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
  autocmd Filetype python,c,elm,haskell,markdown,rust,rst,kv,nginx
        \ setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype dot setlocal autoindent cindent
  autocmd Filetype make,tsv,votl,go
        \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
  " Prevent auto-indenting from occuring
  autocmd Filetype yaml setlocal indentkeys-=<:>
augroup END

" }}}
" Writing (non-coding)------------------ {{{

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
" Folding Settings --------------- {{{

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
" Trailing whitespace ------------- {{{

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
" Syntax highlighting ---------------- {{{

" Papercolor: options
let g:PaperColor_Theme_Options = {
      \   'theme' : {
      \     'default': {
      \       'transparent_background': 1,
      \       'override': {
      \         'folded_fg' : ['#00ff00', ''],
      \         'folded_bg' : ['#585858', ''],
      \       }
      \     }
      \   }
      \ }
let g:PaperColor_Theme_Options['language'] = {
      \   'python': {
      \     'highlight_builtins' : 1
      \   }
      \ }

let g:vim_jsx_pretty_colorful_config = 1

" Python: Highlight self and cls keyword in class definitions
augroup python_syntax
  autocmd!
  autocmd FileType python syn keyword pythonBuiltinObj self
  autocmd FileType python syn keyword pythonBuiltinObj cls
augroup end

" Javascript: Highlight this keyword in object / function definitions
augroup javascript_syntax
  autocmd!
  autocmd FileType javascript syn keyword jsBooleanTrue this
  autocmd FileType javascript.jsx syn keyword jsBooleanTrue this
augroup end

" Syntax: select global syntax scheme
" Make sure this is at end of section
try
  set t_Co=256 " says terminal has 256 colors
  set background=dark
  colorscheme PaperColor
catch
endtry

" }}}
" Key remappings ----------------------- {{{
"
" Omnicompletion:
" <C-@> is signal sent by terminal when pressing <C-Space>
" Need to include <C-Space> as well for neovim sometimes
inoremap <C-@> <C-x><C-o>
inoremap <C-space> <C-x><C-o>

" Emacs:
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A

" Paste:
inoremap <C-v> <esc>p

" Escape:
" Make escape also clear highlighting
nnoremap <silent> <esc> :noh<return><esc>

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
" Sometimes we want to set some filetypes due to annoying behavior of plugins
" The following mappings make it easier to chage javascript plugin behavior
nnoremap <leader>jx :set filetype=javascript.jsx<CR>
nnoremap <leader>jj :set filetype=javascript<CR>

" TogglePluginWindows:
nnoremap <silent> <space>j :NERDTreeToggle<CR>
nnoremap <silent> <space>J :call NERDTreeToggleCustom()<CR>

" nnoremap <silent> <space>l :TagbarToggle <CR> no use for these yet
" nnoremap <silent> <space>u :UndotreeToggle<CR>

" NERDTree: Jump to current file
nnoremap <silent> <space>k :NERDTreeFind<cr>

" AutoPairs:
imap <silent><CR> <CR><Plug>AutoPairsReturn

" }}}
" Cleanup ------------------ {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless they’re owned by you.
set secure

" ShowCommand: turn off character printing to vim status line
set noshowcmd

" }}}
