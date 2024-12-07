-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
-- Unmap arrow keys in normal mode
lvim.keys.normal_mode["<Up>"] = ""
lvim.keys.normal_mode["<Down>"] = ""
lvim.keys.normal_mode["<Left>"] = ""
lvim.keys.normal_mode["<Right>"] = ""
-- Unmap arrow keys in visual mode

lvim.keys.visual_mode["<Up>"] = ""
lvim.keys.visual_mode["<Down>"] = ""
lvim.keys.visual_mode["<Left>"] = ""
lvim.keys.visual_mode["<Right>"] = ""
--Themes
lvim.colorscheme = "dracula"

--Configuration for python

lvim.builtin.treesitter.ensure_installed = {
  "python",
  "html",
  "javascript",
  "css",
}
-- Certifique-se de que o servidor jdtls está instalado
local home = os.getenv("HOME")
local workspace_dir = home .. "/.workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- Desabilitar configuração automática para evitar conflitos
lvim.lsp.automatic_configuration.skipped_servers = { "jdtls" }

-- Configurar jdtls manualmente
require("lvim.lsp.manager").setup("jdtls", {
    cmd = { "jdtls", "-data", workspace_dir },
    on_attach = function(client, bufnr)
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()
    end,
    settings = {
        java = {
            format = {
                enabled = true,
            },
        },
    },
})


local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" , filetypes = { "python" } },
  { name = "prettier", filetypes = { "javascript", "html", "css", "json" } }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", args = { "--ignore=E203" }, filetypes = { "python" } } }

lvim.plugins = {
  "AckslD/swenv.nvim",
  "stevearc/dressing.nvim",
  "Mofiqul/dracula.nvim",
  "folke/tokyonight.nvim",
  "hat0uma/csvview.nvim",
  "mfussenegger/nvim-jdtls",

}

require('swenv').setup({
  post_set_venv = function()
    vim.cmd("LspRestart")
  end,
})


