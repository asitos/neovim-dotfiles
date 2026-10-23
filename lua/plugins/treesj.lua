return {
	"Wansmer/treesj",
	keys = {
		{ "<leader>m", desc = "TreeSJ: Toggle split/join" },
		{ "<leader>M", desc = "TreeSJ: Recursive toggle" },
		{ "gS", desc = "TreeSJ: Split block" },
		{ "gJ", desc = "TreeSJ: Join block" },
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		use_default_keymaps = false,
		max_join_length = 150,
	},
	config = function(_, opts)
		local treesj = require("treesj")
		treesj.setup(opts)

		vim.keymap.set("n", "<leader>m", treesj.toggle, { desc = "TreeSJ: Toggle split/join" })
		vim.keymap.set("n", "<leader>M", function()
			treesj.toggle({ split = { recursive = true } })
		end, { desc = "TreeSJ: Recursive toggle" })
		vim.keymap.set("n", "gS", treesj.split, { desc = "TreeSJ: Split block" })
		vim.keymap.set("n", "gJ", treesj.join, { desc = "TreeSJ: Join block" })
	end,
}
