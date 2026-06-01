return {
    -- Imports (fine, but their internal specs matter)
    { import = "plugins.telescope" },
    { import = "plugins.telescope_project" },
    { import = "plugins.transparent" },
    { import = "plugins.lsp" },
    { import = "plugins.lualine" },
    { import = "plugins.nvim-tree" },
    { import = "plugins.noice" },
    { import = "plugins.lazygit" },
    { import = "plugins.blame" },

    -- Copilot (currently eager in your config)
    {
        "github/copilot.vim",
        event = "InsertEnter",
    },

    -- Roslyn (should not load at startup)
    {
        "seblyng/roslyn.nvim",
        opts = {
            silent = true,
        },
        ft = { "cs" },
    },

    -- Treesitter (good)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
    },

    -- Autopairs (should be insert-driven)
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    -- Project.nvim (was executing on startup before)
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function()
            require("project_nvim").setup({
                manual_mode = true,
                detection_methods = { "pattern", "lsp" },
                patterns = {
                    "*.sln",
                    ".git",
                    "Makefile",
                    "pnpm-workspace.yaml",
                    "package.json",
                },
                show_hidden = true,
            })
        end,
    },

    -- Alpha dashboard (must be startup-safe but lazy-loaded)
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VimEnter",
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
