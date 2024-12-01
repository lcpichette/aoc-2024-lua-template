local lunatest = require("lunatest")
local lfs = require("lfs")
local M = {}
local function find_test_suites(day)
	local target_dir = day and string.format("day%02d", tonumber(day)) or nil

	for dir in lfs.dir(".") do
		if dir ~= "." and dir ~= ".." and lfs.attributes(dir, "mode") == "directory" then
			if not target_dir or dir == target_dir then
				local test_file = dir .. "/tests.lua"
				if lfs.attributes(test_file, "mode") == "file" then
					local suite_name = dir .. ".tests"
					lunatest.suite(suite_name)
				end
			end
		end
	end
end

function M.run_tests(day)
	if day then
		print(string.format("Running tests for day %02d...", tonumber(day)))
	else
		print("Running tests for all days...")
	end

	find_test_suites(day)

	lunatest.run()
end

return M
