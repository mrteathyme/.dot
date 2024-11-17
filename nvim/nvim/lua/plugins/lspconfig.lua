return {
	"neovim/nvim-lspconfig",
	dependencies = {"williamboman/mason-lspconfig.nvim",
	"williamboman/mason.nvim",
	"hrsh7th/cmp-nvim-lsp"
},
	config = function()
		local lspconfig = require('lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
local handlers = {
    function(server_name)
        require('lspconfig')[server_name].setup({capabilities=capabilities})
    end,
	["htmx"] = function ()
			require("lspconfig").htmx.setup{
capabilities=capabilities,
				filetypes = { "html", "htm", "htmx" },
			}
		end,
		["html"] = function ()
			require("lspconfig").html.setup{capabilities=capabilities,

			filetypes = { "html", "htm", "htmx" },
			}
		end,
		["rust_analyzer"] = function ()
			require("lspconfig").rust_analyzer.setup{capabilities=capabilities,

			settings = {
				['rust-analyzer'] = {},
			},
			}
		end,
}

		require("mason-lspconfig").setup {
    ensure_installed = { "html", "htmx", "rust_analyzer" },
}
		require("mason-lspconfig").setup_handlers(handlers)
		
		--[[
		lspconfig.rust_analyzer.setup {
  			-- Server-specific settings. See `:help lspconfig-setup`
  			settings = {
    				['rust-analyzer'] = {},
  			},
		}
		]]
		
	end,
}
