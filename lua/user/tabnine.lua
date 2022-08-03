-- M = {}
local ok, os_info = pcall(require, "user.get_os_info")
if not ok then
  print("get_os_info plugin is not found")
  return
end

local os_type = os_info.get_os_type()
local os_arch = os_info.get_os_arch()

-- there is no TabNine sollution for Linux arm64
if os_type == "linux" then
  if os_arch == "arm64" then
    return
  end
end


local status_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not status_ok then
  print("cmp_tabnine.config is not found")
  return
end

tabnine:setup {
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = "..",
  ignored_file_types = { -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true
  },
}

-- return M
