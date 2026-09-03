local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

--==================================================
-- ASSET IDS
--==================================================

local HAIR_ID = 123633915099119
local FACE_ID = 72680112744477
local TAIL_ID = 99456016159610

--==================================================
-- SETTINGS
--==================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- Slightly smaller than before
local MELON_SIZE = 1.35

-- Keep the same good spacing
local LEFT_MELON_X = -0.36
local RIGHT_MELON_X = 0.36

-- Same vertical position
local MELON_Y = 0.05

-- How much of the melon is visible in front
local MELON_DEPTH = 0.65

-- Little center piece
local DETAIL_SIZE = 0.20
local DETAIL_COLOR = Color3.fromRGB(170, 120, 85)


--==================================================
-- CLEAN OLD CUSTOM OBJECTS
--==================================================

for _, obj in ipairs(character:GetDescendants()) do
	if obj.Name == "Melon"
		or obj.Name == "MelonDetail" then

		obj:Destroy()
	end
end


--==================================================
-- REMOVE CLOTHING
--==================================================

for _, obj in ipairs(character:GetChildren()) do
	if obj:IsA("Shirt")
		or obj:IsA("Pants")
		or obj:IsA("ShirtGraphic")
		or obj:IsA("CharacterMesh") then

		obj:Destroy()
	end
end


--==================================================
-- TAN SKIN
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

for _, obj in ipairs(character:GetChildren()) do
	if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
		obj.Color = SKIN_COLOR
	end
end


--==================================================
-- GET TORSO
--==================================================

local torso =
	character:FindFirstChild("UpperTorso")
	or character:FindFirstChild("Torso")

if not torso then
	warn("R6/R15 torso not found")
	return
end


--==================================================
-- ACCESSORIES
--
-- IMPORTANT:
-- We use SetAccessories rather than putting the
-- face accessory into HumanoidDescription.Face.
--==================================================

local description = humanoid:GetAppliedDescription()

-- Clear old rigid accessory slots
description.HatAccessory = ""
description.HairAccessory = ""
description.FaceAccessory = ""
description.NeckAccessory = ""
description.ShouldersAccessory = ""
description.FrontAccessory = ""
description.BackAccessory = ""
description.WaistAccessory = ""

-- Keep clothes removed
description.Shirt = 0
description.Pants = 0
description.GraphicTShirt = 0

-- Keep the tan colors in the description
description.HeadColor = SKIN_COLOR
description.TorsoColor = SKIN_COLOR
description.LeftArmColor = SKIN_COLOR
description.RightArmColor = SKIN_COLOR
description.LeftLegColor = SKIN_COLOR
description.RightLegColor = SKIN_COLOR


-- Add the three actual accessory types
description:SetAccessories({

	{
		AssetId = HAIR_ID,
		AccessoryType = Enum.AccessoryType.Hair
	},

	{
		AssetId = FACE_ID,
		AccessoryType = Enum.AccessoryType.Face
	},

	{
		AssetId = TAIL_ID,
		AccessoryType = Enum.AccessoryType.Waist
	}

}, true)


--==================================================
-- IMPORTANT:
-- Do NOT ApplyDescription here.
--
-- We are not rebuilding the character because that
-- was the part that was causing your appearance to
-- disappear / reset.
--==================================================


--==================================================
-- TRY TO ADD THE ACCESSORIES WITHOUT RESETTING
--==================================================

local function loadAccessory(assetId)

	local ok, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. tostring(assetId))
	end)

	if not ok or not objects then
		return nil
	end

	for _, obj in ipairs(objects) do
		if obj:IsA("Accessory") then
			return obj
		end

		local nested = obj:FindFirstChildWhichIsA("Accessory", true)

		if nested then
			return nested
		end
	end

	return nil
end


local function equipAccessory(assetId)

	local accessory = loadAccessory(assetId)

	if not accessory then
		return false
	end

	accessory.Parent = character

	-- Roblox's normal accessory attachment
	local ok = pcall(function()
		humanoid:AddAccessory(accessory)
	end)

	return ok
end


-- Hair
equipAccessory(HAIR_ID)

-- Face accessory
equipAccessory(FACE_ID)

-- Tail
equipAccessory(TAIL_ID)


--==================================================
-- MELON CREATOR
--==================================================

local function createMelon(x)

	local melon = Instance.new("Part")

	melon.Name = "Melon"
	melon.Shape = Enum.PartType.Ball

	-- A little smaller
	melon.Size = Vector3.new(
		MELON_SIZE,
		MELON_SIZE,
		MELON_DEPTH
	)

	melon.Color = SKIN_COLOR
	melon.Material = Enum.Material.SmoothPlastic

	melon.Anchored = false
	melon.CanCollide = false
	melon.CanTouch = false
	melon.CanQuery = false
	melon.Massless = true


	--==================================================
	-- FRONT OF CHEST
	--==================================================

	local front =
		torso.Position
		+ torso.CFrame.LookVector * (torso.Size.Z / 2)

	local position =
		front
		+ torso.CFrame.RightVector * x
		+ torso.CFrame.UpVector * MELON_Y

	melon.CFrame =
		CFrame.new(position)
		* torso.CFrame.Rotation

	melon.Parent = character


	--==================================================
	-- CENTER DETAIL
	--==================================================

	local detail = Instance.new("Part")

	detail.Name = "MelonDetail"
	detail.Shape = Enum.PartType.Ball

	detail.Size = Vector3.new(
		DETAIL_SIZE,
		DETAIL_SIZE,
		DETAIL_SIZE * 0.45
	)

	detail.Color = DETAIL_COLOR
	detail.Material = Enum.Material.SmoothPlastic

	detail.Anchored = false
	detail.CanCollide = false
	detail.CanTouch = false
	detail.CanQuery = false
	detail.Massless = true

	detail.CFrame =
		melon.CFrame
		* CFrame.new(
			0,
			0,
			-(MELON_DEPTH / 2) - 0.02
		)

	detail.Parent = character


	--==================================================
	-- WELDS
	--==================================================

	local melonWeld = Instance.new("WeldConstraint")

	melonWeld.Part0 = torso
	melonWeld.Part1 = melon
	melonWeld.Parent = melon


	local detailWeld = Instance.new("WeldConstraint")

	detailWeld.Part0 = melon
	detailWeld.Part1 = detail
	detailWeld.Parent = detail

end


--==================================================
-- EXACTLY TWO MELONS
--==================================================

createMelon(LEFT_MELON_X)
createMelon(RIGHT_MELON_X)


print("Finished: tan body + accessories + 2 melons")
