--========================================================
-- NEKO V5
-- LOCAL PLAYER ONLY
-- Place in StarterPlayer > StarterPlayerScripts
--========================================================

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

--========================================================
-- ASSET IDS
--========================================================

local ASSETS = {
    -- Long cute straight black hair
    Hair = 86220548304036,

    -- Cute fluffy soft white fuzzy tail
    Tail = 104494501265878,

    -- Blue Traffic Cone
    Cone = 1609390589,
}

--========================================================
-- COLORS
--========================================================

local SKIN_COLOR = Color3.fromRGB(232, 205, 178)
local CHEST_COLOR = SKIN_COLOR

local WHITE = Color3.fromRGB(255, 255, 255)

--========================================================
-- HELPERS
--========================================================

local function getCharacter()
    return LocalPlayer.Character
end

local function getHumanoid()
    local Character = getCharacter()
    return Character and Character:FindFirstChildOfClass("Humanoid")
end

--========================================================
-- REMOVE OLD APPEARANCE
--========================================================

local function clearCharacter(Character)

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
-- APPLY BASE AVATAR
--========================================================

local function resetAvatar()

    local Character = getCharacter()

    if not Character then
        return false
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        return false
    end

    clearCharacter(Character)

    local Description =
        Humanoid:GetAppliedDescription()

    -- Remove existing accessories
    Description.HatAccessory = ""
    Description.HairAccessory = ""
    Description.FaceAccessory = ""
    Description.NeckAccessory = ""
    Description.ShouldersAccessory = ""
    Description.FrontAccessory = ""
    Description.BackAccessory = ""
    Description.WaistAccessory = ""

    -- Remove clothes
    Description.Shirt = 0
    Description.Pants = 0
    Description.GraphicTShirt = 0

    -- Pale tan body
    Description.HeadColor = SKIN_COLOR
    Description.LeftArmColor = SKIN_COLOR
    Description.RightArmColor = SKIN_COLOR
    Description.LeftLegColor = SKIN_COLOR
    Description.RightLegColor = SKIN_COLOR
    Description.TorsoColor = SKIN_COLOR

    -- Requested accessories
    Description.HairAccessory = tostring(ASSETS.Hair)
    Description.HatAccessory = tostring(ASSETS.Cone)
    Description.WaistAccessory = tostring(ASSETS.Tail)

    Humanoid:ApplyDescriptionAsync(
        Description
    )

    task.wait(1)

    return true
end

--========================================================
-- CREATE FOLDER
--========================================================

local function createFolder(Character)

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
-- HIDE DEFAULT BODY VISUALLY
--========================================================

local function hideDefaultBody(Character)

    local Names = {
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
        "Right Leg",
    }

    for _, Name in ipairs(Names) do

        local Part = Character:FindFirstChild(Name)

        if Part and Part:IsA("BasePart") then
            Part.Transparency = 1
            Part.CanCollide = false
        end
    end
end

--========================================================
-- CREATE PART
--========================================================

local function createPart(
    Name,
    Size,
    Color,
    Parent
)

    local Part = Instance.new("Part")

    Part.Name = Name
    Part.Size = Size
    Part.Color = Color
    Part.Material = Enum.Material.SmoothPlastic

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

local function weld(
    Part0,
    Part1,
    C0
)

    local Weld = Instance.new("Weld")

    Weld.Part0 = Part0
    Weld.Part1 = Part1
    Weld.C0 = C0

    Weld.Parent = Part1

    return Weld
end

--========================================================
-- CAT EARS
--========================================================

local function createEar(
    Head,
    Folder,
    Name,
    X
)

    local Ear = Instance.new("WedgePart")

    Ear.Name = Name
    Ear.Size = Vector3.new(
        0.9,
        1.2,
        0.9
    )

    Ear.Color = WHITE
    Ear.Material = Enum.Material.SmoothPlastic

    Ear.CanCollide = false
    Ear.CanTouch = false
    Ear.CanQuery = false
    Ear.Massless = true

    Ear.CFrame =
        Head.CFrame
        * CFrame.new(
            X,
            0.72,
            0
        )
        * CFrame.Angles(
            0,
            0,
            math.rad(
                X < 0 and -18 or 18
            )
        )

    Ear.Parent = Folder

    local Weld = Instance.new(
        "WeldConstraint"
    )

    Weld.Part0 = Head
    Weld.Part1 = Ear
    Weld.Parent = Ear
end

--========================================================
-- BLOCK BODY
--========================================================

