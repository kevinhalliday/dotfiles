" Make typing more fun.

" General: Leader mappings {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}
" General: Global config {{{

function! AlacrittySetBackground()
  let g:alacritty_background = system('alacritty-which-colorscheme')
  if !v:shell_error
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
  " don't give |ins-completion-menu| messages; they're noisy
  set shortmess+=c

  " Hidden Buffer: enable instead of having to write each buffer
  set hidden

  " Sign Column: always show it
  set signcolumn=yes

  " Mouse: enable GUI mouse support in all modes
  set mouse=a

  " SwapFiles: prevent their creation
  set nobackup
  set nowritebackup
  set noswapfile

  " Command Line Height: higher for display for messages
  set cmdheight=2

  " Line Wrapping: do not wrap lines by default
  set nowrap

  " Highlight Search: do that
  set incsearch
  set inccommand=nosplit
  augroup incsearch_highlight
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
  set updatetime=300

  " Linux Dev Path: system libraries
  set path+=/usr/include/x86_64-linux-gnu/

  " Path: add node_modules for neomake / other stuff
  let $PATH = $PWD . '/node_modules/.bin:' . $PATH

  " Vim History: for command line; can't imagine that more than 100 is needed
  set history=100
endfunction
call SetGlobalConfig()


" }}}
" General: Plugin Install {{{

call plug#begin('~/.vim/plugged')

" Copilot
Plug 'github/copilot.vim'

" Fonts
Plug 'ryanoasis/vim-devicons'

" Repls
Plug 'pappasam/nvim-repl'

" Commands run in vim's virtual screen and don't pollute main shell
Plug 'fcpg/vim-altscreen'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" TreeSitter:
Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }
Plug 'nvim-treesitter/playground'

" File Navigation
Plug 'kh3phr3n/tabline'
Plug 'Shougo/defx.nvim'
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
Plug 'airblade/vim-rooter' " bse vim root at github root
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Tim Pope: general, uncategorizable tim pope plugins
" Notes:
"   * abolish: convert to snake cases
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-rsi'

" Auto-Completion and Diagnostics
" \ 'iamcco/coc-spell-checker',
Plug 'neoclide/coc.nvim', {'branch': 'release'}
for coc_plugin in [
      \ 'coc-extensions/coc-svelte',
      \ 'fannheyward/coc-markdownlint',
      \ 'pappasam/coc-jedi',
      \ 'neoclide/coc-css',
      \ 'neoclide/coc-html',
      \ 'neoclide/coc-json',
      \ 'neoclide/coc-yaml',
      \ 'neoclide/coc-rls',
      \ 'pappasam/coc-jedi',
      \ 'neoclide/coc-snippets',
      \ 'neoclide/coc-tsserver',
      \ 'neoclide/coc-eslint',
      \ 'neoclide/coc-pairs',
      \ 'iamcco/coc-diagnostic',
      \ 'iamcco/coc-vimlsp',
      \ 'josa42/coc-docker',
      \ 'josa42/coc-sh',
      \ 'pantharshit00/coc-prisma',
      \ ]
  Plug coc_plugin, { 'do': 'yarn install --frozen-lockfile && yarn build' }
endfor

" Writing
Plug 'junegunn/limelight.vim' " highlight text (for Goyo)
Plug 'junegunn/goyo.vim' " Distraction-free writing

" Basic coloring
" Plug 'NLKNguyen/papercolor-theme'
Plug 'pappasam/papercolor-theme-slim'

" Previewers
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" Utils
Plug 'windwp/nvim-ts-autotag'
Plug 'tpope/vim-surround'
Plug 'ckarnell/Antonys-macro-repeater'
Plug 'wincent/ferret' " multi file search
Plug 'dkarter/bullets.vim'

" Syntax highlighting
Plug 'pantharshit00/vim-prisma'
Plug 'hashivim/vim-terraform'
Plug 'tomlion/vim-solidity'
Plug 'jparise/vim-graphql'
Plug 'chr4/nginx.vim'
Plug 'khalliday7/Jenkinsfile-vim-syntax'
Plug 'rdolgushin/groovy.vim'
Plug 'jxnblk/vim-mdx-js'

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
" General: Status Line and Tab Line {{{

function! SetStatusAndTabLine()
  " Tab Line
  set tabline=%t

  " Status Line
  set laststatus=2
  set statusline=
  set statusline+=\ %{mode()}\  " spaces after mode
  set statusline+=%#CursorLine#
  set statusline+=\   " space
  set statusline+=%{&paste?'[PASTE]':''}
  set statusline+=%{&spell?'[SPELL]':''}
  set statusline+=%r
  set statusline+=%m
  set statusline+=%{get(b:,'gitbranch','')}
  set statusline+=\   " space
  set statusline+=%*  " default color
  set statusline+=\ %t  " tailed filename
  set statusline+=%=
  set statusline+=%n  " buffer number
  set statusline+=\ %y\  " file type
  set statusline+=%#CursorLine#
  set statusline+=\ %{&ff}\  " Unix or Dos
  set statusline+=%*  " default color
  set statusline+=\ %{strlen(&fenc)?&fenc:'none'}\  " file encoding
endfunction
call SetStatusAndTabLine()

" Status Line
augroup statusline_local_overrides
  autocmd!
  autocmd FileType defx setlocal statusline=\ defx\ %#CursorLine#
augroup END

" Strip newlines from a string
function! StripNewlines(instring)
  return substitute(a:instring, '\v^\n*(.{-})\n*$', '\1', '')
endfunction

augroup custom_statusline
  autocmd!
  autocmd FileType defx setlocal statusline=\ defx\ %#CursorLine#
augroup end

augroup custom_cursorline
  autocmd!
  autocmd FileType tagbar,defx,qf setlocal cursorline
augroup end

