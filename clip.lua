-- Noclip Script (Toggle with C) | No GUI
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local noclipEnabled = false

-- Floor materials to stay collidable with
local floorMaterials = {
	Enum.Material.Grass,
	Enum.Material.Concrete,
	Enum.Material.SmoothPlastic,
	Enum.Material.Asphalt,
	Enum.Material.Cobblestone,
	Enum.Material.Brick,
	Enum.Material.WoodPlanks,
	Enum.Material.Metal,
	Enum.Material.Wood,
	Enum.Material.Ground,
	Enum.Material.Sand,
}

local allowedFloor = {}
for _, mat in ipairs(floorMaterials) do
	allowedFloor[mat.Value] = true
end

-- Toggle noclip with "C"
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.C then
		noclipEnabled = not noclipEnabled
	end
end)

-- Noclip handler
RunService.Stepped:Connect(function()
	if not noclipEnabled then return end

	local character = LocalPlayer.Character
	if not character then return end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.CanCollide and not obj:IsDescendantOf(character) then
			if not allowedFloor[obj.Material.Value] then
				obj.CanCollide = false
			end
		end
	end
end)
