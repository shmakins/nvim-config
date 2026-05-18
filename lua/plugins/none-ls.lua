-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    opts.on_init = function(new_client, _)
      new_client.offset_encoding = "utf-8"
    end

    -- Find .clang-format by traversing up from the given dir, stopping at .git boundary
    local function find_clang_format(start_dir)
      local dir = start_dir
      while dir and dir ~= "/" do
        if vim.fn.filereadable(dir .. "/.clang-format") == 1 then
          return dir .. "/.clang-format"
        end
        -- Stop if this dir contains .git
        if vim.fn.isdirectory(dir .. "/.git") == 1 then
          break
        end
        dir = vim.fn.fnamemodify(dir, ":h")
      end
      return nil
    end

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      null_ls.builtins.formatting.clang_format.with({
        command = "clang-format-14",
        filetypes = { "c", "cpp", "objc", "objcpp" },
        -- Dynamically pass --style=file:<path> so clang-format-14 uses the
        -- nearest .clang-format found by traversing up to (but not beyond) .git
        dynamic_command = function(params)
          local style_arg = "file"
          local buf_dir = vim.fn.fnamemodify(params.bufname, ":h")
          local cfg = find_clang_format(buf_dir)
          if cfg then style_arg = "file:" .. cfg end
          return { "clang-format-14", "--style=" .. style_arg }
        end,
      }),
    })
  end,
}
