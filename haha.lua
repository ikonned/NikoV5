local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")

local LocalPlayer = Players.LocalPlayer

-- =====================================================
-- SETTINGS
-- =====================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- Same tan color as the body
local ORB_COLOR = Color3.fromRGB(204, 160, 115)

local ORB_SIZE = 1.3

-- Your Black hair
local HAIR_ID = 88443547532669

-- Similar Shy Blush Face accessory
local FACE_ACCESSORY_ID = 80812899534997


-- =====================================================
-- LOAD ACCESSORY
-- =====================================================

local function loadAccessory(assetId)

	local success, model = pcall(function()
		return InsertService:LoadAsset(assetId)
	end)

	if not success or not model then
		warn("Could not load asset:", assetId)
		return nil
	end

	local accessory = model:FindFirstChildWhichIsA("Accessory", true)

	if not accessory then
		model:Destroy()
		warn("Asset is not an accessory:", assetId)
		return nil
	end

	accessory.Parent = nil

	model:Destroy()

	return accessory
end


-- =====================================================
-- SETUP CHARACTER
-- =====================================================

local function setupCharacter(character)

	local humanoid = character:WaitForChild("Humanoid")

	local torso = character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
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
	-- CHANGE SKIN COLOR
	-- =================================================

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

		pcall(function()
			humanoid:AddAccessory(hair)
		end)
	end


	-- =================================================
	-- EQUIP SHY BLUSH FACE ACCESSORY
	-- =================================================

	local faceAccessory = loadAccessory(FACE_ACCESSORY_ID)

	if faceAccessory then
		faceAccessory.Parent = character

		pcall(function()
			humanoid:AddAccessory(faceAccessory)
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
	-- CREATE 2 CHEST ORBS
	-- =================================================

	local orbPositions = {
		-0.62, -- Left orb
		 0.62  -- Right orb
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


		-- =============================================
		-- ORB POSITION
		-- =============================================

		local frontSurface = -(torso.Size.Z / 2)

		-- Push the orb into the torso.
		local depth = frontSurface + 0.45

		orb.CFrame = torso.CFrame * CFrame.new(
			x,      -- Left / right
			0.45,   -- Higher on chest
			depth   -- Inside torso
		)


		orb.Parent = character


		-- =============================================
		-- WELD ORB TO TORSO
		-- =============================================

		local weld = Instance.new("WeldConstraint")

		weld.Part0 = torso
		weld.Part1 = orb

		weld.Parent = orb
	end
end


-- =====================================================
-- ONLY APPLY TO LOCAL PLAYER
-- =====================================================

if LocalPlayer.Character then
	setupCharacter(LocalPlayer.Character)
end


-- =====================================================
-- REAPPLY AFTER RESPAWN
-- =====================================================

LocalPlayer.CharacterAdded:Connect(function(character)

	task.wait(1)

	setupCharacter(character)

end)
