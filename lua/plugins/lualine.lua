return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local colors = {
      base     = '#1e1e2e', 
      overlay0 = '#6c7086', 
      text     = '#cdd6f4', 
      mauve    = '#cba6f7', -- Mocha Purple
      lavender = '#b4befe', -- Mocha Lavender
      peach    = '#fab387', 
      green    = '#a6e3a1', 
      red      = '#f38ba8', 
    }

    local theme = {
      normal = {
        a = { fg = colors.base, bg = colors.mauve },
        b = { fg = colors.text, bg = colors.overlay0 },
        c = { fg = colors.text, bg = colors.base },
        z = { fg = colors.base, bg = colors.mauve },
      },
      insert  = { a = { fg = colors.base, bg = colors.lavender } },
      visual  = { a = { fg = colors.base, bg = colors.peach } },
      replace = { a = { fg = colors.base, bg = colors.red } },
    }

    local empty = require('lualine.component'):extend()
    function empty:draw(default_highlight)
      self.status = ''
      self.applied_separator = ''
      self:apply_highlights(default_highlight)
      self:apply_section_separators()
      return self.status
    end

    local function process_sections(sections)
      for name, section in pairs(sections) do
        local left = name:sub(9, 10) < 'x'
        for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
          -- Fixed: gap colors are now dark background instead of solid text color
          table.insert(section, pos * 2, { empty, color = { fg = colors.base, bg = colors.base } })
        end
        for id, comp in ipairs(section) do
          if type(comp) ~= 'table' then
            comp = { comp }
            section[id] = comp
          end
          comp.separator = left and { right = '' } or { left = '' }
        end
      end
      return sections
    end

    local function search_result()
      if vim.v.hlsearch == 0 then
        return ''
      end
      local last_search = vim.fn.getreg('/')
      if not last_search or last_search == '' then
        return ''
      end
      local searchcount = vim.fn.searchcount { maxcount = 9999 }
      return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
    end

    local function modified()
      if vim.bo.modified then
        return '+'
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return '-'
      end
      return ''
    end

    require('lualine').setup {
      options = {
        theme = theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = process_sections {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          'diff',
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'error' },
            diagnostics_color = { error = { bg = colors.red, fg = colors.base } },
          },
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'warn' },
            diagnostics_color = { warn = { bg = colors.peach, fg = colors.base } },
          },
          { 'filename', file_status = false, path = 1 },
          { modified, color = { bg = colors.red, fg = colors.base } },
          {
            '%w',
            cond = function() return vim.wo.previewwindow end,
          },
          {
            '%r',
            cond = function() return vim.bo.readonly end,
          },
          {
            '%q',
            cond = function() return vim.bo.buftype == 'quickfix' end,
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { search_result, 'filetype' },
        lualine_z = { '%l:%c', '%p%%/%L' },
      },
      inactive_sections = {
        lualine_c = { '%f %y %m' },
        lualine_x = {},
      },
    }
  end
}