" }}}
" General: Filetype specification {{{
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
  autocmd BufNewFile,BufRead,BufEnter *.svelte, set filetype=svelte
  autocmd BufNewFile,BufRead,BufEnter *.cfg,*.ini,.coveragerc,.pylintrc
        \ set filetype=dosini
  autocmd BufNewFile,BufRead,BufEnter *.tsv set filetype=tsv
  autocmd BufNewFile,BufRead,BufEnter Dockerfile.* set filetype=Dockerfile
  autocmd BufNewFile,BufRead,BufEnter Makefile.* set filetype=make
  autocmd BufNewFile,BufRead,BufEnter *.groovy  set filetype=groovy
  autocmd BufNewFile,BufRead,BufEnter *.vue  set filetype=vue
  autocmd BufNewFile,BufRead,BufEnter *.rs  set filetype=rust
  autocmd BufNewFile,BufRead,BufEnter *.prisma  set filetype=prisma
  autocmd BufNewFile,BufRead,BufEnter .eslintrc.json,tsconfig.json  set filetype=jsonc
augroup END


" }}}
" General: Comment / Text Format Options {{{

" Notes:
" commentstring: read by vim-commentary; must be one template
" comments: csv of comments.
" formatoptions: influences how Vim formats text
"   ':help fo-table' will get the desired result
augroup custom_comment_config
  autocmd!
  autocmd FileType dosini
        \ setlocal commentstring=#\ %s comments=:#,:;
  autocmd FileType jsonc
        \ setlocal commentstring=//\ %s comments=:// formatoptions=jcroql
  autocmd FileType sh setlocal formatoptions=jcroql
  autocmd FileType typescript.tsx,typescript,typescriptreact
        \ setlocal commentstring=//\ %s
  autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
augroup END
        " \ setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

" }}}
" General: Indentation (tabs, spaces, width, etc) {{{

" Note -> apparently BufRead, BufNewFile trumps Filetype
" Eg, if BufRead,BufNewFile * ignores any Filetype overwrites
" This is why default settings are chosen with Filetype *
set expandtab shiftwidth=2 softtabstop=2 tabstop=8
augroup indentation_sr
  autocmd!
  autocmd Filetype python,c,haskell,rust,rst,kv,nginx,asm,nasm,gdscript3
        \ setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype dot setlocal autoindent cindent
  autocmd Filetype make,tsv,votl,go,gomod
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
" General: ColorColumn different widths for different filetypes {{{

set colorcolumn=80
augroup colorcolumn_configuration
  autocmd!
  autocmd FileType gitcommit setlocal colorcolumn=73 textwidth=72
  autocmd Filetype html,text,markdown,rst setlocal colorcolumn=0
augroup END

" }}}
" General: Writing (non-coding) {{{

function! s:abolish_correct()
  " Started from:
  " https://github.com/tpope/tpope/blob/94b1f7c33ee4049866f0726f96d9a0fb5fdf868f/.vim/after/plugin/abolish_tpope.vim
  if !exists('g:loaded_abolish')
    echom 'Abolish does not exist, skipping...'
    return
  endif
  Abolish Lidsa                       Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  Abolish Tqbf                        The quick, brown fox jumps over the lazy dog
  Abolish adn                         and
  Abolish afterword{,s}               afterward{}
  Abolish anomol{y,ies}               anomal{}
  Abolish austrail{a,an,ia,ian}       austral{ia,ian}
  Abolish cal{a,e}nder{,s}            cal{e}ndar{}
  Abolish delimeter{,s}               delimiter{}
  Abolish despara{te,tely,tion}       despera{}
  Abolish destionation{,s}            destination{}
  Abolish d{e,i}screp{e,a}nc{y,ies}   d{i}screp{a}nc{}
  Abolish euphamis{m,ms,tic,tically}  euphemis{}
  Abolish hense                       hence
  Abolish hte                         the
  Abolish improvment{,s}              improvement{}
  Abolish inherant{,ly}               inherent{}
  Abolish lastest                     latest
  Abolish nto                         not
  Abolish nto                         not
  Abolish ot                          to
  Abolish persistan{ce,t,tly}         persisten{}
  Abolish rec{co,com,o}mend{,s,ed,ing,ation} rec{om}mend{}
  Abolish referesh{,es}               refresh{}
  Abolish reproducable                reproducible
  Abolish resouce{,s}                 resource{}
  Abolish restraunt{,s}               restaurant{}
  Abolish scflead                     supercalifragilisticexpialidocious
  Abolish segument{,s,ed,ation}       segment{}
  Abolish seperat{e,es,ed,ing,ely,ion,ions,or} separat{}
  Abolish si                          is
  Abolish teh                         the
  Abolish {,in}consistan{cy,cies,t,tly} {}consisten{}
  Abolish {,ir}releven{ce,cy,t,tly}   {}relevan{}
  Abolish {,non}existan{ce,t}         {}existen{}
  Abolish {,re}impliment{,s,ing,ed,ation} {}implement{}
  Abolish {,un}nec{ce,ces,e}sar{y,ily} {}nec{es}sar{}
  Abolish {,un}orgin{,al}             {}origin{}
  Abolish {c,m}arraige{,s}            {}arriage{}
  Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or} {despe,sepa}rat{}
  Abolish {les,compar,compari}sion{,s} {les,compari,compari}son{}
  Abolish healtcheck                  healthcheck
endfunction

" what is textobj#sentence#init?
" autocmd FileType markdown,rst,text,gitcommit
"       \ setlocal wrap linebreak nolist
"       \ | call textobj#sentence#init()
augroup writing
  autocmd!
  autocmd VimEnter * call s:abolish_correct()
  autocmd FileType markdown,rst,text,gitcommit setlocal wrap linebreak nolist
  autocmd FileType requirements setlocal nospell
  autocmd BufNewFile,BufRead *.html,*.tex setlocal wrap linebreak nolist
  autocmd FileType markdown nnoremap <buffer> <leader>f :TableFormat<CR>
augroup END

" }}}
" General: Folding Settings {{{

