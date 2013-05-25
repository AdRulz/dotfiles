" This is Adil Jarulin's vimrc file. (honestly stolen from Gary Bernhardt)
call pathogen#runtime_append_all_bundles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JCUKEN
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan 
setlocal spell spelllang=ru_yo,en_us

set ve=all
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set autowrite
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=2
set winheight=30
set winminheight=5
set winwidth=150
set winminwidth=50
set switchbuf=useopen
set number
set numberwidth=5
set showtabline=2
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" CoffeeScript indent
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab


" Encoding
set iminsert=0
set imsearch=0
setlocal spell spelllang=ru_yo,en_us
set encoding=utf-8
set fileencodings=utf-8,cp1251,koi8-r,latin1

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","

" Vimux
"let VimuxUseNearestPane = 1
let g:VimuxOrientation = "h"
let VimuxHeight = "33" 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kill trailing whitespace on save

au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile Assetfile set filetype=ruby

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!


  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " 256 colors
colorscheme solarized
set background=dark
"set background=light
"j:color grb256
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_diffmode = "high"
let g:solarized_termtrans = 1

if has("gui_running")
  syntax on
  set guifont=Skyhook\ Mono:h14
endif

"Highlight commas for best diff with dots (special for Skyhook Mono) 

highlight commaInsteadDot ctermfg=red
autocmd! BufRead,BufNewFile * match commaInsteadDot "[a-z],[a-z]"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"hide tmux staus bar
"autocmd VimEnter,VimLeave * silent !tmux set status

"source /usr/local/lib/python2.7/site-packages/powerline/ext/vim/source_plugin.vim
"python from powerline.ext.vim import source_plugin; source_plugin()
":set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
"set fillchars+=stl:\ ,stlnc:\
"let g:Powerline_symbols = 'fancy'
"let g:Powerline_colorscheme = 'skwp'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" " (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

"Move lines
"TODO Replace current symbols with ALT key
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

map <leader>y "*y

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()
nnoremap <leader><leader> <c-^>

" format the entire file
nnoremap <c-i> ggVG=''j

" Replace highlighted text (Visual Mode)
vnoremap <C-r> <Esc>:%s/<C-r>+//gc<left><left><left>

" CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTRACT VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExtractVariable()
  let name = input("Variable name: ")
  if name == ''
    return
  endif
  " Enter visual mode (not sure why this is needed since we're already in
  " visual mode anyway)
  normal! gv

  " Replace selected text with the variable name
  exec "normal c" . name
  " Define the variable on the line above
  exec "normal! O" . name . " = "
  " Paste the original selected text to be the variable value
  normal! $p
endfunction
vnoremap <leader>rv :call ExtractVariable()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INLINE VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InlineVariable()
  " Copy the variable under the cursor into the 'a' register
  :let l:tmp_a = @a
  :normal "ayiw
  " Delete variable and equals sign
  :normal 2daW
  " Delete the expression into the 'b' register
  :let l:tmp_b = @b
  :normal "bd$
  " Delete the remnants of the line
  :normal dd
  " Go to the end of the previous line so we can start our search for the
  " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
  " work; I'm not sure why.
  normal k$
  " Find the next occurence of the variable
  exec '/\<' . @a . '\>'
  " Replace that occurence with the text we yanked
  exec ':.s/\<' . @a . '\>/' . @b
  :let @a = l:tmp_a
  :let @b = l:tmp_b
endfunction
nnoremap <leader>ri :call InlineVariable()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC COMMAND-T TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>ga :CommandTFlush<cr>\|:CommandT app/serializers<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT app/assets/stylesheets<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

map <leader>gjv :CommandTFlush<cr>\|:CommandT app/assets/javascripts/views<cr>
map <leader>gjc :CommandTFlush<cr>\|:CommandT app/assets/javascripts/controllers<cr>
map <leader>gjm :CommandTFlush<cr>\|:CommandT app/assets/javascripts/models<cr>
map <leader>gjh :CommandTFlush<cr>\|:CommandT app/assets/javascripts/helpers<cr>
map <leader>gjr :CommandTFlush<cr>\|:CommandT app/assets/javascripts/routes<cr>
map <leader>gjt :CommandTFlush<cr>\|:CommandT app/assets/javascripts/templates<cr>
map <leader>gjs :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
map <leader>gjf :CommandTFlush<cr>\|:CommandT spec/javascripts<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN MVC's OBJECTS.
" EMBER.JS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenMVCTemplate()
  let new_file = TemplateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! OpenMVCController()
  let new_file = ControllerForCurrentFile()
  exec ':e ' . new_file
endfunction

function! OpenMVCView()
  let new_file = ViewForCurrentFile()
  exec ':e ' . new_file
endfunction

function! OpenMVCRoute()
  let new_file = RouteForCurrentFile()
  exec ':e ' . new_file
endfunction

