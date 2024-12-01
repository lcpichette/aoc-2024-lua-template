local tests = require("tests")

local function format_day_dir(day)
	return string.format("day%02d", day)
end

local function run_solution(day)
	local day_dir = format_day_dir(day)
	local sol_module_path = day_dir .. ".sol"

	local success, sol_module = pcall(require, sol_module_path)
	if not success then
		print(string.format("Failed to load solution for %s", day_dir))
		return
	end

	if sol_module and sol_module.solution then
		print(string.format("Running solution for %s:", day_dir))
		sol_module.solution()
	else
		print(string.format("No 'solution' function found in %s.sol", day_dir))
	end
end

local args = { ... }

if #args == 0 then
	for day = 1, 25 do
		run_solution(day)
	end
elseif #args == 1 then
	if arg[1] == "tests" then
		local day = arg[2]
		tests.run_tests(day)
	else
		local day = arg[1]
		run_solution(day)
	end
else
	print("Usage:")
	print("  lua app.lua               -- Runs all solutions")
	print("  lua app.lua <day>         -- Runs solution for the specified day (e.g., lua app.lua 1)")
	print("  lua app.lua tests         -- Runs all tests")
	print("  lua app.lua tests <day>   -- Runs solution for the specified day (e.g., lua app.lua tests 1)")
end
