return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })

			-- Lua
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})
			vim.lsp.enable("lua_ls")

			local servers = {
				"bashls",
				"html",
				"cssls",
				"ts_ls",
				"pyright",
				"intelephense",
				"emmet_language_server",
				"jdtls",
			}
			for _, server in ipairs(servers) do
				vim.lsp.config(server, {})
				vim.lsp.enable(server)
			end

			-- Specific config for clangd (critical for ESP32/Arduino to find compiler headers)
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--query-driver=**/.platformio/packages/**/bin/*g++,**/bin/arm-none-eabi-g++,**/bin/xtensa-esp32-elf-g++"
				}
			})
			vim.lsp.enable("clangd")

			-- Specific config for Arduino
			vim.lsp.config("arduino_language_server", {
				cmd = {
					"arduino-language-server",
					"-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
					"-cli", vim.fn.expand("~/.local/bin/arduino-cli"),
					"-clangd", "clangd"
				}
			})
			vim.lsp.enable("arduino_language_server")
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"clangd",
					"html",
					"cssls",
					"ts_ls",
					"pyright",
					"intelephense",
					"emmet_language_server",
					"jdtls",
					"arduino_language_server",
				},
				automatic_installation = true,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					python = { "black" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}
