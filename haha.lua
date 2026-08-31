--========================================================
-- NEKO V5 - LOCAL PLAYER ONLY
--========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--========================================================
-- ASSET IDS
--========================================================

local HAIR_ID = 86220548304036
local TAIL_ID = 104494501265878
local CONE_ID = 1609390589

-- Current Proud Happy Goober Dynamic Head
local GOOBER_HEAD_ID = 105570021630368

--========================================================
-- COLORS
--========================================================

local NEKO_COLOR = Color3.fromRGB(232, 205, 178)

--========================================================
-- CHARACTER
--========================================================

local Character = LocalPlayer.Character
    or LocalPlayer.CharacterAdded:Wait()

local Humanoid =
    Character:WaitForChild("Humanoid")

local RootPart =
    Character:WaitForChild("HumanoidRootPart")

local Head =
    Character:WaitForChild("Head")

local Torso =
    Character:FindFirstChild("UpperTorso")
    or Character:FindFirstChild("Torso")

if not Torso then
    error("Neko V5: Torso not found.")
end

--========================================================
-- CLEAN OLD NEKO
--========================================================

local OldNeko =
    Character:FindFirstChild("NekoV5")

if OldNeko then
    OldNeko:Destroy()
end

--========================================================
-- REMOVE CLOTHING / ACCESSORIES
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
-- SKIN COLOR
--========================================================

local BodyParts = {
    "Head",
    "Torso",
    "UpperTorso",
    "LowerTorso",

    "Left Arm",
    "Right Arm",
    "Left Leg",
    "Right Leg",

    "LeftUpperArm",
    "LeftLowerArm",
    "LeftHand",

    "RightUpperArm",
    "RightLowerArm",
    "RightHand",

    "LeftUpperLeg",
    "LeftLowerLeg",
    "LeftFoot",

    "RightUpperLeg",
    "RightLowerLeg",
    "RightFoot"
}

for _, Name in ipairs(BodyParts) do

    local Part =
        Character:FindFirstChild(Name)

    if Part and Part:IsA("BasePart") then
        Part.Color = NEKO_COLOR
    end
end

--========================================================
-- NEKO FOLDER
--========================================================

local NekoFolder =
    Instance.new("Folder")

NekoFolder.Name = "NekoV5"
NekoFolder.Parent = Character

--========================================================
-- ACCESSORY LOADING
--========================================================

local function LoadAccessory(Id)

    local Success, Objects =
        pcall(function()

            return game:GetObjects(
                "rbxassetid://" .. tostring(Id)
            )

        end)

    if not Success then

        warn(
            "[Neko V5] Asset load failed:",
            Id,
            Objects
        )

        return nil
    end

    if not Objects or #Objects == 0 then

        warn(
            "[Neko V5] Empty asset:",
            Id
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
            "[Neko V5] No Accessory found:",
            Id
        )

        if Root.Parent then
            Root:Destroy()
        end

        return nil
    end

    return Accessory
end

--========================================================
-- EQUIP ACCESSORY
--========================================================

local function EquipAccessory(Id)

    local Accessory =
        LoadAccessory(Id)

    if not Accessory then
        return nil
    end

    Accessory.Parent = Character

    local Success, ErrorMessage =
        pcall(function()
            Humanoid:AddAccessory(Accessory)
        end)

    if not Success then

        warn(
            "[Neko V5] AddAccessory failed:",
            Id,
            ErrorMessage
        )

        return Accessory
    end

    return Accessory
end

--========================================================
-- HAIR
--========================================================

local Hair =
    EquipAccessory(HAIR_ID)

--========================================================
-- FLUFFY TAIL
--========================================================

local Tail =
    EquipAccessory(TAIL_ID)

--========================================================
-- BLUE TRAFFIC CONE
--========================================================

local Cone =
    EquipAccessory(CONE_ID)

--========================================================
-- FIX ACCESSORIES
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
            Object.CanQuery = false
            Object.Massless = true

        end
    end
end

FixAccessory(Hair)
FixAccessory(Tail)
FixAccessory(Cone)

--========================================================
-- GOOBER FACE
--========================================================
--
-- The current Proud Happy Goober Face is a Dynamic Head
-- asset, not a classic Face decal.
--
-- Try to obtain it directly and use its head appearance.
--========================================================

