-- Noclip Toggle Script (press C to toggle on/off) | Floor stays solid
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local noclipEnabled = false

-- Set of allowed floor materials you stay collidable with
local allowedFloor = {
	[Enum.Material.Plastic.Value] = true,
	[Enum.Material.SmoothPlastic.Value] = true,
	[Enum.Material.Concrete.Value] = true,
	[Enum.Material.Asphalt.Value] = true,
	[Enum.Material.Grass.Value] = true,
	[Enum.Material.Ground.Value] = true,
	[Enum.Material.Sand.Value] = true,
	[Enum.Material.Metal.Value] = true,
	[Enum.Material.Wood.Value] = true,
	[Enum.Material.WoodPlanks.Value] = true,
	[Enum.Material.Cobblestone.Value] = true,
	[Enum.Material.Slate.Value] = true,
}

-- Key toggle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.C then
		noclipEnabled = not noclipEnabled
	end
end)

-- Per-frame update
RunService.Stepped:Connect(function()
	local character = LocalPlayer.Character
	if not character then return end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = not noclipEnabled -- restore collision when disabled
		end
	end

	if noclipEnabled then
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and obj.CanCollide and not obj:IsDescendantOf(character) then
				local mat = obj.Material
				if not allowedFloor[mat.Value] then
					obj.CanCollide = false
				end
			end
		end
	end
end)
