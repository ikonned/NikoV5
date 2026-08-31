--========================================================
-- NEKO V5
-- Original Roblox LocalScript
-- Place in StarterPlayer > StarterPlayerScripts
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer

--========================================================
-- SETTINGS
--========================================================

local CONFIG = {
    NormalSpeed = 16,
    SprintSpeed = 28,

    TailColor = Color3.fromRGB(255, 255, 255),
    EarColor = Color3.fromRGB(255, 255, 255),
    ClawColor = Color3.fromRGB(235, 235, 235),

    ChestCircleColor = Color3.fromRGB(255, 255, 255),

    EnableSounds = true,
    EnableCombat = true,

    AttackCooldown = 0.45
}

--========================================================
-- STATE
--========================================================

local Character
local Humanoid
local RootPart

local NekoFolder
local Tail
local LeftEar
local RightEar
local LeftClaw
local RightClaw
local ChestCircleLeft
local ChestCircleRight

local Sprinting = false
local Attacking = false
local LastAttack = 0

local Connections = {}

--========================================================
-- CLEANUP
--========================================================

local function DisconnectAll()
    for _, Connection in ipairs(Connections) do
        if Connection then
            Connection:Disconnect()
        end
    end

    table.clear(Connections)
end

local function CleanupNeko()
    DisconnectAll()

    if NekoFolder then
        NekoFolder:Destroy()
        NekoFolder = nil
    end

    Tail = nil
    LeftEar = nil
    RightEar = nil
    LeftClaw = nil
    RightClaw = nil
    ChestCircleLeft = nil
    ChestCircleRight = nil
end

--========================================================
-- PART CREATION
--========================================================

local function CreatePart(Name, Size, Color, Parent)
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

    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth

    Part.Parent = Parent

    return Part
end

local function WeldPart(Part, BodyPart, Offset)
    local Weld = Instance.new("Weld")

    Weld.Part0 = BodyPart
    Weld.Part1 = Part
    Weld.C0 = Offset

    Weld.Parent = Part

    return Weld
end

--========================================================
-- MESH
--========================================================

local function AddMesh(Part, MeshType, Scale)
    local Mesh = Instance.new("SpecialMesh")

    Mesh.MeshType = MeshType
    Mesh.Scale = Scale

    Mesh.Parent = Part

    return Mesh
end

--========================================================
-- SOUND
--========================================================

local function PlaySound(SoundId, Parent, Volume, PlaybackSpeed)
    if not CONFIG.EnableSounds then
        return
    end

    local Sound = Instance.new("Sound")

    Sound.SoundId = "rbxassetid://" .. tostring(SoundId)
    Sound.Volume = Volume or 1
    Sound.PlaybackSpeed = PlaybackSpeed or 1
    Sound.RollOffMaxDistance = 80

    Sound.Parent = Parent
    Sound:Play()

    Debris:AddItem(Sound, 5)

    return Sound
end

--========================================================
-- EFFECT
--========================================================

local function CreateSpark(Position)
    local Holder = Instance.new("Part")

    Holder.Name = "NekoEffect"
    Holder.Size = Vector3.new(0.1, 0.1, 0.1)
    Holder.Transparency = 1
    Holder.Anchored = true
    Holder.CanCollide = false
    Holder.CanTouch = false
    Holder.CanQuery = false

    Holder.Position = Position
    Holder.Parent = workspace

    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Holder

    local Particle = Instance.new("ParticleEmitter")

    Particle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    Particle.Color = ColorSequence.new(CONFIG.ClawColor)
    Particle.LightEmission = 1

    Particle.Lifetime = NumberRange.new(0.25, 0.45)
    Particle.Speed = NumberRange.new(3, 7)
    Particle.Rate = 0
    Particle.SpreadAngle = Vector2.new(180, 180)

    Particle.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.35),
        NumberSequenceKeypoint.new(1, 0)
    })

    Particle.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })

    Particle.Parent = Attachment

    Particle:Emit(12)

    Debris:AddItem(Holder, 1)
end

--========================================================
-- EARS
--========================================================

local function CreateEar(Name, Head, X)
    local Ear = CreatePart(
        Name,
        Vector3.new(0.8, 1.1, 0.8),
        CONFIG.EarColor,
        NekoFolder
    )

    Ear.Shape = Enum.PartType.Wedge

    WeldPart(
        Ear,
        Head,
        CFrame.new(X, 0.8, 0)
            * CFrame.Angles(
                0,
                0,
                math.rad(X < 0 and -20 or 20)
            )
    )

    return Ear
