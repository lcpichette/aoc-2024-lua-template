local lfs = require("lfs")

local function create_day(day_number)
  local day_folder = string.format("day%02d", day_number)

  if lfs.attributes(day_folder, "mode") == "directory" then
    print("Error: Folder " .. day_folder .. " already exists.")
    return
  end

  assert(lfs.mkdir(day_folder), "Failed to create folder: " .. day_folder)

  local sol_content = [[
local M = {}

function M.solution()
    print("Solution for day " .. ]] .. day_number .. [[ .. "...")
end

return M
]]

  local tests_content = [[
local lunatest = require("lunatest")

local M = {}

function M.test_example()
    lunatest.assert_equal(1 + 1, 2)
end

return M
]]

  local sol_file = io.open(day_folder .. "/sol.lua", "w")
  assert(sol_file, "Failed to create sol.lua in " .. day_folder)
  sol_file:write(sol_content)
  sol_file:close()

  local tests_file = io.open(day_folder .. "/tests.lua", "w")
  assert(tests_file, "Failed to create tests.lua in " .. day_folder)
  tests_file:write(tests_content)
  tests_file:close()

  print("Created " .. day_folder .. " with sol.lua and tests.lua")
end

local function main()
  local day = arg[1]
  if not day or not tonumber(day) then
    print("Usage: lua create_day.lua <day_number>")
    return
  end

  create_day(tonumber(day))
end

main()
