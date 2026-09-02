local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

--==================================================
-- EXACT ASSETS
--==================================================

local HAIR_ID = "123633915099119"
local FACE_ID = "72680112744477"
local TAIL_ID = "99456016159610"

--==================================================
-- SETTINGS
--==================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- Bigger melons
local MELON_SIZE = 1.55

-- Closer together
local LEFT_MELON_X = -0.36
local RIGHT_MELON_X = 0.36

-- Slightly lower on chest
local MELON_Y = 0.05

-- Small middle detail
local DETAIL_SIZE = 0.22
local DETAIL_COLOR = Color3.fromRGB(170, 120, 85)

--==================================================
-- REMOVE EXISTING ACCESSORIES / CLOTHING / TOOLS
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
-- REMOVE OLD FACE DECAL
--==================================================

local head = character:FindFirstChild("Head")

if head then
	for _, obj in ipairs(head:GetChildren()) do
		if obj:IsA("Decal") then
			obj:Destroy()
		end
	end
end

--==================================================
-- APPLY HAIR / FACE / TAIL
--==================================================

local description = humanoid:GetAppliedDescription()

description.HairAccessory = HAIR_ID
description.Face = FACE_ID
description.BackAccessory = TAIL_ID

description.Shirt = 0
description.Pants = 0
description.GraphicTShirt = 0

-- Apply the appearance
pcall(function()
	humanoid:ApplyDescription(description)
end)

-- Give Roblox time to apply everything
task.wait(0.7)

-- Get character again
character = player.Character or character
humanoid = character:WaitForChild("Humanoid")

--==================================================
-- GET TORSO
--==================================================

local torso =
	character:FindFirstChild("UpperTorso")
	or character:FindFirstChild("Torso")

if not torso then
	warn("Could not find torso.")
	return
end

--==================================================
-- GET SKIN COLOR
--==================================================

local skinColor = SKIN_COLOR

--==================================================
-- APPLY TAN SKIN
--==================================================

local bodyColors = character:FindFirstChildOfClass("BodyColors")

if bodyColors then
	bodyColors.HeadColor3 = skinColor
	bodyColors.TorsoColor3 = skinColor
	bodyColors.LeftArmColor3 = skinColor
	bodyColors.RightArmColor3 = skinColor
	bodyColors.LeftLegColor3 = skinColor
	bodyColors.RightLegColor3 = skinColor
end

for _, obj in ipairs(character:GetChildren()) do
	if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
		obj.Color = skinColor
	end
end

--==================================================
-- REMOVE OLD MELONS / DETAILS
--==================================================

for _, obj in ipairs(character:GetDescendants()) do
	if obj.Name == "Melon"
		or obj.Name == "MelonDetail" then

		obj:Destroy()
	end
end

--==================================================
-- CREATE MELON
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

	-- SAME COLOR AS SKIN
	melon.Color = skinColor

	melon.Material = Enum.Material.SmoothPlastic

	melon.Anchored = false
	melon.CanCollide = false
	melon.CanTouch = false
	melon.CanQuery = false
	melon.Massless = true

	--================================================
	-- HALF INSIDE FRONT OF CHEST
	--================================================

	-- Front of the torso is negative Z.
	-- Putting the center around the front surface
	-- makes approximately half of the melon embedded.
	local front = -(torso.Size.Z / 2)

	melon.CFrame = torso.CFrame * CFrame.new(
		x,
		MELON_Y,
		front
	)

	melon.Parent = character

	--================================================
	-- SMALL CENTER DETAIL
	--================================================

	local detail = Instance.new("Part")

	detail.Name = "MelonDetail"
	detail.Shape = Enum.PartType.Ball

	detail.Size = Vector3.new(
		DETAIL_SIZE,
		DETAIL_SIZE,
		DETAIL_SIZE
	)

	detail.Color = DETAIL_COLOR
	detail.Material = Enum.Material.SmoothPlastic

	detail.Anchored = false
	detail.CanCollide = false
	detail.CanTouch = false
	detail.CanQuery = false
	detail.Massless = true

	-- Put the little detail on the front-center
	-- of the visible part of the melon.
	detail.CFrame = melon.CFrame * CFrame.new(
		0,
		0,
		-(MELON_SIZE / 2) - 0.01
	)

	detail.Parent = character

	--================================================
	-- WELD MELON TO CHEST
	--================================================

	local melonWeld = Instance.new("WeldConstraint")

	melonWeld.Part0 = torso
	melonWeld.Part1 = melon

	melonWeld.Parent = melon

	--================================================
	-- WELD CENTER DETAIL TO MELON
	--================================================

	local detailWeld = Instance.new("WeldConstraint")

	detailWeld.Part0 = melon
	detailWeld.Part1 = detail

	detailWeld.Parent = detail

end

--==================================================
-- CREATE EXACTLY 2 MELONS
--==================================================

createMelon(LEFT_MELON_X)
createMelon(RIGHT_MELON_X)
