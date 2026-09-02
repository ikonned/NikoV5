local Players = game:GetService("Players")

local Player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

-- Bigger melons
local MELON_SIZE = 1.55

-- Closer together
local MELON_X = 0.34

-- A little lower on chest
local MELON_Y = 0.10

-- Main melon detail
local DETAIL_COLOR = Color3.fromRGB(150, 105, 75)

-- Hair
local HAIR_COLOR = Color3.fromRGB(235, 235, 235)


--==================================================
-- REMOVE OLD CUSTOM OBJECTS
--==================================================

local function clearOld(character)

	for _, obj in ipairs(character:GetDescendants()) do

		if obj.Name == "CustomMelon"
			or obj.Name == "MelonCenter"
			or obj.Name == "CustomHair"
			or obj.Name == "CustomEar"
			or obj.Name == "CustomFace" then

			obj:Destroy()

		end

	end

end


--==================================================
-- REMOVE CLOTHES
--==================================================

local function removeClothes(character)

	for _, obj in ipairs(character:GetChildren()) do

		if obj:IsA("Shirt")
			or obj:IsA("Pants")
			or obj:IsA("ShirtGraphic") then

			obj:Destroy()

		end

	end

end


--==================================================
-- TAN BODY
--==================================================

local function tanBody(character)

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

	for _, obj in ipairs(character:GetChildren()) do

		if obj:IsA("BasePart") then
			obj.Color = SKIN_COLOR
		end

	end

end


--==================================================
-- CREATE MELON
--==================================================

local function createMelon(character, torso, x)

	local melon = Instance.new("Part")

	melon.Name = "CustomMelon"
	melon.Shape = Enum.PartType.Ball

	melon.Size = Vector3.new(
		MELON_SIZE,
		MELON_SIZE,
		MELON_SIZE
	)

	melon.Color = SKIN_COLOR
	melon.Material = Enum.Material.SmoothPlastic

	melon.Anchored = false
	melon.CanCollide = false
	melon.CanTouch = false
	melon.CanQuery = false
	melon.Massless = true


	--================================================
	-- PUT MELON INSIDE FRONT OF TORSO
	--================================================

	local radius = MELON_SIZE / 2

	local front = -(torso.Size.Z / 2)

	-- More of the melon inside the torso
	local z = front + radius - 0.38

	melon.CFrame =
		torso.CFrame *
		CFrame.new(
			x,
			MELON_Y,
			z
		)

	melon.Parent = character


	--================================================
	-- MELON CENTER DETAIL
	--================================================

	local detail = Instance.new("Part")

	detail.Name = "MelonCenter"
	detail.Shape = Enum.PartType.Ball

	detail.Size = Vector3.new(
		0.25,
		0.25,
		0.16
	)

	detail.Color = DETAIL_COLOR
	detail.Material = Enum.Material.SmoothPlastic

	detail.Anchored = false
	detail.CanCollide = false
	detail.CanTouch = false
	detail.CanQuery = false
	detail.Massless = true


	-- Small detail on visible center
	detail.CFrame =
		melon.CFrame *
		CFrame.new(
			0,
			0,
			-radius + 0.03
		)

	detail.Parent = character


	--================================================
	-- WELD MELON
	--================================================

	local melonWeld = Instance.new("WeldConstraint")

	melonWeld.Part0 = torso
	melonWeld.Part1 = melon

	melonWeld.Parent = melon


	--================================================
	-- WELD CENTER
	--================================================

	local detailWeld = Instance.new("WeldConstraint")

	detailWeld.Part0 = melon
	detailWeld.Part1 = detail

	detailWeld.Parent = detail

end


--==================================================
-- FAKE WHITE HAIR
--==================================================

