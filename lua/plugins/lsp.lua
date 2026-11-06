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

			-- Diagnostic display options
			vim.diagnostic.config({
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
				},
			})

			-- Demote unused variable/function/param diagnostics from Error to Warning
			local default_publish_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
			vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
				if result and result.diagnostics then
					for _, diag in ipairs(result.diagnostics) do
						local is_unused = (
							diag.code == "UnusedVar"
							or diag.code == "UnusedParam"
							or diag.code == "UnusedFunc"
							or diag.code == "U1000"
							or (diag.user_data and diag.user_data.lsp and diag.user_data.lsp.code == "UnusedVar")
						) or (diag.message and (
							diag.message:match("declared and not used")
							or diag.message:match("declared but not used")
							or diag.message:match("unused parameter")
							or diag.message:match("is unused")
						))

						if is_unused and diag.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
							diag.severity = vim.lsp.protocol.DiagnosticSeverity.Warning
						end
					end
				end
				return default_publish_handler(err, result, ctx, config)
			end

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

			-- Specific config for Go (gopls)
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							unusedvariable = true,
							unusedwrite = true,
							shadow = true,
						},
						staticcheck = true,
					},
				},
			})
			vim.lsp.enable("gopls")

			-- Specific config for clangd (critical for ESP32/Arduino to find compiler headers)
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--query-driver=**/.platformio/packages/**/bin/*g++,**/bin/arm-none-eabi-g++,**/bin/xtensa-esp32-elf-g++"
				}
			})
			vim.lsp.enable("clangd")

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
					"gopls",
				},
				automatic_installation = true,
				automatic_enable = {
					exclude = { "arduino_language_server" },
				},
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
					go = { "gofmt" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}
