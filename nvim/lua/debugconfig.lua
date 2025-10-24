local dm = require 'debugmaster'

dm.keys.get("t").key = "B" -- replace <your_new_key> with the key you want

vim.keymap.set({ 'n', 'v' }, '<leader>d', dm.mode.toggle, { nowait = true })

dm.plugins.osv_integration.enabled = true

-- Setup dap-go first
require('dap-go').setup {
  -- Additional dap-go configuration
  dap_configurations = {
    {
      type = 'go',
      name = 'Attach remote',
      mode = 'remote',
      request = 'attach',
    },
  },
  -- delve configurations
  delve = {
    -- the path to the executable dlv which will be used for debugging.
    path = 'dlv',
    -- time to wait for delve to initialize the debug session.
    initialize_timeout_sec = 20,
    -- a string that defines the port to start delve debugger.
    port = '${port}',
    -- additional args to pass to dlv
    args = {},
    -- the build flags that are passed to delve.
    build_flags = '',
  },
}

local dap = require 'dap'

-- Ensure Go adapter is properly configured
if not dap.adapters.go then
  dap.adapters.go = function(callback)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697

    handle, pid_or_err = vim.loop.spawn('dlv', {
      stdio = { nil, stdout },
      args = { 'dap', '-l', '127.0.0.1:' .. port },
      detached = true,
    }, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print('dlv exited with code', code)
      end
    end)

    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))

    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)

    -- Wait for delve to start
    vim.defer_fn(function()
      callback { type = 'server', host = '127.0.0.1', port = port }
    end, 100)
  end
end
