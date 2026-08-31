--========================================================
-- IKONNED NEKO V5
-- LOCAL PLAYER ONLY
--========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--========================================================
-- SETTINGS
--========================================================

local HAIR_ID = 86220548304036
local TAIL_ID = 104494501265878
local CONE_ID = 1609390589

-- Pale white-ish tan
local NEKO_COLOR = Color3.fromRGB(232, 205, 178)

-- Same color for chest pieces
local CHEST_COLOR = NEKO_COLOR

--========================================================
-- CHARACTER
--========================================================

local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid(Character)
    return Character
        and Character:FindFirstChildOfClass("Humanoid")
end

--========================================================
-- WAIT FOR CHARACTER
--========================================================

local Character = GetCharacter()

if not Character then
    Character = LocalPlayer.CharacterAdded:Wait()
end

local Humanoid = GetHumanoid(Character)

if not Humanoid then
    Humanoid = Character:WaitForChild("Humanoid")
end

--========================================================
-- REMOVE OLD NEKO
--========================================================

local OldNeko = Character:FindFirstChild("NekoV5")

if OldNeko then
    OldNeko:Destroy()
end

--========================================================
-- REMOVE AVATAR CLOTHES / ACCESSORIES
--========================================================

for _, Object in ipairs(Character:GetChildren()) do

    if Object:IsA("Accessory")
        or Object:IsA("Shirt")
        or Object:IsA("Pants")
        or Object:IsA("ShirtGraphic")
        or Object:IsA("CharacterMesh") then

        Object:Destroy()
    end
end

--========================================================
-- BODY COLOR
--========================================================

for _, Object in ipairs(Character:GetDescendants()) do

    if Object:IsA("BasePart") then

        local Name = Object.Name

        if Name == "Head"
            or Name == "Torso"
            or Name == "UpperTorso"
            or Name == "LowerTorso"
            or Name == "Left Arm"
            or Name == "Right Arm"
            or Name == "Left Leg"
            or Name == "Right Leg"
            or Name == "LeftUpperArm"
            or Name == "LeftLowerArm"
            or Name == "LeftHand"
            or Name == "RightUpperArm"
            or Name == "RightLowerArm"
            or Name == "RightHand"
            or Name == "LeftUpperLeg"
            or Name == "LeftLowerLeg"
            or Name == "LeftFoot"
            or Name == "RightUpperLeg"
            or Name == "RightLowerLeg"
            or Name == "RightFoot" then

            Object.Color = NEKO_COLOR
        end
    end
end

--========================================================
-- REMOVE CLOTHING AGAIN
--========================================================

for _, Object in ipairs(Character:GetChildren()) do

    if Object:IsA("Accessory")
        or Object:IsA("Shirt")
        or Object:IsA("Pants")
        or Object:IsA("ShirtGraphic")
        or Object:IsA("CharacterMesh") then

        Object:Destroy()
    end
end

--========================================================
-- NEKO FOLDER
--========================================================

local NekoFolder = Instance.new("Folder")
NekoFolder.Name = "NekoV5"
NekoFolder.Parent = Character

--========================================================
-- ASSET LOADER
--========================================================

local function LoadAccessory(AssetId)

    local Success, Objects = pcall(function()
        return game:GetObjects(
            "rbxassetid://" .. tostring(AssetId)
        )
    end)

    if not Success then
        warn(
            "[Neko V5] Failed to load asset:",
            AssetId,
            Objects
        )

        return nil
    end

    if not Objects or #Objects == 0 then
        warn(
            "[Neko V5] No object returned for asset:",
            AssetId
        )

        return nil
    end

    local Root = Objects[1]

    -- The returned object can be a folder/model
    -- containing the actual Accessory.
    local Accessory =
        Root:IsA("Accessory")
        and Root
        or Root:FindFirstChildWhichIsA(
            "Accessory",
            true
        )

    if not Accessory then
        warn(
            "[Neko V5] Asset is not an Accessory:",
            AssetId
        )

        Root:Destroy()

        return nil
    end

    Accessory.Parent = Character

    return Accessory
