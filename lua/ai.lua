return {{
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️  must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
    opts = function()
      local ollama = require("avante.providers.ollama")
      local path = vim.fn.expand '~/sandbox/HOME_IP'
      local default_value = '192.168.1.158:11434'
      local file = io.open(path, 'r')
      local home_ip
      if file then
        home_ip = file:read '*a'
        home_ip = home_ip:gsub('%s+$', '')
        file:close()
        home_ip = home_ip .. ':5265'
      else
        home_ip = default_value
      end
      return {
        provider = "ollama",
        providers = {
          ollama = {
            endpoint = 'http://' .. home_ip,
            model = 'qwen2.5-coder:7b',
            is_env_set = require("avante.providers.ollama").check_endpoint_alive,
          },
        },
      }
    end,
}}