function! TemplateForCurrentFile()
  let current_file = expand("%")
  let is_view = match(current_file, '\<views\>')  != -1
  let is_template = match(current_file, '\<templates\>')  != -1
  let is_controller = match(current_file, '\<controllers\>')  != -1
  let is_route = match(current_file, '\<routes\>')  != -1

  let new_file = current_file
  let new_file = substitute(new_file, '\.\+.*', '.handlebars', '')

  if is_view
    let new_file = substitute(new_file, '_view', '', '')
    let new_file = substitute(new_file, '\<views\>', 'templates', '')
  end

  if is_route
    let new_file = substitute(new_file, '_route', '', '')
    let new_file = substitute(new_file, '\<routes\>', 'templates', '')
  end

  if is_controller
    let new_file = substitute(new_file, '\<controllers\>', 'templates', '')
    let new_file = substitute(new_file, '_controller', '', '')
  end

  return new_file
endfunction

function! ControllerForCurrentFile()
  let current_file = expand("%")
  let is_view = match(current_file, '\<views\>')  != -1
  let is_template = match(current_file, '\<templates\>')  != -1
  let is_controller = match(current_file, '\<controllers\>')  != -1
  let is_route = match(current_file, '\<routes\>')  != -1

  let new_file = current_file

  if is_view
    let new_file = substitute(new_file, '_view', '_controller', '')
    let new_file = substitute(new_file, '\<views\>', 'controllers', '')
  end
  if is_template
    let new_file = substitute(new_file, '\.\+.*', '_controller.js.coffee', '') "coffee is hardcoded :(
    let new_file = substitute(new_file, '\<templates\>', 'controllers', '')
  end
  if is_route
    let new_file = substitute(new_file, '_route', '_controller', '')
    let new_file = substitute(new_file, '\<routes\>', 'controllers', '')
  end
  return new_file
endfunction

function! ViewForCurrentFile()
  let current_file = expand("%")
  let is_view = match(current_file, '\<views\>')  != -1
  let is_template = match(current_file, '\<templates\>')  != -1
  let is_controller = match(current_file, '\<controllers\>')  != -1
  let is_route = match(current_file, '\<routes\>')  != -1

  let new_file = current_file

  if is_controller
    let new_file = substitute(new_file, '_controller', '_view', '')
    let new_file = substitute(new_file, '\<controllers\>', 'views', '')
  end
  if is_template
    let new_file = substitute(new_file, '\.\+.*', '_view.js.coffee', '') "coffee is hardcoded :(
    let new_file = substitute(new_file, '\<templates\>', 'views', '')
  end
  if is_route
    let new_file = substitute(new_file, '_route', '_view', '')
    let new_file = substitute(new_file, '\<routes\>', 'views', '')
  end
  return new_file
endfunction

function! RouteForCurrentFile()
  let current_file = expand("%")
  let is_view = match(current_file, '\<views\>')  != -1
  let is_template = match(current_file, '\<templates\>')  != -1
  let is_controller = match(current_file, '\<controllers\>')  != -1
  let is_route = match(current_file, '\<routes\>')  != -1

  let new_file = current_file

  if is_controller
    let new_file = substitute(new_file, '_controller', '_route', '')
    let new_file = substitute(new_file, '\<controllers\>', 'routes', '')
  end
  if is_template
    let new_file = substitute(new_file, '\.\+.*', '_route.js.coffee', '') "coffee is hardcoded :(
    let new_file = substitute(new_file, '\<templates\>', 'routes', '')
  end
  if is_view
    let new_file = substitute(new_file, '_view', '_route', '')
    let new_file = substitute(new_file, '\<views\>', 'routes', '')
  end
  return new_file
endfunction

nnoremap <leader>.t :call OpenMVCTemplate()<cr>
nnoremap <leader>.c :call OpenMVCController()<cr>
nnoremap <leader>.v :call OpenMVCView()<cr>
nnoremap <leader>.r :call OpenMVCRoute()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') || match(current_file, '\<helpers\>') != -1 || match(current_file, '\<javascripts\>') != -1
  let in_assets = match(current_file, '\<javascripts\>')  != -1

  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    if in_assets
      let new_file = substitute(new_file, '^assets/', '', '')
    end

    let new_file = substitute(new_file, '\.js\(\.\{0,1\}\)\@=', '_spec.js', '')
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.js', '.js', '')
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_assets
      let new_file = 'assets/' . new_file
    end
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>.s :call OpenTestAlternate()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabularize
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"extra in after/plugin/tabular-extra.vim

vmap <Leader>a, :Tabularize first_comma<CR>
nmap <Leader>a, :Tabularize first_comma<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vroom_map_keys = 0
map <leader>t :call vroom#RunTestFile({'options':'--drb'})<cr>
map <leader>T :call vroom#RunNearestTestFile({'options':'--drb'})<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Md5 COMMAND
" Show the MD5 of the current buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" InsertTime COMMAND
" Insert the current time
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>

