local Players = game:GetService("Players")

-- =========================
-- SETTINGS
-- =========================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115) -- Tan like your example
local ORB_COLOR = Color3.fromRGB(204, 160, 115) -- 
local ORB_SIZE = 4.5

local function setupCharacter(character)

	-- Get torso (works with R6 and R15)
	local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")

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

	-- Left and right positions
	local positions = {
		-0.5,
		0.5
	}

	for _, x in ipairs(positions) do

		local orb = Instance.new("Part")

		orb.Name = "ChestOrb"
		orb.Shape = Enum.PartType.Ball
		orb.Size = Vector3.new(ORB_SIZE, ORB_SIZE, ORB_SIZE)

		-- Appearance
		orb.Material = Enum.Material.SmoothPlastic
		orb.Color = ORB_COLOR

		-- Physics
		orb.Anchored = false
		orb.CanCollide = false
		orb.CanTouch = false
		orb.CanQuery = false
		orb.Massless = true

		-- =========================
		-- HALF INSIDE THE TORSO
		-- =========================

		-- Roblox characters face toward -Z.
		-- Placing the orb's center at the front surface
		-- makes roughly half of the orb inside the torso.
		local frontSurface = -(torso.Size.Z / 2)

		orb.CFrame = torso.CFrame * CFrame.new(
			x,
			0,
			frontSurface
		)

		orb.Parent = character

		-- =========================
		-- WELD ORB TO CHEST
		-- =========================

		local weld = Instance.new("WeldConstraint")
		weld.Part0 = torso
		weld.Part1 = orb
		weld.Parent = orb
	end
end

-- =========================
-- PLAYER JOIN
-- =========================

Players.PlayerAdded:Connect(function(player)

	player.CharacterAdded:Connect(function(character)

		character:WaitForChild("Humanoid")

		task.wait(0.5)

		setupCharacter(character)

	end)

end)
