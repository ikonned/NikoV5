local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- =====================================================
-- SETTINGS
-- =====================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- Dark chest orbs
local ORB_COLOR = Color3.fromRGB(35, 30, 28)

local ORB_SIZE = 1.67

-- White anime/cat-ear hair
local HAIR_ID = 126188913203914

-- Shy anime face
local FACE_ID = 91788965319375

-- ORB POSITION
-- Smaller X = closer together
local ORB_X = 0.35

-- Slightly lower than before
local ORB_Y = 0.20


-- =====================================================
-- LOAD ACCESSORY
-- =====================================================

local function loadAccessory(assetId)

	local success, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. tostring(assetId))
	end)

	if not success or not objects then
		warn("Could not load asset:", assetId)
		return nil
	end

	for _, object in ipairs(objects) do

		if object:IsA("Accessory") then
			return object
		end

	end

	return nil
end


-- =====================================================
-- SETUP CHARACTER
-- =====================================================

local function setupCharacter(character)

	local humanoid = character:WaitForChild("Humanoid")

	-- Wait for torso
	local torso =
		character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		warn("No torso found")
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
	-- REMOVE ACCESSORIES
	-- =================================================

	for _, object in ipairs(character:GetChildren()) do

		if object:IsA("Accessory") then
			object:Destroy()
		end

	end


	-- =================================================
	-- TAN SKIN
	-- =================================================

	local bodyColors =
		character:FindFirstChildOfClass("BodyColors")

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
	-- EQUIP WHITE HAIR
	-- =================================================

	local hair = loadAccessory(HAIR_ID)

	if hair then

		hair.Parent = character

		pcall(function()
			humanoid:AddAccessory(hair)
		end)

	end


	-- =================================================
	-- EQUIP SHY FACE
	-- =================================================

	local face = loadAccessory(FACE_ID)

	if face then

		face.Parent = character

		pcall(function()
			humanoid:AddAccessory(face)
		end)

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
	-- CREATE EXACTLY 2 ORBS
	-- =================================================

	local orbPositions = {
		-ORB_X,
		 ORB_X
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

		orb.Material = Enum.Material.SmoothPlastic
		orb.Color = ORB_COLOR

		orb.Anchored = false
		orb.CanCollide = false
		orb.CanTouch = false
		orb.CanQuery = false
		orb.Massless = true


		-- =================================================
		-- PUT ORBS ON FRONT OF CHEST
		-- =================================================

		local radius = ORB_SIZE / 2

		local frontSurface =
			-(torso.Size.Z / 2)

		-- Push them toward the front.
		-- Keeps roughly half embedded.
		local depth =
			frontSurface - radius + 0.15


		orb.CFrame =
			torso.CFrame *
			CFrame.new(
				x,
				ORB_Y,
				depth
			)


		orb.Parent = character


		-- =================================================
		-- WELD ORB TO TORSO
		-- =================================================

		local weld =
			Instance.new("WeldConstraint")

		weld.Part0 = torso
		weld.Part1 = orb

		weld.Parent = orb

	end

end


-- =====================================================
-- RUN ONLY FOR YOU
-- =====================================================

if LocalPlayer.Character then
	setupCharacter(LocalPlayer.Character)
end


-- =====================================================
-- RUN AGAIN AFTER RESPAWN
-- =====================================================

LocalPlayer.CharacterAdded:Connect(function(character)

	task.wait(1)

	setupCharacter(character)

end)
