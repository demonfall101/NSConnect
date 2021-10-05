local tool = Instance.new("Tool")
tool.Name = "Block_Placer"
tool.Parent = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Parent = tool
handle.Color = Color3.fromRGB(17,17,17)
handle.Size = Vector3.new(0.09, 1, 0.05)
handle.Position = Vector3.new(422.345, 5.774, 1062.285)
local light = Instance.new("Part")
light.Name = "Light"
light.Parent = tool
light.Color = Color3.fromRGB(248, 248, 248)
light.Material = Enum.Material.Neon
light.Size = Vector3.new(0.7, 0.34, 0.65)
light.Position = Vector3.new(422.35, 6.443, 1062.285)
local weld = Instance.new("Weld")
weld.Name = "Weld"
weld.Parent = light
weld.Part0 = handle
weld.Part1 = light
weld.Archivable = true

tool.Activated:Connect(function()
	local Plr = game:GetService("Players").LocalPlayer
	local Mouse = Plr:GetMouse()
	if not Mouse.Target then return end
	local part = Instance.new("Part")
	part.Parent = game.Workspace
	part.Name = "part321100"
	part.Position = Mouse.Hit.p
	game:GetService("ReplicatedStorage").NSSend:Fire("create:part321100/pos:"..Mouse.Hit.p.X..","..Mouse.Hit.p.Y..","..Mouse.Hit.p.Z)
end)