augroup fold_settings
  autocmd!
  autocmd FileType vim,tmux,bash,zsh,sh
        \ setlocal foldmethod=marker foldlevelstart=0 foldnestmax=1
  autocmd FileType markdown,rst
        \ setlocal nofoldenable
augroup END

" }}}
" General: Trailing whitespace {{{

function! s:trim_whitespace()
  let l:save = winsaveview()
  if &ft == 'markdown'
    " Replace lines with only trailing spaces
    %s/^\s\+$//e
    " Replace lines with exactly one trailing space with no trailing spaces
    %g/\S\s$/s/\s$//g
    " Replace lines with more than 2 trailing spaces with 2 trailing spaces
    %s/\s\s\s\+$/  /e
  else
    " Remove all trailing spaces
    %s/\s\+$//e
  endif
  call winrestview(l:save)
endfunction

command! TrimWhitespace call <SID>trim_whitespace()

augroup fix_whitespace_save
  autocmd!
  autocmd BufWritePre * TrimWhitespace
augroup END

" }}}
" General: Syntax highlighting {{{

" Python: Highlight args and kwargs, since they are conventionally special
augroup python_syntax
  autocmd!
  autocmd FileType python syntax keyword pythonBuiltinObj args
  autocmd FileType python syntax keyword pythonBuiltinObj kwargs
  autocmd FileType python syntax keyword pythonBuiltinObj self
augroup end

" Javascript: Highlight this keyword in object / function definitions
augroup javascript_syntax
  autocmd!
  autocmd FileType javascript syntax keyword jsBooleanTrue this
  autocmd BufEnter * :syntax sync fromstart
augroup end

" Typescript: fixes
augroup typescript_syntax
  autocmd!
  autocmd ColorScheme * highlight link typescriptExceptions Exception
  autocmd BufEnter * :syntax sync fromstart
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
  colorscheme PaperColorSlim
catch
  echo 'An error occured while configuring PaperColor'
endtry

" }}}
" General: Resize Window {{{

" WindowWidth: Resize window to a couple more than longest line
" modified function from:
" https://stackoverflow.com/questions/2075276/longest-line-in-vim
function! s:resize_window_width()
  normal! m`
  let maxlength   = 0
  let linenumber  = 1
  while linenumber <= line('$')
    exe ':' . linenumber
    let linelength  = virtcol('$')
    if maxlength < linelength
      let maxlength = linelength
    endif
    let linenumber  = linenumber+1
  endwhile
  exe ':vertical resize ' . (maxlength + 4)
  normal! ``
endfunction

function! s:resize_window_height()
  normal! m`
  let initial = winnr()

  " this duplicates code but avoids polluting global namespace
  wincmd k
  if winnr() != initial
    execute initial . 'wincmd w'
    1
    execute 'resize ' . (line('$') + 1)
    normal! ``
    return
  endif

  wincmd j
  if winnr() != initial
    execute initial . 'wincmd w'
    1
    execute 'resize ' . (line('$') + 1)
    normal! ``
    return
  endif
endfunction

command! ResizeWindowWidth call <SID>resize_window_width()
command! ResizeWindowHeight call <SID>resize_window_height()

" }}}
" General: Clean Unicode {{{

" Replace unicode symbols with cleaned, ascii versions
function! s:clean_unicode()
  silent! %s/”/"/g
  silent! %s/“/"/g
  silent! %s/’/'/g
  silent! %s/‘/'/g
  silent! %s/—/-/g
  silent! %s/…/.../g
endfunction()
command! CleanUnicode call <SID>clean_unicode()

" }}}
" General: Neovim Terminal {{{

function! s:open_term_interactive(view_type)
  execute a:view_type
  terminal
  setlocal nonumber nornu
  startinsert
endfunction

command! Term call s:open_term_interactive('vsplit')
command! VTerm call s:open_term_interactive('vsplit')
command! STerm call s:open_term_interactive('split')
command! Tterm call s:open_term_interactive('tabnew')


" }}}
" General: Language builder / runner {{{

let s:language_builders = {
      \ 'rust': 'rustc %',
      \ 'go': 'go build %',
      \ }

let s:language_runners = {
      \ 'rust': '%:p:r',
      \ 'go': 'go run %',
      \ 'python': 'python %',
      \ }

function! s:code_term_cmd(str_command)
  silent only
  write
  if &columns >= 160
    vsplit
  else
    belowright split
  endif
  execute 'terminal ' . a:str_command
  nnoremap <buffer> q :bd!<CR>
  cnoremap <buffer> q bd!
  wincmd w
endfunction

" Build source code
function! s:code_build()
  if !has_key(s:language_builders, &filetype)
    echo 'Build not configured for filetype "' . &filetype . '"'
    return
  endif
  call s:code_term_cmd(s:language_builders[&filetype])
endfunction

" Run source code
function! s:code_run()
  let filepath = expand('%:p')
  if executable(filepath) == 1
    call s:code_term_cmd(filepath)
  elseif !has_key(s:language_runners, &filetype)
    echo 'Run not configured for filetype "' . &filetype . '"'
  else
    call s:code_term_cmd(s:language_runners[&filetype])
  endif
endfunction

command! Build call <SID>code_build()
command! Run call <SID>code_run()

" }}}
" General: View available colors {{{

