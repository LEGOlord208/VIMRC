call plug#begin()

Plug 'aperezdc/vim-template'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'PeterRincker/vim-argumentative'
Plug 'dhruvasagar/vim-table-mode'

Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Languages
Plug 'Xe/lolcode.vim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'fatih/vim-go'
Plug 'justmao945/vim-clang'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'udalov/kotlin-vim'
Plug 'vim-ruby/vim-ruby'

call plug#end()

" Settings
set ts=4
set sw=0
set cursorline
set number
set splitright
set nrformats=alpha,octal,hex

" Colors
set background=dark
colorscheme base16-default-dark

hi CursorLine ctermbg=green cterm=none
hi LineNr ctermfg=darkgray
hi Normal ctermbg=none
hi Trail ctermbg=red

" Auto commands
au BufWinEnter * match Trail /\s\+$/ " Copy pasted from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
au BufEnter * silent! lcd %:p:h

au FileType fish compiler fish
au FileType yaml,markdown setlocal ts=2 expandtab indentkeys=

" NERDTree copy pastes
au VimEnter * NERDTree | wincmd p
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Plugins
let g:go_template_autocreate = 0
let g:go_fmt_command = 'goimports'
let g:go_metalinter_autosave = 1

let g:rustfmt_autosave = 1
let g:rust_recommended_style = 0
let g:racer_cmd = '~/.cargo/bin/racer'
let g:racer_experimental_completer = 1

let g:airline_theme = 'base16_default'

let g:AutoPairsMultilineClose = 0
let g:AutoPairsMapBS = 0

" Commands
function! JSON()
	%!python -m json.tool
	retab!
endfunction
function! JavaFmt()
	silent %!java -jar ~/.config/nvim/google-java-format-1.3-all-deps.jar -
	let tab = &ts
	let &ts=2
	retab!
	let &ts=tab
endfunction
function! InjectSemicolon()
	let pos = getpos(".")
	normal! A;
	call setpos(".", pos)
endfunction

command! CWD silent! lcd %:p:h | echo "Changed directory!"
command! Term silent! lcd %:p:h | tabe +terminal
command! VTerm silent! lcd %:p:h | vnew +terminal
command! SudoW silent exec "w !sudo tee %" | echo "Saved!"

command! JSON call JSON()
command! JSONMIN silent %!ruby ~/.config/nvim/minify.rb
command! JavaFmt call JavaFmt()
command! -nargs=1 Keyword syn keyword Keyword <args>

nnoremap <leader>; :call InjectSemicolon()<CR>
nnoremap <leader>n :NERDTree \| wincmd p<CR>
vnoremap <leader>c y`>a = <c-r>=<c-r>"<cr><esc>
tnoremap <esc><esc> <c-\><c-n>
