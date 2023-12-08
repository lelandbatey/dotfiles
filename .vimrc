"let g:python_host_prog='/home/leland/bin/venv/bin/python'
let g:python3_host_prog='/home/parallels/bin/venv-3/bin/python'
"let g:python3_host_prog='/home/leland/projects/glympse_ghorg/glympse/solutions/reporting-standardization/venv-3/bin/python'

set nocompatible              " be iMproved, required
filetype off                  " required

" Install the vim-plug command according to the instructions here:
"     https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" A prerequisite for autocompletion
Plug 'ncm2/ncm2'
" Also a prerequisite for autocompletion
Plug 'roxma/nvim-yarp'
" Also a prerequisite for autocompletion
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'

Plug 'ncm2/ncm2-jedi'

Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'

" Airline, for better buffer displays
Plug 'vim-airline/vim-airline'

" delimiMate -- Enables SublimeText-like autocompletion for quotes, brackets, etc.
Plug 'Raimondi/delimitMate'

" Monokai colorscheme
Plug 'sickill/vim-monokai'

" A github-like colorscheme. Great for printing with:
"     vim -c 'colorscheme morning' -c 'let g:html_number_lines=1' -c 'run! syntax/2html.vim' -c 'wqa' <FILENAME>
Plug 'cormacrelf/vim-colors-github'

" Convenient commenting
Plug 'scrooloose/nerdcommenter'

" Run code formatters upon saving a file
Plug 'Chiel92/vim-autoformat'

" Autoindent
Plug 'tpope/vim-sleuth'

" Handlebars support
Plug 'mustache/vim-mustache-handlebars'

" Rust language support
Plug 'rust-lang/rust.vim'

" Vim-orgmode
Plug 'jceb/vim-orgmode'

" Improved C syntax highlighting
"Plug 'justinmk/vim-syntax-extra'

" Nice Go integrations and autocompletions
Plug 'fatih/vim-go'

" An inter-vim wiki for my own use
Plug 'vimwiki/vimwiki'

" Add syntax highlighting for Apex, the Salesforce plugin language
Plug 'ejholmes/vim-forcedotcom'

" Support for postgres-specific SQL syntax
Plug 'lifepillar/pgsql.vim'

" Floobits
"Plug 'floobits/floobits-neovim'

" Install the FZF plugin because I want functionality like Projectile in Emacs
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Add ability to generate a link to the current file and line, if the file
" being edited is in a gitlab/github repository.
Plug 'iautom8things/gitlink-vim'

" Fixes Python indenting of braces and brackets
Plug 'Vimjas/vim-python-pep8-indent'

" trying out this plugin for Pico8
Plug 'bakudankun/pico-8.vim'

" allow me to use 'let' statements in modeline
Plug 'vim-scripts/let-modeline.vim'

call plug#end()

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
filetype plugin indent on

" In order to have project-specific vim configuration, we turn on exrc and
" secure. With exrc on, vim will search for .vimrc files in the same dir it's
" being run in, but won't traverse up the tree to find one.
set exrc
set secure

" Turn on delimiMate
let delimitMate_expand_cr = 1

" Enable airline's smarter tabline
let g:airline#extensions#tabline#enabled = 1
" Set the number next to the filename in the tab to show splits and tab number
let g:airline#extensions#tabline#tab_nr_type = 2
" Show both buffers and tabs
" enable/disable displaying buffers with a single tab
let g:airline#extensions#tabline#show_buffers = 1
" Displays a superscript buffer index in the tabline
let g:airline#extensions#tabline#buffer_idx_mode = 1
" Mappings for moving between buffers using vim-airline
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab


" Modify file view so it uses a tree structure
let g:netrw_liststyle = 3
" Causes opening a file to open it in the previous buffer. This has the effect
" of letting you have an 'always open' pane beside the netrw view, and opening
" something opens it in the 'always open' pane. AKA emulates an IDE file tree
let g:netrw_browse_split=4
" Hide files which are build artifacts
let g:netrw_hide=1
let g:netrw_list_hide='.*\.pyc$'