" From https://vim.fandom.com/wiki/View_all_colors_available_to_gvim
" There are some sort options at the end you can uncomment to your preference
"
" Create a new scratch buffer:
" - Read file $VIMRUNTIME/rgb.txt
" - Delete lines where color name is not a single word (duplicates).
" - Delete 'grey' lines (duplicate 'gray'; there are a few more 'gray').
" Add syntax so each color name is highlighted in its color.
function! s:vim_colors()
  vnew
  set modifiable
  setlocal filetype=vimcolors buftype=nofile bufhidden=delete noswapfile
  0read $VIMRUNTIME/rgb.txt
  let find_color = '^\s*\(\d\+\s*\)\{3}\zs\w*$'
  silent execute 'v/'.find_color.'/d'
  silent g/grey/d
  let namedcolors=[]
  1
  while search(find_color, 'W') > 0
    let w = expand('<cword>')
    call add(namedcolors, w)
  endwhile
  for w in namedcolors
    execute 'hi col_'.w.' guifg=black guibg='.w
    execute 'hi col_'.w.'_fg guifg='.w.' guibg=NONE'
    execute '%s/\<'.w.'\>/'.printf("%-36s%s", w, w.'_fg').'/g'
    execute 'syn keyword col_'.w w
    execute 'syn keyword col_'.w.'_fg' w.'_fg'
  endfor
  " Add hex value column (and format columns nicely)
  %s/^\s*\(\d\+\)\s\+\(\d\+\)\s\+\(\d\+\)\s\+/\=printf(" %3d %3d %3d   #%02x%02x%02x   ", submatch(1), submatch(2), submatch(3), submatch(1), submatch(2), submatch(3))/
  1
  nohlsearch
  nnoremap <buffer> d <C-d>
  nnoremap <buffer> u <C-u>
  file VimColors
  set nomodifiable
endfunction

command! VimColors silent call <SID>vim_colors()

" }}}
" General: Toggle numbers {{{

function! s:toggle_number()
  if &number == 0
    set number
  else
    set nonumber
  endif
endfunction

function! s:toggle_relative_number()
  if &relativenumber == 0
    set relativenumber
  else
    set norelativenumber
  endif
endfunction

command! ToggleNumber call <SID>toggle_number()
command! ToggleRelativeNumber call <SID>toggle_relative_number()

" }}}
" General: spacesurround {{{
" Helper functions to format surrounding text as I type
" The function is: Surround<Key>, where key is the intended mapping key
" 1. Add two spaces around cursor when pressing space bar.
" 2. Spaces will be deleted if cursor is in middle with 1 space on either side.
"     For example: ( | ), pressing <bs> or <c-w> should delete surrounding
"     spaces
let s:surround_spaces = {
      \ '()': 1,
      \ '[]': 1,
      \ '{}': 1,
      \ }
function! SurroundSpace()
  let char_left = getline('.')[col('.') - 2]
  let char_right = getline('.')[col('.') - 1]
  let left_right = char_left . char_right
  if has_key(s:surround_spaces, left_right)
    call feedkeys("\<space>\<space>\<left>", 'ni')
  else
    call feedkeys("\<space>", 'ni')
  endif
endfunction
" delete surround items if surrounding cursor with no space
" for example: (|)
" when pressing delete, surrounding parentheses will be deleted
let s:surround_delete = {
      \ "''": 1,
      \ '""': 1,
      \ '()': 1,
      \ '<>': 1,
      \ '[]': 1,
      \ '{}': 1,
      \ }
function! SurroundBackspace()
  let char_left = getline('.')[col('.') - 3]
  let char_left_mid = getline('.')[col('.') - 2]
  let char_right_mid = getline('.')[col('.') - 1]
  let char_right = getline('.')[col('.')]
  let mid_left_right = char_left_mid . char_right_mid
  let left_right = char_left . char_right
  if has_key(s:surround_delete, mid_left_right)
    call feedkeys("\<bs>\<right>\<bs>", 'ni')
  elseif mid_left_right != '  '
    call feedkeys("\<bs>", 'ni')
  elseif has_key(s:surround_spaces, left_right)
    execute "normal! \<right>di" . left_right[1]
  else
    call feedkeys("\<bs>", 'ni')
  endif
endfunction
function! SurroundCw()
  let char_left = getline('.')[col('.') - 3]
  let char_left_mid = getline('.')[col('.') - 2]
  let char_right_mid = getline('.')[col('.') - 1]
  let char_right = getline('.')[col('.')]
  let mid_left_right = char_left_mid . char_right_mid
  let left_right = char_left . char_right
  if has_key(s:surround_delete, mid_left_right)
    call feedkeys("\<bs>\<right>\<bs>", 'ni')
  elseif mid_left_right != '  '
    call feedkeys("\<c-w>", 'ni')
  elseif has_key(s:surround_spaces, left_right)
    execute "normal! \<right>di" . left_right[1]
  else
    call feedkeys("\<c-w>", 'ni')
  endif
endfunction

" }}}
" Plugin: Vim-Plug: {{{
" Plug update and upgrade
function! _PU()
  exec 'PlugUpdate'
  exec 'PlugUpgrade'
endfunction
command! PU call _PU()

"  }}}
"  Plugin: Vim Filetype Formatter {{{

" code formatting, thanks sam
" let g:vim_filetype_formatter_verbose = 1
let g:vim_filetype_formatter_commands = {
      \ 'python': 'black - -q --line-length 79',
      \ 'javascript': 'npx -q prettier --parser typescript',
      \ 'javascript.jsx': 'npx -q prettier typescript',
      \ 'typescript': 'npx -q prettier --parser typescript',
      \ 'typescript.tsx': 'npx -q prettier --parser typescript',
      \ 'typescriptreact': 'npx -q prettier --parser typescript',
      \ 'svelte': 'npx -q prettier',
      \ 'css': 'npx -q prettier --parser css',
      \ 'less': 'npx -q prettier --parser less',
      \ 'html': 'npx -q prettier --parser html',
      \ 'vue': 'npx -q prettier --html-whitespace-sensitivity ignore --parser vue'
      \}

nnoremap <leader>f :FiletypeFormat<cr>
vnoremap <leader>f :FiletypeFormat<cr>

" }}}
" Plugin: Fzf {{{

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
  let l:fzf_command = 'rg --files --no-ignore --no-messages --hidden --follow --glob "!.git/*" ~'
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


" }}}
" Plugin: Tagbar {{{

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
" Plugin: COC {{{

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup Smartf
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
augroup end