end

--========================================================
-- LOAD REQUESTED ACCESSORIES
--========================================================

-- BLACK HAIR
local Hair = LoadAccessory(HAIR_ID)

-- WHITE FLUFFY TAIL
local Tail = LoadAccessory(TAIL_ID)

-- BLUE TRAFFIC CONE
local Cone = LoadAccessory(CONE_ID)

--========================================================
-- FIND HEAD / BODY
--========================================================

local Head = Character:FindFirstChild("Head")

local RootPart =
    Character:FindFirstChild(
        "HumanoidRootPart"
    )

local Torso =
    Character:FindFirstChild("UpperTorso")
    or Character:FindFirstChild("Torso")

if not Head or not RootPart or not Torso then
    warn("[Neko V5] Required character parts missing.")
    return
end

--========================================================
-- HIDE ORIGINAL BODY VISUALLY
--========================================================

local OriginalBody = {
    "UpperTorso",
    "LowerTorso",
    "Torso",

    "LeftUpperArm",
    "LeftLowerArm",
    "LeftHand",
    "Left Arm",

    "RightUpperArm",
    "RightLowerArm",
    "RightHand",
    "Right Arm",

    "LeftUpperLeg",
    "LeftLowerLeg",
    "LeftFoot",
    "Left Leg",

    "RightUpperLeg",
    "RightLowerLeg",
    "RightFoot",
    "Right Leg"
}

for _, Name in ipairs(OriginalBody) do

    local Part =
        Character:FindFirstChild(Name)

    if Part and Part:IsA("BasePart") then
        Part.Transparency = 1
    end
end

--========================================================
-- CUSTOM BLOCK BODY
--========================================================

local function MakeBodyPart(
    Name,
    Size,
    Offset
)

    local Part = Instance.new("Part")

    Part.Name = Name
    Part.Size = Size
    Part.Color = NEKO_COLOR

    Part.Material =
        Enum.Material.SmoothPlastic

    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.Massless = true
    Part.Anchored = false

    Part.CFrame =
        RootPart.CFrame
        * Offset

    Part.Parent = NekoFolder

    local Weld =
        Instance.new("Weld")

    Weld.Part0 = RootPart
    Weld.Part1 = Part
    Weld.C0 = Offset

    Weld.Parent = Part

    return Part
end

local Body = MakeBodyPart(
    "Body",
    Vector3.new(2.5, 2.9, 1.35),
    CFrame.new(0, -0.15, 0)
)

local LeftArm = MakeBodyPart(
    "LeftArm",
    Vector3.new(0.7, 2.65, 0.7),
    CFrame.new(-1.6, -0.15, 0)
)

local RightArm = MakeBodyPart(
    "RightArm",
    Vector3.new(0.7, 2.65, 0.7),
    CFrame.new(1.6, -0.15, 0)
)

local LeftLeg = MakeBodyPart(
    "LeftLeg",
    Vector3.new(0.82, 2.7, 0.82),
    CFrame.new(-0.62, -2.9, 0)
)

local RightLeg = MakeBodyPart(
    "RightLeg",
    Vector3.new(0.82, 2.7, 0.82),
    CFrame.new(0.62, -2.9, 0)
)

--========================================================
-- CAT EARS
--========================================================

local function MakeEar(Name, OffsetX)

    local Ear =
        Instance.new("WedgePart")

    Ear.Name = Name

    Ear.Size =
        Vector3.new(
            0.85,
            1.15,
            0.85
        )

    Ear.Color = NEKO_COLOR

    Ear.Material =
        Enum.Material.SmoothPlastic

    Ear.CanCollide = false
    Ear.CanTouch = false
    Ear.CanQuery = false
    Ear.Massless = true

    local Offset =
        CFrame.new(
            OffsetX,
            0.72,
            0
        )
        * CFrame.Angles(
            0,
            0,
            math.rad(
                OffsetX < 0
                and -20
                or 20
            )
        )

    Ear.CFrame =
        Head.CFrame
        * Offset

    Ear.Parent = NekoFolder

    local Weld =
        Instance.new("Weld")

    Weld.Part0 = Head
    Weld.Part1 = Ear
    Weld.C0 = Offset

    Weld.Parent = Ear

    return Ear
