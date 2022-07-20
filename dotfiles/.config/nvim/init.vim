" Make typing more fun.
"
" Notes:
"
" BufRead, BufNewFile trumps Filetype
" Eg, if BufRead,BufNewFile * ignores any Filetype overwrites
" This is why default settings are chosen with Filetype *


set runtimepath^=/Users/kevinhalliday/src/kevinhalliday/coc-cairo

" Packages {{{

function! s:packager_init(packager) abort
  call a:packager.add('git@github.com:kristijanhusak/vim-packager', {'type': 'opt'})

  " My plugins:
  call a:packager.add('git@github.com:kevinhalliday/cairo.vim')

  " Copilot:
  call a:packager.add('git@github.com:github/copilot.vim.git')

  " Autocompletion And IDE Features:
  call a:packager.add('git@github.com:neoclide/coc.nvim.git', {'do': 'yarn install --frozen-lockfile'})
  call a:packager.add('git@github.com:pappasam/coc-jedi.git', {'do': 'yarn install --frozen-lockfile && yarn build'})

  " Fonts:
  call a:packager.add('git@github.com:ryanoasis/vim-devicons.git')

  " TreeSitter:
  call a:packager.add('git@github.com:nvim-treesitter/nvim-treesitter.git', {'do': ':TSUpdate'})
  call a:packager.add('git@github.com:nvim-treesitter/playground.git')
  call a:packager.add('git@github.com:windwp/nvim-ts-autotag.git')
  call a:packager.add('git@github.com:JoosepAlviste/nvim-ts-context-commentstring.git')

  " Repls:
  call a:packager.add('git@github.com:pappasam/nvim-repl.git')

  " Git Integration:
  call a:packager.add('git@github.com:tpope/vim-fugitive.git')
  call a:packager.add('git@github.com:tpope/vim-rhubarb.git')

  " Defx:
  call a:packager.add('git@github.com:Shougo/defx.nvim')
  call a:packager.add('git@github.com:kristijanhusak/defx-git')
  call a:packager.add('git@github.com:kristijanhusak/defx-icons')

  " General:
  call a:packager.add('git@github.com:bronson/vim-visual-star-search')
  call a:packager.add('git@github.com:fidian/hexmode')
  call a:packager.add('git@github.com:junegunn/vader.vim')
  call a:packager.add('git@github.com:kh3phr3n/tabline')
  call a:packager.add('git@github.com:mbbill/undotree')
  call a:packager.add('git@github.com:qpkorr/vim-bufkill')
  call a:packager.add('git@github.com:ryvnf/readline.vim.git')
  call a:packager.add('git@github.com:simeji/winresizer')
  call a:packager.add('git@github.com:unblevable/quick-scope')
  call a:packager.add('git@github.com:wincent/ferret')
  call a:packager.add('git@github.com:folke/zen-mode.nvim.git')
  call a:packager.add('git@github.com:windwp/nvim-autopairs.git')
  call a:packager.add('git@github.com:ntpeters/vim-better-whitespace.git')
  call a:packager.add('git@github.com:tpope/vim-commentary.git')
  call a:packager.add('git@github.com:tpope/vim-repeat.git')
  call a:packager.add('git@github.com:tpope/vim-surround.git')
  call a:packager.add('git@github.com:tpope/vim-abolish.git')
  call a:packager.add('git@github.com:ckarnell/Antonys-macro-repeater.git')
  call a:packager.add('git@github.com:wincent/ferret.git' )
  call a:packager.add('git@github.com:airblade/vim-rooter.git' )

  " FZF:
  call a:packager.add('git@github.com:junegunn/fzf.git', { 'dir': '~/.fzf', 'do': './install --all' })
  call a:packager.add('git@github.com:junegunn/fzf.vim.git')

  " Writing:
  call a:packager.add('git@github.com:junegunn/limelight.vim.git')
  call a:packager.add('git@github.com:junegunn/goyo.vim.git')
  call a:packager.add('git@github.com:dkarter/bullets.vim.git')

  " ColorScheme:
  call a:packager.add('git@github.com:pappasam/papercolor-theme-slim.git')
  call a:packager.add('git@github.com:tanvirtin/monokai.nvim.git')
  call a:packager.add('git@github.com:tomasiser/vim-code-dark.git')


  " Previewers:
  call a:packager.add('git@github.com:iamcco/markdown-preview.nvim.git', { 'do': 'cd app & yarn install'  })
  call a:packager.add('git@github.com:tyru/open-browser.vim.git')
  call a:packager.add('git@github.com:weirongxu/plantuml-previewer.vim.git')
  call a:packager.add('git@github.com:turbio/bracey.vim.git', { 'do': 'yarn install --cwd server' })

  " Formatters:
  call a:packager.add('git@github.com:pappasam/vim-filetype-formatter.git')


  " Syntax Highlighting:
  call a:packager.add('git@github.com:pangloss/vim-javascript')
  call a:packager.add('git@github.com:peitalin/vim-jsx-typescript.git')
  call a:packager.add('git@github.com:pantharshit00/vim-prisma.git')
  call a:packager.add('git@github.com:hashivim/vim-terraform.git')
  call a:packager.add('git@github.com:tomlion/vim-solidity.git')
  call a:packager.add('git@github.com:jparise/vim-graphql.git')
  call a:packager.add('git@github.com:chr4/nginx.vim.git')
  call a:packager.add('git@github.com:khalliday7/Jenkinsfile-vim-syntax.git')
  call a:packager.add('git@github.com:rdolgushin/groovy.vim.git')
  call a:packager.add('git@github.com:jxnblk/vim-mdx-js.git')

  " Indentation Only:
  call a:packager.add('git@github.com:hynek/vim-python-pep8-indent.git')
  call a:packager.add('git@github.com:vim-scripts/groovyindent-unix.git')
