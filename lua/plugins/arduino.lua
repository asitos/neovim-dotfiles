return {
	"yuukiflow/Arduino-Nvim",
	ft = "arduino",
	cmd = {
		"InoCheck",
		"InoUpload",
		"InoSelectBoard",
		"InoSelectPort",
		"InoStatus",
		"InoMonitor",
		"InoGUI",
		"InoList",
		"InoUno",
		"InoNano",
		"InoNanoOld",
	},
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = {
		board = "arduino:avr:uno",
		port = "/dev/ttyUSB0",
		baudrate = 115200,
		use_default_keymaps = false,
		keymaps = {
			{ mode = "n", key = "<leader>ab", func = ":InoCheck<CR>", opts = { silent = true, desc = "Arduino: Compile code" } },
			{ mode = "n", key = "<leader>au", func = ":InoUpload<CR>", opts = { silent = true, desc = "Arduino: Upload code" } },
			{ mode = "n", key = "<leader>aB", func = ":InoSelectBoard<CR>", opts = { silent = true, desc = "Arduino: Select board (Telescope)" } },
			{ mode = "n", key = "<leader>ap", func = ":InoSelectPort<CR>", opts = { silent = true, desc = "Arduino: Select port" } },
			{ mode = "n", key = "<leader>am", func = ":InoMonitor<CR>", opts = { silent = true, desc = "Arduino: Serial monitor" } },
			{ mode = "n", key = "<leader>as", func = ":InoStatus<CR>", opts = { silent = true, desc = "Arduino: Board status" } },
			{ mode = "n", key = "<leader>ag", func = ":InoGUI<CR>", opts = { silent = true, desc = "Arduino: Board & port GUI" } },
		},
	},
	config = function(_, opts)
		-- Fix upstream bug: InoSelectBoard passes cmd opts table as callback
		local p_telescope = require("Arduino-Nvim.pickers.telescope")
		local orig_select_board = p_telescope.select_board
		p_telescope.select_board = function(cb)
			if type(cb) ~= "function" then
				cb = nil
			end
			return orig_select_board(cb)
		end

		require("Arduino-Nvim").setup(opts)

		-- Safeguard root_dir to prevent nil rootUri crash
		if vim.lsp.config["arduino-language-server"] then
			local util = require("lspconfig.util")
			vim.lsp.config["arduino-language-server"].root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				local root = util.root_pattern("sketch.yaml", ".arduino_config.lua", "*.ino")(fname)
				if not root or root == "" then
					root = (fname ~= "" and vim.fs.dirname(fname)) or vim.fn.getcwd()
				end
				on_dir(root)
			end
		end

		local b_config = require("Arduino-Nvim.board_config")

		local function update_sketch_yaml(fqbn)
			local yaml_path = vim.fn.expand("%:p:h") .. "/sketch.yaml"
			if vim.fn.filereadable(yaml_path) == 1 then
				local lines = {}
				for line in io.lines(yaml_path) do
					if line:match("^default_fqbn:") or line:match("^fqbn:") then
						table.insert(lines, "default_fqbn: " .. fqbn)
					else
						table.insert(lines, line)
					end
				end
				local f = io.open(yaml_path, "w")
				if f then
					f:write(table.concat(lines, "\n") .. "\n")
					f:close()
				end
			end
		end

		local function switch_board(fqbn, name)
			b_config.set_board(fqbn)
			update_sketch_yaml(fqbn)
			vim.notify("Arduino board switched to " .. name .. " (" .. fqbn .. ")", vim.log.levels.INFO)
		end

		vim.api.nvim_create_user_command("InoUno", function()
			switch_board("arduino:avr:uno", "Arduino UNO")
		end, { desc = "Arduino: Switch to UNO (arduino:avr:uno)" })

		vim.api.nvim_create_user_command("InoNano", function()
			switch_board("arduino:avr:nano", "Arduino Nano")
		end, { desc = "Arduino: Switch to Nano (arduino:avr:nano)" })

		vim.api.nvim_create_user_command("InoNanoOld", function()
			switch_board("arduino:avr:nano:cpu=atmega328old", "Arduino Nano (Old Bootloader)")
		end, { desc = "Arduino: Switch to Nano Old Bootloader" })
	end,
}
