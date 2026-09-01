--========================================================
-- LOCAL R6 APPEARANCE + 4 SMALL SKIN ORBS
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

--========================================================
-- CONFIG
--========================================================

local HAIR_ID = 123633915099119
local FACE_ID = 72680112744477
local TAIL_ID = 99456016159610

-- Slightly smaller than your example
local ORB_SIZE = 0.72

-- Skin color
local SKIN_COLOR = Color3.fromRGB(145, 145, 145)

--========================================================
-- CHARACTER
--========================================================

local Humanoid = Character:WaitForChild("Humanoid")

if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
	warn("This script is intended for R6.")
	return
end

local Head = Character:WaitForChild("Head")
local Torso = Character:WaitForChild("Torso")
local LeftLeg = Character:WaitForChild("Left Leg")
local RightLeg = Character:WaitForChild("Right Leg")

--========================================================
-- DO NOT TOUCH BACKPACK / TOOLS
--========================================================
-- We intentionally do NOT remove anything from the Backpack.

-- Remove only accessories currently attached to the character
-- so the requested appearance can be applied.
for _, obj in ipairs(Character:GetChildren()) do
	if obj:IsA("Accessory") then
		obj:Destroy()
	end
end

-- Remove clothing currently worn by the character.
for _, obj in ipairs(Character:GetChildren()) do
	if obj:IsA("Shirt")
		or obj:IsA("Pants")
		or obj:IsA("ShirtGraphic") then
		obj:Destroy()
	end
end

--========================================================
-- BODY COLOR
--========================================================

for _, obj in ipairs(Character:GetChildren()) do
	if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
		obj.Color = SKIN_COLOR
	end
end

--========================================================
-- FACE
--========================================================

for _, obj in ipairs(Head:GetChildren()) do
	if obj:IsA("Decal") then
		obj:Destroy()
	end
end

local Face = Instance.new("Decal")
Face.Name = "face"
Face.Face = Enum.NormalId.Front
Face.Texture = "rbxassetid://" .. FACE_ID
Face.Parent = Head

--========================================================
-- LOAD ACCESSORY
--========================================================

local function LoadAccessory(assetId)
	local ok, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. assetId)
	end)

	if not ok or not objects then
		warn("Could not load accessory:", assetId)
		return nil
	end

	for _, object in ipairs(objects) do
		if object:IsA("Accessory") then
			object.Parent = Character

			local handle = object:FindFirstChild("Handle")

			if handle then
				local attachment = handle:FindFirstChildWhichIsA("Attachment")

				if attachment then
					local matchingAttachment =
						Character:FindFirstChild(attachment.Name, true)

					if matchingAttachment and matchingAttachment:IsA("Attachment") then
						handle.CFrame =
							matchingAttachment.WorldCFrame
							* attachment.CFrame:Inverse()

						local weld = Instance.new("Weld")
						weld.Part0 = matchingAttachment.Parent
						weld.Part1 = handle
						weld.C0 =
							matchingAttachment.CFrame
							* attachment.CFrame:Inverse()
						weld.Parent = handle
					end
				end
			end

			return object
		end
	end

	warn("No Accessory found in asset:", assetId)
	return nil
end

-- Hair
LoadAccessory(HAIR_ID)

-- Fox tail
LoadAccessory(TAIL_ID)

--========================================================
-- REMOVE OLD ORBS
--========================================================

local OldOrbs = Character:FindFirstChild("VisualOrbs")

if OldOrbs then
	OldOrbs:Destroy()
end

local OrbFolder = Instance.new("Folder")
OrbFolder.Name = "VisualOrbs"
OrbFolder.Parent = Character

--========================================================
-- ORB CREATION
--========================================================

local function CreateOrb(name, part, offset)
	local orb = Instance.new("Part")

	orb.Name = name
	orb.Shape = Enum.PartType.Ball

	orb.Size = Vector3.new(
		ORB_SIZE,
		ORB_SIZE,
		ORB_SIZE
	)

	orb.Color = SKIN_COLOR
	orb.Material = Enum.Material.SmoothPlastic

	orb.CanCollide = false
	orb.CanTouch = false
	orb.CanQuery = false
	orb.Massless = true
	orb.CastShadow = false

	orb.Parent = OrbFolder

	local weld = Instance.new("Weld")

	weld.Name = "OrbWeld"
	weld.Part0 = part
	weld.Part1 = orb
	weld.C0 = CFrame.new(offset)
	weld.Parent = orb

	return {
		Part = orb,
		Weld = weld,
		Base = CFrame.new(offset),
	}
end

--========================================================
-- FOUR ORBS
--========================================================

-- Chest
local LeftChest = CreateOrb(
	"LeftChestOrb",
	Torso,
	Vector3.new(-0.45, 0.28, -0.48)
)

local RightChest = CreateOrb(
	"RightChestOrb",
	Torso,
	Vector3.new(0.45, 0.28, -0.48)
)

-- Back of upper legs
local LeftUpperLeg = CreateOrb(
	"LeftUpperLegOrb",
	LeftLeg,
	Vector3.new(-0.05, 0.55, 0.38)
)

local RightUpperLeg = CreateOrb(
	"RightUpperLegOrb",
	RightLeg,
	Vector3.new(0.05, 0.55, 0.38)
)

local Orbs = {
	LeftChest,
	RightChest,
	LeftUpperLeg,
	RightUpperLeg
}

print("Local sexy appearance loaded.")
