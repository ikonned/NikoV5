local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =========================
-- SETTINGS
-- =========================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_SIZE = 0.5

local function setupCharacter(character)

	-- Get torso
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

	-- Remove layered clothing/accessories that can cover the chest
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
	-- REMOVE OLD ORBS
	-- =========================

	for _, object in ipairs(character:GetChildren()) do
		if object.Name == "ChestOrb" then
			object:Destroy()
		end
	end

	-- =========================
	-- CREATE 2 CHEST ORBS
	-- =========================

	local positions = {
		-0.62, -- Left
		0.62   -- Right
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
		-- MOVE ORB FURTHER INTO CHEST
		-- =========================

		-- Front of torso is negative Z.
		-- The +0.45 pushes the orb deeper inside,
		-- reducing the visible bump.
		local frontSurface = -(torso.Size.Z / 2)
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

-- Reapply after respawn
LocalPlayer.CharacterAdded:Connect(function(character)

	character:WaitForChild("Humanoid")
	task.wait(0.5)

	setupCharacter(character)

end)
