--========================================================
-- IKONNED NEKO V5
-- Complete avatar rebuild
-- Place this Script in ServerScriptService
--========================================================

local Players = game:GetService("Players")
local AssetService = game:GetService("AssetService")

--========================================================
-- ASSETS
--========================================================

local HAIR_ASSET = 86220548304036
local TAIL_ASSET = 104494501265878
local CONE_ASSET = 1609390589

-- Proud Happy Goober Face bundle
local FACE_BUNDLE = 167878794367281

--========================================================
-- COLORS
--========================================================

-- Pale white-ish tan
local SKIN_COLOR = Color3.fromRGB(232, 205, 178)

-- Chest pieces use the exact same color
local CHEST_COLOR = SKIN_COLOR

--========================================================
-- BODY SETTINGS
--========================================================

local BODY_COLOR = SKIN_COLOR

local TORSO_SIZE = Vector3.new(2.6, 2.8, 1.35)

local ARM_SIZE = Vector3.new(0.7, 2.6, 0.7)
local LEG_SIZE = Vector3.new(0.8, 2.7, 0.8)

--========================================================
-- FACE BUNDLE RESOLUTION
--========================================================

local function ResolveFaceFromBundle()
    local Success, Bundle = pcall(function()
        return AssetService:GetBundleDetailsAsync(FACE_BUNDLE)
    end)

    if not Success or not Bundle then
        warn(
            "[Neko V5] Couldn't read face bundle:",
            Bundle
        )

        return nil
    end

    -- Try to locate a UserOutfit contained in the bundle.
    for _, Item in ipairs(Bundle.Items or {}) do

        if Item.Type == "UserOutfit" then

            local OutfitSuccess, Description =
                pcall(function()

                    return Players:GetHumanoidDescriptionFromOutfitIdAsync(
                        Item.Id
                    )

                end)

            if OutfitSuccess and Description then
                return Description
            end
        end
    end

    -- Some bundles expose their asset parts directly.
    local HeadId
    local FaceId

    for _, Item in ipairs(Bundle.Items or {}) do

        if Item.Type == "Asset" then

            if Item.AssetType == "DynamicHead"
                or Item.AssetType == "Head" then

                HeadId = Item.Id

            elseif Item.AssetType == "Face" then

                FaceId = Item.Id
            end
        end
    end

    if HeadId or FaceId then

        local Description = Instance.new(
            "HumanoidDescription"
        )

        if HeadId then
            Description.Head = HeadId
        end

        if FaceId then
            Description.Face = FaceId
        end

        return Description
    end

    return nil
end

--========================================================
-- CLEAR ACCESSORIES / CLOTHING
--========================================================

local function ClearDescription(Description)

    -- Accessories
    Description.HatAccessory = ""
    Description.HairAccessory = ""
    Description.FaceAccessory = ""
    Description.NeckAccessory = ""
    Description.ShouldersAccessory = ""
    Description.FrontAccessory = ""
    Description.BackAccessory = ""
    Description.WaistAccessory = ""

    -- Clothing
    Description.Shirt = 0
    Description.Pants = 0
    Description.GraphicTShirt = 0

    -- Body colors
    Description.HeadColor = SKIN_COLOR
    Description.LeftArmColor = SKIN_COLOR
    Description.RightArmColor = SKIN_COLOR
    Description.LeftLegColor = SKIN_COLOR
    Description.RightLegColor = SKIN_COLOR
    Description.TorsoColor = SKIN_COLOR

    return Description
end

--========================================================
-- REMOVE PHYSICAL EXTRAS
--========================================================

local function RemovePhysicalExtras(Character)

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
-- HIDE DEFAULT BODY
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

    Part.TopSurface =
        Enum.SurfaceType.Smooth

    Part.BottomSurface =
        Enum.SurfaceType.Smooth

    Part.Parent = Parent

    return Part
end

--========================================================
-- WELD
--========================================================

