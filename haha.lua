--========================================================
-- NEKO V5
-- Avatar rebuild for your own Roblox experience
--========================================================

local Players = game:GetService("Players")
local AssetService = game:GetService("AssetService")

--========================================================
-- ASSETS
--========================================================

local ASSETS = {
    Tail = 104494501265878,
    Hair = 86220548304036,
    Cone = 1609390589,

    -- Proud Happy Goober Face bundle
    FaceBundle = 167878794367281
}

--========================================================
-- COLORS
--========================================================

local TAN = Color3.fromRGB(198, 142, 93)

--========================================================
-- RESOLVE FACE/DYNAMIC HEAD FROM BUNDLE
--========================================================

local function GetFaceAssetFromBundle()
    local Success, Details = pcall(function()
        return AssetService:GetBundleDetailsAsync(
            ASSETS.FaceBundle
        )
    end)

    if not Success or not Details then
        warn("Neko V5: Could not read face bundle:", Details)
        return nil
    end

    -- Prefer DynamicHead
    for _, Item in ipairs(Details.Items or {}) do
        if Item.Type == "Asset" and Item.AssetType == "DynamicHead" then
            return Item.Id
        end
    end

    -- Fallback: look for a Head component
    for _, Item in ipairs(Details.Items or {}) do
        if Item.Type == "Asset"
            and Item.AssetType == "Head" then

            return Item.Id
        end
    end

    return nil
end

--========================================================
-- RESET ACCESSORIES / CLOTHING
--========================================================

local function ClearDescription(Description)
    -- Accessories
    Description.BackAccessory = ""
    Description.FaceAccessory = ""
    Description.FrontAccessory = ""
    Description.HairAccessory = ""
    Description.HatAccessory = ""
    Description.NeckAccessory = ""
    Description.ShouldersAccessory = ""
    Description.WaistAccessory = ""

    -- Clothing
    Description.Shirt = 0
    Description.Pants = 0
    Description.GraphicTShirt = 0

    -- Body colors
    Description.HeadColor = TAN
    Description.LeftArmColor = TAN
    Description.RightArmColor = TAN
    Description.LeftLegColor = TAN
    Description.RightLegColor = TAN
    Description.TorsoColor = TAN

    return Description
end

--========================================================
-- APPLY NEKO V5
--========================================================

