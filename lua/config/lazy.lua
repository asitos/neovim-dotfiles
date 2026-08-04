require("lazy").setup({
	-- { import = "plugins.arduino" },
	{ import = "plugins.barbar" },
	{ import = "plugins.cmp" },
	{ import = "plugins.core" },
	{ import = "plugins.dashboard" },
	{ import = "plugins.flash" },
	{ import = "plugins.lazygit" },
	{ import = "plugins.lsp" },
	{ import = "plugins.lualine" },
	-- { import = "plugins.obsidian" },
	{ import = "plugins.render-markdown" },
	{ import = "plugins.oil" },
	{ import = "plugins.telescope" },
	{ import = "plugins.toggleterm" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.treesj" },
	{ import = "plugins.twilight" },

	lockfile = false,
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
})
