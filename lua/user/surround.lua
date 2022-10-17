local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
  print("nvim-surround plugin is not found")
  return
end

surround.setup {
  -- Configuration here, or leave empty to use defaults
}
