return {
	-- colorscheme = "melange",
	-- colorscheme = "github_dark",
	-- mappings = {
	-- 	n = {
	-- 		["j"] = nil,
	-- 		["k"] = nil
	-- 	}
	-- },
	colorscheme = "github_light",
	-- colorscheme = "melange",
	options = {
		opt = {
			shell = "/bin/bash",
			signcolumn = "no",
			foldcolumn = "0",
			number = false,
			relativenumber = true,
			laststatus = 0,
			showtabline = 0,
			smartindent = true,
			expandtab = false,
			tabstop = 4,
			shiftwidth = 4,
			softtabstop = 4,
		},
		g = {
			autoformat_enabled = false,
		}
	},
	lsp = {
		servers = {
			"clangd",
		},
		config = {
			clangd = {
				capabilities = { offsetEncoding = "utf-8" },
				cmd = { 'clangd', '--background-index', '-j=8', '--clang-tidy',
					'--all-scopes-completion', '--completion-style=detailed' }
			},
		}
	},
	plugins = {
		{
			"AstroNvim/astrocommunity",
			{ import = "astrocommunity.utility.noice-nvim" },
			{ import = "astrocommunity.colorscheme.gruvbox-nvim" },
			{ import = "astrocommunity.colorscheme.github-nvim-theme" },
			{ import = "astrocommunity.colorscheme.melange-nvim" },
			{ import = "astrocommunity.colorscheme.nightfox-nvim" },
			{ import = "astrocommunity.colorscheme.onedarkpro-nvim" },
			{ import = "astrocommunity.scrolling.mini-animate" },
			-- {
			-- 	"echasnovski/mini.animate",
			-- 	opts = function (_, opts)
			-- 		local animate = require("mini.animate")
			-- 		opts.cursor = {
   --      		timing = animate.gen_timing.linear { duration = 80, unit = "total" },
   --    		}
			-- 		return opts
			-- 	end
			-- },
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
		},
		{
			"rainbowhxch/accelerated-jk.nvim",
			-- lazy = false,
			-- keys = function (self,keys)
			-- 	-- local utils = require "astronvim.utils"
			-- 	-- local maps = require("astronvim.utils").empty_map_table()
			-- 	-- maps = astronvim.user_opts("mappings")
			-- 	-- print(maps)
			-- 	-- print(maps.n)
			-- 	-- maps.n["j"] = nil
			-- 	-- maps.n["k"] = nil
			-- 	-- utils.set_mappings(maps)
			-- 	keys = {
			-- 		{"j", "<Plug>(accelerated_jk_gj)"},
			-- 		{"k", "<Plug>(accelerated_jk_gk)"}
			-- 	}
			-- 	return keys
			-- end,
			keys = {"j", "k"},
			opts = function(_, opts)
				vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
				vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
				return {
    		mode = 'time_driven',
    		enable_deceleration = false,
    		acceleration_motions = {},
    		acceleration_limit = 150,
    		-- acceleration_table = { 7,12,17,21,24,26,28,30 },
    		acceleration_table = {5,10, 15},
    		-- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
    		deceleration_table = { {150, 9999} }
			}
			end
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
			-- init = function()
			-- 	vim.g.mkdp_filetypes = { "markdown" }
			-- 	vim.g.mkdp_open_ip = '0.0.0.0'
			-- 	vim.g.mkdp_open_to_the_world = 1
			-- 	vim.cmd([[
			-- 	function! g:EchoUrl(url)
			-- 	:echo a:url
			-- 	endfunction
			-- 	]])
			-- 	vim.g.mkdp_browserfunc = 'g:EchoUrl'
			-- end,
			ft = { "markdown" },
		},
		{
			"akinsho/toggleterm.nvim",
			opts = {
				shell = "/opt/homebrew/bin/fish",
				direction = "vertical"
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