" Apparently netrw now overrides the ctrl-L shortcut, so revert it:
"     https://github.com/christoomey/vim-tmux-navigator/issues/189#issuecomment-362079200
"augroup netrw_mapping
"  autocmd!
"  autocmd filetype netrw call NetrwMapping()
"augroup END
"
"function! NetrwMapping()
"  nnoremap <silent> <buffer> <c-l> :wincmd l<CR>
"endfunction
" Freed <C-l> in Netrw
nmap <leader><leader><leader><leader><leader><leader>l <Plug>NetrwRefresh

" Make YouCompleteMe close it's preview window once you leave insert mode
"let g:ycm_autoclose_preview_window_after_insertion = 1
" Ensure YouCompleteMe uses whichever version of python I'm using
"let g:ycm_python_binary_path = 'python'

" Add powerline font support
let g:airline_powerline_fonts = 1

" Make PostgreSQL the default SQL syntax format
let g:sql_type_default = 'pgsql'

" When opening a new buffer, moves the previous buffer into the background and
" allows the new buffer to be opened, and hides the previous buffer, instead
" of forcing changes to be saved before opening a new buffer.
set hidden

" Switching to a buffer means switching to the existing tab if the buffer is
" open, or creating a new one if it's not.
"set switchbuf=usetab,newtab

" Turn on syntax highlighting
syntax on

" Tab characters '\t' are represented as 4 spaces, but they are still inserted
" as single '\t' characters
set tabstop=4
set shiftwidth=4

" Turn on autoindenting. This means a new line has the same indentation as the
" line preceding it.
set autoindent

" Turn on indenttion when soft-wrapping
set breakindent

" Makes tab and newline characters visible
" To toggle, type `set list!`
set listchars=tab:▸\ ,eol:¬,space:·,trail:␣
"set listchars=tab:>\ ,eol:$,trail:&

" Turns on line number for current line, then turns on relative line numbers
" for all other lines.
set number
set relativenumber
set numberwidth=4

" We want commands like gqq to wrap text at line 100 instead of line 80, but
" we also don't want our comments to be auto-wrapped while we're typing. We
" want to have to manually wrap everything; code, comments, text, etc.
"
" Don't wrap text using textwidth, don't wrap comments using textwidth
set fo-=t fo-=c
" Make the textwidth 100 so that gqq will wrap at column 100
set textwidth=100

" Always show the statusline
set laststatus=2
" Our actual status line:
set statusline=%-.30f
set statusline+=%=
set statusline+=Line:\ %l
set statusline+=/%L,\ Column:
set statusline+=\ %-8c
set statusline+=\ %P

" Highlight matching search terms
set hlsearch
" Searches are case-insenitive unless they have an uppercase letter
set ignorecase
set smartcase

" Set total number of available colors (forcefully) to 256
"set t_Co=256
" Set the background color
"set t_AB=[48;5;%dm
" Set the foreground color
"set t_AF=[38;5;%dm

" Lets the backspace key delete things it otherwise can't
set backspace=indent,eol,start

" Set the colorscheme
colorscheme monokai

" Allow for deleting the current buffer withough closing the open pane:
" See here: https://stackoverflow.com/a/29179159
noremap <leader>d :bp\|bd #<enter>
" Clear last search
noremap <silent> <leader>/ :let @/ = ""<CR>
" Change search highlight color
"highlight Search ctermbg=yellow ctermfg=black

" Create a 'crosshair' on the current position
" set cursorline
" set cursorcolumn

" Map space to leader
map <space> <leader>
" For compatability, map double space to double leader.
map <space><space> <leader><leader>

" Maps `ctrl+movementKey` to allow you to move between vim windows.
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Fast resizing of windows
nnoremap <silent> <leader><leader>h :exe "vertical resize" . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader><leader>l :exe "vertical resize" . (winwidth(0) * 2/3)<CR>
nnoremap <silent> <leader><leader>j :exe "resize" . (winheight(0) * 3/2)<CR>
nnoremap <silent> <leader><leader>k :exe "resize" . (winheight(0) * 2/3)<CR>

" Create map to edit vimrc
map <leader>v :sp ~/.vimrc<enter>G

" Change how Rg is called by fzf.vim so that it'll follow symlinks (via
" '--follow' argument)
command! -bang -nargs=* Rg  call fzf#vim#grep("rg --column --follow --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" Allow for quickly searching for an identifier across a codebase
nnoremap <silent> <leader>fc yiw:Rg <C-r>"<CR>
vnoremap <silent> <leader>fc y:Rg <C-r>"<CR>

