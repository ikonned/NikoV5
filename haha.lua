--========================================================
-- NEKO V5
-- LOCAL PLAYER ONLY
--========================================================

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

--========================================================
-- ASSETS
--========================================================

local HAIR_ID = 86220548304036
local TAIL_ID = 104494501265878
local CONE_ID = 1609390589

--========================================================
-- COLOR
--========================================================

local NEKO_COLOR = Color3.fromRGB(232, 205, 178)

--========================================================
-- GET CHARACTER
--========================================================

local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid()
    local Character = GetCharacter()

    if not Character then
        return nil
    end

    return Character:FindFirstChildOfClass("Humanoid")
end

--========================================================
-- COMPLETELY CLEAR EXISTING APPEARANCE
--========================================================

local function ClearAvatar(Character)

    for _, Object in ipairs(Character:GetChildren()) do
        if Object:IsA("Accessory")
            or Object:IsA("Shirt")
            or Object:IsA("Pants")
            or Object:IsA("ShirtGraphic")
            or Object:IsA("CharacterMesh") then

            Object:Destroy()
        end
    end
end

--========================================================
-- RESET + APPLY REQUESTED ACCESSORIES
--========================================================

local function ApplyNekoAppearance()

    local Character = GetCharacter()

    if not Character then
        return false
    end

    local Humanoid = GetHumanoid()

    if not Humanoid then
        return false
    end

    -- Remove everything currently equipped
    ClearAvatar(Character)

    -- Get current description
    local Description = Humanoid:GetAppliedDescription()

    --====================================================
    -- CLEAR EVERYTHING
    --====================================================

    Description.HatAccessory = ""
    Description.HairAccessory = ""
    Description.FaceAccessory = ""
    Description.NeckAccessory = ""
    Description.ShouldersAccessory = ""
    Description.FrontAccessory = ""
    Description.BackAccessory = ""
    Description.WaistAccessory = ""

    Description.Shirt = 0
    Description.Pants = 0
    Description.GraphicTShirt = 0

    --====================================================
    -- PALE TAN SKIN
    --====================================================

    Description.HeadColor = NEKO_COLOR
    Description.LeftArmColor = NEKO_COLOR
    Description.RightArmColor = NEKO_COLOR
    Description.LeftLegColor = NEKO_COLOR
    Description.RightLegColor = NEKO_COLOR
    Description.TorsoColor = NEKO_COLOR

    --====================================================
    -- REQUESTED ACCESSORIES
    --====================================================

    Description.HairAccessory =
        tostring(HAIR_ID)

    Description.WaistAccessory =
        tostring(TAIL_ID)

    Description.HatAccessory =
        tostring(CONE_ID)

    --====================================================
    -- APPLY
    --====================================================

    local Success, ErrorMessage = pcall(function()
        Humanoid:ApplyDescriptionAsync(Description)
    end)

    if not Success then
        warn(
            "Neko V5 appearance error:",
            ErrorMessage
        )

        return false
    end

    task.wait(1)

    return true
end

--========================================================
-- HIDE DEFAULT LIMBS VISUALLY
--========================================================

