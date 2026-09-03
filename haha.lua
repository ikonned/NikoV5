local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

--==================================================
-- EXACT ASSETS
--==================================================

local HAIR_ID = 123633915099119
local FACE_ACCESSORY_ID = 72680112744477
local TAIL_ID = 99456016159610

--==================================================
-- SETTINGS
--==================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- A little smaller
local MELON_SIZE = 1.35

-- Closer together
local LEFT_MELON_X = -0.33
local RIGHT_MELON_X = 0.33

-- Slightly lower
local MELON_Y = 0.05

-- Small detail in the middle
local DETAIL_SIZE = 0.20
local DETAIL_COLOR = Color3.fromRGB(170, 120, 85)


--==================================================
-- REMOVE OLD ACCESSORIES / CLOTHING / TOOLS
--==================================================

for _, obj in ipairs(character:GetChildren()) do
	if obj:IsA("Accessory")
		or obj:IsA("Shirt")
		or obj:IsA("Pants")
		or obj:IsA("ShirtGraphic")
		or obj:IsA("CharacterMesh")
		or obj:IsA("Tool") then

		obj:Destroy()
	end
end

local backpack = player:FindFirstChildOfClass("Backpack")

if backpack then
	for _, obj in ipairs(backpack:GetChildren()) do
		if obj:IsA("Tool") then
			obj:Destroy()
		end
	end
end


--==================================================
-- APPLY TAN BODY
--==================================================

local bodyColors = character:FindFirstChildOfClass("BodyColors")

if bodyColors then
	bodyColors.HeadColor3 = SKIN_COLOR
	bodyColors.TorsoColor3 = SKIN_COLOR
	bodyColors.LeftArmColor3 = SKIN_COLOR
	bodyColors.RightArmColor3 = SKIN_COLOR
	bodyColors.LeftLegColor3 = SKIN_COLOR
	bodyColors.RightLegColor3 = SKIN_COLOR
end


--==================================================
-- CREATE CORRECT HUMANOID DESCRIPTION
--==================================================

local description = humanoid:GetAppliedDescription()

-- Clear ALL accessory slots first
description.HatAccessory = ""
description.HairAccessory = ""
description.FaceAccessory = ""
description.NeckAccessory = ""
description.ShouldersAccessory = ""
description.FrontAccessory = ""
description.BackAccessory = ""
description.WaistAccessory = ""

-- Remove clothing
description.Shirt = 0
description.Pants = 0
description.GraphicTShirt = 0

-- Tan skin
description.HeadColor = SKIN_COLOR
description.TorsoColor = SKIN_COLOR
description.LeftArmColor = SKIN_COLOR
description.RightArmColor = SKIN_COLOR
description.LeftLegColor = SKIN_COLOR
description.RightLegColor = SKIN_COLOR


--==================================================
-- SET THE THREE ACCESSORIES USING THEIR REAL TYPES
--==================================================

description:SetAccessories({
	{
		AssetId = HAIR_ID,
		AccessoryType = Enum.AccessoryType.Hair
	},

	{
		AssetId = FACE_ACCESSORY_ID,
		AccessoryType = Enum.AccessoryType.Face
	},

	{
		AssetId = TAIL_ID,
		AccessoryType = Enum.AccessoryType.Waist
	}
}, true)


--==================================================
-- APPLY
--==================================================

local success, err = pcall(function()
	humanoid:ApplyDescriptionAsync(description)
end)

if not success then
	warn("AVATAR APPLY ERROR:", err)
else
	print("Hair / face / tail description applied.")
end


-- Wait for Roblox to finish building accessories
task.wait(1)


--==================================================
-- REFRESH CHARACTER
--==================================================

character = player.Character or character
humanoid = character:WaitForChild("Humanoid")


--==================================================
-- REMOVE CLOTHING AGAIN
--==================================================

for _, obj in ipairs(character:GetChildren()) do
	if obj:IsA("Shirt")
		or obj:IsA("Pants")
		or obj:IsA("ShirtGraphic") then

		obj:Destroy()
	end
end


