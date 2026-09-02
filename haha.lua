local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =========================
-- SETTINGS
-- =========================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_SIZE = 1.67

-- Avatar items
local HAIR_ID = "88443547532669"

-- Put the actual FACE asset ID here
local FACE_ID = 0


local function setupCharacter(character)

	-- Get humanoid
	local humanoid = character:WaitForChild("Humanoid")

	-- Get torso (R6 or R15)
	local torso = character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		return
	end

	-- =========================
	-- REMOVE CLOTHING
	-- =========================

	for _, object in ipairs(character:GetChildren()) do
		if object:IsA("Shirt")
			or object:IsA("Pants")
			or object:IsA("ShirtGraphic") then

			object:Destroy()
		end
	end

	-- =========================
	-- REMOVE OLD ORBS
	-- =========================

	for _, object in ipairs(character:GetChildren()) do
		if object.Name == "ChestOrb" then
			object:Destroy()
		end
	end

	-- =========================
	-- REMOVE OLD ACCESSORIES
	-- =========================

	for _, object in ipairs(character:GetChildren()) do
		if object:IsA("Accessory") then
			object:Destroy()
		end
	end

	-- =========================
	-- CHANGE SKIN COLOR
	-- =========================

	for _, object in ipairs(character:GetChildren()) do
		if object:IsA("BasePart") then
			object.Color = SKIN_COLOR
		end
	end

	-- =========================
	-- EQUIP HAIR + FACE
	-- =========================

	local description = humanoid:GetAppliedDescription()

	-- Black hair
	description.HairAccessory = HAIR_ID

	-- Face
	if FACE_ID ~= 0 then
		description.Face = FACE_ID
	end

	-- Keep the tan colors
	description.HeadColor = SKIN_COLOR
	description.TorsoColor = SKIN_COLOR
	description.LeftArmColor = SKIN_COLOR
	description.RightArmColor = SKIN_COLOR
	description.LeftLegColor = SKIN_COLOR
	description.RightLegColor = SKIN_COLOR

	-- Apply appearance
	pcall(function()
		humanoid:ApplyDescriptionAsync(description)
	end)

	-- Wait for appearance to finish
	task.wait(0.5)

	-- =========================
	-- CREATE 2 CHEST ORBS
	-- =========================

	local positions = {
		-0.62, -- Left orb moved slightly right
		0.62   -- Right orb moved slightly left
	}

	for _, x in ipairs(positions) do

		local orb = Instance.new("Part")

		orb.Name = "ChestOrb"
		orb.Shape = Enum.PartType.Ball
		orb.Size = Vector3.new(
			ORB_SIZE,
			ORB_SIZE,
			ORB_SIZE
		)

		orb.Material = Enum.Material.SmoothPlastic
		orb.Color = ORB_COLOR

		orb.Anchored = false
		orb.CanCollide = false
		orb.CanTouch = false
		orb.CanQuery = false
		orb.Massless = true

		-- =========================
		-- HALF INSIDE THE TORSO
		-- =========================

		local frontSurface = -(torso.Size.Z / 2)

		-- Push the orb into the torso
		local depth = frontSurface + 0.45

		orb.CFrame = torso.CFrame * CFrame.new(
			x,
			0,
			depth
		)

		orb.Parent = character

		-- =========================
		-- WELD TO TORSO
		-- =========================

		local weld = Instance.new("WeldConstraint")
		weld.Part0 = torso
		weld.Part1 = orb
		weld.Parent = orb
	end
end


-- =========================
-- APPLY ONLY TO YOU
-- =========================

local character = LocalPlayer.Character

if character then
	setupCharacter(character)
end

-- Reapply after respawning
LocalPlayer.CharacterAdded:Connect(function(character)

	task.wait(0.5)

	setupCharacter(character)

end)
