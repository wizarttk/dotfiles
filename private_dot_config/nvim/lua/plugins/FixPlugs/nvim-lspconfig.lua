-- Mason 📦 安装管理器：帮你安装 LSP、Dap、Formatter 等
-- nvim-lspconfig 🧠 连接器/配置器：配置并启用 LSP
-- conform.nvim 🪄 格式化器：配置代码格式化方式

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts = opts or {}
      opts.servers = opts.servers or {}
      opts.inlay_hints = { enabled = false }

      -- 配置 gopls
      opts.servers.gopls = {
        settings = {
          gopls = {
            -- 使用 gofumpt 进行更严格的格式化，gofumpt 是 gofmt 的超集
            -- 如果你更喜欢标准的 gofmt，可以将此项设为 false
            -- gofumpt = true,              -- NEW:
            completions = {
              completeUnimported = true, -- 设置为 true 或 false
              usePlaceholders = false,   -- 禁用参数占位符，避免与某些 snippet 插件冲突
            },
          },
        },
      }


      opts.servers.protols = {}

      -- 添加 yamlls 的配置
      opts.servers.yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://kubernetesjsonschema.dev/v1.28.0-standalone-strict/all.json"] = "k8s-*.yaml",
              ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
              ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json"] =
              "ansible.yml",
              ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/schemas/json/prettierrc.json"] =
              ".prettierrc.yml",
            },
            format = {
              enable = true,
            },
            validate = true,
          },
        },
      }

      return opts
    end,
  },
}