local function HideDefaultBody(Character)

    local BodyParts = {
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

    for _, Name in ipairs(BodyParts) do

        local Part =
            Character:FindFirstChild(Name)

        if Part and Part:IsA("BasePart") then
            Part.Transparency = 1
            Part.CanCollide = false
        end
    end
end

--========================================================
-- CREATE FOLDER
--========================================================

local function CreateNekoFolder(Character)

    local Existing =
        Character:FindFirstChild("NekoV5")

    if Existing then
        Existing:Destroy()
    end

    local Folder = Instance.new("Folder")

    Folder.Name = "NekoV5"
    Folder.Parent = Character

    return Folder
end

--========================================================
-- CREATE PART
--========================================================

local function CreatePart(
    Name,
    Size,
    Color,
    Parent
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

    Part.Parent = Parent

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
-- CAT EARS
--========================================================

local function CreateEars(
    Character,
    Folder
)

    local Head =
        Character:FindFirstChild("Head")

    if not Head then
        return
    end

    local LeftEar =
        Instance.new("WedgePart")

    LeftEar.Name = "LeftEar"
    LeftEar.Size =
        Vector3.new(
            0.9,
            1.2,
            0.9
        )

    LeftEar.Color = NEKO_COLOR
    LeftEar.Material =
        Enum.Material.SmoothPlastic

    LeftEar.CanCollide = false
    LeftEar.CanTouch = false
    LeftEar.CanQuery = false
    LeftEar.Massless = true

    LeftEar.CFrame =
        Head.CFrame
        * CFrame.new(
            -0.55,
            0.7,
            0
        )
        * CFrame.Angles(
            0,
            0,
            math.rad(-18)
        )

    LeftEar.Parent = Folder

    local LWeld =
        Instance.new("WeldConstraint")

    LWeld.Part0 = Head
    LWeld.Part1 = LeftEar
    LWeld.Parent = LeftEar


    local RightEar =
        Instance.new("WedgePart")

    RightEar.Name = "RightEar"
    RightEar.Size =
        Vector3.new(
            0.9,
            1.2,
            0.9
        )

    RightEar.Color = NEKO_COLOR
    RightEar.Material =
        Enum.Material.SmoothPlastic

    RightEar.CanCollide = false
    RightEar.CanTouch = false
    RightEar.CanQuery = false
    RightEar.Massless = true

    RightEar.CFrame =
        Head.CFrame
        * CFrame.new(
            0.55,
            0.7,
            0
        )
        * CFrame.Angles(
            0,
            0,
            math.rad(18)
        )

    RightEar.Parent = Folder

    local RWeld =
        Instance.new("WeldConstraint")

    RWeld.Part0 = Head
    RWeld.Part1 = RightEar
    RWeld.Parent = RightEar
end

--========================================================
-- BLOCK BODY
--========================================================

local function CreateBlockBody(
    Character,
    Folder
)

    local RootPart =
        Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not RootPart then
        return nil
    end

    -- Main body
    local Body = CreatePart(
        "NekoBody",
        Vector3.new(
            2.6,
            2.9,
            1.35
        ),
        NEKO_COLOR,
        Folder
    )

    Weld(
        RootPart,
        Body,
        CFrame.new(
            0,
            -0.1,
            0
        )
    )

    -- Left arm
    local LeftArm = CreatePart(
        "NekoLeftArm",
        Vector3.new(
            0.72,
            2.7,
            0.72
        ),
        NEKO_COLOR,
        Folder
    )

    Weld(
        Body,
        LeftArm,
        CFrame.new(
            -1.65,
            0,
            0
        )
    )

    -- Right arm
    local RightArm = CreatePart(
        "NekoRightArm",
        Vector3.new(
            0.72,
            2.7,
            0.72
        ),
        NEKO_COLOR,
        Folder
    )

    Weld(
        Body,
        RightArm,
        CFrame.new(
            1.65,
            0,
            0
        )
    )

    -- Left leg
    local LeftLeg = CreatePart(
        "NekoLeftLeg",
        Vector3.new(
            0.82,
            2.7,
            0.82
        ),
        NEKO_COLOR,
        Folder
    )

    Weld(
        RootPart,
        LeftLeg,
        CFrame.new(
            -0.65,
            -2.8,
            0
        )
    )

    -- Right leg
    local RightLeg = CreatePart(
        "NekoRightLeg",
        Vector3.new(
            0.82,
            2.7,
            0.82
        ),
        NEKO_COLOR,
        Folder
    )

    Weld(
        RootPart,
        RightLeg,
        CFrame.new(
            0.65,
            -2.8,
            0
        )
    )

    return Body
end

--========================================================
-- 3D HALF-CIRCLE
--========================================================

local function CreateHalfCircle(
    Body,
    Folder,
    Name,
    X
)

    -- Large rounded 3D piece
    local Dome = Instance.new("Part")

    Dome.Name = Name
    Dome.Shape = Enum.PartType.Ball

    Dome.Size =
        Vector3.new(
            1.2,
            1.2,
            0.45
        )

    -- SAME COLOR AS SKIN
    Dome.Color = NEKO_COLOR

    Dome.Material =
        Enum.Material.SmoothPlastic

    Dome.CanCollide = false
    Dome.CanTouch = false
    Dome.CanQuery = false
    Dome.Massless = true

    Dome.CFrame =
        Body.CFrame
        * CFrame.new(
            X,
            0.35,
            -0.72
        )

    Dome.Parent = Folder

    local DomeWeld =
        Instance.new("WeldConstraint")

    DomeWeld.Part0 = Body
    DomeWeld.Part1 = Dome
    DomeWeld.Parent = Dome

    -- Covers lower portion to give a half-circle profile
    local Cover = CreatePart(
        Name .. "_Cover",
        Vector3.new(
            0.5,
            0.65,
            1.25
        ),
        NEKO_COLOR,
        Folder
    )

    Weld(
        Body,
        Cover,
        CFrame.new(
            X,
            0.0,
            -0.72
        )
    )
end

--========================================================
-- BUILD NEKO
--========================================================

local function BuildNeko()

    local Character =
        GetCharacter()

    if not Character then
        return
    end

    local Folder =
        CreateNekoFolder(
            Character
        )

    HideDefaultBody(
        Character
    )

    local Body =
        CreateBlockBody(
            Character,
            Folder
        )

    if not Body then
        return
    end

    -- Cat ears
    CreateEars(
        Character,
        Folder
    )

    -- Two large 3D half-circles
    CreateHalfCircle(
        Body,
        Folder,
        "LeftChestHalf",
        -0.5
    )

    CreateHalfCircle(
        Body,
        Folder,
        "RightChestHalf",
        0.5
    )
end

--========================================================
-- START
--========================================================

local function StartNeko()

    if not LocalPlayer.Character then
        LocalPlayer.CharacterAdded:Wait()
    end

    task.wait(1)

    local Success, ErrorMessage =
        pcall(function()

            -- FIRST:
            -- wipe avatar and apply requested assets
            local Applied =
                ApplyNekoAppearance()

            if not Applied then
                error(
                    "Failed to apply Neko appearance."
                )
            end

            task.wait(1)

            -- SECOND:
            -- build custom body + chest pieces
            BuildNeko()
        end)

    if not Success then
        warn(
            "[Neko V5]",
            ErrorMessage
        )
    end
end

--========================================================
-- RESPAWN
--========================================================

LocalPlayer.CharacterAdded:Connect(
    function()
        task.wait(1)

        StartNeko()
    end
)

--========================================================
-- RUN
--========================================================

StartNeko()