local function WeldPart(
    BasePart,
    Part,
    Offset
)

    local Weld = Instance.new("Weld")

    Weld.Part0 = BasePart
    Weld.Part1 = Part
    Weld.C0 = Offset

    Weld.Parent = Part

    return Weld
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

    --====================================================
    -- BODY
    --====================================================

    local Body = CreatePart(
        "NekoBody",
        TORSO_SIZE,
        BODY_COLOR,
        Folder
    )

    Body.CFrame =
        RootPart.CFrame
        * CFrame.new(
            0,
            -0.15,
            0
        )

    WeldPart(
        RootPart,
        Body,
        CFrame.new(
            0,
            -0.15,
            0
        )
    )

    --====================================================
    -- LEFT ARM
    --====================================================

    local LeftArm = CreatePart(
        "NekoLeftArm",
        ARM_SIZE,
        BODY_COLOR,
        Folder
    )

    LeftArm.CFrame =
        Body.CFrame
        * CFrame.new(
            -1.62,
            0,
            0
        )

    WeldPart(
        Body,
        LeftArm,
        CFrame.new(
            -1.62,
            0,
            0
        )
    )

    --====================================================
    -- RIGHT ARM
    --====================================================

    local RightArm = CreatePart(
        "NekoRightArm",
        ARM_SIZE,
        BODY_COLOR,
        Folder
    )

    RightArm.CFrame =
        Body.CFrame
        * CFrame.new(
            1.62,
            0,
            0
        )

    WeldPart(
        Body,
        RightArm,
        CFrame.new(
            1.62,
            0,
            0
        )
    )

    --====================================================
    -- LEFT LEG
    --====================================================

    local LeftLeg = CreatePart(
        "NekoLeftLeg",
        LEG_SIZE,
        BODY_COLOR,
        Folder
    )

    LeftLeg.CFrame =
        Body.CFrame
        * CFrame.new(
            -0.67,
            -2.75,
            0
        )

    WeldPart(
        RootPart,
        LeftLeg,
        CFrame.new(
            -0.67,
            -2.75,
            0
        )
    )

    --====================================================
    -- RIGHT LEG
    --====================================================

    local RightLeg = CreatePart(
        "NekoRightLeg",
        LEG_SIZE,
        BODY_COLOR,
        Folder
    )

    RightLeg.CFrame =
        Body.CFrame
        * CFrame.new(
            0.67,
            -2.75,
            0
        )

    WeldPart(
        RootPart,
        RightLeg,
        CFrame.new(
            0.67,
            -2.75,
            0
        )
    )

    return Body
end

--========================================================
-- CAT EARS
--========================================================

