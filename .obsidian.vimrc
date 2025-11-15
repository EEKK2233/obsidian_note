" ========================================
" Obsidian Vim Support Configuration
" ========================================

" 设置 Leader 键为空格
let mapleader = " "

" ========================================
" 插入模式映射
" ========================================
" Alt + hjkl 移动光标
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

" jk 快速退出插入模式
inoremap jk <Esc>

" ========================================
" 视觉模式映射
" ========================================
" 移动选中的行 (上下移动)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ========================================
" 普通模式映射
" ========================================
" 取消搜索高亮
nnoremap <leader>nh :nohl<CR>

" 切换标签页 (Obsidian 中对应切换笔记)
nnoremap <C-]> :tabnext<CR>
nnoremap <C-[> :tabprevious<CR>

" ========================================
" Obsidian 特定命令 (需要安装 Vimrc Support 插件)
" ========================================
" 打开/关闭左侧边栏 (类似 NvimTree)
exmap toggleLeftSidebar obcommand app:toggle-left-sidebar
nnoremap <leader>e :toggleLeftSidebar<CR>

" 打开文件搜索
exmap openQuickSwitcher obcommand obsidian-quick-switcher:search-obsidian
nnoremap <leader>ff :openQuickSwitcher<CR>

" 全局搜索
exmap openSearch obcommand global-search:open
nnoremap <leader>fg :openSearch<CR>

" 创建新笔记
exmap newNote obcommand file-explorer:new-file
nnoremap <leader>nn :newNote<CR>

" 切换编辑/预览模式
exmap toggleMode obcommand markdown:toggle-preview
nnoremap <leader>tm :toggleMode<CR>

" 打开命令面板
exmap showCommands obcommand command-palette:open
nnoremap <leader>sc :showCommands<CR>

" ========================================
" 通用 Vim 设置
" ========================================
" 设置超时时间
set timeout
set timeoutlen=1000

" 显示行号
set number
set relativenumber

" 搜索设置
set ignorecase
set smartcase
set incsearch
set hlsearch

" 剪贴板共享
set clipboard=unnamed

" ========================================
" 说明
" ========================================
" 注意:
" 1. Obsidian 的 Vim 支持基于 CodeMirror Vim 模式
" 2. 部分高级功能可能不支持,需要配合 Vimrc Support 插件使用
" 3. exmap 命令用于映射 Obsidian 的内部命令
" 4. 可以通过 Ctrl+Shift+I 打开开发者工具查看可用命令 ID