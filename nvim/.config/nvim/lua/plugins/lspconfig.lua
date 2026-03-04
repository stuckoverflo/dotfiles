return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }
        local keymap = vim.keymap -- for conciseness

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "󰠠",
        },
      },
      underline = false,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- setup gopls using new mason-lspconfig handler
    vim.lsp.config("gopls", {
      capabilities = capabilities,
      filetypes = { "go" },
      settings = {
        gopls = {
          gofumpt = true, -- use gofumpt for formatting
        },
      },
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace", -- use "Replace" to replace the snippet with the function call
          },
        },
      },
    })

    vim.lsp.config("pyright", {
      handlers = {
        -- Override the default rename handler to remove the `annotationId` from edits.
        --
        -- Pyright is being non-compliant here by returning `annotationId` in the edits, but not
        -- populating the `changeAnnotations` field in the `WorkspaceEdit`. This causes Neovim to
        -- throw an error when applying the workspace edit.
        --
        -- See:
        -- - https://github.com/neovim/neovim/issues/34731
        -- - https://github.com/microsoft/pyright/issues/10671
        [vim.lsp.protocol.Methods.textDocument_rename] = function(err, result, ctx)
          if err then
            vim.notify("Pyright rename failed: " .. err.message, vim.log.levels.ERROR)
            return
          end

          ---@cast result lsp.WorkspaceEdit
          for _, change in ipairs(result.documentChanges or {}) do
            for _, edit in ipairs(change.edits or {}) do
              if edit.annotationId then
                edit.annotationId = nil
              end
            end
          end

          local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
          vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
        end,
      },
    })

    -- :lua vim.diagnostic.config({ virtual_text = false })
    vim.keymap.set("n", "<leader>dd", function()
      local current = vim.diagnostic.config().virtual_text
      vim.diagnostic.config({ virtual_text = not current })
    end, { desc = "Toggle LSP diagnostics virtual text" })
  end,
}
