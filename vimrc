:let mapleader = "-"
:let maplocalleader = "\\"

:" DeepSeek 插件配置 {{{
let g:deepseek_api_key = "sk-196d2771df8241688c644feac65399a4"  " 替换为你的API密钥
" 可选配置
" " let g:deepseek_doc_dir = "/sdcard/my_documents"  " 自定义文档目录
" " let g:deepseek_no_mappings = 1  " 禁用默认快捷键
" }}}

" common tags ---------- {{{
set nu
set relativenumber
set helplang=cn
set encoding=utf-8
syntax enable
syntax on
set cursorline
set expandtab
"set hlsearch incsearch
set clipboard=unnamed
nnoremap <S-Left> :vertical resize-1<cr>
nnoremap <S-Right> :vertical resize+1<cr>
nnoremap <S-Up> :resize-1<cr>
nnoremap <S-Down> :resize+1<cr>
"}}}

" Vimscript file setting ---------------  {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" getting things done {{{
:filetype plugin on
:let g:gtd#dir = '~/notes'
:let g:gtd#review = [
		\ '(!inbox + !scheduled-'.strftime("%Y%m%d").') ',
		\ '!todo ',
		\ '!waiting ',
		\ ]
" }}}

" set tags {{{
	set tags+=./tags
    set tags+=~/workspace/aosp/external/libfuse/tags 
" }}}

" set auto indent for diffrent type {{{
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ai
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sw=4
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ts=4
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sts=4
autocmd FileType javascript,html,css,xml set ai
autocmd FileType javascript,html,css,xml set sw=2
autocmd FileType javascript,html,css,xml set ts=2
autocmd FileType javascript,html,css,xml set sts=2
autocmd FileType make set noexpandtab
" }}}

" NERDTree group {{{
augroup NERDTree
	autocmd!	
	"autocmd VimEnter * NERDTree| wincmd p
	nnoremap <leader>n :NERDTreeToggle<cr>
	inoremap <F2> <esc>:NERDTreeToggle<cr>i
	vnoremap <F2> <esc>:NERDTreeToggle<cr>v
	let NERDTreeIgnore = ['\.pyc$','output']

	" Exit Vim if NERDTree is the only window remaining in the only tab.
	autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
	" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
	autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    		\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
	" show bookmarks
	let NERDTreeShowBookmarks=1
augroup END
" }}}

" Leaderf group {{{

augroup Leaderf
	autocmd!
	" don't show the help in normal mode
    let g:Lf_HideHelp = 1
    let g:Lf_UseVersionControlTool = 0
    let g:Lf_IgnoreCurrentBufferName = 1
    " popup mode
    let g:Lf_WindowPosition = 'bottom'
    let g:Lf_PreviewInPopup = 1
    let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
    let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

    let g:Lf_ShortcutF = "<leader>ff"
    noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
    noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
    noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
    noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

    "noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
    "noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
    " search visually selected text literally
    "xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
    "noremap go :<C-U>Leaderf! rg --recall<CR>

    " should use `Leaderf gtags --update` first
    let g:Lf_GtagsAutoGenerate = 0
    let g:Lf_Gtagslabel = 'native-pygments'
    noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
    noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
    noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
    noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
    noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

augroup END
" }}}

" Floaterm settings {{{
let g:floaterm_keymap_new = '<leader>ft'
" }}}

" leader map {{{
:nnoremap <leader>ev :edit $MYVIMRC<cr>
:nnoremap <leader>esh :edit $HOME/.zshrc<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:noremap <leader>t :TranslateW<cr>
" }}}

"Statusline format setting ---------------- {{{
:set statusline=%f\ -\ FileType:\ %y
" }}}

" compile and run {{{
augroup run
	autocmd!
	noremap <leader>r :call f4cf5r#CompileAndRun() <CR>
augroup END
" }}}
 
" ycm configuration {{{

highlight PMenu ctermfg=blue ctermbg=236 guifg=white guibg=darkgrey
highlight PMenuSel ctermfg=white ctermbg=237 guifg=white guibg=black
set completeopt=longest,menu 
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap pumvisible() ? "\" : "\"
let g:ycm_show_diagnostics_ui = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/pack/vendor/start/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=0

let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
"endfor

" }}}

" snippets config {{{

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" }}}

" Plugins {{{
call plug#begin("~/.vim/pack/vendor/start/")
Plug 'ycm-core/YouCompleteMe'
Plug 'voldikss/vim-floaterm'
Plug 'Yggdroot/LeaderF'
Plug 'preservim/nerdtree'
Plug 'voldikss/vim-translator'
Plug 'honza/vim-snippets'
Plug 'heronghua/ctrlp.vim'
Plug 'git@github.com:heronghua/account.git'
Plug 'https://gitee.com/he_ronghua/newFile.git'
Plug 'https://gitee.com/he_ronghua/f4-compile-f5-run.git'
Plug 'fifi2/gtd.vim'
Plug 'heronghua/vim-dadbod'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
call plug#end()
" }}}   

" 复制到系统剪贴板 {{{
au TextYankPost * call system('termux-clipboard-set &', @")

" 粘贴时读取系统剪贴板
function! Paste()
    let @" = system('termux-clipboard-get')
    return 'p'
endfunction
nnoremap <expr> p Paste()
nnoremap <expr> P 'P'  " 保留大写 P 行为[citation:1][citation:4]
"}}}