nnoremap <leader>ff :FZF<CR>

" Function to source `vimrc` again. Originally from here:
" https://github.com/adamryman/dotfiles/blob/c794063815e674c956bc2450c3bafa9067722016/home/adamryman/.vimrc#L124
if !exists("*SourceAgain")
  function! SourceAgain()
    execute "source ~/.vimrc"
    execute "set filetype=" . &filetype
  endfunction
endif
:map <leader>s :call SourceAgain()<enter>

" Open the netrw explorer
map <leader>f :Vexplore<enter>
let g:netrw_winsize = -25

" Quickly search for a file in my directory by the name of that file with FZF
map <leader>ff :FZF<enter>

" Quickly search for the contents of a file in my directory with Ag/Rg
map <leader>fc :Rg <C-R><C-W><CR>

" Quick opening tabs
map <leader>t :e<space>

" Open a sibling file
nnoremap <leader>sf :e <C-R>=expand('%:p:h') . "/"<CR>

" Toggleing viewing whitespace
nmap <leader>W :set list!<enter>

" Toggle spellchecking
nmap <leader>l :set spell! spelllang=en_us<CR>

" Search for the current visual selection with '//'
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Moving between buffers in normal mode
if !exists("*ConditionalChangeBufNext")
  " Move to the next buffer as long as we're not in a 'netrw' buffer
  function! ConditionalChangeBufNext()
    if getbufvar(bufnr("%"), '&filetype') !=# "netrw"
      execute "bnext"
    endif
  endfunction
endif
if !exists("*ConditionalChangeBufPrevious")
  " Move to the previous buffer as long as we're not in a 'netrw' buffer
  function! ConditionalChangeBufPrevious()
    if getbufvar(bufnr("%"), '&filetype') !=# "netrw"
      execute "bprevious"
    endif
  endfunction
endif

" Courtesy of my coworker Logan Brooke
if !exists("SearchJustify")
" using a set of keystrokes like /^\s*\w*\s*<CR>vi):call SearchJustify(30) to
" turn:
"     CREATE TABLE IF NOT EXISTS pickup_invite_request(
"         id BIGSERIAL NOT NULL PRIMARY KEY,
"         type VARCHAR(256) NOT NULL DEFAULT ''
"     );
" into text like this:
"     CREATE TABLE IF NOT EXISTS pickup_invite_request(
"         id                        BIGSERIAL NOT NULL PRIMARY KEY,
"         type                      VARCHAR(256) NOT NULL DEFAULT ''
"     );
  function! SearchJustify(count)
    let format = "%-" . a:count . "s"
    s//\=printf(format, submatch(0))
  endfunc
endif

nmap <leader>m :call ConditionalChangeBufNext()<enter>
nmap <leader>n :call ConditionalChangeBufPrevious()<enter>

" Highlight all trailing whitespace in red
" Taken from here: https://vim.fandom.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Inserting newlines in normal mode without moving your cursor, from here:
" http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
" Bind <Shift-Enter> to insert a line below you without moving your cursor
nmap <leader><Enter> o<Esc>k

" Toggle paste
nmap <leader><leader>p :set paste!<enter>

" Global yank/put modifier for easy system copy/paste
" For example, let's say you've made a selection in visual mode and you'd like
" to copy it to your system clipboard. Assuming the selection is active, you'd
" type "<leader><shift><quote>y" and that would copy the selection to system
" keyboard.
map <leader>" "+

" Ensure YouCompleteMe will jump to definitions in a new tab
"let g:ycm_goto_buffer_command = 'new-tab'
" Easier binds for the 'GoTo' functionality of YouCompleteMe
"nnoremap <leader>jd :tab YcmCompleter GoTo<CR>

" For those times where vim doesn't have access to the system clipboard, this
" command exists to toggle the line-numbers on and off to allow for copying by
" selection in the terminal.
nmap <leader><leader>c :set number! relativenumber!<enter>