local function CreateEar(
    Character,
    Folder,
    Name,
    X
)

    local Head =
        Character:FindFirstChild("Head")

    if not Head then
        return
    end

    local Ear = Instance.new("WedgePart")

    Ear.Name = Name

    Ear.Size =
        Vector3.new(
            0.85,
            1.15,
            0.85
        )

    Ear.Color = BODY_COLOR

    Ear.Material =
        Enum.Material.SmoothPlastic

    Ear.CanCollide = false
    Ear.CanTouch = false
    Ear.CanQuery = false
    Ear.Massless = true

    Ear.CFrame =
        Head.CFrame
        * CFrame.new(
            X,
            0.7,
            0
        )
        * CFrame.Angles(
            0,
            0,
            math.rad(
                X < 0
                    and -20
                    or 20
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
-- 3D HALF-DOME CHEST MARKING
--========================================================

local function CreateChestHalf(
    Body,
    Folder,
    Name,
    X
)

    -- Main rounded dome
    local Dome = Instance.new("Part")

    Dome.Name = Name

    Dome.Shape =
        Enum.PartType.Ball

    Dome.Size =
        Vector3.new(
            0.9,
            0.9,
            0.3
        )

    Dome.Color = CHEST_COLOR

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
            0.25,
            -0.72
        )

    Dome.Parent = Folder

    local DomeWeld =
        Instance.new("WeldConstraint")

    DomeWeld.Part0 = Body
    DomeWeld.Part1 = Dome
    DomeWeld.Parent = Dome

    -- Skin-colored cover masks the lower half,
    -- producing the half-circle / half-dome look.
    local Cover = CreatePart(
        Name .. "_Cover",
        Vector3.new(
            0.35,
            0.5,
            0.95
        ),
        SKIN_COLOR,
        Folder
    )

    Cover.CFrame =
        Body.CFrame
        * CFrame.new(
            X,
            -0.05,
            -0.72
        )

    WeldPart(
        Body,
        Cover,
        CFrame.new(
            X,
            -0.05,
            -0.72
        )
    )
end

--========================================================
-- APPLY REQUESTED AVATAR
--========================================================

local function ApplyNeko(Player)

    local Character = Player.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    if not Humanoid then
        return
    end

    --====================================================
    -- GET CURRENT DESCRIPTION
    --====================================================

    local Description

    local Success, Result = pcall(function()
        return Humanoid:GetAppliedDescription()
    end)

    if Success and Result then
        Description = Result
    else
        Description =
            Instance.new("HumanoidDescription")
    end

    --====================================================
    -- SAVE FACE FROM THE REQUESTED BUNDLE
    --====================================================

    local FaceDescription =
        ResolveFaceFromBundle()

    local WantedHead
    local WantedFace

    if FaceDescription then
        WantedHead = FaceDescription.Head
        WantedFace = FaceDescription.Face
    end

    --====================================================
    -- RESET EVERYTHING
    --====================================================

    ClearDescription(Description)

    --====================================================
    -- APPLY FACE BUNDLE COMPONENTS
    --====================================================

    if WantedHead and WantedHead ~= 0 then
        Description.Head = WantedHead
    end

    if WantedFace and WantedFace ~= 0 then
        Description.Face = WantedFace
    end

    --====================================================
    -- REQUESTED ACCESSORIES
    --====================================================

    -- Black long hair
    Description.HairAccessory =
        tostring(HAIR_ASSET)

    -- Blue Traffic Cone
    Description.HatAccessory =
        tostring(CONE_ASSET)

    -- White fluffy tail
    Description.WaistAccessory =
        tostring(TAIL_ASSET)

    --====================================================
    -- APPLY DESCRIPTION
    --====================================================

    local ApplySuccess, ApplyError =
        pcall(function()

            Humanoid:ApplyDescriptionAsync(
                Description,
                Enum.AssetTypeVerification.Default
            )

        end)

    if not ApplySuccess then
        warn(
            "[Neko V5] Appearance application failed:",
            ApplyError
        )

        return
    end

    task.wait(1)

    Character = Player.Character

    if not Character then
        return
    end

    Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    if not Humanoid then
        return
    end

    --====================================================
    -- REMOVE ANYTHING THAT SHOULD NOT BE THERE
    --====================================================

    RemovePhysicalExtras(Character)

    --====================================================
    -- CREATE CUSTOM BODY
    --====================================================

    local OldFolder =
        Character:FindFirstChild(
            "NekoV5"
        )

    if OldFolder then
        OldFolder:Destroy()
    end

    local Folder = Instance.new("Folder")

    Folder.Name = "NekoV5"
    Folder.Parent = Character

    --====================================================
    -- HIDE DEFAULT LIMBS
    --====================================================

    HideDefaultBody(Character)

    --====================================================
    -- BUILD CUSTOM BLOCK BODY
    --====================================================

    local Body =
        CreateBlockBody(
            Character,
            Folder
        )

    if not Body then
        return
    end

    --====================================================
    -- EARS
    --====================================================

    CreateEar(
        Character,
        Folder,
        "LeftEar",
        -0.55
    )

    CreateEar(
        Character,
        Folder,
        "RightEar",
        0.55
    )

    --====================================================
    -- CHEST HALF CIRCLES
    --====================================================

    CreateChestHalf(
        Body,
        Folder,
        "LeftChestHalf",
        -0.48
    )

    CreateChestHalf(
        Body,
        Folder,
        "RightChestHalf",
        0.48
    )

    print(
        "[Neko V5] Applied to",
        Player.Name
    )
end

--========================================================
-- PLAYER SETUP
--========================================================

local function SetupPlayer(Player)

    Player.CharacterAdded:Connect(function()
        task.wait(1)

        local Success, ErrorMessage =
            pcall(function()
                ApplyNeko(Player)
            end)

        if not Success then
            warn(
                "[Neko V5] Error for "
                    .. Player.Name
                    .. ": "
                    .. tostring(ErrorMessage)
            )
        end
    end)

    if Player.Character then

        task.spawn(function()

            task.wait(1)

            local Success, ErrorMessage =
                pcall(function()
                    ApplyNeko(Player)
                end)

            if not Success then
                warn(
                    "[Neko V5] Error for "
                        .. Player.Name
                        .. ": "
                        .. tostring(ErrorMessage)
                )
            end

        end)
    end
end

--========================================================
-- PLAYERS
--========================================================

Players.PlayerAdded:Connect(
    SetupPlayer
)

for _, Player in ipairs(
    Players:GetPlayers()
) do
    task.spawn(function()
        SetupPlayer(Player)
    end)
end
