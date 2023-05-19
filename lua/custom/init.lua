--- Scopes
--- vim.o Gets or sets general settings e.g. 
--- vim.o.background = 'light'
--- vim.wo Gets or sets window-scoped options e.g.
--- vim.wo.colorcolumn = '80'
--- vim.bo Gets or sets buffer-scoped options. e.g.
--- vim.bo.filetype = 'lua'
--- vim.g Gets or sets global variables. 
--- This is usually the namespace where you'll find variables set by plugins. The only one I know isn't tied to a plugin is the leader key.
--- e.g. use space as a the leader key
--- vim.g.mapleader = ' '
--- You should know that some variable names in vimscript are not valid in lua. 
--- We still have access to them but we can't use the dot notation. 
--- E.g. vim-zoom has a variable called zoom#statustext and in vimscript we use it like this.
--- let g:zoom#statustext = 'Z'
--- In lua we would have to do this.
--- vim.g['zoom#statustext'] = 'Z'
--- As you might have guessed this also gives us an oportunity to access properties which have the name of keywords. 
--- You may find yourselves in a situation where you need to access a property called for, 
--- do or end which are reserved keywords, in those cases remember this bracket syntax.
--- vim.env Gets or sets environment variables. e.g.
--- vim.env.FZF_DEFAULT_OPTS = '--layout=reverse'
--- As far as I know if you make a change in an environment variables the change will only apply in the active neovim session.
--- But now how do we know which "scope" we need to use when we're writting our config? 
--- Don't worry about that, think of vim.o and company just as a way to read values. 
--- When it's time set values we can use another method.
--- vim.opt -- With vim.opt we can set global, window and buffer settings.
--- -- buffer-scoped
--- vim.opt.autoindent = true
--- -- window-scoped
--- vim.opt.cursorline = true
--- -- global scope
--- vim.opt.autowrite = true
--- When we use it like this vim.opt acts like the :set command in vimscript, it give us a consistent way to modify neovim's options.
--- A funny thing you can do is assign vim.opt to a variable called set.
--- Say we have this piece of vimscript.
--- " Set the behavior of tab
--- set tabstop=2
--- set shiftwidth=2
--- set softtabstop=2
--- set expandtab
--- We could translate this easily in lua like this.
--- 
--- local set = vim.opt
--- 
--- -- Set the behavior of tab
--- set.tabstop = 2
--- set.shiftwidth = 2
--- set.softtabstop = 2
--- set.expandtab = true

--- backups etc ==================================================================
local set = vim.opt

vim.cmd [[
set backup
set backupdir=~/vimfiles/bak
set directory=~/vimfiles/temp
set backupext=.bak
" --- Permanent undo
set undodir=~/vimfiles/undo
set undofile
]]

--- tabs, as in... #space, -denting, etc. =================================
--- main way #1 to use tabs: use a mix of tabs and spaces, but typing
--- <Tab> and <BS> will behave like a tab appears every 4 (or 3) characters.
--set.noexpandtab=true ---do not subst tabs with spaces
set.tabstop=8 --- Number of spaces that a <Tab> in the file counts for. 

--- softtabstop - Number of spaces that a <Tab> counts for while performing editing
--- operations, like inserting a <Tab> or using <BS>.  It 'feels' like
--- <Tab>s are being inserted, while in fact a mix of spaces and <Tab>s is
--- used.  This is useful to keep the 'ts' setting at its standard value
--- of 8, while being able to edit like it is set to 'sts'.  However, commands like
--- 'x' still work on the actual characters.
set.softtabstop=4

--- shiftwidth - Number of spaces to use for each step of (auto)indent.
set.shiftwidth=4
--- Language-specific -- MAYBE: figure out how to do this in lua
vim.cmd [[
au FileType yaml set ts=2 sw=2 sts=2
au FileType json set ts=2 sw=2 sts=2
au FileType html set ts=2 sw=2 sts=2
au FileType css set ts=2 sw=2 sts=2
au FileType xml set ts=2 sw=2 sts=2
]]

