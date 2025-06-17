-- Noclip Toggle Script (press C to toggle on/off) | Floors stay solid
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local noclipEnabled = false

-- Materials considered FLOOR (cannot be noclipped through)
local safeFloorMaterials = {
	[Enum.Material.Grass.Value] = true,
	[Enum.Material.Mud.Value] = true,
	[Enum.Material.Ground.Value] = true,
	[Enum.Material.Sand.Value] = true,
	[Enum.Material.Snow.Value] = true,
	[Enum.Material.Ice.Value] = true,
	[Enum.Material.Salt.Value] = true,
	[Enum.Material.LeafyGrass.Value] = true,
	[Enum.Material.Glacier.Value] = true,
	[Enum.Material.CrackedLava.Value] = true,
	[Enum.Material.Basalt.Value] = true,
	[Enum.Material.Limestone.Value] = true,
	[Enum.Material.Asphalt.Value] = true,
	[Enum.Material.Concrete.Value] = true,
	[Enum.Material.Cobblestone.Value] = true,
	[Enum.Material.Pavement.Value] = true,
	[Enum.Material.Slate.Value] = true,
	[Enum.Material.Granite.Value] = true,
	[Enum.Material.Pebble.Value] = true,
	[Enum.Material.Rock.Value] = true,
	[Enum.Material.Sandstone.Value] = true,
	[Enum.Material.Wood.Value] = true,
	[Enum.Material.WoodPlanks.Value] = true,
	[Enum.Material.Marble.Value] = true,
	[Enum.Material.SmoothPlastic.Value] = true,
	[Enum.Material.Plastic.Value] = true,
	[Enum.Material.Fabric.Value] = true,
	[Enum.Material.Foil.Value] = true,
	[Enum.Material.Neon.Value] = true,
	[Enum.Material.Metal.Value] = true,
	[Enum.Material.DiamondPlate.Value] = true
}

-- Toggle key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.C then
		noclipEnabled = not noclipEnabled
	end
end)

-- Main noclip loop
RunService.Stepped:Connect(function()
	local character = LocalPlayer.Character
	if not character then return end

	-- Update player parts
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = not noclipEnabled
		end
	end

	-- Disable wall collisions
	if noclipEnabled then
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and obj.CanCollide and not obj:IsDescendantOf(character) then
				if not safeFloorMaterials[obj.Material.Value] then
					obj.CanCollide = false
				end
			end
		end
	end
end)
