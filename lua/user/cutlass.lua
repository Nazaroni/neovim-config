local status_ok, cutlass = pcall(require, "cutlass")
if not status_ok then
  print("cutlass plugin is not found")
  return
end

cutlass.setup {
  {
    cut_key = nil,
    override_del = nil,
    exclude = {},
  },
}
