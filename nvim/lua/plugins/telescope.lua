return {
    'nvim-telescope/telescope.nvim', version=false,
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
	      	require('telescope').setup{}
		end,
}