endfunction

packadd vim-packager
call packager#setup(function('s:packager_init'), {
      \ 'window_cmd': 'edit',
      \ })

command! PackInstall    PackagerInstall
command! PackUpdate     PackagerUpdate
command! PackClean      PackagerClean
command! PackStatus     PackagerStatus
command! PU             PackagerUpdate | PackagerClean

" }}}
" Leader mappings {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}
" Global config {{{

filetype plugin indent on

set completeopt=menuone,longest
set wildmode=longest,list,full
set wildmenu
set shortmess+=c
set hidden
set signcolumn=yes
set mouse=a
set nobackup
set nowritebackup
set noswapfile
set cmdheight=2
set nowrap
set incsearch
set inccommand=nosplit
set dictionary=$HOME/.american-english-with-propcase.txt
set spelllang=en_us
set nojoinspaces
set showtabline=2
set autoread
set grepprg=rg\ --vimgrep
set pastetoggle=<C-_>
set notimeout
set ttimeout
set exrc
set shell=$SHELL
set number
set splitright
set laststatus=2
set ttimeoutlen=50
set noshowmode
set noshowcmd
set updatetime=300
set history=100

" Path: add node_modules for neomake / other stuff
let $PATH = $PWD . '/node_modules/.bin:' . $PATH

augroup redraw_on_refocus
  autocmd!
  autocmd FocusGained * redraw!
augroup end

augroup custom_incsearch_highlight
  autocmd!
  autocmd CmdlineEnter /,\? set hlsearch
  autocmd CmdlineLeave /,\? set nohlsearch
augroup end

augroup custom_nginx
  autocmd!
  autocmd FileType nginx set iskeyword+=$
  autocmd FileType zsh,sh set iskeyword+=-
augroup end

" Terminal Color Support: only set guicursor if truecolor
if $COLORTERM ==# 'truecolor'
  set termguicolors
else
  set guicursor=
endif

" Make Python support work better with asdf
let g:python3_host_prog = "$HOME/.asdf/shims/python"
let g:loaded_python_provider = 0

" }}}
" Alacritty Color Scheme {{{

" set environment variables based on light or dark
function s:set_env_from_background()
  let $BAT_THEME = &background == 'light' ?
        \ 'Monokai Extended Light' : 'Monokai Extended'
endfunction

function! s:alacritty_set_background()
  let g:alacritty_background = system('alacritty-which-colorscheme')
  if !v:shell_error
    let &background = g:alacritty_background
  else
    echom 'Error calling "alacritty-which-colorscheme"'
  endif
  call s:set_env_from_background()
