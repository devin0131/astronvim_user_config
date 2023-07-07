return {
	options = {
		opt = {
			shell = "/usr/bin/bash"
		},
	},
	lsp = {
		servers = {
			"clangd",
			"lemminx",
		},
		config = {
			clangd = {
				capabilities = { offsetEncoding = "utf-8" },
				cmd = { 'clangd', '--background-index', '-j=8', '--clang-tidy',
					'--all-scopes-completion', '--completion-style=detailed' }
			},
			lemminx = {
				cmd = { '/home/devin/lemminx/org.eclipse.lemminx/target/lemminx-linux-aarch_64-0.26.1-SNAPSHOT' }
			}
		}
	},
	plugins = {
		{
			"AstroNvim/astrocommunity",
			{ import = "astrocommunity.utility.noice-nvim" },
			{ import = "astrocommunity.motion.hop-nvim" },
			{
				"phaazon/hop.nvim",
				config = true,
				keys = function (self, keys)
					keys = 				{
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
					end },
					{
      			";w",
      			function() require("hop").hint_words() end,
      			mode = { "n" },
      			desc = "Hop hint words",
    			},
    			{
      			";l",
      			function() require("hop").hint_lines() end,
      			mode = { "n" },
      			desc = "Hop hint lines",
    			},
				}

					return keys
				end
			},
			-- { import = "astrocommunity.motion.leap-nvim" },
			-- { import = "astrocommunity.motion.flash-nvim" },
			{ import = "astrocommunity.pack.java" },
			-- 下边的两个配置是因为mason可能不会安装指定的插件，所以我们不要它装我们自己装
			{
				"williamboman/mason-lspconfig.nvim",
				opts = function(_, opts)
					opts.ensure_installed['lemminx'] = nil
					for k, v in pairs(opts.ensure_installed) do
						if v == 'lemminx' then
							table.remove(opts.ensure_installed, k)
						end
					end
				end,
			},
			{
				"jose-elias-alvarez/null-ls.nvim",
				-- opts = {
				-- 	sources = {
				-- 		require("null-ls").builtins.formatting.clang_format,
				-- 	}
				-- }
				config = function(_, opts)
					local null_ls = require("null-ls")
					local source = { null_ls.builtins.formatting.clang_format }
					null_ls.register(source)
					null_ls.setup(opts)
				end
			},
			{
				"jay-babu/mason-null-ls.nvim",
				opts = function(_, opts) opts.ensure_installed = {} end,
			},
		},
		{
			"lervag/vimtex",
			enabled = false,
			lazy = false,
			config = function()
				vim.cmd('filetype plugin indent on')

				-- syntax enable

				vim.g.vimtex_view_method = 'zathura'
				-- vim.g.vimtex_view_general_viewer = '/home/devin/.local/bin/sumatrapdf.sh'
				-- vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
				-- vim.g.vimtex_compiler_method = 'latexrun'

				vim.cmd('let maplocalleader = ";"')
			end,

		},
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle" },
			build = "cd app && yarn install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
				vim.g.mkdp_open_ip = '0.0.0.0'
				vim.g.mkdp_open_to_the_world = 1
				vim.cmd([[
				function! g:EchoUrl(url)
				:echo a:url
				endfunction
				]])
				vim.g.mkdp_browserfunc = 'g:EchoUrl'
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
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-cmdline",
			},
			config = function(_, opts)
				-- require("plugins.configs.nvim-cmp")(plugin, opts)
				local cmp = require('cmp')
				opts.sources = cmp.config.sources {
        	{ name = "nvim_lsp", priority = 750 },
          { name = "luasnip", priority = 1000 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }
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
