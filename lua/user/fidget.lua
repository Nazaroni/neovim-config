local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  print("fidget plugin is not found")
  return
end

fidget.setup()