endfunction

call s:alacritty_set_background()
call jobstart(
      \ 'ls ' . $HOME . '/.alacritty.yml | entr -ps "echo alacritty_colorchange"',
      \ {
      \   'on_stdout': { j, d, e -> s:alacritty_set_background() },
      \   'on_stderr': { j, d, e -> s:alacritty_set_background() }
      \ }
      \ )


" }}}
"  Filetype recognition {{{

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
  autocmd BufNewFile,BufRead,BufEnter .cairo  set filetype=cairo
augroup end


" }}}
" Status & Tab lines {{{

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

" Status Line
augroup statusline_local_overrides
  autocmd!
  autocmd FileType defx setlocal statusline=\ defx\ %#CursorLine#
augroup end

" }}}
" Comment / Text Format Options {{{

" commentstring: read by vim-commentary; must be one template
" comments: csv of comments.
" formatoptions: influences how Vim formats text
"   ':help fo-table' will get the desired result
augroup custom_comment_config
  autocmd!
  autocmd FileType dosini
        \ setlocal commentstring=#\ %s comments=:#,:;
  autocmd FileType cairo
        \ setlocal commentstring=#\ %s comments=:#,:;
  autocmd FileType jsonc
        \ setlocal commentstring=//\ %s comments=:// formatoptions=jcroql
  autocmd FileType sh setlocal formatoptions=jcroql
  autocmd FileType typescript.tsx,typescript,typescriptreact
        \ setlocal commentstring=//\ %s
  autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
augroup end

" }}}
" Indentation {{{

set expandtab shiftwidth=2 softtabstop=2 tabstop=8
augroup indentation_sr
  autocmd!
  autocmd Filetype python,c,haskell,rust,rst,kv,nginx,asm,nasm,gdscript3,cair
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
augroup end

" }}}
" ColorColumn different widths for different filetypes {{{

set colorcolumn=80
augroup colorcolumn_configuration
  autocmd!
  autocmd FileType gitcommit setlocal colorcolumn=73 textwidth=72
  autocmd Filetype html,text,markdown,rst setlocal colorcolumn=0
  autocmd FileType solidity setlocal colorcolumn=120
augroup end

" }}}
" Writing {{{
"
function! s:abolish_correct()
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
  Abolish improt                      import
  Abolish imoprt                      import
endfunction

augroup custom_writing
  autocmd!
  autocmd VimEnter * call s:abolish_correct()
  autocmd FileType markdown,markdown.mdx,mdx,rst,text,gitcommit setlocal wrap linebreak nolist
  autocmd FileType requirements setlocal nospell
  autocmd BufNewFile,BufRead *.html,*.tex setlocal wrap linebreak nolist
augroup end

" }}}
" Folding Settings {{{

augroup fold_settings
  autocmd!
  autocmd FileType vim,tmux,bash,zsh,sh
        \ setlocal foldmethod=marker foldlevelstart=0 foldnestmax=1
  autocmd FileType markdown,rst
        \ setlocal nofoldenable
augroup end

" }}}
" Trailing whitespace {{{

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
augroup end

" }}}
" Color schemes {{{

" }}}
" Syntax highlighting {{{
"
augroup cairo_syntax
  autocmd!
  autocmd FileType cairo set syntax=cairo
augroup end

" Python: Highlight args and kwargs, since they are conventionally special
augroup python_syntax
  autocmd!
  autocmd FileType python syntax keyword pythonBuiltinObj args
  autocmd FileType python syntax keyword pythonBuiltinObj kwargs
  autocmd FileType python syntax keyword pythonBuiltinObj self
augroup end

" QuickScope: choose primary and secondary colors
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='LimeGreen' ctermfg=Green gui=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='turquoise1' ctermfg=Cyan gui=underline
augroup end

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
augroup end

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
augroup end

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
" try
"   colorscheme PaperColorSlim
" catch
"   echo 'An error occured while configuring PaperColor'
" endtry

try
  " colorscheme monokai
  " colorscheme monokai_pro
  " colorscheme monokai_soda
  colorscheme monokai_ristretto