end

MakeEar(
    "LeftEar",
    -0.55
)

MakeEar(
    "RightEar",
    0.55
)

--========================================================
-- 3D HALF-CIRCLE CHEST PIECES
--========================================================

local function MakeChestHalf(
    Name,
    X
)

    -- Main rounded dome
    local Dome =
        Instance.new("Part")

    Dome.Name = Name

    Dome.Shape =
        Enum.PartType.Ball

    Dome.Size =
        Vector3.new(
            1.15,
            1.15,
            0.38
        )

    -- SAME COLOR AS BODY
    Dome.Color = CHEST_COLOR

    Dome.Material =
        Enum.Material.SmoothPlastic

    Dome.CanCollide = false
    Dome.CanTouch = false
    Dome.CanQuery = false
    Dome.Massless = true

    local DomeOffset =
        CFrame.new(
            X,
            0.3,
            -0.72
        )

    Dome.CFrame =
        Body.CFrame
        * DomeOffset

    Dome.Parent = NekoFolder

    local DomeWeld =
        Instance.new("Weld")

    DomeWeld.Part0 = Body
    DomeWeld.Part1 = Dome
    DomeWeld.C0 = DomeOffset

    DomeWeld.Parent = Dome

    -- Lower cover creates the visual
    -- half-circle shape.
    local Cover =
        Instance.new("Part")

    Cover.Name =
        Name .. "_Cover"

    Cover.Size =
        Vector3.new(
            0.45,
            0.62,
            1.2
        )

    -- SAME COLOR AS BODY
    Cover.Color = NEKO_COLOR

    Cover.Material =
        Enum.Material.SmoothPlastic

    Cover.CanCollide = false
    Cover.CanTouch = false
    Cover.CanQuery = false
    Cover.Massless = true

    local CoverOffset =
        CFrame.new(
            X,
            -0.02,
            -0.72
        )

    Cover.CFrame =
        Body.CFrame
        * CoverOffset

    Cover.Parent = NekoFolder

    local CoverWeld =
        Instance.new("Weld")

    CoverWeld.Part0 = Body
    CoverWeld.Part1 = Cover
    CoverWeld.C0 = CoverOffset

    CoverWeld.Parent = Cover
end

MakeChestHalf(
    "LeftChestHalf",
    -0.5
)

MakeChestHalf(
    "RightChestHalf",
    0.5
)

--========================================================
-- MAKE SURE ACCESSORIES STAY VISIBLE
--========================================================

local function RestoreAccessory(Accessory)

    if not Accessory then
        return
    end

    for _, Object in ipairs(
        Accessory:GetDescendants()
    ) do

        if Object:IsA("BasePart") then
            Object.Transparency = 0
            Object.CanCollide = false
            Object.Massless = true
        end
    end
end

RestoreAccessory(Hair)
RestoreAccessory(Tail)
RestoreAccessory(Cone)

--========================================================
-- OPTIONAL: HANDLE EXISTING FACE
--========================================================

-- Do not destroy the original Head/face.
-- The supplied Proud Happy Goober link is a bundle,
-- not a direct Face asset ID, so it should not be put
-- directly into HumanoidDescription.Face.

--========================================================
-- FINISHED
--========================================================

print("======================================")
print("IKONNED NEKO V5")
print("Local avatar rebuild complete.")
print("Hair:", HAIR_ID)
print("Tail:", TAIL_ID)
print("Cone:", CONE_ID)
print("======================================")
