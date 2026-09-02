local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =========================
-- SETTINGS
-- =========================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_SIZE = 1.67

-- Black hair
local HAIR_ID = "88443547532669"

-- =========================
-- SETUP CHARACTER
-- =========================

local function setupCharacter(character)

	local humanoid = character:WaitForChild("Humanoid")

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
	-- REMOVE OLD HAIR
	-- =========================

	for _, object in ipairs(character:GetChildren()) do

		if object:IsA("Accessory") then
			object:Destroy()
		end

	end

	-- =========================
	-- CHANGE BODY COLOR
	-- =========================

	for _, object in ipairs(character:GetChildren()) do

		if object:IsA("BasePart") then
			object.Color = SKIN_COLOR
		end

	end

	-- =========================
	-- EQUIP BLACK HAIR
	-- =========================

	local description = humanoid:GetAppliedDescription()

	description.HairAccessory = HAIR_ID

	description.HeadColor = SKIN_COLOR
	description.TorsoColor = SKIN_COLOR
	description.LeftArmColor = SKIN_COLOR
	description.RightArmColor = SKIN_COLOR
	description.LeftLegColor = SKIN_COLOR
	description.RightLegColor = SKIN_COLOR

	-- Apply the description
	pcall(function()
		humanoid:ApplyDescriptionAsync(description)
	end)

	-- Let Roblox finish applying the avatar
	task.wait(1)

	-- Get torso again in case appearance changed it
	torso = character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		return
	end

	-- =========================
	-- CREATE 2 CHEST ORBS
	-- =========================

	local positions = {
		-0.62, -- Left orb
		0.62   -- Right orb
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
		-- ORBS HIGHER + HALF INSIDE
		-- =========================

		local frontSurface = -(torso.Size.Z / 2)

		local depth = frontSurface + 0.45

		orb.CFrame = torso.CFrame * CFrame.new(
			x,
			0.45,
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
-- ONLY YOUR CHARACTER
-- =========================

if LocalPlayer.Character then
	setupCharacter(LocalPlayer.Character)
end

-- Reapply after respawn
LocalPlayer.CharacterAdded:Connect(function(character)

	task.wait(0.5)

	setupCharacter(character)

end)
