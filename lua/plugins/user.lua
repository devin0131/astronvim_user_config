return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },

        opts = function(_, opts) 
            local cmp = require "cmp"
            opts.sources = cmp.config.sources {
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip", priority = 750 },
                { name = "buffer", priority = 500 },
                { name = "path", priority = 250 },
            }
            cmp.setup(opts)
            return opts
        end,

    },
    {
        "kawre/leetcode.nvim",
        cmd = "Leet",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- configuration goes here
            lang="rust",
            cn = {
                enabled = true,
                translator = true,
                translator_problems = true,
            },

        },

    }
}

