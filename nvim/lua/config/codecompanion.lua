require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "copilot",
			slash_commands = {
        		["buffer"] = {
          			callback = "strategies.chat.slash_commands.buffer",
          			description = "Insert open buffers",
          			opts = {
            			contains_code = true,
            			provider = "telescope", -- default|telescope|mini_pick|fzf_lua
          			},
			},
		},
	},
		inline = {
			adapter = "copilot",
		},
},
	display = {
		chat = {
			window = {
				layout = "vertical",
				width = 90,
				opts = {
					wrap = true,
				}
		 	},
			render_headers = false,
		}
	},
	opts = {
		---@param adapter CodeCompanion.Adapter
		---@return string
		system_prompt = function(opts)
		if opts.adapter.schema.model.default == "llama3.1:latest" then
		return "My custom system prompt"
		end
		return "My default system prompt"
		end
	}
})

vim.keymap.set('n', '<LocalLeader>a', "<cmd>CodeCompanionChat Toggle<cr>", {silent = true})
vim.keymap.set('v', '<LocalLeader>a', "<cmd>CodeCompanionChat Toggle<cr>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