end

--========================================================
-- TAIL
--========================================================

local function CreateTail(Torso)
    local TailModel = Instance.new("Model")
    TailModel.Name = "NekoTail"
    TailModel.Parent = NekoFolder

    local Segments = {}

    for Index = 1, 8 do
        local Segment = CreatePart(
            "TailSegment" .. Index,
            Vector3.new(
                0.55 - Index * 0.04,
                0.55 - Index * 0.04,
                0.7
            ),
            CONFIG.TailColor,
            TailModel
        )

        AddMesh(
            Segment,
            Enum.MeshType.Cylinder,
            Vector3.new(1, 1, 1)
        )

        Segments[Index] = Segment

        local ParentPart =
            Index == 1 and Torso or Segments[Index - 1]

        local Offset

        if Index == 1 then
            Offset = CFrame.new(0, -0.25, 0.6)
        else
            Offset = CFrame.new(0, 0.02, 0.55)
        end

        WeldPart(Segment, ParentPart, Offset)
    end

    return Segments
end

--========================================================
-- CLAWS
--========================================================

local function CreateClaw(Name, Arm, Offset)
    local Claw = CreatePart(
        Name,
        Vector3.new(0.3, 0.8, 0.3),
        CONFIG.ClawColor,
        NekoFolder
    )

    Claw.Shape = Enum.PartType.Cylinder

    WeldPart(
        Claw,
        Arm,
        Offset
    )

    return Claw
end

--========================================================
-- BIG CHEST CIRCLES
--========================================================

local function CreateChestCircles(Torso)
    -- Left circle
    local Left = CreatePart(
        "ChestCircleLeft",
        Vector3.new(0.1, 1.6, 1.6),
        CONFIG.ChestCircleColor,
        NekoFolder
    )

    Left.Shape = Enum.PartType.Cylinder

    local LeftWeld = Instance.new("Weld")
    LeftWeld.Part0 = Torso
    LeftWeld.Part1 = Left
    LeftWeld.C0 =
        CFrame.new(-0.48, 0.15, -0.58)
        * CFrame.Angles(0, math.rad(90), 0)
    LeftWeld.Parent = Left

    -- Right circle
    local Right = CreatePart(
        "ChestCircleRight",
        Vector3.new(0.1, 1.6, 1.6),
        CONFIG.ChestCircleColor,
        NekoFolder
    )

    Right.Shape = Enum.PartType.Cylinder

    local RightWeld = Instance.new("Weld")
    RightWeld.Part0 = Torso
    RightWeld.Part1 = Right
    RightWeld.C0 =
        CFrame.new(0.48, 0.15, -0.58)
        * CFrame.Angles(0, math.rad(90), 0)
    RightWeld.Parent = Right

    ChestCircleLeft = Left
    ChestCircleRight = Right
end

--========================================================
-- ATTACK
--========================================================

local function PerformAttack()
    if Attacking then
        return
    end

    if not Character or not Humanoid or not RootPart then
        return
    end

    if os.clock() - LastAttack < CONFIG.AttackCooldown then
        return
    end

    LastAttack = os.clock()
    Attacking = true

    Humanoid.WalkSpeed = 5

    local OriginalAutoRotate = Humanoid.AutoRotate
    Humanoid.AutoRotate = false

    local OriginalCFrame = RootPart.CFrame

    local Back =
        TweenService:Create(
            RootPart,
            TweenInfo.new(
                0.12,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                CFrame =
                    OriginalCFrame
                    * CFrame.Angles(
                        0,
                        0,
                        math.rad(-12)
                    )
            }
        )

    Back:Play()
    Back.Completed:Wait()

    CreateSpark(
        RootPart.Position
        + RootPart.CFrame.LookVector * 3
    )

    PlaySound(
        12222134,
        RootPart,
        0.8,
        math.random(90, 110) / 100
    )

    local Forward =
        TweenService:Create(
            RootPart,
            TweenInfo.new(
                0.16,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),
            {
                CFrame =
                    OriginalCFrame
                    * CFrame.new(0, 0, -1.25)
            }
        )

    Forward:Play()
    Forward.Completed:Wait()

    CreateSpark(
        RootPart.Position
        + RootPart.CFrame.LookVector * 2
    )

    task.wait(0.08)

    RootPart.CFrame = OriginalCFrame

    Humanoid.AutoRotate = OriginalAutoRotate

    Humanoid.WalkSpeed =
        Sprinting and CONFIG.SprintSpeed
        or CONFIG.NormalSpeed

    Attacking = false
