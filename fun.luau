local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

--==================================================
-- EXACT ASSETS
--==================================================

local HAIR_ID = 123633915099119
local FACE_ID = 120333800416724 -- Shy Worrywart Dynamic Head
local TAIL_ID = 99456016159610

--==================================================
-- SETTINGS
--==================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- Melons
local MELON_SIZE = 1.35

local LEFT_MELON_X = -0.36
local RIGHT_MELON_X = 0.36

local MELON_Y = 0.05

-- Middle details
local DETAIL_SIZE = 0.20
local DETAIL_COLOR = Color3.fromRGB(170, 120, 85)


--==================================================
-- REMOVE EXISTING HAIR / ACCESSORIES / CLOTHING
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


--==================================================
-- REMOVE TOOLS FROM BACKPACK
--==================================================

local backpack = player:FindFirstChildOfClass("Backpack")

if backpack then
	for _, obj in ipairs(backpack:GetChildren()) do
		if obj:IsA("Tool") then
			obj:Destroy()
		end
	end
end


--==================================================
-- REMOVE OLD FACE DECALS
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
-- GET TORSO
--==================================================

local torso =
	character:FindFirstChild("UpperTorso")
	or character:FindFirstChild("Torso")

if not torso then
	warn("Could not find R6/R15 torso.")
	return
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
-- CREATE HUMANOID DESCRIPTION
--==================================================

local description = humanoid:GetAppliedDescription()

-- Clear accessory slots
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

--==================================================
-- TAN BODY COLOURS
--==================================================

description.HeadColor = SKIN_COLOR
description.TorsoColor = SKIN_COLOR
description.LeftArmColor = SKIN_COLOR
description.RightArmColor = SKIN_COLOR
description.LeftLegColor = SKIN_COLOR
description.RightLegColor = SKIN_COLOR


--==================================================
-- HAIR
--==================================================

description.HairAccessory = tostring(HAIR_ID)


--==================================================
-- SHY WORRYWART DYNAMIC HEAD
--==================================================

description.Head = FACE_ID

-- Disable facial animation for a more static look
description.StaticFacialAnimation = true


--==================================================
-- TAIL / WAIST ACCESSORY
--==================================================

description.WaistAccessory = tostring(TAIL_ID)


--==================================================
-- APPLY EVERYTHING
--==================================================

local success, err = pcall(function()
	humanoid:ApplyDescriptionAsync(description)
end)

if not success then
	warn("Appearance error:", err)
end


-- Give Roblox time to apply appearance
task.wait(1)


--==================================================
-- REFRESH REFERENCES
--==================================================

character = player.Character or character
humanoid = character:WaitForChild("Humanoid")

torso =
	character:FindFirstChild("UpperTorso")
	or character:FindFirstChild("Torso")

if not torso then
	return
end


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
-- REMOVE OLD MELONS
--==================================================

for _, obj in ipairs(character:GetDescendants()) do
	if obj.Name == "Melon"
		or obj.Name == "MelonDetail" then

		obj:Destroy()
	end
end


--==================================================
-- REAPPLY TAN BODY COLOUR
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
		and obj.Name ~= "HumanoidRootPart"
		and not obj.Parent:IsA("Accessory") then

		obj.Color = SKIN_COLOR
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

	melon.Color = SKIN_COLOR
	melon.Material = Enum.Material.SmoothPlastic

	melon.Anchored = false
	melon.CanCollide = false
	melon.CanTouch = false
	melon.CanQuery = false
	melon.Massless = true


	--================================================
	-- FRONT OF TORSO
	--================================================

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


	--================================================
	-- SMALL CENTER DETAIL
	--================================================

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
		melon.CFrame *
		CFrame.new(
			0,
			0,
			-(MELON_SIZE / 2) - 0.01
		)

	detail.Parent = character


	--================================================
	-- WELD MELON
	--================================================

	local melonWeld = Instance.new("WeldConstraint")

	melonWeld.Part0 = torso
	melonWeld.Part1 = melon

	melonWeld.Parent = melon


	--================================================
	-- WELD DETAIL
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


print("====================================")
print("CUSTOM AVATAR COMPLETE")
print("Hair:", HAIR_ID)
print("Dynamic Head:", FACE_ID)
print("Tail:", TAIL_ID)
print("Rig:", torso.Name)
print("====================================")
