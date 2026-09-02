local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =====================================================
-- SETTINGS
-- =====================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_COLOR = Color3.fromRGB(204, 160, 115)

local ORB_SIZE = 1.35

-- Black hair
local HAIR_ID = "88443547532669"

-- Similar Shy Blush Face accessory
local FACE_ACCESSORY_ID = "80812899534997"

-- Orb position
local ORB_X = 0.35      -- SMALLER = closer together
local ORB_Y = 0.55      -- Higher on chest


-- =====================================================
-- SETUP
-- =====================================================

local function setupCharacter(character)

	local humanoid = character:WaitForChild("Humanoid")

	-- Wait for body
	local torso = character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		return
	end

	-- =================================================
	-- REMOVE CLOTHING
	-- =================================================

	for _, obj in ipairs(character:GetChildren()) do

		if obj:IsA("Shirt")
			or obj:IsA("Pants")
			or obj:IsA("ShirtGraphic") then

			obj:Destroy()

		end
	end


	-- =================================================
	-- REMOVE EXISTING ACCESSORIES
	-- =================================================

	for _, obj in ipairs(character:GetChildren()) do

		if obj:IsA("Accessory") then
			obj:Destroy()
		end

	end


	-- =================================================
	-- TAN SKIN
	-- =================================================

	local bodyColors = character:FindFirstChildOfClass("BodyColors")

	if bodyColors then

		bodyColors.HeadColor3 = SKIN_COLOR
		bodyColors.TorsoColor3 = SKIN_COLOR
		bodyColors.LeftArmColor3 = SKIN_COLOR
		bodyColors.RightArmColor3 = SKIN_COLOR
		bodyColors.LeftLegColor3 = SKIN_COLOR
		bodyColors.RightLegColor3 = SKIN_COLOR

	end

	-- Also directly color body parts
	for _, obj in ipairs(character:GetChildren()) do

		if obj:IsA("BasePart") then
			obj.Color = SKIN_COLOR
		end

	end


	-- =================================================
	-- EQUIP HAIR + FACE
	-- =================================================

	local description

	local success = pcall(function()
		description = humanoid:GetAppliedDescription()
	end)

	if not success or not description then
		return
	end

	-- Black hair
	description.HairAccessory = HAIR_ID

	-- Shy Blush face accessory
	description.FaceAccessory = FACE_ACCESSORY_ID

	-- Keep body tan
	description.HeadColor = SKIN_COLOR
	description.TorsoColor = SKIN_COLOR
	description.LeftArmColor = SKIN_COLOR
	description.RightArmColor = SKIN_COLOR
	description.LeftLegColor = SKIN_COLOR
	description.RightLegColor = SKIN_COLOR


	-- Apply avatar appearance
	pcall(function()
		humanoid:ApplyDescriptionAsync(description)
	end)


	-- Let Roblox finish loading accessories
	task.wait(1)


	-- =================================================
	-- GET TORSO AGAIN
	-- =================================================

	torso = character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		return
	end


	-- =================================================
	-- REMOVE OLD ORBS
	-- =================================================

	for _, obj in ipairs(character:GetChildren()) do

		if obj.Name == "ChestOrb" then
			obj:Destroy()
		end

	end


	-- =================================================
	-- CREATE 2 ORBS
	-- =================================================

	local orbPositions = {
		-ORB_X, -- Left
		 ORB_X  -- Right
	}


	for _, x in ipairs(orbPositions) do

		local orb = Instance.new("Part")

		orb.Name = "ChestOrb"
		orb.Shape = Enum.PartType.Ball

		orb.Size = Vector3.new(
			ORB_SIZE,
			ORB_SIZE,
			ORB_SIZE
		)

		orb.Color = ORB_COLOR
		orb.Material = Enum.Material.SmoothPlastic

		orb.Anchored = false
		orb.CanCollide = false
		orb.CanTouch = false
		orb.CanQuery = false
		orb.Massless = true


		-- =================================================
		-- ACTUALLY HALF INSIDE THE TORSO
		-- =================================================

		-- Front of torso
		local frontSurface = -(torso.Size.Z / 2)

		-- Half the orb goes inside the torso.
		-- This is based on the actual orb radius.
		local depth = frontSurface + (ORB_SIZE / 2)


		orb.CFrame = torso.CFrame * CFrame.new(
			x,
			ORB_Y,
			depth
		)


		orb.Parent = character


		-- =================================================
		-- WELD
		-- =================================================

		local weld = Instance.new("WeldConstraint")

		weld.Part0 = torso
		weld.Part1 = orb

		weld.Parent = orb

	end
end


-- =====================================================
-- ONLY YOUR CHARACTER
-- =====================================================

if LocalPlayer.Character then
	setupCharacter(LocalPlayer.Character)
end


-- =====================================================
-- RESPAWN
-- =====================================================

LocalPlayer.CharacterAdded:Connect(function(character)

	task.wait(1)

	setupCharacter(character)

end)
