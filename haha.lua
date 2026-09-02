local Players = game:GetService("Players")
local player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- Same colour as skin
local ORB_COLOR = Color3.fromRGB(204, 160, 115)

-- Smaller than before
local ORB_SIZE = 1.25

-- Closer together
local LEFT_X = -0.28
local RIGHT_X = 0.28

-- Slightly lower
local ORB_Y = 0.10

-- Your black hair
local HAIR_ID = 88443547532669


--==================================================
-- GET CHARACTER
--==================================================

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")


--==================================================
-- REMOVE CLOTHES
--==================================================

for _, v in ipairs(character:GetChildren()) do
	if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
		v:Destroy()
	end
end


--==================================================
-- REMOVE ACCESSORIES
--==================================================

for _, v in ipairs(character:GetChildren()) do
	if v:IsA("Accessory") then
		v:Destroy()
	end
end


--==================================================
-- TAN BODY
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

for _, v in ipairs(character:GetChildren()) do
	if v:IsA("BasePart") then
		v.Color = SKIN_COLOR
	end
end


--==================================================
-- EQUIP HAIR USING HUMANOID DESCRIPTION
--==================================================

local description = humanoid:GetAppliedDescription()

description.HairAccessory = tostring(HAIR_ID)

pcall(function()
	humanoid:ApplyDescriptionAsync(description)
end)

task.wait(1)


--==================================================
-- GET TORSO AGAIN
--==================================================

local torso =
	character:FindFirstChild("UpperTorso")
	or character:FindFirstChild("Torso")

if not torso then
	warn("No torso found.")
	return
end


--==================================================
-- REMOVE OLD ORBS
--==================================================

for _, v in ipairs(character:GetChildren()) do
	if v.Name == "ChestOrb" then
		v:Destroy()
	end
end


--==================================================
-- CREATE ORB
--==================================================

local function makeOrb(x)

	local orb = Instance.new("Part")

	orb.Name = "ChestOrb"
	orb.Shape = Enum.PartType.Ball

	orb.Size = Vector3.new(
		ORB_SIZE,
		ORB_SIZE,
		ORB_SIZE
	)

	orb.Color = SKIN_COLOR
	orb.Material = Enum.Material.SmoothPlastic

	orb.Anchored = false
	orb.CanCollide = false
	orb.CanTouch = false
	orb.CanQuery = false
	orb.Massless = true

	--================================================
	-- CHEST POSITION
	--================================================

	local radius = ORB_SIZE / 2

	-- Front of torso
	local front = -(torso.Size.Z / 2)

	-- Put most of the sphere INSIDE the torso.
	local z = front + radius - 0.35

	orb.CFrame = torso.CFrame * CFrame.new(
		x,
		ORB_Y,
		z
	)

	orb.Parent = character

	--================================================
	-- WELD
	--================================================

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = torso
	weld.Part1 = orb
	weld.Parent = orb

end


--==================================================
-- TWO ORBS
--==================================================

makeOrb(LEFT_X)
makeOrb(RIGHT_X)