catch
  echo 'An error occured while configuring Monokai'
endtry

" try
"   colorscheme codedark
" catch
"   echo 'An error occured while configuring codedark'
" endtry

" }}}
" Resize Window {{{

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
" Clean Unicode {{{

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
" Neovim Terminal {{{

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
" Toggle numbers {{{

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
"   vim-filetype-formatter {{{

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
      \ 'svg': 'npx -q prettier --parser html',
      \ 'vue': 'npx -q prettier --html-whitespace-sensitivity ignore --parser vue',
      \ 'solidity': 'npx -q prettier --parser solidity-parse',
      \ 'cairo': 'cairo-format -',
      \}

nnoremap <leader>f :FiletypeFormat<cr>
vnoremap <leader>f :FiletypeFormat<cr>

" }}}
" Fzf {{{

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
" COC {{{

let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'
let g:coc_start_at_startup = 1
let g:coc_filetype_map = {
      \ 'python.jinja2': 'python',
      \ 'markdown.mdx': 'markdown',
      \ 'sql.jinja2': 'sql',
      \ 'yaml.ansible': 'yaml',
      \ 'yaml.docker-compose': 'yaml',
      \ 'jinja.html': 'html',
      \ }

" Coc Global Extensions: automatically installed on Vim open
" \ 'coc-snippets',
" \ 'coc-highlight',
" \ 'coc-markdownlint',
" \ 'coc-angular',
" \ 'coc-cairo',
" \ 'https://github.com/rodrigore/coc-tailwind-intellisense',
let g:coc_global_extensions = [
      \ '@yaegassy/coc-nginx',
      \ 'coc-cssmodules',
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-docker',
      \ 'coc-emoji',
      \ 'coc-eslint',
      \ 'coc-go',
      \ 'coc-html',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-rls',
      \ 'coc-sh',
      \ 'coc-svelte',
      \ 'coc-svg',
      \ 'coc-syntax',
      \ 'coc-texlab',
      \ 'coc-toml',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ 'coc-yank',
      \ 'coc-dictionary',
      \ 'coc-word',
      \ 'coc-tailwindcss',
      \ 'coc-solidity',
      \ ]

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" }}}
" Restructured Text {{{

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
augroup end

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
augroup end

" }}}
" Markdown-preview.vim {{{

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
" let g:mkdp_browserfunc = 'open'

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
" vimtext {{{
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
" Package: zen-mode.nvim {{{

function! s:init_zen_mode()
  if !exists('g:loaded_commentary')
    echom 'ts context commentstring does not exist, skipping...'
    return
  endif
lua << EOF
local ok, _ = pcall(require, 'zen-mode')
if not ok then
  print('zen-mode does not exist, skipping...')
  return
end
require'zen-mode'.setup {
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 120, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = false,
      font = "+4", -- font size increment
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
}
EOF
endfunction

augroup custom_zenmode
  autocmd!
  autocmd VimEnter * call s:init_zen_mode()
augroup end

" }}}
" Preview Compiled Stuff in Viewer {{{

function! s:preview()
  if &filetype ==? 'rst'
    exec 'terminal restview %'
    exec "normal \<C-O>"
  elseif &filetype ==? 'markdown'
    " from markdown-preview.vim
    exec 'MarkdownPreview'
  elseif &filetype ==? 'html'
    " from bran.vim
    exec 'Bracey'
  elseif &filetype ==? 'dot'
    " from wmgraphviz.vim
    exec 'GraphvizInteractive'
  elseif &filetype ==? 'plantuml'
    " from plantuml-previewer.vim
    exec 'PlantumlOpen'
  else
    echo 'Preview not supported for this filetype'
  endif
endfunction

command! Preview call <SID>preview()

" }}}
"  Miscellaneous Configuration {{{

" Python: highlighting
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1

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

" QuickScope: great plugin helping with f and t
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars = 10000

" WinResize:
let g:winresizer_start_key = '<C-\>'
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

" Bracey:
let g:bracey_refresh_on_save = 1