" Fix filetype associations for Markdown.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Fix filetype associations for Gotemplate files.
autocmd BufNewFile,BufReadPost *.gotemplate set filetype=go
" Fix filetype associations for JSONNET files, and turn off autoformatting
" since jsonnet doesn't have actually the same syntax as JSON, but it works
" for highlighting purposes.
autocmd BufNewFile,BufReadPost *.jsonnet set filetype=javascript | let g:should_autoformat=0
autocmd BufNewFile,BufReadPost *.libsonnet set filetype=javascript | let g:should_autoformat=0


map <leader>cd <plug>NERDCommenterToggle

"nmap <F5> :silent !tmux split-window -h '/usr/bin/env python -i "%:p"' <CR>


" Show info about current syntax highlighting unit below cursor
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" Set path to Pico8 binary for the Pico8 vim plugin
let g:pico8_config = {'pico8_path': "/home/parallels/projects/pico8/0.2.5_pico8_bin/pico8"}

" Set the auto-export variable of vimwiki, so all wiki entries are rendered to
" html on write. This big bunch of configuration is derived from
" 'echo g:vimwiki_list' on a brand new install. It includes pretty much
" everything.
" let g:vimwiki_list = [{'maxhi': 0, 'css_name': 'style.css', 'auto_export': 1,\
"	'diary_index': 'diary', 'template_default': 'default',\
"	'nested_syntaxes': {}, 'auto_toc': 0, 'auto_tags': 0,\
"	'diary_sort': 'desc', 'path': '/home/leland/vimwiki/',\
"	'diary_link_fmt': '%Y-%m-%d', 'template_ext': '.tpl',\
"	'syntax': 'default', 'custom_wiki2html': '',\
"	'automatic_nested_syntaxes': 1, 'index': 'index',\
"	'diary_header': 'Diary', 'ext': '.wiki',\
"	'path_html': '/home/leland/vimwiki_html/', 'temp': 0,\
"	'template_path': '/home/leland/vimwiki/templates/',\
"	'list_margin': -1, 'diary_rel_path': 'diary/'}]
"let g:vimwiki_list = [{'path': '/home/leland/vimwiki/', 'auto_export': 1, 'auto_toc': 1}]
let g:vimwiki_list = [{'path': '/home/parallels/vimwiki/', 'auto_export': 1, 'auto_toc': 1}]
let g:vimwiki_url_maxsave=0

" Vimwiki supports markdown, and Vimwiki tries to apply its own syntax
" highlighting to all filetypes it supports, even if we're not editing a file
" within a vimwiki - registered folder.
"     echo g:vimwiki_global_vars['ext2syntax']
" That's unfortunate, since it means all my .md files are being displayed with
" filetype 'vimwiki', and the vimwiki syntax highlighting is really slow
" compared to the ''normal'' syntax highlighting for markdown (which we can
" get via 'set ft=markdown').
" To fix this, we disable the vimwiki plugin unless we're inside of a
" registered vimwiki directory, such as '/home/leland/vimwiki/'
let g:vimwiki_global_ext = 0

" Useful for pasting in my pre-generated daily text for diarys in vimwiki
map <leader>vd :.!~/dotfiles/scripts/insert_vdate.sh %:p<enter>


" use the python formatter called 'black' over 'yapf'
let g:formatters_python = ['black', 'yapf', 'autopep8']
"let g:formatters_python = ['yapf']

" Fix Vim combining stdin and stdout when running another command, usually a
" problem when running black
"     https://vi.stackexchange.com/a/11731
set shellredir=>

let g:should_autoformat = 1
" A way to toggle the autoformatting of a file. Turn off with
" :let g:should_autoformat = 0
if !exists("*ConditionalAutoFormat")
  " Move to the next buffer as long as we're not in a 'netrw' buffer
  function! ConditionalAutoFormat()
    if g:should_autoformat ==# 1
      execute "Autoformat"
    endif
  endfunction
endif
" Enable automatic code formatting when saving a file
au BufWrite * call ConditionalAutoFormat()
" Toggle the 'should_autoformat' variable using <leader>af
nnoremap <leader>af :silent if g:should_autoformat ==# 1 \| let g:should_autoformat=0 \| else \| let g:should_autoformat=1 \| endif <enter>

" Disable the fallback on basic (but slow) vim based formatting
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0


