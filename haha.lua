local Players = game:GetService("Players")

local player = Players.LocalPlayer

--==================================================
-- EXACT ACCESSORIES
--==================================================

local HAIR_ID = 123633915099119
local FACE_ID = 72680112744477
local TAIL_ID = 99456016159610

--==================================================
-- SETTINGS
--==================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- KEEPING YOUR MELONS
local MELON_SIZE = 1.35

local LEFT_MELON_X = -0.36
local RIGHT_MELON_X = 0.36

local MELON_Y = 0.05

local DETAIL_SIZE = 0.20
local DETAIL_COLOR = Color3.fromRGB(170, 120, 85)

--==================================================
-- CHARACTER
--==================================================

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Save position so this script NEVER intentionally moves you
local root = character:FindFirstChild("HumanoidRootPart")
local savedCFrame = root and root.CFrame


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
-- REMOVE OLD CUSTOM OBJECTS
--==================================================

for _, obj in ipairs(character:GetDescendants()) do

	if obj.Name == "Melon"
		or obj.Name == "MelonDetail" then

		obj:Destroy()
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

for _, obj in ipairs(character:GetChildren()) do

	if obj:IsA("BasePart")
		and obj.Name ~= "HumanoidRootPart" then

		obj.Color = SKIN_COLOR

	end
end


--==================================================
-- LOAD ACCESSORY
--==================================================

local function loadAccessory(assetId)

	local ok, objects = pcall(function()

		return game:GetObjects(
			"rbxassetid://" .. tostring(assetId)
		)

	end)

	if not ok or not objects then
		warn("FAILED TO LOAD:", assetId)
		return nil
	end

	for _, obj in ipairs(objects) do

		if obj:IsA("Accessory") then
			return obj
		end

		local accessory =
			obj:FindFirstChildWhichIsA(
				"Accessory",
				true
			)

		if accessory then
			return accessory
		end

	end

	warn("NO ACCESSORY FOUND:", assetId)

	return nil
end


--==================================================
-- EQUIP ACCESSORY MANUALLY
--==================================================

local function equipAccessory(assetId)

	local accessory = loadAccessory(assetId)

	if not accessory then
		return false
	end

	-- Make sure it isn't sitting somewhere weird
	accessory.Parent = character

	local success = pcall(function()

		humanoid:AddAccessory(accessory)

	end)

	-- IMPORTANT:
	-- Client-side AddAccessory can create the accessory
	-- without correctly building the weld.
	pcall(function()

		humanoid:BuildRigFromAttachments()

	end)

	-- Make sure it isn't collidable
	for _, obj in ipairs(accessory:GetDescendants()) do

		if obj:IsA("BasePart") then

			obj.CanCollide = false
			obj.CanTouch = false
			obj.CanQuery = false
			obj.Massless = true

		end

	end

	return success
end


--==================================================
-- EQUIP HAIR
--==================================================

local hairWorked = equipAccessory(HAIR_ID)

if not hairWorked then
	warn("HAIR DID NOT LOAD")
end


--==================================================
-- EQUIP FACE
--==================================================

local faceWorked = equipAccessory(FACE_ID)

if not faceWorked then
	warn("FACE DID NOT LOAD")
end


--==================================================
-- EQUIP TAIL
--==================================================

local tailWorked = equipAccessory(TAIL_ID)

if not tailWorked then
	warn("TAIL DID NOT LOAD")
end


--==================================================
-- RESTORE POSITION
--==================================================

if root and root.Parent and savedCFrame then

	root.CFrame = savedCFrame

end


--==================================================
-- GET TORSO
--==================================================

local torso =
	character:FindFirstChild("UpperTorso")
	or character:FindFirstChild("Torso")

if not torso then
	warn("NO R6/R15 TORSO FOUND")
	return
end


--==================================================
-- CREATE MELON
--==================================================

local function createMelon(x)

	local melon = Instance.new("Part")

	melon.Name = "Melon"
	melon.Shape = Enum.PartType.Ball

	-- YOUR CURRENT MELON SIZE
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
		+ torso.CFrame.LookVector *
		(torso.Size.Z / 2)

	local position =
		front
		+ torso.CFrame.RightVector * x
		+ torso.CFrame.UpVector * MELON_Y

	melon.CFrame =
		CFrame.new(position)
		* torso.CFrame.Rotation

	melon.Parent = character


	--================================================
	-- CENTER DETAIL
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
		melon.CFrame
		* CFrame.new(
			0,
			0,
			-(MELON_SIZE / 2) - 0.01
		)

	detail.Parent = character


	--================================================
	-- WELDS
	--================================================

	local melonWeld =
		Instance.new("WeldConstraint")

	melonWeld.Part0 = torso
	melonWeld.Part1 = melon
	melonWeld.Parent = melon


	local detailWeld =
		Instance.new("WeldConstraint")

	detailWeld.Part0 = melon
	detailWeld.Part1 = detail
	detailWeld.Parent = detail

end


--==================================================
-- TWO MELONS
--==================================================

createMelon(LEFT_MELON_X)
createMelon(RIGHT_MELON_X)


print("======================================")
print("CUSTOM AVATAR FINISHED")
print("Hair:", hairWorked)
print("Face:", faceWorked)
print("Tail:", tailWorked)
print("R15/R6:", torso.Name)
print("======================================")
