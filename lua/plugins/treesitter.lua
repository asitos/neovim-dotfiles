return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-ts-autotag").setup()

			vim.schedule(function()
				require("nvim-treesitter").setup({
					ensure_installed = {
						"lua",
						"vim",
						"vimdoc",
						"bash",
						"markdown",
						"markdown_inline",
						"json",
						"html",
						"css",
						"javascript",
						"typescript",
						"c",
						"cpp",
						"qmljs",
						"php",
						"phpdoc",
					},
					highlight = { enable = true },
					indent = { enable = true },
				})
			end)
		end,
	},
}
