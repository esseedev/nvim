return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      local mason_netcoredbg = vim.fn.stdpath 'data' .. '/mason/packages/netcoredbg/netcoredbg'
      local netcoredbg_path = vim.fn.executable(mason_netcoredbg) == 1 and mason_netcoredbg or '/usr/local/bin/netcoredbg/netcoredbg'

      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
        mappings = {
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        element_mappings = {},
        expand_lines = vim.fn.has 'nvim-0.7' == 1,
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              'breakpoints',
              'stacks',
              'watches',
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              'repl',
              'console',
            },
            size = 0.25,
            position = 'bottom',
          },
        },
        controls = {
          enabled = true,
          element = 'repl',
          icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '↻',
            terminate = '□',
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = 'single',
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      }

      dap.adapters.coreclr = {
        type = 'executable',
        command = netcoredbg_path,
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'launch - netcoredbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
      }

      vim.keymap.set('n', '<F5>', function()
        dap.continue()
      end, { silent = true })
      vim.keymap.set('n', '<F10>', function()
        dap.step_over()
      end, { silent = true })
      vim.keymap.set('n', '<F11>', function()
        dap.step_into()
      end, { silent = true })
      vim.keymap.set('n', '<F12>', function()
        dap.step_out()
      end, { silent = true })
      vim.keymap.set('n', '<Leader>b', function()
        dap.toggle_breakpoint()
      end, { silent = true })
      vim.keymap.set('n', '<Leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { silent = true })
      vim.keymap.set('n', '<Leader>lp', function()
        dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end, { silent = true })
      vim.keymap.set('n', '<Leader>dr', function()
        dap.repl.open()
      end, { silent = true })
      vim.keymap.set('n', '<Leader>dl', function()
        dap.run_last()
      end, { silent = true })

      dap.listeners.after.event_initialized.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
