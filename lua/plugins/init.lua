return {
    { import = "plugins.telescope" },
    { import = "plugins.telescope_project" },
    { import = "plugins.transparent" },
    { import = "plugins.lsp" },
    { import = "plugins.lualine" },
    { import = "plugins.nvim-tree" },
    { import = "plugins.noice" },
    { import = "plugins.lazygit" },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
    },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup{}
        end,
    },

    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                detection_methods = { "pattern", "lsp" },
                patterns = { ".git", "Makefile", "package.json" },
                show_hidden = true,
            })
        end,
    },

    {
        -- They Say:
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.buttons.val = {
                dashboard.button("p", "  Projects", ":Telescope projects<CR>"),
                dashboard.button("f", "  Find Files", ":Telescope find_files<CR>"),
                dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
                dashboard.button("q", "  Quit", ":qa<CR>"),
            }

            table.insert(dashboard.config.layout, 1, {
                type = "padding",
                val = math.floor(vim.fn.winheight(0) * 0.25),
            })

            alpha.setup(dashboard.config)
        end,
    },
}
