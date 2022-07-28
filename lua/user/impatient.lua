local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  print("impatient plugin is not found")
  return
end

impatient.enable_profile()

