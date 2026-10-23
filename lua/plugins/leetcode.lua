return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		arg = "leetcode.nvim",
		lang = "cpp",
		storage = {
			home = vim.fn.expand("~/!corporateMajdoori/leetcode"),
		},
		hooks = {
			["enter"] = {
				function()
					local Question = require("leetcode-ui.question")
					Question.path = function(self)
						local lang = require("leetcode.utils").get_lang(self.lang)
						local alt = lang.alt and ("." .. lang.alt) or ""
						local func_name = (self.q.meta_data and self.q.meta_data.name) or self.q.title_slug
						local fn = ("%s_%s%s.%s"):format(self.q.frontend_id, func_name, alt, lang.ft)
						local config = require("leetcode.config")
						self.file = config.storage.home:joinpath(fn)
						local existed = self.file:exists()

						if not existed then
							self.file:write(self:snippet(), "w")
						end

						return self.file:absolute(), existed
					end
				end,
			},
		},
	},
}
