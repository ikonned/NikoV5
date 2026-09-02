local Players = game:GetService("Players")

local Player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- Melons are the SAME colour as the skin
local MELON_COLOR = SKIN_COLOR

-- Smaller than the old version
local MELON_SIZE = 1.15

-- Very close together
local MELON_X = 0.30

-- Slightly below the middle of the chest
local MELON_Y = 0.15

-- White anime cat-ear hair
local HAIR_ID = 130180863705500

-- Shy Blush face accessory
local FACE_ID = 89320600334787


--==================================================
-- GET CHARACTER
--==================================================

local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")


--==================================================
-- BODY COLOUR
--==================================================

local BodyColors = Character:FindFirstChildOfClass("BodyColors")

if BodyColors then
	BodyColors.HeadColor3 = SKIN_COLOR
	BodyColors.TorsoColor3 = SKIN_COLOR
	BodyColors.LeftArmColor3 = SKIN_COLOR
	BodyColors.RightArmColor3 = SKIN_COLOR
	BodyColors.LeftLegColor3 = SKIN_COLOR
	BodyColors.RightLegColor3 = SKIN_COLOR
end

for _, Object in ipairs(Character:GetChildren()) do
	if Object:IsA("BasePart") then
		Object.Color = SKIN_COLOR
	end
end


--==================================================
-- REMOVE SHIRT / PANTS / SHIRT GRAPHIC
--==================================================

for _, Object in ipairs(Character:GetChildren()) do
	if Object:IsA("Shirt")
		or Object:IsA("Pants")
		or Object:IsA("ShirtGraphic") then

		Object:Destroy()
	end
end


--==================================================
-- APPLY HAIR + FACE
--==================================================

local Description = Humanoid:GetAppliedDescription()

-- White cat-ear hair
Description.HairAccessory = tostring(HAIR_ID)

-- Shy Blush face accessory
Description.FaceAccessory = tostring(FACE_ID)

-- Keep skin tan
Description.HeadColor = SKIN_COLOR
Description.TorsoColor = SKIN_COLOR
Description.LeftArmColor = SKIN_COLOR
Description.RightArmColor = SKIN_COLOR
Description.LeftLegColor = SKIN_COLOR
Description.RightLegColor = SKIN_COLOR

pcall(function()
	Humanoid:ApplyDescriptionAsync(Description)
end)

-- Give Roblox time to apply appearance
task.wait(1)


--==================================================
-- FIND TORSO
--==================================================

local Torso =
	Character:FindFirstChild("UpperTorso")
	or Character:FindFirstChild("Torso")

if not Torso then
	warn("Torso not found")
	return
end


--==================================================
-- REMOVE OLD MELONS
--==================================================

for _, Object in ipairs(Character:GetChildren()) do
	if Object.Name == "Melon" then
		Object:Destroy()
	end
end


--==================================================
-- CREATE MELON
--==================================================

local function CreateMelon(X)

	local Melon = Instance.new("Part")

	Melon.Name = "Melon"
	Melon.Shape = Enum.PartType.Ball

	Melon.Size = Vector3.new(
		MELON_SIZE,
		MELON_SIZE,
		MELON_SIZE
	)

	Melon.Color = MELON_COLOR
	Melon.Material = Enum.Material.SmoothPlastic

	Melon.Anchored = false
	Melon.CanCollide = false
	Melon.CanTouch = false
	Melon.CanQuery = false
	Melon.Massless = true

	--================================================
	-- EMBED INTO FRONT OF TORSO
	--================================================

	local Radius = MELON_SIZE / 2

	-- Front surface of torso
	local Front = -(Torso.Size.Z / 2)

	-- Push the melon INTO the torso.
	-- Only part of it should show.
	local Z = Front + Radius - 0.22

	Melon.CFrame =
		Torso.CFrame *
		CFrame.new(
			X,
			MELON_Y,
			Z
		)

	Melon.Parent = Character

	--================================================
	-- WELD
	--================================================

	local Weld = Instance.new("WeldConstraint")

	Weld.Part0 = Torso
	Weld.Part1 = Melon

	Weld.Parent = Melon
end


--==================================================
-- TWO MELONS
--==================================================

CreateMelon(-MELON_X)
CreateMelon(MELON_X)


--==================================================
-- SMALL DARK HEART DETAILS
--==================================================

local function CreateHeartDetail(Leg, Offset)

	local Detail = Instance.new("Part")

	Detail.Name = "HeartDetail"
	Detail.Shape = Enum.PartType.Ball

	Detail.Size = Vector3.new(
		0.28,
		0.28,
		0.18
	)

	Detail.Color = Color3.fromRGB(35, 30, 28)
	Detail.Material = Enum.Material.SmoothPlastic

	Detail.Anchored = false
	Detail.CanCollide = false
	Detail.CanTouch = false
	Detail.CanQuery = false
	Detail.Massless = true

	-- Put details slightly inside the leg
	Detail.CFrame =
		Leg.CFrame *
		CFrame.new(
			0,
			Offset,
			-(Leg.Size.Z / 2) + 0.05
		)

	Detail.Parent = Character

	local Weld = Instance.new("WeldConstraint")

	Weld.Part0 = Leg
	Weld.Part1 = Detail

	Weld.Parent = Detail
end


--==================================================
-- ADD THE LITTLE DETAILS TO RIGHT LEG
--==================================================

local RightLeg =
	Character:FindFirstChild("RightUpperLeg")
	or Character:FindFirstChild("Right Leg")

if RightLeg then

	CreateHeartDetail(RightLeg, 0.55)
	CreateHeartDetail(RightLeg, 0.05)
	CreateHeartDetail(RightLeg, -0.45)

end
