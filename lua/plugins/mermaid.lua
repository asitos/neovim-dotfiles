return {
	"kevalin/mermaid.nvim",
	ft = { "mermaid" },
	cmd = {
		"MermaidPreview",
		"MermaidPreviewStop",
		"MermaidFormat",
		"MermaidRender",
		"MermaidCopyURL",
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		format = {
			shift_width = 4,
		},
		preview = {
			renderer = "mermaid.js",
			theme = "default",
		},
	},
	config = function(_, opts)
		require("mermaid").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "mermaid",
			callback = function(args)
				local map = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
				end
				map("<leader>mp", "<cmd>MermaidPreview<CR>", "Mermaid: Preview in browser")
				map("<leader>mx", "<cmd>MermaidPreviewStop<CR>", "Mermaid: Stop preview")
				map("<leader>mf", "<cmd>MermaidFormat<CR>", "Mermaid: Format diagram")
				map("<leader>mr", "<cmd>MermaidRender<CR>", "Mermaid: Inline render")
				map("<leader>mc", "<cmd>MermaidCopyURL<CR>", "Mermaid: Copy preview URL")
			end,
		})
	end,
}
