local status_ok, aerial = pcall(require, "aerial")
if not status_ok then
  print("aerial plugin is not found")
  return
end

aerial.setup()
