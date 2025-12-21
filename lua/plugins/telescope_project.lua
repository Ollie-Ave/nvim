return {
    "nvim-telescope/telescope-project.nvim",
    after = "telescope.nvim",
    config = function()
        require("telescope").load_extension("project")

        vim.keymap.set('n', '<C-q>', '<cmd>Telescope projects<cr>', { silent = true })
    end,
}