local function ApplyGooberHead()

    local Success, Objects =
        pcall(function()

            return game:GetObjects(
                "rbxassetid://" ..
                tostring(GOOBER_HEAD_ID)
            )

        end)

    if not Success
        or not Objects
        or #Objects == 0 then

        warn(
            "[Neko V5] Could not load Goober Dynamic Head."
        )

        return false
    end

    local Asset = Objects[1]

    -- Look for a usable head/model.
    local NewHead

    if Asset:IsA("MeshPart")
        and Asset.Name == "Head" then

        NewHead = Asset

    elseif Asset:IsA("Model") then

        NewHead =
            Asset:FindFirstChild(
                "Head",
                true
            )

    else

        NewHead =
            Asset:FindFirstChildWhichIsA(
                "MeshPart",
                true
            )
    end

    if not NewHead then

        warn(
            "[Neko V5] Dynamic Head loaded but no head mesh found."
        )

        if Asset.Parent then
            Asset:Destroy()
        end

        return false
    end

    -- Copy visual properties onto the existing
    -- local Roblox head instead of replacing the
    -- character's actual rig joint.
    local ExistingMesh =
        Head:FindFirstChildWhichIsA(
            "SpecialMesh"
        )

    if NewHead:FindFirstChildWhichIsA("SpecialMesh") then

        local SourceMesh =
            NewHead:FindFirstChildWhichIsA(
                "SpecialMesh"
            )

        if ExistingMesh then
            ExistingMesh:Destroy()
        end

        local Mesh =
            SourceMesh:Clone()

        Mesh.Parent = Head

    elseif NewHead:IsA("MeshPart") then

        -- Preserve the actual Roblox Head,
        -- but copy the mesh appearance.
        pcall(function()
            Head.MeshId = NewHead.MeshId
        end)

        pcall(function()
            Head.TextureID = NewHead.TextureID
        end)
    end

    -- Copy decals if supplied by the head.
    for _, Object in ipairs(
        NewHead:GetChildren()
    ) do

        if Object:IsA("Decal") then

            local Old =
                Head:FindFirstChild(
                    Object.Name
                )

            if Old then
                Old:Destroy()
            end

            Object:Clone().Parent = Head
        end
    end

    if Asset.Parent then
        Asset:Destroy()
    end

    return true
end

ApplyGooberHead()

--========================================================
-- 3D HALF-CIRCLE CHEST PIECES
--========================================================

local function CreateChestHalf(
    Name,
    X
)

    --====================================================
    -- LARGE OUTWARD 3D DOME
    --====================================================

    local Dome =
        Instance.new("Part")

    Dome.Name = Name

    Dome.Shape =
        Enum.PartType.Ball

    Dome.Size =
        Vector3.new(
            1.35,
            1.35,
            0.55
        )

    -- Same color as skin
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
            0.30,
            -0.72
        )

    Dome.CFrame =
        Torso.CFrame
        * DomeOffset

    Dome.Parent =
        NekoFolder

    local DomeWeld =
        Instance.new("Weld")

    DomeWeld.Part0 = Torso
    DomeWeld.Part1 = Dome
    DomeWeld.C0 = DomeOffset

    DomeWeld.Parent = Dome

    --====================================================
    -- LOWER MASK
    --====================================================

    local Cover =
        Instance.new("Part")

    Cover.Name =
        Name .. "_HalfMask"

    Cover.Size =
        Vector3.new(
            0.6,
            0.72,
            1.35
        )

    Cover.Color =
        NEKO_COLOR

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
            -0.73
        )

    Cover.CFrame =
        Torso.CFrame
        * CoverOffset

    Cover.Parent =
        NekoFolder

    local CoverWeld =
        Instance.new("Weld")

    CoverWeld.Part0 = Torso
    CoverWeld.Part1 = Cover
    CoverWeld.C0 = CoverOffset

    CoverWeld.Parent = Cover
end

CreateChestHalf(
    "LeftChestCircle",
    -0.52
)

CreateChestHalf(
    "RightChestCircle",
    0.52
)

--========================================================
-- OPTIONAL: GIVE CHEST PIECES A SOFT POLISHED LOOK
--========================================================

for _, Object in ipairs(
    NekoFolder:GetChildren()
) do

    if Object:IsA("BasePart") then

        Object.Reflectance = 0
        Object.CastShadow = true

    end
end

--========================================================
-- FINAL CHECK
--========================================================

print("----------------------------------------")
print("NEKO V5")
print("LOCAL PLAYER ONLY")
print("----------------------------------------")
print("Hair:", HAIR_ID)
print("Tail:", TAIL_ID)
print("Cone:", CONE_ID)
print("Goober Head:", GOOBER_HEAD_ID)
print("Skin:", tostring(NEKO_COLOR))
print("----------------------------------------")