end

--========================================================
-- SETUP
--========================================================

local function SetupNeko()
    CleanupNeko()

    Character = Player.Character

    if not Character then
        return
    end

    Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    RootPart =
        Character:FindFirstChild("HumanoidRootPart")

    local Head =
        Character:FindFirstChild("Head")

    local Torso =
        Character:FindFirstChild("UpperTorso")
        or Character:FindFirstChild("Torso")

    local LeftArmPart =
        Character:FindFirstChild("LeftHand")
        or Character:FindFirstChild("Left Arm")

    local RightArmPart =
        Character:FindFirstChild("RightHand")
        or Character:FindFirstChild("Right Arm")

    if not Humanoid
        or not RootPart
        or not Head
        or not Torso then
        return
    end

    NekoFolder = Instance.new("Folder")
    NekoFolder.Name = "NekoV5"
    NekoFolder.Parent = Character

    -- Ears
    LeftEar = CreateEar(
        "LeftEar",
        Head,
        -0.55
    )

    RightEar = CreateEar(
        "RightEar",
        Head,
        0.55
    )

    -- Tail
    Tail = CreateTail(Torso)

    -- Claws
    if LeftArmPart then
        LeftClaw = CreateClaw(
            "LeftClaw",
            LeftArmPart,
            CFrame.new(0, -0.35, 0)
        )
    end

    if RightArmPart then
        RightClaw = CreateClaw(
            "RightClaw",
            RightArmPart,
            CFrame.new(0, -0.35, 0)
        )
    end

    -- Big chest circles
    CreateChestCircles(Torso)

    -- Starting speed
    Humanoid.WalkSpeed = CONFIG.NormalSpeed

    --====================================================
    -- ANIMATION LOOP
    --====================================================

    local Sine = 0

    table.insert(
        Connections,
        RunService.RenderStepped:Connect(function(DeltaTime)

            if not Character
                or not Character.Parent then
                return
            end

            if not Humanoid.Parent then
                return
            end

            Sine += DeltaTime * 6

            local Moving =
                Humanoid.MoveDirection.Magnitude > 0.05

            local Speed =
                Humanoid.MoveDirection.Magnitude

            --================================================
            -- TAIL ANIMATION
            --================================================

            if Tail then
                for Index, Segment in ipairs(Tail) do

                    local Wave =
                        math.sin(
                            Sine * 1.5
                            + Index * 0.65
                        )

                    local Angle =
                        math.rad(Wave * (10 + Index))

                    local BaseCFrame =
                        Index == 1
                        and CFrame.new(0, -0.25, 0.6)
                        or CFrame.new(0, 0.02, 0.55)

                    local Target =
                        BaseCFrame
                        * CFrame.Angles(
                            0,
                            Angle,
                            math.rad(
                                math.sin(
                                    Sine * 1.2
                                    + Index
                                ) * 4
                            )
                        )

                    local Weld =
                        Segment:FindFirstChildOfClass("Weld")

                    if Weld then
                        Weld.C0 =
                            Weld.C0:Lerp(
                                Target,
                                math.clamp(
                                    DeltaTime * 8,
                                    0,
                                    1
                                )
                            )
                    end
                end
            end

            --================================================
            -- EAR ANIMATION
            --================================================

            if LeftEar and RightEar then

                local EarWave =
                    math.sin(Sine * 2) * 3

                local LWeld =
                    LeftEar:FindFirstChildOfClass("Weld")

                local RWeld =
                    RightEar:FindFirstChildOfClass("Weld")

                if LWeld then
                    LWeld.C0 =
                        CFrame.new(-0.55, 0.8, 0)
                        * CFrame.Angles(
                            0,
                            0,
                            math.rad(-20 + EarWave)
                        )
                end

                if RWeld then
                    RWeld.C0 =
                        CFrame.new(0.55, 0.8, 0)
                        * CFrame.Angles(
                            0,
                            0,
                            math.rad(20 - EarWave)
                        )
                end
            end

            --================================================
            -- CLAW ANIMATION
            --================================================

            if LeftClaw and RightClaw then

                local ClawWave =
                    math.sin(Sine * 3) * 0.08

                local LWeld =
                    LeftClaw:FindFirstChildOfClass("Weld")

                local RWeld =
                    RightClaw:FindFirstChildOfClass("Weld")

                if LWeld then
                    LWeld.C0 =
                        CFrame.new(
                            0,
                            -0.35,
                            -0.05 + ClawWave
                        )
                end

                if RWeld then
                    RWeld.C0 =
                        CFrame.new(
                            0,
                            -0.35,
                            -0.05 - ClawWave
                        )
                end
            end

            --================================================
            -- CHEST CIRCLE BOUNCE
            --================================================

            if ChestCircleLeft and ChestCircleRight then

                local Bounce =
                    math.sin(Sine * 2) * 0.025

                local LeftWeld =
                    ChestCircleLeft:FindFirstChildOfClass("Weld")

                local RightWeld =
                    ChestCircleRight:FindFirstChildOfClass("Weld")

                if LeftWeld then
                    LeftWeld.C0 =
                        CFrame.new(
                            -0.48,
                            0.15 + Bounce,
                            -0.58
                        )
                        * CFrame.Angles(
                            0,
                            math.rad(90),
                            0
                        )
                end

                if RightWeld then
                    RightWeld.C0 =
                        CFrame.new(
                            0.48,
                            0.15 + Bounce,
                            -0.58
                        )
                        * CFrame.Angles(
                            0,
                            math.rad(90),
                            0
                        )
                end
            end

            --================================================
            -- SPEED
            --================================================

            if Sprinting then
                Humanoid.WalkSpeed =
                    CONFIG.SprintSpeed
            else
                Humanoid.WalkSpeed =
                    CONFIG.NormalSpeed
            end

            --================================================
            -- CAMERA BOB
            --================================================

            if Moving and not Attacking then

                local Bob =
                    math.sin(Sine * 2.2)
                    * math.clamp(Speed, 0, 1)
                    * 0.03

                local Camera =
                    workspace.CurrentCamera

                if Camera then
                    Camera.CFrame =
                        Camera.CFrame
                        * CFrame.new(0, Bob, 0)
                end
            end
        end)
    )

    --====================================================
    -- INPUT
    --====================================================

    table.insert(
        Connections,
        UserInputService.InputBegan:Connect(
            function(Input, Processed)

                if Processed then
                    return
                end

                -- Shift = sprint
                if Input.KeyCode == Enum.KeyCode.LeftShift
                    or Input.KeyCode == Enum.KeyCode.RightShift then

                    Sprinting = true
                end

                -- M = meow
                if Input.KeyCode == Enum.KeyCode.M then

                    PlaySound(
                        912038643,
                        Head,
                        1,
                        math.random(90, 110) / 100
                    )
                end

                -- F = claw toggle
                if Input.KeyCode == Enum.KeyCode.F then

                    if LeftClaw and RightClaw then

                        local Active =
                            LeftClaw:GetAttribute(
                                "Active"
                            ) == true

                        Active = not Active

                        LeftClaw:SetAttribute(
                            "Active",
                            Active
                        )

                        RightClaw:SetAttribute(
                            "Active",
                            Active
                        )

                        local ClawColor =
                            Active
                            and Color3.fromRGB(255, 80, 80)
                            or CONFIG.ClawColor

                        LeftClaw.Color = ClawColor
                        RightClaw.Color = ClawColor

                        if Active then
                            PlaySound(
                                911882856,
                                Head,
                                0.7,
                                1
                            )
                        end
                    end
                end

                -- Z = attack
                if Input.KeyCode == Enum.KeyCode.Z then
                    if CONFIG.EnableCombat then
                        PerformAttack()
                    end
                end
            end
        )
    )

    table.insert(
        Connections,
        UserInputService.InputEnded:Connect(
            function(Input)

                if Input.KeyCode == Enum.KeyCode.LeftShift
                    or Input.KeyCode == Enum.KeyCode.RightShift then

                    Sprinting = false
                end
            end
        )
    )

    --====================================================
    -- MOUSE ATTACK
    --====================================================

    table.insert(
        Connections,
        UserInputService.InputBegan:Connect(
            function(Input, Processed)

                if Processed then
                    return
                end

                if Input.UserInputType ==
                    Enum.UserInputType.MouseButton1 then

                    if CONFIG.EnableCombat then
                        PerformAttack()
                    end
                end
            end
        )
    )
end

--========================================================
-- CHARACTER LIFECYCLE
--========================================================

Player.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter

    task.wait(0.5)

    SetupNeko()
end)

Player.CharacterRemoving:Connect(function()
    CleanupNeko()
end)

--========================================================
-- INITIALIZE
--========================================================

if Player.Character then
    task.spawn(function()
        SetupNeko()
    end)
end

print("Neko V5 loaded.")