" Customization:
" function! s:coc_diagnostic_disable()
"   call coc#config('diagnostic.enable', v:false)
"   let g:coc_custom_diagnostic_enabled = v:false
"   silent CocRestart
"   echom 'Disabled: Coc Diagnostics'
" endfunction

" function! s:coc_diagnostic_enable()
"   call coc#config('diagnostic.enable', v:true)
"   let g:coc_custom_diagnostic_enabled = v:true
"   echom 'Enabled: Coc Diagnostics'
" endfunction

" function! s:coc_diagnostic_toggle()
"   if g:coc_custom_diagnostic_enabled == v:true
"     call s:coc_diagnostic_disable()
"   else
"     call s:coc_diagnostic_enable()
"   endif
" endfunction

" function! s:coc_init()
"   let g:coc_custom_diagnostic_enabled = v:true
" endfunction

" augroup coc_initialization
"   autocmd!
"   autocmd VimEnter * call s:coc_init()
" augroup END

" command! CocDiagnosticToggle call s:coc_diagnostic_toggle()
" command! CocDiagnosticEnable call s:coc_diagnostic_enable()
" command! CocDiagnosticDisable call s:coc_diagnostic_disable()

" }}}
" Plugin: Restructured Text {{{

" Vim Rst Sections: documentation
" -----------------------------------------------------------------------
" Shortcuts:
" press your *leader* key followed by *s* and then:
"   * a number from 0 to 6 to set the section level (RstSetSection(level))
"   * k or j to jump to the previuos or next section
"   * a or x to increase or decrease the section level
"   * l to labelize

" Conventional Markup Hierarchy:
"   1. # with overline, for parts
"   2. * with overline, for chapters
"   3. =, for sections
"   4. -, for subsections
"   5. ^, for subsubsections
"   6. ", for paragraphs

" Source: https://stackoverflow.com/a/30772902
function! LineMatchCount(pat,...)
  " searches for pattern matches in the active buffer, with optional start and
  " end line number specifications

  " useful command-line for testing against last-used pattern within last-used
  " visual selection: echo LineMatchCount(@/,getpos("'<")[1],getpos("'>")[1])

  if (a:0 > 2) | echoerr 'too many arguments for function: LineMatchCount()'
        \ | return| endif
  let start = a:0 >= 1 ? a:000[0] : 1
  let end = a:0 >= 2 ? a:000[1] : line('$')
  "" validate args
  if (type(start) != type(0))
        \ | echoerr 'invalid type of argument: start' | return | endif
  if (type(end) != type(0))
        \ | echoerr 'invalid type of argument: end' | return | endif
  if (end < start)| echoerr 'invalid arguments: end < start'| return | endif
  "" save current cursor position
  let wsv = winsaveview()
  "" set cursor position to start (defaults to start-of-buffer)
  call setpos('.',[0,start,1,0])
  "" accumulate line count in local var
  let lineCount = 0
  "" keep searching until we hit end-of-buffer
  let ret = search(a:pat,'cW')
  while (ret != 0)
    " break if the latest match was past end; must do this prior to
    " incrementing lineCount for it, because if the match start is past end,
    " it's not a valid match for the caller
    if (ret > end)
      break
    endif
    let lineCount += 1
    " always move the cursor to the start of the line following the latest
    " match; also, break if we're already at end; otherwise next search would
    " be unnecessary, and could get stuck in an infinite loop if end ==
    " line('$')
    if (ret == end)
      break
    endif
    call setpos('.',[0,ret+1,1,0])
    let ret = search(a:pat,'cW')
  endwhile
  "" restore original cursor position
  call winrestview(wsv)
  "" return result
  return lineCount
endfunction

command! HovercraftSlide echo 'Slide ' . LineMatchCount('^----$', 1, line('.'))

augroup rst_overrides
  autocmd!
  autocmd FileType rst nnoremap <buffer> <leader>w :HovercraftSlide<CR>
  autocmd FileType rst nnoremap <buffer> <leader>f :TableRstFormat<CR>
augroup END

let g:no_rst_sections_maps = 0

augroup rst_sections_mappings
  autocmd!
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s0 :call RstSetSection('0')<cr>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s1 :call RstSetSection('1')<cr>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s2 :call RstSetSection(2)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s3 :call RstSetSection(3)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s4 :call RstSetSection(4)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s5 :call RstSetSection(5)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>s6 :call RstSetSection(6)<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sk :call RstGoPrevSection()<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sj :call RstGoNextSection()<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sa :call RstIncrSectionLevel()<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sx :call RstDecrSectionLevel()<CR>
  autocmd FileType rst nnoremap <buffer> <silent> <leader>sl :call RstSectionLabelize()<CR>
augroup END

" }}}
" Plugin: Markdown-preview.vim {{{

let g:mkdp_auto_start = v:false
let g:mkdp_auto_close = v:false

" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = v:false

" set to 1, the MarkdownPreview command can be use for all files,
" by default it just can be use in markdown file
" default: 0
let g:mkdp_command_for_global = v:false

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle'
      \ }

" }}}
" Plugin: vimtext {{{
  let g:tex_flavor = 'latex'
" }}}
" Plugins: nvim-repl {{{

let g:repl_filetype_commands = {
      \ 'bash': 'bash',
      \ 'javascript': 'node',
      \ 'typescript': 'npx ts-node',
      \ 'python': 'bpython -q',
      \ 'sh': 'sh',
      \ 'vim': 'nvim --clean -ERZM',
      \ 'zsh': 'zsh',
      \ }

let g:repl_default = &shell

" }}}
" Plugin: Preview Compiled Stuff in Viewer {{{

function! s:preview()
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

command! Preview call <SID>preview()

" }}}
"  Plugin: Miscellaneous Configuration {{{

" Python: highlighting
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1

" change color of preview window
" highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000

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

"  }}}
"  Plugin: defx {{{

let g:custom_defx_state = tempname()

