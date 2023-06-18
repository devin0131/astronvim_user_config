return {
	options = {
		opt = {
			shell = "/usr/bin/bash"
		},
	},
	lsp = {
		config = {
			clangd = {
				capabilities = { offsetEncoding = "utf-8" },
			}
		}
	},
	plugins = {
		{
			"AstroNvim/astrocommunity",
			{
				import = "astrocommunity.pack.java",
			}
		},
		{
			"phaazon/hop.nvim",
			config = true,
			keys = {
				{ 'f', function()
					local directions = require('hop.hint').HintDirection
					require('hop').hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
				end },
				{ 'F', function()
					local directions = require('hop.hint').HintDirection
					require('hop').hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
				end },
				{ 't', function()
					local directions = require('hop.hint').HintDirection
					require('hop').hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
				end },
				{ 'T', function()
					local directions = require('hop.hint').HintDirection
					require('hop').hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
				end }
			}
		},
		{
			"lervag/vimtex",
			config = function()
				vim.cmd('filetype plugin indent on')

				-- syntax enable

				vim.g.vimtex_view_method = 'zathura'
				-- vim.g.vimtex_view_general_viewer = '/home/devin/.local/bin/sumatrapdf.sh'
				-- vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
				-- vim.g.vimtex_compiler_method = 'latexrun'

				vim.cmd('let maplocalleader = ";"')
			end,
			lazy = false
		},
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle" },
			build = "cd app && yarn install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		},
		{
			"akinsho/toggleterm.nvim",
			opts = {
				shell = "/usr/bin/fish"
			}
		},
		{
			"hrsh7th/cmp-cmdline",
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-cmdline",
			},
			config = function(plugin, opts)
				-- require("plugins.configs.nvim-cmp")(plugin, opts)
				local cmp = require('cmp')
				cmp.setup(opts)
				cmp.setup.cmdline(':', {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = 'path' }
					}, {
						{
							name = 'cmdline',
							option = {
								ignore_cmds = { 'Man', '!' }
							}
						}
					})
				})
			end
		},
	}
}
