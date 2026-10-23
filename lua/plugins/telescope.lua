return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { height = 0.9 },
                file_ignore_patterns = { "node_modules", "%.git/", "/Games", "venv", "/Music", "/STM" },
            },
            extensions = {
                file_browser = {
                    hidden = true,
                    respect_gitignore = false,
                },
                ["ui-select"] = {},
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("ui-select")
            telescope.load_extension("file_browser")
        end,
    },
}
