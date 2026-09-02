local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- =====================================================
-- SETTINGS
-- =====================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_COLOR = Color3.fromRGB(204, 160, 115)

local ORB_SIZE = 1.67

-- Black hair
local HAIR_ID = 88443547532669

-- Shy Blush Face replacement
local FACE_ID = 80812899534997

-- Closer together
local ORB_X = 0.35

-- Slightly lower
local ORB_Y = 0.25


-- =====================================================
-- LOAD AN ACCESSORY
-- =====================================================

local function loadAccessory(assetId)

	local success, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. tostring(assetId))
	end)

	if not success or not objects then
		warn("FAILED TO LOAD ACCESSORY:", assetId)
		return nil
	end

	for _, object in ipairs(objects) do
		if object:IsA("Accessory") then
			return object
		end
	end

	warn("NO ACCESSORY FOUND:", assetId)
	return nil
end


-- =====================================================
-- SETUP CHARACTER
-- =====================================================

local function setupCharacter(character)

	local humanoid = character:WaitForChild("Humanoid")

	local torso = character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		warn("TORso not found")
		return
	end


	-- =================================================
	-- REMOVE CLOTHING
	-- =================================================

	for _, object in ipairs(character:GetChildren()) do

		if object:IsA("Shirt")
			or object:IsA("Pants")
			or object:IsA("ShirtGraphic") then

			object:Destroy()

		end

	end


	-- =================================================
	-- REMOVE OLD ACCESSORIES
	-- =================================================

	for _, object in ipairs(character:GetChildren()) do

		if object:IsA("Accessory") then
			object:Destroy()
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


	for _, object in ipairs(character:GetChildren()) do

		if object:IsA("BasePart") then
			object.Color = SKIN_COLOR
		end

	end


	-- =================================================
	-- EQUIP BLACK HAIR
	-- =================================================

	local hair = loadAccessory(HAIR_ID)

	if hair then

		hair.Parent = character

		local success, errorMessage = pcall(function()
			humanoid:AddAccessory(hair)
		end)

		if not success then
			warn("HAIR ERROR:", errorMessage)
		end

	end


	-- =================================================
	-- EQUIP SHY BLUSH FACE
	-- =================================================

	local face = loadAccessory(FACE_ID)

	if face then

		face.Parent = character

		local success, errorMessage = pcall(function()
			humanoid:AddAccessory(face)
		end)

		if not success then
			warn("FACE ERROR:", errorMessage)
		end

	end


	-- =================================================
	-- REMOVE OLD ORBS
	-- =================================================

	for _, object in ipairs(character:GetChildren()) do

		if object.Name == "ChestOrb" then
			object:Destroy()
		end

	end


	-- =================================================
	-- CREATE 2 CHEST ORBS
	-- =================================================

	local positions = {
		-ORB_X, -- left
		 ORB_X  -- right
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

		orb.Color = ORB_COLOR
		orb.Material = Enum.Material.SmoothPlastic

		orb.Anchored = false
		orb.CanCollide = false
		orb.CanTouch = false
		orb.CanQuery = false
		orb.Massless = true


		-- =================================================
		-- CHEST POSITION
		-- =================================================

		local frontSurface = -(torso.Size.Z / 2)

		-- Orb radius
		local radius = ORB_SIZE / 2

		-- Half inside the torso,
		-- slightly toward the front
		local depth = frontSurface + radius - 0.10

		orb.CFrame = torso.CFrame * CFrame.new(
			x,
			ORB_Y,
			depth
		)


		orb.Parent = character


		-- =================================================
		-- WELD ORB TO TORSO
		-- =================================================

		local weld = Instance.new("WeldConstraint")

		weld.Part0 = torso
		weld.Part1 = orb

		weld.Parent = orb

	end

end


-- =====================================================
-- ONLY APPLY TO LOCAL PLAYER
-- =====================================================

local function run()

	local character = LocalPlayer.Character

	if not character then
		character = LocalPlayer.CharacterAdded:Wait()
	end

	setupCharacter(character)

end


run()


-- =====================================================
-- REAPPLY AFTER RESPAWN
-- =====================================================

LocalPlayer.CharacterAdded:Connect(function(character)

	task.wait(1)

	setupCharacter(character)

end)