--- smarttab - When on, a <Tab> in front of a line inserts blanks according to
--- 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.
--- A <BS> will delete a 'shiftwidth' worth of space at the start of the line
set.smarttab=true

--- autoindent - when noexpandtab is set, autoindent also allows 
--- shifting tabs left/right when v/V with < and > resp.)
set.autoindent=true

--- tabs, as in... those file-seperator-thingies up top ================= 
--set.showtabline=false -- TODO: figure out if this conflicts with nvchad config...

--- buffers ===================================================================
--- navigate quickly next/prev with Alt-h/l
---  moved to mappings (so it's included in whichkey)

--- window-(re)sizing etc =====================================================
set.wrap=true --- always wrap long lines

--- allow Ctrl+W+_ to resize a split tompletely (keeping only the statusbar of
--- other splits)
set.winminheight=0
--- alt-jk allow resizing up/down of horizontal splits 
--- do know that if in the bottom split and pressing <M-k> your statusline moves
--- up... but you can of course simply reverse it with <M-j>

---  TODO: add noremap to below 4
vim.keymap.set('n', '<M-k>', ': resize -1<CR>')
vim.keymap.set('n', '<M-u>', ': resize -10<CR>')
vim.keymap.set('n', '<M-j>', ': resize +1<CR>')
vim.keymap.set('n', '<M-d>', ': resize +10<CR>')

--- moving (stuff) around ======================================================
--- Tip #646: moving lines up/down in a file -- note#2
--- move the current line up or down
vim.keymap.set('n', '<C-Down>', ':m+<CR>==')
vim.keymap.set('i', '<C-Down>', '<C-O>:m+<CR><C-O>==')
vim.keymap.set('n', '<C-Up>', ':m-2<CR>==')
vim.keymap.set('i', '<C-Up>', '<C-O>:m-2<CR><C-O>==')

--- move the selected block up or down
--- fyi can't be arsed to figure out how to escape < and > in lua so vim.cmd()
vim.cmd([[
vmap <C-Down>  :m'>+<CR>gv=gv
vmap <C-Up> :m'<-2<CR>gv=gv
]])

--- move the current line left or right
--- fyi can't be arsed to figure out how to escape < and > in lua so vim.cmd()
vim.cmd([[
nmap <C-Left> <<
nmap <C-Right> >>
imap <C-Left> <C-O><<
imap <C-Right> <C-O>>>
xnoremap <C-Right> >gv|
xnoremap <C-Left> <gv
nnoremap <C-Right> >>_
nnoremap <C-Left> <<_
]])

--- eyecandy to improve *productivity* =========================================
set.number=true
set.relativenumber=true
---set nocopyindent
set.cursorline=false --- no underlining of current/cursor line
set.smartindent=true --- indent next line (c-like programmaming languages)
--set.noautoindent=true --  warning: set autoindent may result in copy paste horrorshow
--set.cmdheight=1  -- always have the statusbar visible;
--set.cmdwinheight=7 --  number of screen lines to use for the command-line (!) window
--set.numberwidth=5 --  allow 'bigger' files


--kset.guicursor="n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
--- don't auto-exit with q if multiple buffers are open...
--- TODO: add noremap to below line
vim.keymap.set('n', '<C-q>', ':confirm qall<CR>')
--- vim.cmd([[
--- noremap <C-q> :confirm qall<CR>
--- ]])

--- apply *after* loading colorscheme or some will get overridden
--= vim.cmd([[
--= hi clear SignColumn
--= hi clear LineNr
--= hi clear CursorLineNr
--= hi clear CursorLineFold
--= hi clear CursorLineSign
--= hi clear CurSearch
--= hi clear CursorColumn
--= hi clear Cursorline
--= hi clear MarkdownUrl
--= ]])

--- from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vim.cmd([[
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif
]])

--local options = vim.o

--- Javascript

--options.javascript.fold=false

--- Open hotkeys
--- TODO: add to mappings in nvchad (so they show up via whichkeys)
vim.cmd([[
map <C-p> :files<CR>
nmap <leader>; :buffers<CR>
]])

--- Don't confirm .lvimrc
vim.g.localvimrc_ask = false


--- rust
vim.g.rustfmt_autosave = true
vim.g.rustfmt_emit_files = true
vim.g.rustfmt_fail_silently = false
vim.g.rust_clip_command = 'xclip -selection clipboard'

--- Completion
--- Better completion
--- menuone: popup even when th:were's only one match
--- noinsert: Do not insert text until a selection is made
--- noselect: Do not select, force user to select one from the menu
--set.completeopt=menuone,noinsert,noselect
--- Better display for messages
set.cmdheight=1
--- You will have bad experience for diagnostic messages when it's default 4000.
set.updatetime=300

--- Sane splits
set.splitright=true
set.splitbelow=true

--- proper search
set.incsearch=true

--- =============================================================================
--- # GUI settings
--- =============================================================================
set.vb=false --:: t_vb= " No more beeps
--set.backspace=2 -- Backspace over newlines
vim.wo.colorcolumn='80' -- and give me a colored column
set.laststatus=2
--set.mouse=all -- Enable mouse usage (all modes) in terminals
--set.shortmess+=c -- don't give |ins-completion-menu| messages.

--- vim.cmd([[
--- au TextYankPost * silent! lua vim.highlight.on_yank() " Highlight yank
--- ]])

--- Show those damn hidden characters
--- Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
---set.listchars='nbsp:¬,eol:¶,extends:»,precedes:«,lead:•,trail:•,tab:<->'
---set.listchars='nbsp:¬,eol:↵¶,extends:»,precedes:«,lead:•,trail:•,tab:<->'
---set.listchars='nbsp:·,eol:←↓,trail:·,tab:⇤-⇥'
set.listchars='nbsp:·,extends:»,precedes:«,lead:·,eol:↵,trail:·,tab:|·'

vim.cmd([[
"set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set invlist
]])


--- --- Neat X clipboard integration
--- --- ,p will paste clipboard into buffer
--- --- ,c will copy entire buffer into clipboard
vim.keymap.set('n', '<leader>xp', ':read !xsel --clipboard --output<CR>')
vim.keymap.set('n', '<leader>xy',':w !xsel -ib<CR><CR>')
--
--
--
--- --- <leader>s for Rg search
--- vim.cmd([[
--- noremap <leader>s :Rg
--- let g:fzf_layout = { 'down': '~20%' }
--- command! -bang -nargs=* Rg
---   \ call fzf#vim#grep(
---   \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
---   \   <bang>0 ? fzf#vim#with_preview('up:60%')
---   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
---   \   <bang>0)
--- 
--- function! s:list_cmd()
---   let base = fnamemodify(expand('%'), ':h:.:S')
---   return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
--- endfunction
--- 
--- command! -bang -nargs=? -complete=dir Files
---   \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
---   \                               'options': '--tiebreak=index'}, <bang>0)
--- 
--- --- Open new file adjacent to current file
--- nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>
--- 
--- --- No arrow keys --- force yourself to use the home row
--- nnoremap <up> <nop>
--- nnoremap <down> <nop>
--- inoremap <up> <nop>
--- inoremap <down> <nop>
--- inoremap <left> <nop>
--- inoremap <right> <nop>
--- 
--- --- Left and right can switch buffers
--- nnoremap <left> :bp<CR>
--- nnoremap <right> :bn<CR>
--- 
--- --- Move by line
--- nnoremap j gj
--- nnoremap k gk
--- 
--- --- <leader><leader> toggles between buffers
--- nnoremap <leader><leader> <c-^>
---
--- --- <leader>, shows/hides hidden characters
--- nnoremap <leader>, :set invlist<cr>
--- nnoremap <leader>, :set invlist<cr>
--- 
--- --- I can type :help on my own, thanks.
--- map <F1> <Esc>
--- imap <F1> <Esc>
--- ]])
--- --- Folding (when in nvim, use treesitter) ======================================
--- --- enable folding, and fold every indented blocks
--- --- how to use zi/zm/zr >>> :help folding
--- set.foldenable=true
--- set.foldmethod.indent=true
--- set.foldlevel=1
--- 
--- --- treesitter folding is a mess... try out again later when more stable
--- --- set foldmethod=expr
--- --- set foldexpr=nvim_treesitter#foldexpr()
--- --- " set foldexpr=getline(v:lnum)[0]==\"\\t\"
--- --- set nofoldenable                     " Disable folding at startup.
--- 
--- 
--- --- scratchbuffers ==============================================================
--- --- make starting a new scratch buffer (like on startup with no args, or via
--- --- <leader>ss) a bit more offensive...
--- vim.cmd([[
--- fun! StartNewOffensiveScratchBuffer()
---     " Start a new buffer ...
---     enew
--- 
---     " ... and set some options for it
---     setlocal
---         \ bufhidden=wipe
---         \ buftype=nofile
---         \ nobuflisted
---         \ nocursorcolumn
---         \ nocursorline
---         \ nolist
---         \ nonumber
---         \ noswapfile
--- 				\ nofoldenable
---         \ norelativenumber
--- 
---     " Now we can just write to the buffer, whatever you want.
---     " (in this case, `fortune` is required, and it needs to support -o)
---     call append('$', "")
---     for line in split(system('fortune -no'), '\n')
---         call append('$', '        ' . l:line)
---     endfor
--- 
---     " No modifications to this buffer
---     setlocal nomodifiable nomodified
--- 
---     " When we go to insert mode start a new buffer, and start insert
---     nnoremap <buffer><silent> e :enew<CR>
---     nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
---     nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
--- endfun
--- 
--- --- when starting up (n)vim without filename (in scratch mode) do it in style
--- --- set shortmess+=I
--- fun! StartingVim()
---     " Don't run if: we have commandline arguments, we don't have an empty
---     " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
---     if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
---         return
---     endif
---     
---     " now disabling the default startup msg
---     " now replace the default startup msg with something offensively
---     call StartNewOffensiveScratchBuffer()
--- endfun
--- 
--- --- <space>ss creates a scratch buffer (as if on startup)
--- nnoremap <leader>ss :call StartNewOffensiveScratchBuffer()<cr>
--- vnoremap <leader>ss :call StartNewOffensiveScratchBuffer()<cr>
--- 
--- --- =============================================================================
--- --- # Autocommands
--- --- =============================================================================
--- 
--- --- Prevent accidental writes to buffers that shouldn't be edited
--- autocmd BufRead *.orig set readonly
--- autocmd BufRead *-ori set readonly
--- autocmd BufRead *-old set readonly
--- autocmd BufRead *-pre set readonly
--- autocmd BufRead *.pacnew set readonly
--- 
--- --- Leave paste mode when leaving insert mode
--- autocmd InsertLeave * set nopaste
--- 
--- --- Jump to last edit position on opening file
--- if has("autocmd")
---   " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
---   au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
--- endif
--- 
--- --- Follow Rust code style rules
--- au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
--- au Filetype rust set colorcolumn=100
--- 
--- --- Help filetype detection
--- autocmd BufRead *.plot set filetype=gnuplot
--- autocmd BufRead *.md set filetype=markdown
--- autocmd BufRead *.yaml set filetype=yaml
--- autocmd BufRead *.yml set filetype=yaml
--- autocmd BufRead *.pl set filetype=perl
--- autocmd BufRead *.pm set filetype=perl
--- autocmd BufRead *.qf3 set filetype=php
--- autocmd BufRead *.qfx set filetype=php
--- 
--- --- Script plugins
--- --autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim
--- 
--- --- Run after "doing all the startup stuff"
--- autocmd VimEnter * call StartingVim()
--- ]])
