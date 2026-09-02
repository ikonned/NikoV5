local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- =====================================================
-- SETTINGS
-- =====================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_COLOR = Color3.fromRGB(204, 160, 115)

local ORB_SIZE = 1.1

-- Black hair
local HAIR_ID = 88443547532669

-- Similar Shy Blush Face
local FACE_ID = 80812899534997


-- =====================================================
-- LOAD ACCESSORY LOCALLY
-- =====================================================

local function getAccessory(assetId)

	local success, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. assetId)
	end)

	if not success or not objects or #objects == 0 then
		warn("Could not load asset:", assetId)
		return nil
	end

	for _, object in ipairs(objects) do
		if object:IsA("Accessory") then
			return object
		end
	end

	warn("No Accessory found in asset:", assetId)
	return nil
end


-- =====================================================
-- SETUP CHARACTER
-- =====================================================

local function setupCharacter(character)

	local humanoid = character:WaitForChild("Humanoid")

	local torso =
		character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		warn("Torso not found")
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
	-- REMOVE EXISTING ACCESSORIES
	-- =================================================

	for _, object in ipairs(character:GetChildren()) do

		if object:IsA("Accessory") then
			object:Destroy()
		end

	end


	-- =================================================
	-- CHANGE BODY COLOR
	-- =================================================

	for _, object in ipairs(character:GetChildren()) do

		if object:IsA("BasePart") then
			object.Color = SKIN_COLOR
		end

	end


	-- =================================================
	-- EQUIP BLACK HAIR
	-- =================================================

	local hair = getAccessory(HAIR_ID)

	if hair then

		hair.Parent = character

		local success, err = pcall(function()
			humanoid:AddAccessory(hair)
		end)

		if not success then
			warn("Hair failed:", err)
		end

	end


	-- =================================================
	-- EQUIP SHY BLUSH FACE
	-- =================================================

	local face = getAccessory(FACE_ID)

	if face then

		face.Parent = character

		local success, err = pcall(function()
			humanoid:AddAccessory(face)
		end)

		if not success then
			warn("Face failed:", err)
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
	-- CREATE TWO CHEST ORBS
	-- =================================================

	local positions = {
		-0.62, -- Left orb
		 0.62  -- Right orb
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
		-- HIGHER + HALF INSIDE TORSO
		-- =================================================

		local frontSurface = -(torso.Size.Z / 2)

		-- Push the orb into the torso
		local depth = frontSurface + 0.45

		orb.CFrame = torso.CFrame * CFrame.new(
			x,
			0.45,
			depth
		)

		orb.Parent = character


		-- =================================================
		-- WELD TO TORSO
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
-- RUN AGAIN AFTER RESPAWN
-- =====================================================

LocalPlayer.CharacterAdded:Connect(function(character)

	task.wait(1)

	setupCharacter(character)

end)
