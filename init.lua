-- 设置 leader 键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基础设置
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- 透明背景设置
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })

-- 终端设置
vim.opt.splitbelow = true              -- 在底部打开新窗口
vim.opt.shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'bash'  -- 优先使用 PowerShell
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false          -- 终端窗口不显示行号
    vim.opt_local.relativenumber = false  -- 终端窗口不显示相对行号
    vim.opt_local.signcolumn = 'no'       -- 终端窗口不显示标记列
    vim.cmd('startinsert')                -- 自动进入插入模式
  end,
})

-- 引导 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载插件
require("lazy").setup("plugins")

-- 加载核心配置
require("core.keymaps")

-- 设置文件编码为 UTF-8
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"

-- Windows 系统下的编码设置
if vim.fn.has('win32') == 1 then
    vim.opt.fileencoding = "utf-8"
    vim.opt.fileencodings = "utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
end

-- OpenAI 配置
vim.env.OPENAI_API_KEY = vim.fn.getenv('deepseek_key')  -- 从环境变量获取 API 密钥
vim.env.OPENAI_API_HOST = "https://api.deepseek.com"

-- 如果需要代理
vim.env.http_proxy = "http://127.0.0.1:7890"
vim.env.https_proxy = "http://127.0.0.1:7890"