local function createBody(
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

    -- Main torso
    local Body = createPart(
        "Body",
        Vector3.new(
            2.6,
            2.9,
            1.35
        ),
        SKIN_COLOR,
        Folder
    )

    Body.CFrame =
        RootPart.CFrame
        * CFrame.new(
            0,
            -0.1,
            0
        )

    weld(
        RootPart,
        Body,
        CFrame.new(
            0,
            -0.1,
            0
        )
    )

    -- Left arm
    local LeftArm = createPart(
        "LeftArm",
        Vector3.new(
            0.72,
            2.7,
            0.72
        ),
        SKIN_COLOR,
        Folder
    )

    LeftArm.CFrame =
        Body.CFrame
        * CFrame.new(
            -1.65,
            0,
            0
        )

    weld(
        Body,
        LeftArm,
        CFrame.new(
            -1.65,
            0,
            0
        )
    )

    -- Right arm
    local RightArm = createPart(
        "RightArm",
        Vector3.new(
            0.72,
            2.7,
            0.72
        ),
        SKIN_COLOR,
        Folder
    )

    RightArm.CFrame =
        Body.CFrame
        * CFrame.new(
            1.65,
            0,
            0
        )

    weld(
        Body,
        RightArm,
        CFrame.new(
            1.65,
            0,
            0
        )
    )

    -- Left leg
    local LeftLeg = createPart(
        "LeftLeg",
        Vector3.new(
            0.82,
            2.7,
            0.82
        ),
        SKIN_COLOR,
        Folder
    )

    LeftLeg.CFrame =
        Body.CFrame
        * CFrame.new(
            -0.65,
            -2.8,
            0
        )

    weld(
        RootPart,
        LeftLeg,
        CFrame.new(
            -0.65,
            -2.8,
            0
        )
    )

    -- Right leg
    local RightLeg = createPart(
        "RightLeg",
        Vector3.new(
            0.82,
            2.7,
            0.82
        ),
        SKIN_COLOR,
        Folder
    )

    RightLeg.CFrame =
        Body.CFrame
        * CFrame.new(
            0.65,
            -2.8,
            0
        )

    weld(
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
-- 3D HALF-CIRCLE CHEST MARKINGS
--========================================================

local function createChestHalf(
    Body,
    Folder,
    Name,
    X
)

    -- Large rounded 3D dome
    local Dome = Instance.new("Part")

    Dome.Name = Name
    Dome.Shape = Enum.PartType.Ball

    Dome.Size = Vector3.new(
        1.1,
        1.1,
        0.42
    )

    Dome.Color = CHEST_COLOR
    Dome.Material = Enum.Material.SmoothPlastic

    Dome.CanCollide = false
    Dome.CanTouch = false
    Dome.CanQuery = false
    Dome.Massless = true

    Dome.CFrame =
        Body.CFrame
        * CFrame.new(
            X,
            0.25,
            -0.72
        )

    Dome.Parent = Folder

    local Weld =
        Instance.new("WeldConstraint")

    Weld.Part0 = Body
    Weld.Part1 = Dome
    Weld.Parent = Dome

    -- Cover the lower half with the same body color
    local Cover = createPart(
        Name .. "_LowerCover",
        Vector3.new(
            0.45,
            0.55,
            1.15
        ),
        SKIN_COLOR,
        Folder
    )

    Cover.CFrame =
        Body.CFrame
        * CFrame.new(
            X,
            -0.03,
            -0.72
        )

    weld(
        Body,
        Cover,
        CFrame.new(
            X,
            -0.03,
            -0.72
        )
    )
end

--========================================================
-- BUILD
--========================================================

local function buildNeko()

    local Character = getCharacter()

    if not Character then
        return
    end

    local Head =
        Character:FindFirstChild("Head")

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Head or not Humanoid then
        return
    end

    local Folder =
        createFolder(Character)

    hideDefaultBody(Character)

    local Body =
        createBody(
            Character,
            Folder
        )

    if not Body then
        return
    end

    -- Cat ears
    createEar(
        Head,
        Folder,
        "LeftEar",
        -0.55
    )

    createEar(
        Head,
        Folder,
        "RightEar",
        0.55
    )

    -- Large 3D half circles
    createChestHalf(
        Body,
        Folder,
        "LeftChest",
        -0.5
    )

    createChestHalf(
        Body,
        Folder,
        "RightChest",
        0.5
    )

    print("Neko V5 applied locally.")
end

--========================================================
-- INITIALIZE
--========================================================

local function initialize()

    if not LocalPlayer.Character then
        LocalPlayer.CharacterAdded:Wait()
    end

    task.wait(1)

    local Success, ErrorMessage =
        pcall(function()

            local Applied =
                resetAvatar()

            if Applied then
                task.wait(1)
                buildNeko()
            end

        end)

    if not Success then
        warn(
            "Neko V5 error:",
            ErrorMessage
        )
    end
end

--========================================================
-- RESPAWN
--========================================================

LocalPlayer.CharacterAdded:Connect(function()

    task.wait(1)

    local Success, ErrorMessage =
        pcall(function()

            local Applied =
                resetAvatar()

            if Applied then
                task.wait(1)
                buildNeko()
            end

        end)

    if not Success then
        warn(
            "Neko V5 respawn error:",
            ErrorMessage
        )
    end
end)

initialize()
