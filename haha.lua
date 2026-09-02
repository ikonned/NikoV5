local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =========================
-- SETTINGS
-- =========================

local SKIN_COLOR = Color3.fromRGB(204, 160, 115)

local ORB_COLOR = Color3.fromRGB(204, 160, 115)
local ORB_SIZE = 0.6
local ORB_HEIGHT = 0.25

local HAIR_ASSET_ID = 88443547532669

-- Put the actual FACE asset ID here once you have it
local FACE_ASSET_ID = nil


local function setupCharacter(character)

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
    -- REMOVE OLD ACCESSORIES
    -- =========================

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
    -- ADD HAIR
    -- =========================

    local Humanoid = character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        local Description = Humanoid:GetAppliedDescription()

        Description.HairAccessory = tostring(HAIR_ASSET_ID)

        if FACE_ASSET_ID then
            Description.Face = FACE_ASSET_ID
        end

        Humanoid:ApplyDescriptionAsync(Description)
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
    -- CREATE CHEST ORBS
    -- =========================

    local positions = {
        -0.62,
        0.62
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

        local frontSurface = -(torso.Size.Z / 2)
        local depth = frontSurface + 0.45

        orb.CFrame = torso.CFrame * CFrame.new(
            x,
            ORB_HEIGHT,
            depth
        )

        orb.Parent = character

        local weld = Instance.new("WeldConstraint")
        weld.Part0 = torso
        weld.Part1 = orb
        weld.Parent = orb
    end
end


local Character = LocalPlayer.Character

if Character then
    setupCharacter(Character)
end

LocalPlayer.CharacterAdded:Connect(function(character)

    character:WaitForChild("Humanoid")
    task.wait(0.5)

    setupCharacter(character)

end)
