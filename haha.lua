local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_COLOR = SKIN_COLOR

local ORB_SIZE = 1.25

-- Closer together
local ORB_X = 0.28

-- Slightly lower
local ORB_Y = 0.12

-- Your requested hair
local HAIR_ID = 88443547532669

-- Similar Shy Blush face accessory
local FACE_ID = 80812899534997


--==================================================
-- LOAD ASSET
--==================================================

local function loadAsset(id)

	local success, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. tostring(id))
	end)

	if not success or not objects then
		warn("Could not load:", id)
		return nil
	end

	for _, obj in ipairs(objects) do

		if obj:IsA("Accessory") then
			return obj
		end

		local accessory = obj:FindFirstChildWhichIsA("Accessory", true)

		if accessory then
			return accessory
		end

	end

	return nil
end


--==================================================
-- MANUALLY ATTACH ACCESSORY
--==================================================

local function attachAccessory(character, accessory)

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not humanoid or not accessory then
		return false
	end

	-- Put accessory inside character
	accessory.Parent = character

	-- First try Roblox's normal method
	local success = pcall(function()
		humanoid:AddAccessory(accessory)
	end)

	if success then

		task.wait(0.15)

		-- Check if Roblox actually created the connection
		local handle = accessory:FindFirstChild("Handle")

		if handle then
			return true
		end

	end


	--================================================
	-- MANUAL ATTACH FALLBACK
	--================================================

	local handle = accessory:FindFirstChild("Handle")

	if not handle then
		return false
	end

	local attachment = handle:FindFirstChildWhichIsA("Attachment")

	if not attachment then
		return false
	end


	-- Find matching attachment on character
	local matchingAttachment

	for _, obj in ipairs(character:GetDescendants()) do

		if obj:IsA("Attachment")
			and obj.Name == attachment.Name
			and obj.Parent:IsA("BasePart") then

			matchingAttachment = obj
			break

		end

	end


	if not matchingAttachment then
		return false
	end


	-- Position handle so both attachments line up
	handle.CFrame =
		matchingAttachment.WorldCFrame
		* attachment.CFrame:Inverse()

	handle.Anchored = false
	handle.CanCollide = false
	handle.CanTouch = false
	handle.CanQuery = false
	handle.Massless = true


	-- Weld handle to body
	local weld = Instance.new("WeldConstraint")

	weld.Part0 = matchingAttachment.Parent
	weld.Part1 = handle

	weld.Parent = handle

	return true
end


--==================================================
-- CHARACTER SETUP
--==================================================

local function setupCharacter(character)

	local humanoid = character:WaitForChild("Humanoid")

	-- Wait for the body to fully load
	task.wait(0.5)


	local torso =
		character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		warn("Torso not found")
		return
	end


	--================================================
	-- REMOVE CLOTHING
	--================================================

	for _, obj in ipairs(character:GetChildren()) do

		if obj:IsA("Shirt")
			or obj:IsA("Pants")
			or obj:IsA("ShirtGraphic") then

			obj:Destroy()

		end
	end


	--================================================
	-- REMOVE OLD CHEST ORBS
	--================================================

	for _, obj in ipairs(character:GetChildren()) do

		if obj.Name == "ChestOrb" then
			obj:Destroy()
		end

	end


	--================================================
	-- REMOVE OLD ACCESSORIES
	--================================================

	for _, obj in ipairs(character:GetChildren()) do

		if obj:IsA("Accessory") then
			obj:Destroy()
		end

	end


	--================================================
	-- TAN SKIN
	--================================================

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

		if obj:IsA("BasePart") then
			obj.Color = SKIN_COLOR
		end

	end


	--================================================
	-- EQUIP HAIR
	--================================================

	local hair = loadAsset(HAIR_ID)

	if hair then

		local equipped = attachAccessory(character, hair)

		if not equipped then
			warn("Hair could not be attached")
		end

	else
		warn("Hair asset could not be loaded")
	end


	--================================================
	-- EQUIP FACE
	--================================================

	local face = loadAsset(FACE_ID)

	if face then

		local equipped = attachAccessory(character, face)

		if not equipped then
			warn("Face could not be attached")
		end

	else
		warn("Face asset could not be loaded")
	end


	--================================================
	-- REFRESH TORSO
	--================================================

	torso =
		character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		return
	end


	--================================================
	-- CREATE TWO ORBS
	--================================================

	local positions = {
		-ORB_X,
		ORB_X
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

		-- SAME COLOR AS SKIN
		orb.Color = SKIN_COLOR

		orb.Material = Enum.Material.SmoothPlastic

		orb.Anchored = false
		orb.CanCollide = false
		orb.CanTouch = false
		orb.CanQuery = false
		orb.Massless = true


		--================================================
		-- PUT ORB INSIDE FRONT OF TORSO
		--================================================

		local radius = ORB_SIZE / 2

		-- Front of torso
		local front = -(torso.Size.Z / 2)

		-- Move the center INSIDE the torso.
		-- Only part of the orb should remain visible.
		local depth = front + radius - 0.20


		orb.CFrame =
			torso.CFrame *
			CFrame.new(
				x,
				ORB_Y,
				depth
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
end


--==================================================
-- ONLY YOUR PLAYER
--==================================================

local function run()

	local character = LocalPlayer.Character

	if not character then
		character = LocalPlayer.CharacterAdded:Wait()
	end

	setupCharacter(character)

end


run()


--==================================================
-- RESPAWN
--==================================================

LocalPlayer.CharacterAdded:Connect(function(character)

	task.wait(1)

	setupCharacter(character)

end)
