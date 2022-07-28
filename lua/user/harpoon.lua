local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print("telescope plugin is not found")
  return
end

local h_status_ok, harpoon = pcall(require, "harpoon")
if not h_status_ok then
  print("harpoon plugin is not found")
  return
end
telescope.load_extension "harpoon"
