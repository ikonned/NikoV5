--========================================================
-- IKONNED NEKO V5
-- LOCAL PLAYER ONLY
--========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--========================================================
-- REQUESTED ASSETS
--========================================================

local HAIR_ID = 86220548304036
local TAIL_ID = 104494501265878
local CONE_ID = 1609390589

--========================================================
-- COLORS
--========================================================

local NEKO_COLOR = Color3.fromRGB(232, 205, 178)

--========================================================
-- CHARACTER
--========================================================

local Character = LocalPlayer.Character
    or LocalPlayer.CharacterAdded:Wait()

local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Head = Character:WaitForChild("Head")

local Torso =
    Character:FindFirstChild("UpperTorso")
    or Character:FindFirstChild("Torso")

if not Torso then
    error("Neko V5: No torso found.")
end

--========================================================
-- CLEAN EXISTING APPEARANCE
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
-- COLOR ORIGINAL HEAD / BODY
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
-- NEKO FOLDER
--========================================================

local OldFolder = Character:FindFirstChild("NekoV5")

if OldFolder then
    OldFolder:Destroy()
end

local NekoFolder = Instance.new("Folder")
NekoFolder.Name = "NekoV5"
NekoFolder.Parent = Character

--========================================================
-- ACCESSORY LOADER
--========================================================

local function LoadAccessory(AssetId)

    local Success, Objects = pcall(function()
        return game:GetObjects(
            "rbxassetid://" .. tostring(AssetId)
        )
    end)

    if not Success then
        warn(
            "[Neko V5] Failed loading asset",
            AssetId,
            Objects
        )
        return nil
    end

    if type(Objects) ~= "table" or #Objects == 0 then
        warn(
            "[Neko V5] No objects returned for",
            AssetId
        )
        return nil
    end

    local Root = Objects[1]

    local Accessory

    if Root:IsA("Accessory") then
        Accessory = Root
    else
        Accessory =
            Root:FindFirstChildWhichIsA(
                "Accessory",
                true
            )
    end

    if not Accessory then
        warn(
            "[Neko V5] Asset",
            AssetId,
            "is not an Accessory."
        )

        if Root and Root.Parent then
            Root:Destroy()
        end

        return nil
    end

    -- Move the actual accessory to the character.
    Accessory.Parent = Character

    -- Remove wrapper if necessary.
    if Root ~= Accessory and Root.Parent then
        Root:Destroy()
    end

    return Accessory
end

--========================================================
-- APPLY ACCESSORIES
--========================================================

-- Black long hair
local Hair = LoadAccessory(HAIR_ID)

-- White fluffy tail
local Tail = LoadAccessory(TAIL_ID)

-- Blue traffic cone
local Cone = LoadAccessory(CONE_ID)

--========================================================
-- REMOVE UNREQUESTED ACCESSORIES
--========================================================

for _, Object in ipairs(Character:GetChildren()) do

    if Object:IsA("Accessory") then

        if Object ~= Hair
            and Object ~= Tail
            and Object ~= Cone then

            Object:Destroy()
        end
    end
end

--========================================================
-- HIDE DEFAULT BODY PARTS
--========================================================

