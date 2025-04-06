-- 设置 leader 键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基础设置
local opt = vim.opt

-- 设置基本选项
opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.wrap = true
opt.breakindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.termguicolors = true
opt.fileencoding = "utf-8"
opt.encoding = "utf-8"
opt.splitbelow = true

-- 设置 shell
opt.shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'bash'

-- 透明背景设置
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })

-- 终端设置
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    local term_opt = vim.opt_local
    term_opt.number = false
    term_opt.relativenumber = false
    term_opt.signcolumn = 'no'
    vim.cmd('startinsert')
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

-- Windows 系统下的编码设置
if vim.fn.has('win32') == 1 then
    opt.fileencoding = "utf-8"
    opt.fileencodings = "utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
end

-- OpenAI 配置
vim.env.OPENAI_API_KEY = vim.fn.getenv('deepseek_key')
vim.env.OPENAI_API_HOST = "https://api.deepseek.com"

-- 如果需要代理
vim.env.http_proxy = "http://127.0.0.1:7890"
vim.env.https_proxy = "http://127.0.0.1:7890"