let g:defx_ignored_files = join([
      \ '*.aux',
      \ '*.egg-info/',
      \ '*.o',
      \ '*.out',
      \ '*.pdf',
      \ '*.pyc',
      \ '*.toc',
      \ '.*',
      \ '__pycache__/',
      \ 'build/',
      \ 'dist/',
      \ 'docs/_build/',
      \ 'fonts/',
      \ 'node_modules/',
      \ 'pip-wheel-metadata/',
      \ 'plantuml-images/',
      \ 'site/',
      \ 'target/',
      \ 'venv.bak/',
      \ 'venv/',
      \ ], ',')

let g:custom_defx_mappings = [
      \ ['!             ', "defx#do_action('execute_command')"],
      \ ['*             ', "defx#do_action('toggle_select_all')"],
      \ [';             ', "defx#do_action('repeat')"],
      \ ['<2-LeftMouse> ', "defx#is_directory() ? defx#do_action('open_tree', 'toggle') : defx#do_action('drop')"],
      \ ['<C-g>         ', "defx#do_action('print')"],
      \ ['<C-h>         ', "defx#do_action('resize', 31)"],
      \ ['<C-i>         ', "defx#do_action('open_directory')"],
      \ ['<C-o>         ', "defx#do_action('cd', ['..'])"],
      \ ['<C-r>         ', "defx#do_action('redraw')"],
      \ ['<C-t>         ', "defx#do_action('open', 'tabe')"],
      \ ['<C-v>         ', "defx#do_action('open', 'vsplit')"],
      \ ['<C-x>         ', "defx#do_action('drop', 'split')"],
      \ ['<CR>          ', "defx#do_action('drop')"],
      \ ['<RightMouse>  ', "defx#do_action('cd', ['..'])"],
      \ ['O             ', "defx#do_action('open_tree', 'recursive:3')"],
      \ ['p             ', "defx#do_action('preview')"],
      \ ['a             ', "defx#do_action('toggle_select')"],
      \ ['cc            ', "defx#do_action('copy')"],
      \ ['cd            ', "defx#do_action('change_vim_cwd')"],
      \ ['i             ', "defx#do_action('toggle_ignored_files')"],
      \ ['ma            ', "defx#do_action('new_file')"],
      \ ['md            ', "defx#do_action('remove')"],
      \ ['mm            ', "defx#do_action('rename')"],
      \ ['o             ', "defx#is_directory() ? defx#do_action('open_tree', 'toggle') : defx#do_action('drop')"],
      \ ['P             ', "defx#do_action('paste')"],
      \ ['q             ', "defx#do_action('quit')"],
      \ ['ss            ', "defx#do_action('multi', [['toggle_sort', 'TIME'], 'redraw'])"],
      \ ['t             ', "defx#do_action('open_tree', 'toggle')"],
      \ ['u             ', "defx#do_action('cd', ['..'])"],
      \ ['x             ', "defx#do_action('execute_system')"],
      \ ['yy            ', "defx#do_action('yank_path')"],
      \ ['~             ', "defx#do_action('cd')"],
      \ ]

function! s:autocmd_custom_defx()
  if !exists('g:loaded_defx')
    return
  endif
  call defx#custom#column('filename', {
        \ 'min_width': 100,
        \ 'max_width': 100,
        \ })
endfunction

let g:defx_icons_column_length = 2

function! s:open_defx_if_directory()
  if !exists('g:loaded_defx')
    echom 'Defx not installed, skipping...'
    return
  endif
  if isdirectory(expand(expand('%:p')))
    Defx `expand('%:p')`
        \ -buffer-name=defx
        \ -columns=mark:git:indent:icons:filename:type:size:time
  endif
endfunction

function! s:defx_redraw()
  if !exists('g:loaded_defx')
    return
  endif
  call defx#redraw()
endfunction

function! s:defx_buffer_remappings() abort
  " Define mappings
  for [key, value] in g:custom_defx_mappings
    execute 'nnoremap <silent><buffer><expr> ' . key . ' ' . value
  endfor
  nnoremap <silent><buffer> ?
        \ :for [key, value] in g:custom_defx_mappings <BAR>
        \ echo '' . key . ': ' . value <BAR>
        \ endfor<CR>
endfunction

augroup custom_defx
  autocmd!
  autocmd VimEnter * call s:autocmd_custom_defx()
  autocmd BufEnter * call s:open_defx_if_directory()
  autocmd BufLeave,BufWinLeave \[defx\]* silent call defx#call_action('add_session')
augroup end

augroup custom_remap_defx
  autocmd!
  autocmd FileType defx call s:defx_buffer_remappings()
  autocmd FileType defx nmap     <buffer> <silent> gp <Plug>(defx-git-prev)
  autocmd FileType defx nmap     <buffer> <silent> gn <Plug>(defx-git-next)
  autocmd FileType defx nmap     <buffer> <silent> gs <Plug>(defx-git-stage)
  autocmd FileType defx nmap     <buffer> <silent> gu <Plug>(defx-git-reset)
  autocmd FileType defx nmap     <buffer> <silent> gd <Plug>(defx-git-discard)
  autocmd FileType defx nnoremap <buffer> <silent> <C-l> <cmd>ResizeWindowWidth<CR>
augroup end


"  }}}
"  Plugin: treesitter {{{

function s:init_treesitter()
  if !exists('g:loaded_nvim_treesitter')
    echom 'nvim-treesitter does not exist, skipping...'
    return
  endif
lua << EOF
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  textobjects = { enable = true },
  autotag = { enable = true  },
  ensure_installed = {
    'bash',
    'c',
    'css',
    'dockerfile',
    'go',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'lua',
    'python',
    'query',
    'rust',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'yaml',
}})
EOF
endfunction

augroup custom_treesitter
  autocmd!
  autocmd VimEnter * call s:init_treesitter()
augroup end

"  }}}
"  Plugin: copilot.vim {{{

let g:copilot_no_tab_map = v:true

"  }}}
" General: Key remappings {{{