local BodyNames = {
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

for _, Name in ipairs(BodyNames) do

    local Part = Character:FindFirstChild(Name)

    if Part and Part:IsA("BasePart") then
        Part.Transparency = 1
        Part.CanCollide = false
    end
end

--========================================================
-- PART CREATOR
--========================================================

local function NewPart(
    Name,
    Size,
    Color
)

    local Part = Instance.new("Part")

    Part.Name = Name
    Part.Size = Size
    Part.Color = Color

    Part.Material =
        Enum.Material.SmoothPlastic

    Part.Anchored = false
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.Massless = true

    Part.TopSurface =
        Enum.SurfaceType.Smooth

    Part.BottomSurface =
        Enum.SurfaceType.Smooth

    Part.Parent = NekoFolder

    return Part
end

--========================================================
-- WELD
--========================================================

local function Weld(
    Part0,
    Part1,
    Offset
)

    local Joint = Instance.new("Weld")

    Joint.Part0 = Part0
    Joint.Part1 = Part1
    Joint.C0 = Offset

    Joint.Parent = Part1

    return Joint
end

--========================================================
-- BODY
--========================================================

local Body = NewPart(
    "NekoBody",
    Vector3.new(
        2.6,
        2.9,
        1.35
    ),
    NEKO_COLOR
)

Weld(
    RootPart,
    Body,
    CFrame.new(
        0,
        -0.15,
        0
    )
)

--========================================================
-- ARMS
--========================================================

local LeftArm = NewPart(
    "NekoLeftArm",
    Vector3.new(
        0.72,
        2.7,
        0.72
    ),
    NEKO_COLOR
)

Weld(
    Body,
    LeftArm,
    CFrame.new(
        -1.66,
        0,
        0
    )
)

local RightArm = NewPart(
    "NekoRightArm",
    Vector3.new(
        0.72,
        2.7,
        0.72
    ),
    NEKO_COLOR
)

Weld(
    Body,
    RightArm,
    CFrame.new(
        1.66,
        0,
        0
    )
)

--========================================================
-- LEGS
--========================================================

local LeftLeg = NewPart(
    "NekoLeftLeg",
    Vector3.new(
        0.82,
        2.7,
        0.82
    ),
    NEKO_COLOR
)

Weld(
    RootPart,
    LeftLeg,
    CFrame.new(
        -0.62,
        -2.8,
        0
    )
)

local RightLeg = NewPart(
    "NekoRightLeg",
    Vector3.new(
        0.82,
        2.7,
        0.82
    ),
    NEKO_COLOR
)

Weld(
    RootPart,
    RightLeg,
    CFrame.new(
        0.62,
        -2.8,
        0
    )
)

--========================================================
-- CAT EARS
--========================================================

local function CreateEar(
    Name,
    X
)

    local Ear = Instance.new("WedgePart")

    Ear.Name = Name

    Ear.Size =
        Vector3.new(
            0.9,
            1.2,
            0.9
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
            X,
            0.72,
            0
        )
        * CFrame.Angles(
            0,
            0,
            math.rad(
                X < 0
                    and -18
                    or 18
            )
        )

    Ear.CFrame =
        Head.CFrame
        * Offset

    Ear.Parent = NekoFolder

    Weld(
        Head,
        Ear,
        Offset
    )
end

CreateEar(
    "LeftEar",
    -0.55
)

CreateEar(
    "RightEar",
    0.55
)

--========================================================
-- LARGE 3D HALF-CIRCLE CHEST MARKINGS
--========================================================

local function CreateChestHalf(
    Name,
    X
)

    -- Rounded 3D dome.
    local Dome = Instance.new("Part")

    Dome.Name = Name

    Dome.Shape =
        Enum.PartType.Ball

    Dome.Size =
        Vector3.new(
            1.25,
            1.25,
            0.48
        )

    -- SAME COLOR AS NEKO BODY
    Dome.Color = NEKO_COLOR

    Dome.Material =
        Enum.Material.SmoothPlastic

    Dome.CanCollide = false
    Dome.CanTouch = false
    Dome.CanQuery = false
    Dome.Massless = true

    local DomeOffset =
        CFrame.new(
            X,
            0.35,
            -0.73
        )

    Dome.CFrame =
        Body.CFrame
        * DomeOffset

    Dome.Parent = NekoFolder

    Weld(
        Body,
        Dome,
        DomeOffset
    )

    -- Lower skin-colored cover.
    -- This hides the lower section of the sphere,
    -- leaving a raised half-circle appearance.
    local Cover = NewPart(
        Name .. "_Cover",
        Vector3.new(
            0.52,
            0.66,
            1.28
        ),
        NEKO_COLOR
    )

    Weld(
        Body,
        Cover,
        CFrame.new(
            X,
            -0.02,
            -0.73
        )
    )
end

CreateChestHalf(
    "LeftChestHalf",
    -0.5
)

CreateChestHalf(
    "RightChestHalf",
    0.5
)

--========================================================
-- FORCE ACCESSORY VISIBILITY
--========================================================

local function FixAccessory(Accessory)

    if not Accessory then
        return
    end

    for _, Object in ipairs(
        Accessory:GetDescendants()
    ) do

        if Object:IsA("BasePart") then
            Object.Transparency = 0
            Object.CanCollide = false
            Object.CanTouch = false
            Object.Massless = true
        end
    end
end

FixAccessory(Hair)
FixAccessory(Tail)
FixAccessory(Cone)

--========================================================
-- DONE
--========================================================

print("========================================")
print("IKONNED NEKO V5")
print("Local player appearance applied.")
print("Hair ID: " .. HAIR_ID)
print("Tail ID: " .. TAIL_ID)
print("Cone ID: " .. CONE_ID)
print("========================================")
