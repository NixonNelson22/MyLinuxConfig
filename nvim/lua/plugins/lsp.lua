return
{
            -- LSP Support
            {
		    'williamboman/mason.nvim',
		    lazy = false,
		    config = function()
			    require("mason").setup()
		    end,
	    },
	    {
		    'williamboman/mason-lspconfig.nvim',
		    config = function()
			    require("mason-lspconfig").setup()
			    require("mason-lspconfig").setup({
				    ensure_installed = {'lua_ls','dockerls',
				    'eslint','spectral','marksman',
				    'basedpyright','sqlls','cssls',
				    'bashls','ansiblels','powershell_es'},
				    automatic_installation = true,
			    })
		    end,
	    },
	    {
		    'neovim/nvim-lspconfig',
		    config = function()
			    require'lspconfig'.setup()
			    require'lspconfig'.setup{
				    servers = {
					    basedpyright = {
						    settings = {
							    basedpyright = {
								    analysis = {
									    typeCheckingMode = "standard",
									    diagnosticMode = "openFilesOnly",
									    inlayHints = {
										    callArgumentNames = true,
									    },
								    },
							    },
						    },
					    },
				    },
			    }
			    require("lspconfig").lua_ls.setup
			    {
				    on_init = function(client)
					    if client.workspace_folders then 
						    local path = client.workspace_folders[1].name 
						    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
							    return
						    end
					    end
					    client.config.settings.Lua = vim.tbl_deep_extend(
					    'force', client.config.settings.Lua,
					    {
						    runtime = {
							    version = 'LuaJIT'
						    },
						    workspace = {
							    checkThirdParty = false,
							    library = {
								    vim.env.VIMRUNTIME
							    }
						    }
					    })
				    end,
				    settings = {
					    Lua = {}
				    }
			    }
		    end,
	    },
            {
		    'hrsh7th/nvim-cmp',
		    dependencies = {
			    'saadparwaiz1/cmp_luasnip',
			    'hrsh7th/cmp-buffer',
			    'hrsh7th/cmp-path',
			    'hrsh7th/cmp-cmdline',
			    'hrsh7th/cmp-nvim-lsp',
		    },
		    lazy=false,
		    opts=function(_,opts)
			    print("cmp runs")
			    local cmp = require("cmp")
			    cmp.setup({
				    snippet={
					    expand = function(args)
						    require('luasnip').lsp_expand(args.body)
						    vim.snippet.expand(args.body)
					    end,
				    },
				    window={
					    completion= cmp.config.window.bordered(),
					    documentation= cmp.config.window.bordered(),
				    },
				    sources={
					    {name='luasnip'},
					    {name='buffer'},
				    },
				    mapping=cmp.mapping.preset.insert({
				      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
				      ['<C-f>'] = cmp.mapping.scroll_docs(4),
				      ['<C-Space>'] = cmp.mapping.complete(),
				      ['<C-e>'] = cmp.mapping.abort(),
				      ['<CR>'] = cmp.mapping.confirm({ select = true }),
				    }),
		    		})
		    end,
		    config = function()
			    local capabilities = require('cmp_nvim_lsp').default_capabilities()
			    require('mason-lspconfig').setup_handlers {
				    function (server_name) -- default handler (optional)
					    require("lspconfig")[server_name].setup({
						    capabilities = capabilities,
					    })
				    end,
			    }
		    end,
	    },
}
