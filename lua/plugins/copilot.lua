return {
  {
    "github/copilot.vim",
    enabled = false,
    event = "InsertEnter",
  },
  -- CopilotChat: provides an interactive AI chat panel inside Neovim.
  -- Disabling this removes the chat UI but keeps Copilot inline completions (Tab to accept).
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   build = "make tiktoken",
  --   opts = {},
  -- },
}