local function createHair(character, head)

	-- Main fluffy hair pieces
	for i = 1, 9 do

		local hair = Instance.new("Part")

		hair.Name = "CustomHair"

		hair.Shape = Enum.PartType.Ball

		local sizeX = math.random(55, 80) / 100
		local sizeY = math.random(55, 85) / 100
		local sizeZ = math.random(55, 80) / 100

		hair.Size = Vector3.new(
			sizeX,
			sizeY,
			sizeZ
		)

		hair.Color = HAIR_COLOR
		hair.Material = Enum.Material.SmoothPlastic

		hair.Anchored = false
		hair.CanCollide = false
		hair.CanTouch = false
		hair.CanQuery = false
		hair.Massless = true


		local angle = (i / 9) * math.pi * 2

		local x = math.cos(angle) * 0.38
		local y = 0.45 + math.sin(angle) * 0.25
		local z = -0.05 + math.cos(angle * 2) * 0.15


		hair.CFrame =
			head.CFrame *
			CFrame.new(
				x,
				y,
				z
			)

		hair.Parent = character


		local weld = Instance.new("WeldConstraint")

		weld.Part0 = head
		weld.Part1 = hair

		weld.Parent = hair

	end


	--================================================
	-- CAT EAR 1
	--================================================

	local ear1 = Instance.new("WedgePart")

	ear1.Name = "CustomEar"

	ear1.Size = Vector3.new(
		0.65,
		0.85,
		0.35
	)

	ear1.Color = HAIR_COLOR
	ear1.Material = Enum.Material.SmoothPlastic

	ear1.Anchored = false
	ear1.CanCollide = false
	ear1.CanTouch = false
	ear1.CanQuery = false
	ear1.Massless = true

	ear1.CFrame =
		head.CFrame *
		CFrame.new(
			-0.45,
			0.80,
			0
		)

	ear1.Parent = character

	local weld1 = Instance.new("WeldConstraint")

	weld1.Part0 = head
	weld1.Part1 = ear1

	weld1.Parent = ear1


	--================================================
	-- CAT EAR 2
	--================================================

	local ear2 = Instance.new("WedgePart")

	ear2.Name = "CustomEar"

	ear2.Size = Vector3.new(
		0.65,
		0.85,
		0.35
	)

	ear2.Color = HAIR_COLOR
	ear2.Material = Enum.Material.SmoothPlastic

	ear2.Anchored = false
	ear2.CanCollide = false
	ear2.CanTouch = false
	ear2.CanQuery = false
	ear2.Massless = true

	ear2.CFrame =
		head.CFrame *
		CFrame.new(
			0.45,
			0.80,
			0
		)

	ear2.Parent = character

	local weld2 = Instance.new("WeldConstraint")

	weld2.Part0 = head
	weld2.Part1 = ear2

	weld2.Parent = ear2

end


--==================================================
-- CREATE CUTE FACE
--==================================================

local function createFace(character, head)

	-- BillboardGui lets us make the face without needing
	-- a Roblox catalog face asset.

	local gui = Instance.new("BillboardGui")

	gui.Name = "CustomFace"

	gui.Size = UDim2.fromOffset(100, 100)

	gui.StudsOffset = Vector3.new(
		0,
		0,
		-0.5
	)

	gui.AlwaysOnTop = false

	gui.Parent = head


	-- Left eye
	local leftEye = Instance.new("Frame")

	leftEye.Size = UDim2.fromOffset(9, 17)

	leftEye.Position = UDim2.fromOffset(
		27,
		35
	)

	leftEye.BackgroundColor3 = Color3.fromRGB(
		35,
		30,
		30
	)

	leftEye.BorderSizePixel = 0

	leftEye.Parent = gui


	-- Right eye
	local rightEye = leftEye:Clone()

	rightEye.Position = UDim2.fromOffset(
		64,
		35
	)

	rightEye.Parent = gui


	-- Little mouth
	local mouth = Instance.new("Frame")

	mouth.Size = UDim2.fromOffset(
		18,
		3
	)

	mouth.Position = UDim2.fromOffset(
		41,
		61
	)

	mouth.BackgroundColor3 =
		Color3.fromRGB(70, 50, 50)

	mouth.BorderSizePixel = 0

	mouth.Parent = gui


	-- Left blush
	local blush1 = Instance.new("Frame")

	blush1.Size = UDim2.fromOffset(
		14,
		5
	)

	blush1.Position = UDim2.fromOffset(
		19,
		57
	)

	blush1.BackgroundColor3 =
		Color3.fromRGB(190, 115, 110)

	blush1.BackgroundTransparency = 0.35

	blush1.BorderSizePixel = 0

	blush1.Parent = gui


	-- Right blush
	local blush2 = blush1:Clone()

	blush2.Position = UDim2.fromOffset(
		67,
		57
	)

	blush2.Parent = gui

end


--==================================================
-- MAIN SETUP
--==================================================

local function setup(character)

	local humanoid =
		character:WaitForChild("Humanoid")

	local head =
		character:WaitForChild("Head")

	local torso =
		character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")

	if not torso then
		return
	end


	-- Clean previous version
	clearOld(character)


	-- Remove clothing
	removeClothes(character)


	-- Tan body
	tanBody(character)


	-- Hair + cat ears
	createHair(character, head)


	-- Cute face
	createFace(character, head)


	-- Two bigger melons
	createMelon(
		character,
		torso,
		-MELON_X
	)

	createMelon(
		character,
		torso,
		MELON_X
	)

end


--==================================================
-- RUN ONLY ON LOCAL PLAYER
--==================================================

if Player.Character then
	setup(Player.Character)
end


--==================================================
-- RESPAWN
--==================================================

Player.CharacterAdded:Connect(function(character)

	task.wait(1)

	setup(character)

end)