local function ApplyNeko(Player)
    local Character = Player.Character

    if not Character then
        return
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        return
    end

    local Description

    local DescriptionSuccess, DescriptionResult = pcall(function()
        return Humanoid:GetAppliedDescription()
    end)

    if not DescriptionSuccess then
        warn(
            "Neko V5: Failed to get HumanoidDescription for",
            Player.Name,
            DescriptionResult
        )
        return
    end

    Description = DescriptionResult

    -- Completely strip existing avatar accessories/clothes
    ClearDescription(Description)

    --====================================================
    -- REQUESTED ASSETS
    --====================================================

    -- Long black hair
    Description.HairAccessory =
        tostring(ASSETS.Hair)

    -- Blue traffic cone
    Description.HatAccessory =
        tostring(ASSETS.Cone)

    -- White fluffy tail
    Description.WaistAccessory =
        tostring(ASSETS.Tail)

    --====================================================
    -- FACE / HEAD
    --====================================================

    local FaceAsset = GetFaceAssetFromBundle()

    if FaceAsset then
        -- The supplied link is a dynamic-head bundle.
        Description.Head = FaceAsset
    else
        warn(
            "Neko V5: Could not resolve Proud Happy Goober Face bundle."
        )
    end

    --====================================================
    -- APPLY
    --====================================================

    local ApplySuccess, ApplyResult = pcall(function()
        Humanoid:ApplyDescription(Description)
    end)

    if not ApplySuccess then
        warn(
            "Neko V5: Failed to apply avatar:",
            ApplyResult
        )
        return
    end

    task.wait(0.75)

    Character = Player.Character

    if not Character then
        return
    end

    Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        return
    end

    --====================================================
    -- NEKO VISUALS
    --====================================================

    local Existing = Character:FindFirstChild("NekoV5Visuals")

    if Existing then
        Existing:Destroy()
    end

    local NekoFolder = Instance.new("Folder")
    NekoFolder.Name = "NekoV5Visuals"
    NekoFolder.Parent = Character

    local Head = Character:FindFirstChild("Head")
    local Torso =
        Character:FindFirstChild("UpperTorso")
        or Character:FindFirstChild("Torso")

    if not Head or not Torso then
        return
    end

    --====================================================
    -- CAT EARS
    --====================================================

    local function CreateEar(Name, X)
        local Ear = Instance.new("WedgePart")

        Ear.Name = Name
        Ear.Size = Vector3.new(0.8, 1.1, 0.8)
        Ear.Color = Color3.fromRGB(255, 255, 255)
        Ear.Material = Enum.Material.SmoothPlastic

        Ear.CanCollide = false
        Ear.CanTouch = false
        Ear.CanQuery = false
        Ear.Massless = true

        Ear.CFrame =
            Head.CFrame
            * CFrame.new(
                X,
                0.75,
                0
            )
            * CFrame.Angles(
                0,
                0,
                math.rad(
                    X < 0 and -20 or 20
                )
            )

        Ear.Parent = NekoFolder

        local Weld = Instance.new("WeldConstraint")
        Weld.Part0 = Head
        Weld.Part1 = Ear
        Weld.Parent = Ear

        return Ear
    end

    local LeftEar = CreateEar(
        "LeftEar",
        -0.55
    )

    local RightEar = CreateEar(
        "RightEar",
        0.55
    )

    --====================================================
    -- SEMI-CIRCLE CHEST MARKINGS
    --====================================================

    -- These are flattened wedge/cylinder-style markings
    -- positioned on the front of the torso.

    local function CreateChestMark(Name, X)
        local Mark = Instance.new("Part")

        Mark.Name = Name
        Mark.Shape = Enum.PartType.Cylinder

        Mark.Size =
            Vector3.new(
                0.08,
                1.45,
                0.9
            )

        Mark.Color =
            Color3.fromRGB(255, 255, 255)

        Mark.Material =
            Enum.Material.SmoothPlastic

        Mark.CanCollide = false
        Mark.CanTouch = false
        Mark.CanQuery = false
        Mark.Massless = true

        Mark.CFrame =
            Torso.CFrame
            * CFrame.new(
                X,
                0.15,
                -0.56
            )
            * CFrame.Angles(
                0,
                math.rad(90),
                0
            )

        Mark.Parent = NekoFolder

        local Weld = Instance.new("WeldConstraint")

        Weld.Part0 = Torso
        Weld.Part1 = Mark

        Weld.Parent = Mark

        return Mark
    end

    local LeftChest =
        CreateChestMark(
            "LeftChestSemiCircle",
            -0.48
        )

    local RightChest =
        CreateChestMark(
            "RightChestSemiCircle",
            0.48
        )

    --====================================================
    -- TAIL ANIMATION
    --====================================================

    local TailAccessory

    for _, Object in ipairs(Character:GetChildren()) do
        if Object:IsA("Accessory") then
            local Handle = Object:FindFirstChild("Handle")

            if Handle and Object.AccessoryType
                == Enum.AccessoryType.Waist then

                TailAccessory = Object
            end
        end
    end

    if TailAccessory then
        local Handle =
            TailAccessory:FindFirstChild("Handle")

        if Handle then
            task.spawn(function()
                local Start = os.clock()

                while Character.Parent
                    and TailAccessory.Parent do

                    local Time =
                        os.clock() - Start

                    local Sway =
                        math.sin(Time * 2.2) * 7

                    local Weld =
                        Handle:FindFirstChildWhichIsA(
                            "Weld"
                        )

                    if Weld then
                        Weld.C0 =
                            Weld.C0:Lerp(
                                Weld.C0
                                * CFrame.Angles(
                                    0,
                                    math.rad(Sway),
                                    math.rad(
                                        math.cos(
                                            Time * 1.7
                                        ) * 4
                                    )
                                ),
                                0.12
                            )
                    end

                    task.wait()
                end
            end)
        end
    end

    --====================================================
    -- SIMPLE IDLE EAR MOTION
    --====================================================

    task.spawn(function()
        local Start = os.clock()

        while Character.Parent do

            local Time =
                os.clock() - Start

            local Wave =
                math.sin(Time * 2) * 3

            if LeftEar
                and LeftEar.Parent then

                LeftEar.CFrame =
                    Head.CFrame
                    * CFrame.new(
                        -0.55,
                        0.75,
                        0
                    )
                    * CFrame.Angles(
                        0,
                        0,
                        math.rad(
                            -20 + Wave
                        )
                    )
            end

            if RightEar
                and RightEar.Parent then

                RightEar.CFrame =
                    Head.CFrame
                    * CFrame.new(
                        0.55,
                        0.75,
                        0
                    )
                    * CFrame.Angles(
                        0,
                        0,
                        math.rad(
                            20 - Wave
                        )
                    )
            end

            task.wait()
        end
    end)

    print(
        "Neko V5 applied to",
        Player.Name
    )
end

--========================================================
-- CHARACTER HANDLING
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
                "Neko V5 error for "
                    .. Player.Name
                    .. ": "
                    .. tostring(ErrorMessage)
            )
        end
    end)

    if Player.Character then
        task.spawn(function()
            task.wait(1)
            ApplyNeko(Player)
        end)
    end
end

--========================================================
-- PLAYERS
--========================================================

Players.PlayerAdded:Connect(SetupPlayer)

for _, Player in ipairs(Players:GetPlayers()) do
    task.spawn(function()
        SetupPlayer(Player)
    end)
end