--==================================================
-- REAPPLY BODY COLORS
--==================================================

bodyColors = character:FindFirstChildOfClass("BodyColors")

if bodyColors then
	bodyColors.HeadColor3 = SKIN_COLOR
	bodyColors.TorsoColor3 = SKIN_COLOR
	bodyColors.LeftArmColor3 = SKIN_COLOR
	bodyColors.RightArmColor3 = SKIN_COLOR
	bodyColors.LeftLegColor3 = SKIN_COLOR
	bodyColors.RightLegColor3 = SKIN_COLOR
end

for _, obj in ipairs(character:GetChildren()) do
	if obj:IsA("BasePart")
		and obj.Name ~= "HumanoidRootPart" then

		-- Don't recolor accessory handles
		if not obj.Parent:IsA("Accessory") then
			obj.Color = SKIN_COLOR
		end
	end
end


--==================================================
-- GET TORSO
--==================================================

local torso =
	character:FindFirstChild("UpperTorso")
	or character:FindFirstChild("Torso")

if not torso then
	warn("R6/R15 torso not found.")
	return
end


--==================================================
-- REMOVE OLD MELONS
--==================================================

for _, obj in ipairs(character:GetChildren()) do
	if obj.Name == "Melon"
		or obj.Name == "MelonDetail" then

		obj:Destroy()
	end
end


--==================================================
-- CREATE ONE MELON
--==================================================

local function createMelon(x)

	local melon = Instance.new("Part")

	melon.Name = "Melon"
	melon.Shape = Enum.PartType.Ball

	melon.Size = Vector3.new(
		MELON_SIZE,
		MELON_SIZE,
		MELON_SIZE
	)

	melon.Color = SKIN_COLOR
	melon.Material = Enum.Material.SmoothPlastic

	melon.Anchored = false
	melon.CanCollide = false
	melon.CanTouch = false
	melon.CanQuery = false
	melon.Massless = true


	--==================================================
	-- CORRECT FRONT OF TORSO
	--==================================================

	local radius = MELON_SIZE / 2

	-- Roblox's LookVector points toward the front
	-- of the character.
	local frontPoint =
		torso.Position
		+ torso.CFrame.LookVector * (torso.Size.Z / 2)

	local position =
		frontPoint
		+ torso.CFrame.RightVector * x
		+ torso.CFrame.UpVector * MELON_Y

	-- Keep the melon aligned with the torso
	melon.CFrame =
		CFrame.new(position)
		* torso.CFrame.Rotation

	melon.Parent = character


	--==================================================
	-- SMALL CENTER DETAIL
	--==================================================

	local detail = Instance.new("Part")

	detail.Name = "MelonDetail"
	detail.Shape = Enum.PartType.Ball

	detail.Size = Vector3.new(
		DETAIL_SIZE,
		DETAIL_SIZE,
		DETAIL_SIZE * 0.5
	)

	detail.Color = DETAIL_COLOR
	detail.Material = Enum.Material.SmoothPlastic

	detail.Anchored = false
	detail.CanCollide = false
	detail.CanTouch = false
	detail.CanQuery = false
	detail.Massless = true

	-- Put detail on the front-facing surface
	detail.CFrame =
		melon.CFrame
		* CFrame.new(
			0,
			0,
			-(MELON_SIZE / 2) - 0.01
		)

	detail.Parent = character


	--==================================================
	-- WELD MELON
	--==================================================

	local melonWeld = Instance.new("WeldConstraint")

	melonWeld.Part0 = torso
	melonWeld.Part1 = melon
	melonWeld.Parent = melon


	--==================================================
	-- WELD DETAIL
	--==================================================

	local detailWeld = Instance.new("WeldConstraint")

	detailWeld.Part0 = melon
	detailWeld.Part1 = detail
	detailWeld.Parent = detail

end


--==================================================
-- TWO MELONS
--==================================================

createMelon(LEFT_MELON_X)
createMelon(RIGHT_MELON_X)


--==================================================
-- DONE
--==================================================

print("Custom avatar setup complete.")
