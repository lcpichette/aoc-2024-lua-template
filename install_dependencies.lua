local function confirm_installation(package, no_confirm)
	if no_confirm then
		return true
	end

	io.write("Do you want to install " .. package .. "? [Y/n]: ")
	local response = io.read():lower()
	return response == "y" or response == ""
end

local function install_package(package)
	print("Installing " .. package .. "...")
	os.execute("luarocks install " .. package)
end

local function main()
	local dependencies = {
		"luafilesystem",
		"lunatest",
	}

	local no_confirm = false
	for _, arg in ipairs(arg) do
		if arg == "--no-confirm" then
			no_confirm = true
			break
		end
	end

	for _, package in ipairs(dependencies) do
		if confirm_installation(package, no_confirm) then
			install_package(package)
		else
			print("Skipping " .. package .. "...")
		end
		print("")
	end
end

main()