"  }}}
"  defx {{{

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
      \ ['<C-s>         ', "defx#do_action('drop', 'split')"],
      \ ['<CR>          ', "defx#do_action('drop')"],
      \ ['<RightMouse>  ', "defx#do_action('cd', ['..'])"],
      \ ['O             ', "defx#do_action('open_tree', 'recursive:3')"],
      \ ['p             ', "defx#do_action('preview')"],
      \ ['a             ', "defx#do_action('toggle_select')"],
      \ ['cc            ', "defx#do_action('copy')"],
      \ ['cd            ', "defx#do_action('change_vim_cwd')"],
      \ ['i             ', "defx#do_action('toggle_ignored_files')"],
      \ ['nf            ', "defx#do_action('new_file')"],
      \ ['nd            ', "defx#do_action('new_directory')"],
      \ ['dd            ', "defx#do_action('remove')"],
      \ ['rn            ', "defx#do_action('rename')"],
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
"  treesitter {{{

function s:init_treesitter()
  if !exists('g:loaded_nvim_treesitter')
    echom 'nvim-treesitter does not exist, skipping...'
    return
  endif
lua << EOF
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    disable = { "cairo" },
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
    'regex',
    'rust',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
}})
EOF
endfunction

augroup custom_treesitter
  autocmd!
  autocmd VimEnter * call s:init_treesitter()
augroup end

"  }}}
"  copilot.vim {{{

let g:copilot_no_tab_map = v:true

"  }}}
" nvim-autopairs {{{

function! s:init_nvim_autopairs()
lua << EOF
local ok, _ = pcall(require, 'nvim-autopairs')
if not ok then
  print('nvim-autopairs does not exist, skipping...')
  return
end
local npairs = require'nvim-autopairs'
local Rule   = require'nvim-autopairs.rule'
npairs.setup({
  disable_filetype = { "TelescopePrompt" },
})
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}
EOF
endfunction

augroup custom_nvim_autopairs
  autocmd!
  autocmd VimEnter * call s:init_nvim_autopairs()
augroup end

"  }}}
" Key remappings {{{

" This is defined as a function to allow me to reset all my key remappings
" without needing to repeate myself. Useful with Goyo for now
function! DefaultKeyMappings()
  " Turn of syntax
  nnoremap <leader>so :set syntax=OFF<CR>

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
  " alt for linux
  " nnoremap <A-1> 1gt
  " nnoremap <A-2> 2gt
  " nnoremap <A-3> 3gt
  " nnoremap <A-4> 4gt
  " nnoremap <A-5> 5gt
  " nnoremap <A-6> 6gt
  " nnoremap <A-7> 7gt
  " nnoremap <A-8> 8gt
  " nnoremap <A-9> 9gt

  " command for mac
  nnoremap <D-1> 1gt
  nnoremap <D-2> 2gt
  nnoremap <D-3> 3gt
  nnoremap <D-4> 4gt
  nnoremap <D-5> 5gt
  nnoremap <D-6> 6gt
  nnoremap <D-7> 7gt
  nnoremap <D-8> 8gt
  nnoremap <D-9> 9gt

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
  nmap <leader><leader>z <Plug>ZenMode

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
  " nnoremap <silent>        <leader>so <cmd>CocList -A outline<cr>
  nnoremap <silent>        <leader>sw <cmd>CocList -A -I symbols<cr>
  inoremap <silent> <expr> <C-space> coc#refresh()
  inoremap <silent> <expr> <C-]> coc#refresh()
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

  " Key Remappings:
  nnoremap <C-p> :call FzfFiles()<CR>
  nnoremap <C-~> :call FzfHomeFiles()<CR>
  " nnoremap <C-p> :call FzfGitFiles()<CR>
  " nnoremap <C-p> :call FzfDiffFiles()<CR>
  nnoremap <C-n> yiw:Grep <C-r>"<CR>
  vnoremap <C-n> y:Grep <C-r>"<CR>
  nnoremap <leader><C-n> yiw:GrepIgnoreCase <C-r>"<CR>
  vnoremap <leader><C-n> y:GrepIgnoreCase <C-r>"<CR>
endfunction

call DefaultKeyMappings()

" }}}
" Cleanup {{{
" commands that need to run at the end of my vimrc

" disable unsafe commands in your project-specific .vimrc files
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless they’re owned by you.
set secure

" }}}