" Custom yapf style, recommended by Zaq?
let g:formatdef_yapf = "'yapf --style=\"{based_on_style: pep8, indent_width: 4, join_multiple_lines: true, SPACE_BETWEEN_ENDING_COMMA_AND_CLOSING_BRACKET: false, COALESCE_BRACKETS: true, DEDENT_CLOSING_BRACKETS: true, COLUMN_LIMIT: 120}\" -l '.a:firstline.'-'.a:lastline"

" Create a command to link to a file in Gitlab/Github
if !exists("*GitLink")
  command GitLink :echo gitlink#GitLink()
endif

" Stuff for autocompletion
autocmd BufEnter  *  call ncm2#enable_for_buffer()

" Affects the visual representation of what happens after you hit <C-x><C-o>
" https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" https://neovim.io/doc/user/options.html#'completeopt'
"
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Disable the vim-go jump to definition, replacing with the LSP jtd
let g:go_def_mapping_enabled = 0

" Use gofmt on save to prevent goimports or gopls from taking a long time
" writing to disk.
let g:go_fmt_command = 'gofmt'
let g:go_imports_autosave = 0

nnoremap <c-]> :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>cr :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>gd :call LanguageClient#textDocument_typeDefinition()<CR>

" Without this, ruby projects nested in git repos won't work with SolarGraph
" properly since LanguageClient falls back to assuming the .git root is
" workspace dir, while solargraph expects it to be the dir with the
" .solargraph.yml
" 'go': ['.git', 'go.mod'],
let g:LanguageClient_rootMarkers = {
      \ 'go': ['.git', 'go.mod'],
      \ 'ruby': ['.solargraph.yml'],
      \ 'typescriptreact': ['tsconfig.json'],
      \ 'javascriptreact': ['tsconfig.json'],
      \ 'typescript': ['tsconfig.json'],
      \ 'javascript': ['tsconfig.json'],
      \ 'javascript.tsx': ['tsconfig.json'],
      \ 'javascript.ts': ['tsconfig.json'],
      \ 'javascript.jsx': ['tsconfig.json'],
      \ 'javascript.js': ['tsconfig.json'],
      \ }

"    \ 'javascript': ['/home/parallels/.asdf/installs/nodejs/16.20.0/bin/typescript-language-server', '--stdio'],
"    \ 'typescriptreact': ['/home/parallels/.asdf/installs/nodejs/16.20.0/bin/typescript-language-server', '--stdio'],
"    \ 'javascriptreact': ['/home/parallels/.asdf/installs/nodejs/16.20.0/bin/typescript-language-server', '--stdio'],
"    \ 'typescript': ['/home/parallels/.asdf/installs/nodejs/16.20.0/bin/typescript-language-server', '--stdio'],
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['/home/parallels/.asdf/shims/typescript-language-server', '--stdio'],
    \ 'typescriptreact': ['/home/parallels/.asdf/shims/typescript-language-server', '--stdio'],
    \ 'javascriptreact': ['/home/parallels/.asdf/shims/typescript-language-server', '--stdio'],
    \ 'typescript': ['/home/parallels/.asdf/shims/typescript-language-server', '--stdio'],
    \ 'go': {
    \     'name': 'gopls',
    \     'command': ['gopls'],
    \     'initializationOptions': {
    \         'usePlaceholders': v:true,
    \         'buildFlags': ['-tags=or_e2e or_int or_test'],
    \     },
    \ },
    \ 'python': ['pylsp'],
    \ 'ruby': [ 'solargraph',  'stdio' ],
    \ }

" Set up logging of language client
let g:LanguageClient_loggingFile = expand('~/.vim/LanguageClient.log')
let g:LanguageClient_loggingLevel = "WARN"

" We have to point jedi at our virtualenv python
"let g:ncm2_jedi#environment='/home/leland/bin/venv-3/bin/python'
"let g:ncm2_jedi#environment='/home/leland/projects/glympse_ghorg/glympse/solutions/reporting-standardization/venv-3/bin/python'
let g:ncm2_jedi#environment='/home/parallels/bin/venv-3/bin/python'
" If we're working on a Python2 environment, we have to point our autocomplete
" at our Python2 venv

let g:rustfmt_autosave = 1

" Prevent the bell sound in vim (it's annoying in windows)
set visualbell

