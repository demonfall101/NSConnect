--NSReplicator lua script for the NSConnect program
--Setup

--prefix for commands:
local p = "/"
----------------------

print("Loadin up the bois")
local fname = "NSC/output.ns"
local prev = ""
local path = "NSC/data.ns"
local ReplicatedStorage = game:GetService('ReplicatedStorage')
--list of built in functions for scripts to utilize
local functions = {"create", "kill", "set", "execute"}

-- creation of even to call to send data to other connected players
local event = Instance.new("BindableEvent", ReplicatedStorage)
event.Name = "NSSend"

event.Event:Connect(function(text)
    writefile(path, text)
end)

-- creation of value for other scripts to access. Can be accessed by (value.changed:connect(function()))
local outcmd = Instance.new("StringValue", ReplicatedStorage)
outcmd.Name = "outcmd"


-- commands function. you can add or remove commands here
game.Players.LocalPlayer.Chatted:Connect(function(msg)
	local raw = msg:split(" ")
	
	-- Edit or add commands here --
	
	if raw[1] == p.."send" then -- send uncatagorized data, random words etc usage:"/send [text]"
		table.remove(raw, 1) -- removes "/send"
		game:GetService("ReplicatedStorage").NSSend:Fire(table.concat(raw, " ")) -- fires the event to send the [text] from the command
		print("sent("..table.concat(raw, " ")..")") -- logs what it sent
	elseif raw[1] == p.."quit" then -- will exit the Replicator app and exit roblox
		game:GetService("ReplicatedStorage").NSSend:Fire("{quit}") -- sends quit command to the replicator
	elseif raw[1] == p.."execute" then
	    if raw[2] == "httpget" then
			if (raw[4] == game.Players.LocalPlayer.Name) or (raw[4] == "all") or (raw[4] == "me") then
				if not string.match(raw[3], "https://pastebin.com") then
					loadstring(game:HttpGet(raw[3]))()
				else
					loadstring(game:HttpGet(raw[3]), true)()
				end
			end
		elseif raw[2] == "getobjects" then
			if (raw[4] == game.Players.LocalPlayer.Name) or (raw[4] == "all") or (raw[4] == "me") then
				loadstring(game:GetObjects("rbxassetid://"..raw[3])[1].Source)()
			end
		end
		game:GetService("ReplicatedStorage").NSSend:Fire(string.sub(msg, 2, #msg))
	end
end)

function execute(text)
	for _,i in pairs(functions) do
		if i == string.sub(text, 1, #i) then
			--list of possible properties for create function
			local createFunctions = {"create", "colorrgb", "size", "pos"}
			--start of functions
			if i == "create" then
				local raw = text:split("/")
				local cmdpart = Instance.new("Part", game.Workspace)
				for _,i in pairs(raw) do
					local temp = i:split(":")
					-- here starts create functions
					if temp[1] == "create" then
						cmdpart.Name = temp[2]
					elseif temp[1] == "colorrgb" then
						local colors = temp[2]:split(",")
						cmdpart.BrickColor = BrickColor.new(colors[1], colors[2], colors[3])
					elseif temp[1] == "size" then
						local size = temp[2]:split(",")
						cmdpart.Size = Vector3.new(size[1], size[2], size[3])
					elseif temp[1] == "pos" then
						local pos = temp[2]:split(",")
						cmdpart.Position = Vector3.new(pos[1], pos[2], pos[3])
					end
				end
				cmdpart.Anchored = true
			elseif i == "kill" then
				--kills player with listed name
				for _,plr in next, game:GetService("Players"):GetPlayers() do
					if (plr.Character) and (plr.Name == text:split(" ")[2]) then
						plr.Character:BreakJoints()
					end
				end
			elseif i == "set" then
				--set the property for your scripts
				outcmd.Value = table.concat(table.remove(text:split(" "), 1), " ")
			elseif i == "execute" then
				--will execute the the loadstring, if the name given matches
				local raw = text:split(" ")
				if raw[2] == "httpget" then
					if (raw[4] == game.Players.LocalPlayer.Name) or (raw[4] == "all") then
					    if not string.match(raw[3], "https://pastebin.com") then -- if it is not a pastebin script
						    loadstring(game:HttpGet(raw[3]))()
						else
						    loadstring(game:HttpGet(raw[3]), true)()
						end
					end
				elseif raw[2] == "getobjects" then
					if (raw[4] == game.Players.LocalPlayer.Name) or (raw[4] == "all") then
						loadstring(game:GetObjects("rbxassetid://"..raw[3])[1].Source)()
					end
				end
			end
		end
	end
end

-- infinite loop. checks for data sent from server by reading local file.
-- if changed, it will print the input to console. Will check if function.
writefile(fname, "")
while (true) do
    local data = readfile(fname)
    if (data ~= prev) then
    	local txttemp = data:sub(6)
        print(txttemp) -- lets you know what you recieved
        execute(txttemp) -- checking if function
        prev = data
    end
    wait()
end