" This is defined as a function to allow me to reset all my key remappings
" without needing to repeate myself. Useful with Goyo for now
function! DefaultKeyMappings()
  " Copilot
  imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")

  " Escape: also clears highlighting
  nnoremap <silent> <esc> :noh<return><esc>

  " Yank/Paste:
  inoremap <C-v> <C-o>p

  " J: basically, unmap in normal mode unless range explicitly specified
  nnoremap <silent> <expr> J v:count == 0 ? '<esc>' : 'J'

  " Exit: Preview, Help, QuickFix, and Location List
  inoremap <silent> <C-c> <Esc>:pclose <BAR> cclose <BAR> lclose <CR>a
  nnoremap <silent> <C-c> :pclose <BAR> cclose <BAR> lclose <CR>

  " InsertModeHelpers: Insert one line above after enter
  " Useful for ``` in markdown. Key code = Alt+Enter
  " inoremap <M-CR> <CR><C-o>O

  " MoveVisual: up and down visually only if count is specified before
  " Otherwise, you want to move up lines numerically e.g. ignore wrapped lines
  nnoremap <expr> k
        \ v:count == 0 ? 'gk' : 'k'
  vnoremap <expr> k
        \ v:count == 0 ? 'gk' : 'k'
  nnoremap <expr> j
        \ v:count == 0 ? 'gj' : 'j'
  vnoremap <expr> j
        \ v:count == 0 ? 'gj' : 'j'

  " MoveTabs: goto tab number. Same as Firefox
  nnoremap <A-1> 1gt
  nnoremap <A-2> 2gt
  nnoremap <A-3> 3gt
  nnoremap <A-4> 4gt
  nnoremap <A-5> 5gt
  nnoremap <A-6> 6gt
  nnoremap <A-7> 7gt
  nnoremap <A-8> 8gt
  nnoremap <A-9> 9gt

  " Substitute: replace word under cursor
  nnoremap <leader><leader>s yiw:%s/\<<C-R>0\>//gc<Left><Left><Left>
  vnoremap <leader><leader>s y:%s/<C-R>0//gc<Left><Left><Left>

  " IndentComma: placing commas one line down; usable with repeat operator '.'
  nnoremap <silent> <Plug>NewLineComma f,wi<CR><Esc>
        \:call repeat#set("\<Plug>NewLineComma")<CR>
  nmap <leader><CR> <Plug>NewLineComma

  " ToggleRelativeNumber: uses custom functions
  nnoremap <silent> <leader>R :ToggleNumber<CR>
  nnoremap <silent> <leader>r :ToggleRelativeNumber<CR>

    " TogglePluginWindows:
  nnoremap <silent> <space>j <cmd>Defx
        \ -buffer-name=defx
        \ -columns=mark:git:indent:icons:filename:type
        \ -direction=topleft
        \ -search=`expand('%:p')`
        \ -session-file=`g:custom_defx_state`
        \ -ignored-files=`g:defx_ignored_files`
        \ -split=vertical
        \ -toggle
        \ -floating-preview
        \ -vertical-preview
        \ -preview-height=50
        \ -winwidth=31
        \ <CR>
  nnoremap <silent> <space>J <cmd>Defx `expand('%:p:h')`
        \ -buffer-name=defx
        \ -columns=mark:git:indent:icons:filename:type
        \ -direction=topleft
        \ -search=`expand('%:p')`
        \ -ignored-files=`g:defx_ignored_files`
        \ -split=vertical
        \ -floating-preview
        \ -vertical-preview
        \ -preview-height=50
        \ -winwidth=31
        \ <CR>
  nnoremap <silent> <space>l <cmd>TagbarToggle <CR>
  nnoremap <silent> <space>u <cmd>UndotreeToggle<CR>

  " Choosewin: (just like tmux)
  " nnoremap <C-w>q :ChooseWin<CR>

  " Goyo And Writing:
  nnoremap <leader><leader>g :Goyo<CR>
  nnoremap <leader><leader>l :Limelight!!<CR>
  nmap <leader><leader>v <Plug>Veil

  " IndentLines: toggle if indent lines is visible
  nnoremap <silent> <leader>i :IndentLinesToggle<CR>

  " ResizeWindow: up and down; relies on custom functions
  nnoremap <silent> <leader><leader>h :ResizeWindowHeight<CR>
  nnoremap <silent> <leader><leader>w :ResizeWindowWidth<CR>

  " DeleteHiddenBuffers: shortcut to make this easier
  " note: weird stuff happens if you mess this up
  " nnoremap <leader>d :DeleteInactiveBuffers<CR>

  " Jumping To Header File:
  " nnoremap gh :call CurtineIncSw()<CR>

  " SearchBackward: remap comma to single quote
  nnoremap ' ,

  " FiletypeFormat: remap leader f to do filetype formatting
  nnoremap <leader>f :FiletypeFormat<cr>
  vnoremap <leader>f :FiletypeFormat<cr>

  " Open Browser: override netrw
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)

  " Run Or Build:
  nnoremap <leader><leader>r :Run<CR>

   " Coc: settings for coc.nvim
  nmap     <silent>        <C-]> <Plug>(coc-definition)
  nmap     <silent>        <C-LeftMouse> <Plug>(coc-definition)
  nnoremap <silent>        <C-k> <cmd>call <SID>show_documentation()<CR>
  nnoremap <silent>        <C-h> <cmd>call CocActionAsync('showSignatureHelp')<CR>
  inoremap <silent>        <C-h> <cmd>call CocActionAsync('showSignatureHelp')<CR>
  nmap     <silent>        <leader>st <Plug>(coc-type-definition)
  nmap     <silent>        <leader>si <Plug>(coc-implementation)
  nmap     <silent>        <leader>su <Plug>(coc-references)
  nmap     <silent>        <leader>sr <Plug>(coc-rename)
  nmap     <silent>        <leader>sa v<Plug>(coc-codeaction-selected)
  vmap     <silent>        <leader>sa <Plug>(coc-codeaction-selected)
  xmap     <silent>        af <Plug>(coc-funcobj-a)
  omap     <silent>        af <Plug>(coc-funcobj-a)
  xmap     <silent>        ac <Plug>(coc-classobj-a)
  omap     <silent>        ac <Plug>(coc-classobj-a)
  nnoremap <silent>        <leader>sn <cmd>CocNext<CR>
  nnoremap <silent>        <leader>sp <cmd>CocPrev<CR>
  nnoremap <silent>        <leader>sl <cmd>CocListResume<CR>
  nnoremap <silent>        <leader>sc <cmd>CocList commands<cr>
  nnoremap <silent>        <leader>so <cmd>CocList -A outline<cr>
  nnoremap <silent>        <leader>sw <cmd>CocList -A -I symbols<cr>
  inoremap <silent> <expr> <c-space> coc#refresh()
  nnoremap <silent> <expr> <C-e> coc#float#has_float() ? coc#float#scroll(1) : "\<C-e>"
  nnoremap <silent> <expr> <C-y> coc#float#has_float() ? coc#float#scroll(0) : "\<C-y>"
  imap     <silent> <expr> <C-l> coc#expandable() ? "<Plug>(coc-snippets-expand)" : "\<C-y>"
  inoremap <silent> <expr> <CR> pumvisible() ? '<CR>' : '<C-g>u<CR><c-r>=coc#on_enter()<CR>'
  nnoremap                 <leader>d <cmd>call CocActionAsync('diagnosticToggle')<CR>
  nmap     <silent>        <leader>n <Plug>(coc-diagnostic-next)
  nmap     <silent>        <leader>p <Plug>(coc-diagnostic-prev)

  " coc-spell-check:
  " <leader>aw for current word
  " <leader>aap for current paragraph
  vmap     <silent>         <leader>a <Plug>(coc-codeaction-selected)
  nmap     <silent>         <leader>a <Plug>(coc-codeaction-selected)
  nnoremap <silent>         <leader>s <cmd>CocCommand cSpell.toggleEnableSpellChecker<CR>


  " coc-smartf: press <esc> to cancel.
  " nmap f <Plug>(coc-smartf-forward)
  " nmap F <Plug>(coc-smartf-backward)
  " nmap ; <Plug>(coc-smartf-repeat)
  " nmap , <Plug>(coc-smartf-repeat-opposite)

  vmap <leader>a <Plug>(coc-codeaction-selected)<cr>
  nmap <leader>a <Plug>(coc-codeaction-selected)<cr>

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Mouse Configuration: remaps mouse to work better in terminal

  " Clipboard Copy Paste: Visual mode copy is pretty simple
  vnoremap <leader>y "+y
  nnoremap <leader>y "+y
  " Normal mode paste checks whether the current line has text
  " if yes, insert new line, if no, start paste on the current line
  " nnoremap <expr> <leader>p
  "       \ len(getline('.')) == 0 ? '"+p' : 'o<esc>"+p'

  " Mouse Copy: system copy mouse characteristics
  vnoremap <RightMouse> "+y

  " Mouse Paste: make it come from the system register
  nnoremap <MiddleMouse> "+<MiddleMouse>

  " Mouse Open Close Folds: open folds with the mouse, and close the folds
  " open operation taken from: https://stackoverflow.com/a/13924974
  nnoremap <expr> <2-LeftMouse>
        \ foldclosed(line('.')) == -1 ? '<2-LeftMouse>' : 'zo'
  nnoremap <RightMouse> <LeftMouse><LeftRelease>zc

  " Scrolling Dropdown: dropdown scrollable + click to select highlighted
  inoremap <expr> <S-ScrollWheelUp>
        \ pumvisible() ?
        \ '<C-p><C-p><C-p><C-p><C-p><C-p><C-p><C-p><C-p><C-p>' :
        \ '<Esc><S-ScrollWheelUp>'
  inoremap <expr> <S-ScrollWheelDown>
        \ pumvisible() ?
        \ '<C-n><C-n><C-n><C-n><C-n><C-n><C-n><C-n><C-n><C-n>' :
        \ '<Esc><S-ScrollWheelDown>'
  inoremap <expr> <ScrollWheelUp>
        \ pumvisible() ? '<C-p>' : '<Esc><ScrollWheelUp>'
  inoremap <expr> <ScrollWheelDown>
        \ pumvisible() ? '<C-n>' : '<Esc><ScrollWheelDown>'
  inoremap <expr> <LeftMouse>
        \ pumvisible() ? '<CR><Backspace>' : '<Esc><LeftMouse>'

  "Repl:
  nnoremap <leader><leader>e :ReplToggle<CR>
  nnoremap <leader><leader>c :ReplClear<CR>
  nmap <leader>e <Plug>ReplSendLine
  vmap <leader>e <Plug>ReplSendVisual

  " spacesurround:
  inoremap <silent>        <space>  <cmd>call SurroundSpace()<CR>
  inoremap <silent>        <bs>     <cmd>call SurroundBackspace()<CR>
  inoremap <silent>        <C-w>    <cmd>call SurroundCw()<CR>

  " Key Remappings:
  nnoremap <C-p> :call FzfFiles()<CR>
  nnoremap <leader><C-p> :call FzfHomeFiles()<CR>
  nnoremap <leader>g<C-p> :call FzfGitFiles()<CR>
  nnoremap <leader>d<C-p> :call FzfDiffFiles()<CR>
  nnoremap <C-n> yiw:Grep <C-r>"<CR>
  vnoremap <C-n> y:Grep <C-r>"<CR>
  nnoremap <leader><C-n> yiw:GrepIgnoreCase <C-r>"<CR>
  vnoremap <leader><C-n> y:GrepIgnoreCase <C-r>"<CR>
endfunction

call DefaultKeyMappings()

" }}}
" General: Cleanup {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless they’re owned by you.
set secure

" }}}
