local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Exact assets
local HAIR_ID = "123633915099119"
local FACE_ID = "72680112744477"
local TAIL_ID = "99456016159610"

--------------------------------------------------
-- REMOVE EXISTING ACCESSORIES / CLOTHING / TOOLS
--------------------------------------------------

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

--------------------------------------------------
-- REMOVE OLD FACE
--------------------------------------------------

local head = character:FindFirstChild("Head")

if head then
	for _, obj in ipairs(head:GetChildren()) do
		if obj:IsA("Decal") then
			obj:Destroy()
		end
	end
end

--------------------------------------------------
-- APPLY HAIR / FACE / TAIL
--------------------------------------------------

local description = humanoid:GetAppliedDescription()

description.HairAccessory = HAIR_ID
description.Face = FACE_ID
description.BackAccessory = TAIL_ID

description.Shirt = 0
description.Pants = 0
description.GraphicTShirt = 0

humanoid:ApplyDescription(description)

task.wait(0.5)

character = player.Character or character

--------------------------------------------------
-- GET SKIN COLOR
--------------------------------------------------

local torso =
	character:FindFirstChild("UpperTorso")
	or character:FindFirstChild("Torso")

local skinColor = Color3.fromRGB(120, 120, 120)

if torso and torso:IsA("BasePart") then
	skinColor = torso.Color
end

--------------------------------------------------
-- RECOLOR ONLY LOCAL CHARACTER
--------------------------------------------------

for _, obj in ipairs(character:GetChildren()) do
	if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
		obj.Color = skinColor
	end
end

--------------------------------------------------
-- SPHERE FUNCTION
--------------------------------------------------

local function createSphere(name, bodyPart, offset)
	if not bodyPart then
		return
	end

	local sphere = Instance.new("Part")
	sphere.Name = name
	sphere.Shape = Enum.PartType.Ball
	sphere.Size = Vector3.new(0.65, 0.65, 0.65)

	-- Same color as the player's skin
	sphere.Color = skinColor

	sphere.Material = Enum.Material.SmoothPlastic
	sphere.CanCollide = false
	sphere.CanTouch = false
	sphere.CanQuery = false
	sphere.Massless = true
	sphere.Anchored = false

	sphere.CFrame = bodyPart.CFrame * CFrame.new(offset)
	sphere.Parent = character

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = bodyPart
	weld.Part1 = sphere
	weld.Parent = sphere
end

--------------------------------------------------
-- CHEST SPHERES
--------------------------------------------------

local chest =
	character:FindFirstChild("UpperTorso")
	or character:FindFirstChild("Torso")

if chest then
	createSphere(
		"ChestSphereLeft",
		chest,
		Vector3.new(-0.55, 0, -0.55)
	)

	createSphere(
		"ChestSphereRight",
		chest,
		Vector3.new(0.55, 0, -0.55)
	)
end

--------------------------------------------------
-- BACK OF UPPER LEG SPHERES
--------------------------------------------------

local leftLeg =
	character:FindFirstChild("LeftUpperLeg")
	or character:FindFirstChild("Left Leg")

local rightLeg =
	character:FindFirstChild("RightUpperLeg")
	or character:FindFirstChild("Right Leg")

-- Place them toward the back of the upper legs
if leftLeg then
	createSphere(
		"BackUpperLegSphereLeft",
		leftLeg,
		Vector3.new(0, 0, 0.45)
	)
end

if rightLeg then
	createSphere(
		"BackUpperLegSphereRight",
		rightLeg,
		Vector3.new(0, 0, 0.45)
	)
end
