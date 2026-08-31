

-------------------------------------------------
-- SERVICES
-------------------------------------------------

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

-------------------------------------------------
-- HELPER
-------------------------------------------------

local function New(ClassName, Parent, Name, Data)
    local Object = Instance.new(ClassName)

    for Index, Value in pairs(Data or {}) do
        Object[Index] = Value
    end

    Object.Name = Name
    Object.Parent = Parent

    return Object
end

-------------------------------------------------
-- CHARACTER
-------------------------------------------------

local Character = Workspace:WaitForChild("non", 10)

if not Character then
    warn("Character 'non' was not found.")
    return
end

local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local la = Character:FindFirstChild("Left Arm")
local ra = Character:FindFirstChild("Right Arm")
local ll = Character:FindFirstChild("Left Leg")
local rl = Character:FindFirstChild("Right Leg")
local Torso = Character:FindFirstChild("Torso")
local Head = Character:FindFirstChild("Head")
local RootPart = Character:FindFirstChild("HumanoidRootPart")
local Animate = Character:FindFirstChild("Animate")

if not Humanoid
    or not la
    or not ra
    or not ll
    or not rl
    or not Torso
    or not Head
    or not RootPart then

    warn("Required character parts are missing.")
    return
end

if Animate then
    Animate.Disabled = true
end

local Animator = Humanoid:FindFirstChildOfClass("Animator")

if Animator then
    Animator:Destroy()
end

local Mouse = Player:GetMouse()

-------------------------------------------------
-- STAFF
-------------------------------------------------

local Staff = New("Model", Character, "Staff", {})

local Handle = New("Part", Staff, "Handle", {
    BrickColor = BrickColor.new("Really black"),
    Material = Enum.Material.Wood,
    Shape = Enum.PartType.Cylinder,
    Size = Vector3.new(4.69999981, 0.200000003, 0.300000042),
    CFrame = CFrame.new(
        0.57149899,
        1.88927495,
        -0.898910999,
        -0.944701791,
        0.319970548,
        -0.0718207732,
        -0.327606022,
        -0.930582702,
        0.163368165,
        -0.0145623889,
        0.177864254,
        0.983946562
    ),
    CanCollide = false,
    BottomSurface = Enum.SurfaceType.Smooth,
    TopSurface = Enum.SurfaceType.Smooth,
    Color = Color3.new(0.454902, 0.52549, 0.615686)
})

local Part1 = New("Part", Staff, "Part1", {
    BrickColor = BrickColor.new("Really black"),
    Material = Enum.Material.Wood,
    Shape = Enum.PartType.Cylinder,
    Size = Vector3.new(1.38, 0.200000003, 0.300000042),
    CFrame = CFrame.new(
        2.87910843,
        2.26322985,
        -0.792562008,
        -0.952355325,
        -0.29641813,
        -0.0718205795,
        0.281945944,
        -0.945417762,
        0.163367048,
        -0.116327964,
        0.135336339,
        0.983944893
    ),
    CanCollide = false,
    BottomSurface = Enum.SurfaceType.Smooth,
    TopSurface = Enum.SurfaceType.Smooth,
    Color = Color3.new(0.454902, 0.52549, 0.615686)
})

New("Motor", Part1, "mot", {
    Part0 = Part1,
    Part1 = Handle,
    C0 = CFrame.new(
        0, 0, 0,
        -0.952353716,
        0.281943917,
        -0.116327204,
        -0.296420157,
        -0.945419192,
        0.135335654,
        -0.0718207732,
        0.163368165,
        0.983946562
    ),
    C1 = CFrame.new(
        -2.30406189,
        0.409280896,
        -1.1920929e-007,
        -0.944701791,
        -0.327606022,
        -0.0145623889,
        0.319970548,
        -0.930582702,
        0.177864254,
        -0.0718207732,
        0.163368165,
        0.983946562
    )
})

local Part2 = New("Part", Staff, "Part2", {
    BrickColor = BrickColor.new("Really black"),
    Material = Enum.Material.Wood,
    Shape = Enum.PartType.Cylinder,
    Size = Vector3.new(0.699999809, 0.200000003, 0.300000042),
    CFrame = CFrame.new(
        3.80125666,
        2.18647099,
        -0.712507248,
        -0.94470191,
        0.319973052,
        -0.0718205795,
        -0.327603519,
        -0.930582702,
        0.163367048,
        -0.014562604,
        0.177865237,
        0.983944893
    ),
    CanCollide = false,
    BottomSurface = Enum.SurfaceType.Smooth,
    TopSurface = Enum.SurfaceType.Smooth,
    Color = Color3.new(0.454902, 0.52549, 0.615686)
})

New("Motor", Part2, "mot", {
    Part0 = Part2,
    Part1 = Handle,
    C0 = CFrame.new(
        0, 0, 0,
        -0.944701791,
        -0.327606022,
        -0.0145623889,
        0.319970548,
        -0.930582702,
        0.177864254,
        -0.0718207732,
        0.163368165,
        0.983946562
    ),
    C1 = CFrame.new(
        -3.15123606,
        0.790008068,
        0,
        -0.944701791,
        -0.327606022,
        -0.0145623889,
        0.319970548,
        -0.930582702,
        0.177864254,
        -0.0718207732,
        0.163368165,
        0.983946562
    )
})

local Part3 = New("Part", Staff, "Part3", {
    BrickColor = BrickColor.new("Really black"),
    Material = Enum.Material.Wood,
    Shape = Enum.PartType.Cylinder,
    Size = Vector3.new(0.899999797, 0.200000003, 0.300000042),
    CFrame = CFrame.new(
        4.27721882,
        2.67641687,
        -0.759113848,
        -0.426075667,
        0.901833594,
        -0.0718205795,
        -0.896977842,
        -0.41077888,
        0.163367048,
        0.117829539,
        0.134031072,
        0.983944893
    ),
    CanCollide = false,
    BottomSurface = Enum.SurfaceType.Smooth,
    TopSurface = Enum.SurfaceType.Smooth,
    Color = Color3.new(0.454902, 0.52549, 0.615686)
})

New("Motor", Part3, "mot", {
    Part0 = Part3,
    Part1 = Handle,
    C0 = CFrame.new(
        0, 0, 0,
        -0.426077485,
        -0.896979511,
        0.117828958,
        0.901831865,
        -0.410777032,
        0.134030208,
        -0.0718207732,
        0.163368165,
        0.983946562
    ),
    C1 = CFrame.new(
        -3.76071024,
        0.4780761,
        -4.17232513e-007,
        -0.944701791,
        -0.327606022,
        -0.0145623889,
        0.319970548,
        -0.930582702,
        0.177864254,
        -0.0718207732,
        0.163368165,
        0.983946562
    )
})

local Part4 = New("Part", Staff, "Part4", {
    BrickColor = BrickColor.new("Really black"),
    Material = Enum.Material.Wood,
    Shape = Enum.PartType.Cylinder,
    Size = Vector3.new(0.899999797, 0.200000003, 0.300000042),
    CFrame = CFrame.new(
        4.18060207,
        3.31991601,
        -0.873009622,
        0.663661063,
        0.744579256,
        -0.0718205795,
        -0.728600919,
        0.665168226,
        0.163367048,
        0.169415876,
        -0.0560925454,
        0.983944893
    ),
    CanCollide = false,
    BottomSurface = Enum.SurfaceType.Smooth,
    TopSurface = Enum.SurfaceType.Smooth,
    Color = Color3.new(0.454902, 0.52549, 0.615686)
})

New("Motor", Part4, "mot", {
    Part0 = Part4,
    Part1 = Handle,
    C0 = CFrame.new(
        0, 0, 0,
        0.663658738,
        -0.728599966,
        0.169414878,
        0.74458015,
        0.665170491,
        -0.0560923368,
        -0.0718207732,
        0.163368165,
        0.983946562
    ),
    C1 = CFrame.new(
        -3.87859344,
        -0.171925187,
        -8.94069672e-007,
        -0.944701791,
        -0.327606022,
        -0.0145623889,
        0.319970548,
        -0.930582702,
        0.177864254,
        -0.0718207732,
        0.163368165,
        0.983946562
    )
})

local Snowball = New("Part", Staff, "Snowball", {
    BrickColor = BrickColor.new("Really red"),
    Material = Enum.Material.Neon,
    Shape = Enum.PartType.Ball,
    Size = Vector3.new(0.400000006, 0.400000006, 0.400000006),
    CFrame = CFrame.new(
        3.51262951,
        2.90919495,
        -0.85357672,
        0.319973052,
        0.94470191,
        -0.0718205795,
        -0.930582702,
        0.327603519,
        0.163367048,
        0.177865237,
        0.014562604,
        0.983944893
    ),
    CanCollide = false,
    BottomSurface = Enum.SurfaceType.Smooth,
    TopSurface = Enum.SurfaceType.Smooth,
    Color = Color3.new(0.686275, 0.866667, 1)
})

New("PointLight", Snowball, "PointLight", {
    Color = Color3.new(0.741176, 1, 1),
    Brightness = 6,
    Range = 7,
    Shadows = true
})

New("Motor", Snowball, "mot", {
    Part0 = Snowball,
    Part1 = Handle,
    C0 = CFrame.new(
        0, 0, 0,
        0.319970548,
        -0.930582702,
        0.177864254,
        0.94470191,
        0.327606022,
        0.0145623889,
        -0.0718207732,
        0.163368165,
        0.983946562
    ),
    C1 = CFrame.new(
        -3.11328602,
        1.10864639e-005,
        -4.64916229e-006,
        -0.944701791,
        -0.327606022,
        -0.0145623889,
        0.319970548,
        -0.930582702,
        0.177864254,
        -0.0718207732,
        0.163368165,
        0.983946562
    )
})

-------------------------------------------------
-- LIMB WELDS
-------------------------------------------------

local LimbAccess = {
    LA = true,
    RA = true,
    LL = true,
    RL = true,
    RJ = true,
    NJ = true,
    Weapon = true
}

local State = "Lounge"
local Active = true
local Mode = "Staff"

local function Lerp(a, b, i)
    return a:Lerp(b, i)
end

local Left_Arm = Instance.new("Weld")
Left_Arm.Part0 = Torso
Left_Arm.Part1 = la
Left_Arm.Name = "LeftArmJ"
Left_Arm.C0 = CFrame.new(-1.5, 0.5, 0)
Left_Arm.C1 = CFrame.new(0, 0.5, 0)
Left_Arm.Parent = Torso

local Right_Arm = Instance.new("Weld")
Right_Arm.Part0 = Torso
Right_Arm.Part1 = ra
Right_Arm.Name = "RightArmJ"
Right_Arm.C0 = CFrame.new(1.5, 0.5, 0)
Right_Arm.C1 = CFrame.new(0, 0.5, 0)
Right_Arm.Parent = Torso

local Left_Leg = Instance.new("Weld")
Left_Leg.Part0 = Torso
Left_Leg.Part1 = ll
Left_Leg.Name = "LeftLegJ"
Left_Leg.C0 = CFrame.new(-0.5, -1, 0)
Left_Leg.C1 = CFrame.new(0, 1, 0)
Left_Leg.Parent = Torso

local Right_Leg = Instance.new("Weld")
Right_Leg.Name = "RightLegJ"
Right_Leg.Part0 = Torso
Right_Leg.Part1 = rl
Right_Leg.C0 = CFrame.new(0.5, -1, 0)
Right_Leg.C1 = CFrame.new(0, 1, 0)
Right_Leg.Parent = Torso

local Staffw = Instance.new("Weld")
Staffw.Part0 = Torso
Staffw.Part1 = Handle
Staffw.Name = "StaffJoint"
Staffw.Parent = Torso

local RootJoint = Instance.new("Weld")
RootJoint.Name = "RootJ"
RootJoint.Part0 = RootPart
RootJoint.Part1 = Torso
RootJoint.Parent = RootPart

local NeckJ = Instance.new("Weld")
NeckJ.Name = "NeckJ"
NeckJ.Part0 = Torso
NeckJ.Part1 = Head
NeckJ.C1 = CFrame.new(0, -1.5, 0)
NeckJ.Parent = Torso

-------------------------------------------------
-- STATE
-------------------------------------------------

_G.MoveCheck1 = false
_G.SatanState = false

-------------------------------------------------
-- SPELL BINDER
-------------------------------------------------

local function SpellBinder(SpellID)

    if _G.MoveCheck1 then
        return
    end

    _G.MoveCheck1 = true

    if not _G.SatanState then

        _G.SatanState = true

        _G.SpellBindStuff = 0

        _G.SpellBind = game:GetObjects(
            "rbxassetid://437368177"
        )[1]

        if not _G.SpellBind then
            _G.MoveCheck1 = false
            _G.SatanState = false
            return
        end

        if _G.SpellBind:FindFirstChild("Decal") then
            _G.SpellBind.Decal.Texture =
                "rbxassetid://" .. SpellID
        end

        if _G.SpellBind:FindFirstChild("Decal1") then
            _G.SpellBind.Decal1.Texture =
                "rbxassetid://" .. SpellID
        end

        _G.SpellBind.Parent = Character

        local torso = Character:FindFirstChild("Torso")

        if not torso then
            _G.MoveCheck1 = false
            _G.SatanState = false
            return
        end

        _G.SpellBind.CFrame =
            torso.CFrame - torso.CFrame.LookVector * 35

        _G.SpellBind.CFrame =
            CFrame.new(
                _G.SpellBind.Position,
                torso.Position
            ) * CFrame.Angles(1.6, 0, 0)

        local emitter = _G.SpellBind:FindFirstChild("ParticleEmitter")

        if emitter then
            emitter.Color =
                ColorSequence.new(
                    Color3.fromRGB(255, 0, 0)
                )

            emitter.Size =
                NumberSequence.new(5)
        end

        _G.UnsealEnforca = RunService.RenderStepped:Connect(function()

            if not _G.SpellBind
                or not _G.SpellBind.Parent then
                return
            end

            local currentTorso =
                Character:FindFirstChild("Torso")

            if not currentTorso then
                return
            end

            _G.SpellBind.CFrame =
                currentTorso.CFrame +
                currentTorso.CFrame.LookVector * 35

            _G.SpellBind.CFrame =
                CFrame.new(
                    _G.SpellBind.Position,
                    currentTorso.Position
                ) * CFrame.Angles(
                    1.6,
                    _G.SpellBindStuff,
                    0
                )

            _G.SpellBindStuff += 0.012
        end)

        for i = 1, 117 do
            if not _G.SpellBind then
                break
            end

            _G.SpellBind.Size +=
                Vector3.new(0.50, 0, 0.50)

            task.wait(0.07)
        end

        task.wait(0.1)

        if _G.chatcustom then
            _G.chatcustom(
                "You shall not pass!",
                "Really red",
                Player
            )
        end

        _G.MoveCheck1 = false

    else

        task.wait(0.6)

        if _G.SpellBind then

            for i = 1, 117 do
                if not _G.SpellBind then
                    break
                end

                _G.SpellBind.Size -=
                    Vector3.new(0.50, 0, 0.50)

                task.wait(0.07)
            end
        end

        if _G.UnsealEnforca then
            _G.UnsealEnforca:Disconnect()
            _G.UnsealEnforca = nil
        end

        if _G.SpellBind then
            _G.SpellBind.Parent = _G.newParent
        end

        task.wait(0.1)

        _G.SatanState = false
        _G.MoveCheck1 = false
    end
end

-------------------------------------------------
-- KEYBINDS
-------------------------------------------------

_G.ConnectionAgent = Mouse.KeyDown:Connect(function(key)

    if not Active then
        return
    end

    key = string.lower(key)

    if key == "q" then

        if State == "Flying" then

            State = "Lounge"
            Humanoid.WalkSpeed = 30

        elseif State == "Lounge" then

            State = "Battle"
            Humanoid.WalkSpeed = 20

        elseif State == "Battle" then

            State = "Flying"
            Humanoid.WalkSpeed = 50
        end

    elseif key == "e" then

        if State == "Battle" then
            SpellBinder(375165574)
        end
    end
end)

-------------------------------------------------
-- DEATH CLEANUP
-------------------------------------------------

Humanoid.Died:Connect(function()

    Active = false

    if _G.ConnectionAgent then
        _G.ConnectionAgent:Disconnect()
        _G.ConnectionAgent = nil
    end

    if _G.UnsealEnforca then
        _G.UnsealEnforca:Disconnect()
        _G.UnsealEnforca = nil
    end
end)

-------------------------------------------------
-- ANIMATION
-------------------------------------------------

local angle = 0
local angle2 = 0
local angle3 = 0

local anglespeed = 2
local anglespeed2 = 1
local anglespeed3 = 0.4

RunService.Stepped:Connect(function()

    if not Character
        or not Character.Parent
        or not Humanoid
        or Humanoid.Health <= 0 then
        return
    end

    angle =
        ((angle % 100) + anglespeed / 10)

    angle2 =
        ((angle2 % 100) + anglespeed2 / 10)

    angle3 =
        ((angle3 % 100) + anglespeed3 / 10)

    local velocity =
        Torso.AssemblyLinearVelocity

    local horizontalSpeed =
        Vector3.new(
            velocity.X,
            0,
            velocity.Z
        ).Magnitude

    -------------------------------------------------
    -- FLYING IDLE
    -------------------------------------------------

    if horizontalSpeed < 2
        and State == "Flying" then

        if Humanoid.WalkSpeed ~= 50 then
            Humanoid.WalkSpeed = 50
        end

        if LimbAccess.RJ then
            RootJoint.C0 = Lerp(
                RootJoint.C0,
                CFrame.new(
                    -0.5,
                    0.5 + math.sin(angle2) * 0.1,
                    0
                ) *
                CFrame.Angles(
                    math.sin(angle3) * 0.02,
                    math.rad(90),
                    0
                ),
                0.2
            )
        end

        if LimbAccess.LA then
            Left_Arm.C0 = Lerp(
                Left_Arm.C0,
                CFrame.new(-1.2, 0.35, 0) *
                CFrame.Angles(
                    math.rad(-25) + math.sin(angle3) * 0.06,
                    math.sin(angle3) * 0.06,
                    math.sin(angle3) * 0.06
                ),
                0.1
            )
        end

        if LimbAccess.NJ then
            NeckJ.C0 = Lerp(
                NeckJ.C0,
                CFrame.Angles(
                    math.sin(-angle3) * 0.04,
                    math.rad(-45) + math.sin(-angle3) * 0.04,
                    0
                ),
                0.25
            )
        end

        if LimbAccess.RA then
            Right_Arm.C0 = Lerp(
                Right_Arm.C0,
                CFrame.new(1.5, 0.5, 0) *
                CFrame.Angles(
                    math.rad(-25) + math.sin(angle3) * 0.06,
                    math.sin(angle3) * 0.06,
                    math.rad(-5) + math.sin(angle3) * 0.06
                ),
                0.1
            )
        end

        if LimbAccess.LL then
            Left_Leg.C0 = Lerp(
                Left_Leg.C0,
                CFrame.new(
                    -0.5,
                    math.sin(angle3) * 0.1 - 0.6,
                    -0.2
                ) *
                CFrame.Angles(
                    math.rad(35) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(-5)
                ),
                0.1
            )
        end

        if LimbAccess.RL then
            Right_Leg.C0 = Lerp(
                Right_Leg.C0,
                CFrame.new(
                    0.5,
                    math.sin(angle3) * 0.1 - 0.7,
                    -0.1
                ) *
                CFrame.Angles(
                    math.rad(45) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(5)
                ),
                0.1
            )
        end

        if LimbAccess.Weapon then
            Staffw.C0 = Lerp(
                Staffw.C0,
                CFrame.new(0, -1, 0),
                0.2
            )

            Staffw.C1 = Lerp(
                Staffw.C1,
                CFrame.new(0, 0, -0.4) *
                CFrame.Angles(
                    math.rad(180),
                    math.rad(180),
                    0
                ),
                0.2
            )
        end

    -------------------------------------------------
    -- FLYING WALK
    -------------------------------------------------

    elseif horizontalSpeed >= 2
        and State == "Flying" then

        if LimbAccess.RJ then
            RootJoint.C0 = Lerp(
                RootJoint.C0,
                CFrame.new(
                    -0.5,
                    0.5 + math.sin(angle2) * 0.1,
                    0
                ) *
                CFrame.Angles(
                    math.sin(angle3) * 0.02,
                    math.rad(90),
                    0
                ),
                0.2
            )
        end

        if LimbAccess.LA then
            Left_Arm.C0 = Lerp(
                Left_Arm.C0,
                CFrame.new(-1.2, 0.35, 0) *
                CFrame.Angles(
                    math.rad(-25) + math.sin(angle3) * 0.06,
                    math.sin(angle3) * 0.06,
                    math.rad(7) + math.sin(angle3) * 0.06
                ),
                0.1
            )
        end

        if LimbAccess.NJ then
            NeckJ.C0 = Lerp(
                NeckJ.C0,
                CFrame.Angles(
                    math.sin(-angle3) * 0.04,
                    math.rad(-45) + math.sin(-angle3) * 0.04,
                    0
                ),
                0.25
            )
        end

        if LimbAccess.RA then
            Right_Arm.C0 = Lerp(
                Right_Arm.C0,
                CFrame.new(1.5, 0.5, 0) *
                CFrame.Angles(
                    math.rad(-25) + math.sin(angle3) * 0.06,
                    math.sin(angle3) * 0.06,
                    math.rad(-5) + math.sin(angle3) * 0.06
                ),
                0.1
            )
        end

        if LimbAccess.LL then
            Left_Leg.C0 = Lerp(
                Left_Leg.C0,
                CFrame.new(
                    -0.5,
                    math.sin(angle3) * 0.1 - 0.6,
                    -0.2
                ) *
                CFrame.Angles(
                    math.rad(35) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(-5)
                ),
                0.1
            )
        end

        if LimbAccess.RL then
            Right_Leg.C0 = Lerp(
                Right_Leg.C0,
                CFrame.new(
                    0.5,
                    math.sin(angle3) * 0.1 - 0.7,
                    -0.1
                ) *
                CFrame.Angles(
                    math.rad(45) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(5)
                ),
                0.1
            )
        end

        if LimbAccess.Weapon then
            Staffw.C0 = Lerp(
                Staffw.C0,
                CFrame.new(0, -1, 0),
                0.2
            )

            Staffw.C1 = Lerp(
                Staffw.C1,
                CFrame.new(0, 0, -0.4) *
                CFrame.Angles(
                    math.rad(180),
                    math.rad(180),
                    0
                ),
                0.2
            )
        end

    -------------------------------------------------
    -- LOUNGE IDLE
    -------------------------------------------------

    elseif horizontalSpeed < 2
        and State == "Lounge" then

        if Humanoid.WalkSpeed ~= 30 then
            Humanoid.WalkSpeed = 30
        end

        if LimbAccess.RJ then
            RootJoint.C0 = Lerp(
                RootJoint.C0,
                CFrame.new(-0.5, 0, 0) *
                CFrame.Angles(
                    math.sin(angle3) * 0.02,
                    0,
                    0
                ),
                0.2
            )
        end

        if LimbAccess.LA then
            Left_Arm.C0 = Lerp(
                Left_Arm.C0,
                CFrame.new(-1.5, 0.5, 0) *
                CFrame.Angles(
                    math.rad(5) + math.sin(angle3) * 0.06,
                    math.sin(angle3) * 0.06,
                    math.rad(-3) + math.sin(angle3) * 0.06
                ),
                0.1
            )
        end

        if LimbAccess.NJ then
            NeckJ.C0 = Lerp(
                NeckJ.C0,
                CFrame.Angles(
                    math.sin(-angle3) * 0.04,
                    math.sin(-angle3) * 0.04,
                    0
                ),
                0.25
            )
        end

        if LimbAccess.RA then
            Right_Arm.C0 = Lerp(
                Right_Arm.C0,
                CFrame.new(1.5, 0.5, 0) *
                CFrame.Angles(
                    math.rad(5) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(3)
                ),
                0.1
            )
        end

        if LimbAccess.LL then
            Left_Leg.C0 = Lerp(
                Left_Leg.C0,
                CFrame.new(-0.5, -1, 0) *
                CFrame.Angles(
                    0,
                    0,
                    math.rad(-5) + math.sin(angle3) * 0.02
                ),
                0.1
            )
        end

        if LimbAccess.RL then
            Right_Leg.C0 = Lerp(
                Right_Leg.C0,
                CFrame.new(0.5, -1, 0) *
                CFrame.Angles(
                    0,
                    0,
                    math.rad(15) - math.sin(angle3) * 0.02
                ),
                0.1
            )
        end

        if LimbAccess.Weapon then
            Staffw.C0 = Lerp(
                Staffw.C0,
                CFrame.new(0, 0, 0.5),
                0.2
            )

            Staffw.C1 = Lerp(
                Staffw.C1,
                CFrame.Angles(
                    math.rad(180),
                    math.rad(180),
                    math.rad(-45)
                ),
                0.2
            )
        end

    -------------------------------------------------
    -- LOUNGE WALK
    -------------------------------------------------

    elseif horizontalSpeed >= 2
        and State == "Lounge" then

        if LimbAccess.RJ then
            RootJoint.C0 = Lerp(
                RootJoint.C0,
                CFrame.new(
                    -0.2,
                    math.sin(angle2) * 0.1,
                    0
                ),
                0.2
            )
        end

        if LimbAccess.LA then
            Left_Arm.C0 = Lerp(
                Left_Arm.C0,
                CFrame.new(-1.5, 0.5, 0) *
                CFrame.Angles(
                    math.rad(5) + math.sin(angle3) * 0.06,
                    math.sin(angle3) * 0.06,
                    math.rad(-23) + math.sin(angle3) * 0.06
                ),
                0.1
            )
        end

        if LimbAccess.NJ then
            NeckJ.C0 = Lerp(
                NeckJ.C0,
                CFrame.Angles(
                    math.sin(-angle3) * 0.04,
                    math.sin(-angle3) * 0.04,
                    0
                ),
                0.25
            )
        end

        if LimbAccess.RA then
            Right_Arm.C0 = Lerp(
                Right_Arm.C0,
                CFrame.new(1.5, 0.5, 0) *
                CFrame.Angles(
                    math.rad(5) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(23)
                ),
                0.1
            )
        end

        if LimbAccess.LL then
            Left_Leg.C0 = Lerp(
                Left_Leg.C0,
                CFrame.new(
                    -0.5,
                    math.sin(angle3) * 0.1 - 0.6,
                    -0.2
                ) *
                CFrame.Angles(
                    math.rad(-15) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(-5)
                ),
                0.1
            )
        end

        if LimbAccess.RL then
            Right_Leg.C0 = Lerp(
                Right_Leg.C0,
                CFrame.new(
                    0.5,
                    math.sin(angle3) * 0.1 - 0.7,
                    -0.1
                ) *
                CFrame.Angles(
                    math.rad(-15) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(5)
                ),
                0.1
            )
        end

        if LimbAccess.Weapon then
            Staffw.C0 = Lerp(
                Staffw.C0,
                CFrame.new(0, 0, 0.5),
                0.2
            )

            Staffw.C1 = Lerp(
                Staffw.C1,
                CFrame.Angles(
                    math.rad(180),
                    math.rad(180),
                    math.rad(-45)
                ),
                0.2
            )
        end

    -------------------------------------------------
    -- BATTLE IDLE
    -------------------------------------------------

    elseif horizontalSpeed < 2
        and State == "Battle" then

        if Humanoid.WalkSpeed ~= 20 then
            Humanoid.WalkSpeed = 20
        end

        if LimbAccess.RJ then
            RootJoint.C0 = Lerp(
                RootJoint.C0,
                CFrame.new(
                    -0.5,
                    0.5 + math.sin(angle2) * 0.1,
                    0
                ),
                0.2
            )
        end

        if LimbAccess.LA then
            Left_Arm.C0 = Lerp(
                Left_Arm.C0,
                CFrame.new(-1.1, 0.5, -0.7) *
                CFrame.Angles(
                    math.rad(5),
                    math.rad(-135),
                    math.rad(-90)
                ),
                0.1
            )
        end

        if LimbAccess.NJ then
            NeckJ.C0 = Lerp(
                NeckJ.C0,
                CFrame.Angles(
                    math.sin(-angle3) * 0.04,
                    math.sin(-angle3) * 0.04,
                    0
                ),
                0.25
            )
        end

        if LimbAccess.RA then
            Right_Arm.C0 = Lerp(
                Right_Arm.C0,
                CFrame.new(1.1, 0.5, -0.7) *
                CFrame.Angles(
                    math.rad(5),
                    math.rad(135),
                    math.rad(90)
                ),
                0.1
            )
        end

        if LimbAccess.LL then
            Left_Leg.C0 = Lerp(
                Left_Leg.C0,
                CFrame.new(-0.5, -1, 0) *
                CFrame.Angles(
                    0,
                    0,
                    math.rad(-5) + math.sin(angle3) * 0.02
                ),
                0.1
            )
        end

        if LimbAccess.RL then
            Right_Leg.C0 = Lerp(
                Right_Leg.C0,
                CFrame.new(0.5, -1, 0) *
                CFrame.Angles(
                    0,
                    0,
                    math.rad(5) - math.sin(angle3) * 0.02
                ),
                0.1
            )
        end

        if LimbAccess.Weapon then
            Staffw.C0 = Lerp(
                Staffw.C0,
                CFrame.new(0, -0.5, -1),
                0.2
            )

            Staffw.C1 = Lerp(
                Staffw.C1,
                CFrame.new(0, 0.6, 0) *
                CFrame.Angles(
                    math.rad(90),
                    math.rad(180),
                    math.rad(-90)
                ),
                0.2
            )
        end

    -------------------------------------------------
    -- BATTLE WALK
    -------------------------------------------------

    elseif horizontalSpeed >= 2
        and State == "Battle" then

        if LimbAccess.RJ then
            RootJoint.C0 = Lerp(
                RootJoint.C0,
                CFrame.new(
                    -0.2,
                    0.5 + math.sin(angle2) * 0.1,
                    0
                ),
                0.2
            )
        end

        if LimbAccess.LA then
            Left_Arm.C0 = Lerp(
                Left_Arm.C0,
                CFrame.new(-0.9, 0.6, -0.8) *
                CFrame.Angles(
                    math.rad(5),
                    math.rad(-135),
                    math.rad(-90)
                ),
                0.1
            )
        end

        if LimbAccess.NJ then
            NeckJ.C0 = Lerp(
                NeckJ.C0,
                CFrame.Angles(
                    math.sin(-angle3) * 0.04,
                    math.sin(-angle3) * 0.04,
                    0
                ),
                0.25
            )
        end

        if LimbAccess.RA then
            Right_Arm.C0 = Lerp(
                Right_Arm.C0,
                CFrame.new(1.1, 0.4, -0.3) *
                CFrame.Angles(
                    math.rad(5),
                    math.rad(135),
                    math.rad(90)
                ),
                0.1
            )
        end

        if LimbAccess.LL then
            Left_Leg.C0 = Lerp(
                Left_Leg.C0,
                CFrame.new(
                    -0.5,
                    math.sin(angle3) * 0.1 - 0.7,
                    -0.2
                ) *
                CFrame.Angles(
                    math.rad(-15) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(-5)
                ),
                0.1
            )
        end

        if LimbAccess.RL then
            Right_Leg.C0 = Lerp(
                Right_Leg.C0,
                CFrame.new(
                    0.5,
                    math.sin(angle3) * 0.1 - 0.7,
                    -0.1
                ) *
                CFrame.Angles(
                    math.rad(-15) + math.sin(angle3) * 0.1,
                    0,
                    math.rad(5)
                ),
                0.1
            )
        end

        if LimbAccess.Weapon then
            Staffw.C0 = Lerp(
                Staffw.C0,
                CFrame.new(0.4, 0.5, -1),
                0.2
            )

            Staffw.C1 = Lerp(
                Staffw.C1,
                CFrame.new(0, 0.1, 0) *
                CFrame.Angles(
                    math.rad(135),
                    math.rad(120),
                    math.rad(-135)
                ),
                0.2
            )
        end

    -------------------------------------------------
    -- CHANGING
    -------------------------------------------------

    elseif horizontalSpeed < 2
        and State == "Changing" then

        if LimbAccess.RJ then
            RootJoint.C0 = Lerp(
                RootJoint.C0,
                CFrame.new(
                    -0.5,
                    0.5 + math.sin(angle2) * 0.1,
                    0
                ),
                0.2
            )
        end

        if LimbAccess.LA then
            Left_Arm.C0 = Lerp(
                Left_Arm.C0,
                CFrame.new(-1.3, 0.51, -0.7) *
                CFrame.Angles(
                    math.rad(5),
                    math.rad(-165),
                    math.rad(-90)
                ),
                0.1
            )
        end

        if LimbAccess.NJ then
            NeckJ.C0 = Lerp(
                NeckJ.C0,
                CFrame.Angles(
                    math.rad(-10),
                    math.sin(-angle3) * 0.04,
                    0
                ),
                0.25
            )
        end

        if LimbAccess.RA then
            Right_Arm.C0 = Lerp(
                Right_Arm.C0,
                CFrame.new(1.3, 0.49, -0.7) *
                CFrame.Angles(
                    math.rad(5),
                    math.rad(165),
                    math.rad(90)
                ),
                0.1
            )
        end

        if LimbAccess.LL then
            Left_Leg.C0 = Lerp(
                Left_Leg.C0,
                CFrame.new(-1, -1, -0.4) *
                CFrame.Angles(
                    0,
                    math.rad(25),
                    math.rad(75)
                ),
                0.1
            )
        end

        if LimbAccess.RL then
            Right_Leg.C0 = Lerp(
                Right_Leg.C0,
                CFrame.new(1, -1, -0.4) *
                CFrame.Angles(
                    0,
                    math.rad(-25),
                    math.rad(-75)
                ),
                0.1
            )
        end
    end
end)

-------------------------------------------------
-- DOORS ENTITY SPAWNER
-------------------------------------------------

local Spawner = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"
))()

local EntityList = {
    {
        Weight = 30,
        Data = {
            Name = "Depth",
            Asset = "https://github.com/MateiDaBest/Utilities/raw/refs/heads/main/Doors/Other/DepthMoving.rbxm",
            Speed = 100,
            Rebounds = 1
        }
    },

    {
        Weight = 30,
        Data = {
            Name = "STUPID HORSE",
            Asset = "https://github.com/MateiDaBest/Utilities/raw/refs/heads/main/Doors/Other/Stupid%20Horse.rbxm",
            Speed = 100,
            Rebounds = 1
        }
    },

    {
        Weight = 9,
        Data = {
            Name = "OG Ambush",
            Asset = "https://github.com/MateiDaBest/Utilities/raw/refs/heads/main/Doors/Other/AmbushMoving.rbxm",
            Speed = 100,
            Rebounds = math.random(2, 4)
        }
    },

    {
        Weight = 15,
        Data = {
            Name = "A-60",
            Asset = "https://github.com/Idk-lol2/a-60aa/blob/main/11379072534.rbxm?raw=true",
            Speed = 135,
            Rebounds = 0
        }
    }
}

local function Choose()

    local total = 0

    for _, v in ipairs(EntityList) do
        total += v.Weight
    end

    local pick = math.random() * total
    local current = 0

    for _, v in ipairs(EntityList) do

        current += v.Weight

        if pick <= current then
            return v.Data
        end
    end
end

local function Spawn()

    local E = Choose()

    if not E then
        return
    end

    Spawner.Create({

        Entity = {
            Name = E.Name,
            Asset = E.Asset,
            HeightOffset = 0
        },

        Lights = {
            Flicker = {
                Enabled = true,
                Duration = 3
            },

            Shatter = true,
            Repair = false
        },

        CameraShake = {
            Enabled = true,
            Range = 100,
            Values = {2, 20, 0.2, 1}
        },

        Movement = {
            Speed = E.Speed,
            Delay = 2,
            Reversed = false
        },

        Rebounding = {
            Enabled = E.Rebounds > 0,
            Type = "Ambush",
            Min = E.Rebounds,
            Max = E.Rebounds,
            Delay = 2
        },

        Damage = {
            Enabled = true,
            Range = 40,
            Amount = 125
        },

        Crucifixion = {
            Enabled = true,
            Range = 40,
            Resist = false,
            Break = true
        }

    }):Run()
end

-------------------------------------------------
-- SEEK FIX
-------------------------------------------------

local function ApplySeekFix(model)

    if not model then
        return
    end

    for _, obj in ipairs(model:GetDescendants()) do

        if obj:IsA("BasePart")
            or obj:IsA("Decal") then

            obj.Transparency = 1
        end
    end

    local Figure = game:GetObjects(
        "rbxassetid://17147503424"
    )[1]

    if not Figure then
        return
    end

    local Body = Figure:FindFirstChild("Body")

    if not Body then
        return
    end

    local Weld = Body:FindFirstChild("Weld")

    if not Weld then
        return
    end

    Weld.C0 =
        CFrame.new(0, 0, 0) *
        CFrame.Angles(0, math.rad(180), 0)

    local SeekRig = model:FindFirstChild("SeekRig")

    if SeekRig then

        local UpperTorso =
            SeekRig:FindFirstChild("UpperTorso")

        if UpperTorso then
            Weld.Part1 = UpperTorso
            Figure.Parent = SeekRig
        end
    end
end

task.spawn(function()

    for _, v in ipairs(Workspace:GetChildren()) do

        if v.Name == "SeekMoving"
            or v.Name == "SeekMovingNewClone" then

            ApplySeekFix(v)
        end
    end
end)

Workspace.ChildAdded:Connect(function(v)

    if v.Name == "SeekMoving"
        or v.Name == "SeekMovingNewClone" then

        task.wait(0.1)
        ApplySeekFix(v)
    end
end)

-------------------------------------------------
-- RAINBOW FIGURE
-------------------------------------------------

local function Rainbowify(model)

    local parts = {}

    for _, obj in ipairs(model:GetDescendants()) do

        if obj:IsA("BasePart") then
            table.insert(parts, obj)
        end
    end

    task.spawn(function()

        local t = 0

        while model and model.Parent do

            t += 0.02

            local color =
                Color3.fromHSV(t % 1, 1, 1)

            for _, part in ipairs(parts) do

                if part and part.Parent then
                    part.Color = color
                end
            end

            RunService.Heartbeat:Wait()
        end
    end)
end

local function Setup(room)

    local Figure =
        room:FindFirstChild("FigureSetup")

    if not Figure then
        return
    end

    local rig =
        Figure:FindFirstChild("FigureRig")

    if not rig then
        return
    end

    if rig:GetAttribute("FigureDone") then
        return
    end

    rig:SetAttribute("FigureDone", true)

    for _, obj in ipairs(rig:GetDescendants()) do

        if obj:IsA("BasePart")
            or obj:IsA("Decal") then

            obj.Transparency = 1
        end
    end

    local BigFigure = game:GetObjects(
        "rbxassetid://80300729404499"
    )[1]

    if not BigFigure then
        return
    end

    local Body = BigFigure:FindFirstChild("Body")

    if not Body then
        return
    end

    BigFigure.Parent = rig

    Rainbowify(BigFigure)

    task.spawn(function()

        while rig
            and rig.Parent
            and BigFigure
            and BigFigure.Parent do

            local TorsoPart =
                rig:FindFirstChild("Torso")

            if TorsoPart then
                Body.CFrame =
                    TorsoPart.CFrame *
                    CFrame.Angles(
                        0,
                        math.rad(180),
                        0
                    )
            end

            task.wait()
        end
    end)
end

task.spawn(function()

    local CurrentRooms =
        Workspace:WaitForChild("CurrentRooms")

    for _, room in ipairs(CurrentRooms:GetChildren()) do

        task.wait(0.1)
        Setup(room)
    end
end)

Workspace:WaitForChild("CurrentRooms").ChildAdded:Connect(
    function(room)

        task.wait(3)
        Setup(room)
    end
)

-------------------------------------------------
-- CARPET / EYES / SCREECH
-------------------------------------------------

local PINK =
    Color3.fromRGB(255, 80, 180)

local RED =
    Color3.fromRGB(180, 0, 0)

local SEEK_RED =
    Color3.fromRGB(150, 20, 20)

local CarpetColors = {

    Color3.fromRGB(95, 55, 20),
    Color3.fromRGB(120, 80, 25),
    Color3.fromRGB(110, 25, 25),
    Color3.fromRGB(90, 40, 10),
    Color3.fromRGB(140, 90, 20)
}

local function recolorCarpet(room)

    local color =
        CarpetColors[
            math.random(#CarpetColors)
        ]

    for _, v in ipairs(room:GetDescendants()) do

        local name =
            string.lower(v.Name)

        if string.find(name, "rug")
            or string.find(name, "carpet") then

            if v:IsA("BasePart") then
                v.Color = color
            end

            for _, obj in ipairs(v:GetDescendants()) do

                if obj:IsA("BasePart") then
                    obj.Color = color
                end
            end
        end
    end
end

local function applyColor(model, color)

    for _, v in ipairs(model:GetDescendants()) do

        if v:IsA("BasePart") then

            v.Color = color

        elseif v:IsA("Decal") then

            v.Color3 = color

        elseif v:IsA("Texture") then

            v.Color = color

        elseif v:IsA("ParticleEmitter") then

            v.Color =
                ColorSequence.new(color)

        elseif v:IsA("Beam")
            or v:IsA("Trail") then

            v.Color =
                ColorSequence.new(color)

        elseif v:IsA("Highlight") then

            v.FillColor = color
            v.OutlineColor = color

        elseif v:IsA("ImageLabel")
            or v:IsA("ImageButton") then

            v.ImageColor3 = color
        end
    end
end

local AnimatedEyes = {}

local function AnimateEyes(model)

    if AnimatedEyes[model] then
        return
    end

    AnimatedEyes[model] = true

    task.spawn(function()

        local t = 0

        while model and model.Parent do

            t += RunService.Heartbeat:Wait()

            local alpha =
                (math.sin(t * 2) + 1) / 2

            local color =
                PINK:Lerp(RED, alpha)

            applyColor(model, color)
        end

        AnimatedEyes[model] = nil
    end)
end

local function hookEntity(model)

    if not model:IsA("Model") then
        return
    end

    if model.Name == "Screech"
        or model.Name == "_Screech" then

        applyColor(model, PINK)

        model.DescendantAdded:Connect(function()

            task.wait()
            applyColor(model, PINK)
        end)
    end

    if model.Name == "SeekMoving"
        or model.Name == "SeekMovingNewClone" then

        applyColor(model, SEEK_RED)

        model.DescendantAdded:Connect(function()

            task.wait()
            applyColor(model, SEEK_RED)
        end)
    end

    if model.Name == "Eye"
        or model.Name == "Eyes" then

        AnimateEyes(model)

        model.DescendantAdded:Connect(function()

            task.wait()
            AnimateEyes(model)
        end)
    end
end

task.spawn(function()

    local CurrentRooms =
        Workspace:WaitForChild("CurrentRooms")

    for _, room in ipairs(CurrentRooms:GetChildren()) do
        recolorCarpet(room)
    end
end)

Workspace:WaitForChild("CurrentRooms").ChildAdded:Connect(
    function(room)

        task.wait(0.1)
        recolorCarpet(room)
    end
)

for _, obj in ipairs(Workspace:GetDescendants()) do
    hookEntity(obj)
end

Workspace.DescendantAdded:Connect(function(obj)
    hookEntity(obj)
end)

-------------------------------------------------
-- ATMOSPHERE
-------------------------------------------------

local Lighting =
    game:GetService("Lighting")

local Atmosphere =
    Instance.new("Atmosphere")

Atmosphere.Density = 0.75
Atmosphere.Parent = Lighting

-------------------------------------------------
-- NEON OVERRIDE
-------------------------------------------------

local NEON_COLOR =
    Color3.new(
        0.333333,
        0.666667,
        1
    )

local function applyNeon(obj)

    if obj:IsA("BasePart")
        and obj.Name == "Neon" then

        obj.Color = NEON_COLOR
    end
end

task.spawn(function()

    local rooms =
        Workspace:WaitForChild("CurrentRooms")

    for _, obj in ipairs(rooms:GetDescendants()) do
        applyNeon(obj)
    end
end)

Workspace:WaitForChild("CurrentRooms").DescendantAdded:Connect(
    function(obj)

        applyNeon(obj)
    end
)

-------------------------------------------------
-- WHITE WINDOWS / RED TO WHITE CHAIRS
-------------------------------------------------

local WINDOW_NAMES = {
    "Window",
    "Windows"
}

local CHAIR_NAME = "regal_chair"

local DARK_RED =
    Color3.fromRGB(80, 0, 0)

local WHITE =
    Color3.fromRGB(255, 255, 255)

local function lerpColor(part, t)

    if part and part.Parent then
        part.Color =
            DARK_RED:Lerp(WHITE, t)
    end
end

local function updateWindows()

    for _, obj in ipairs(Workspace:GetDescendants()) do

        if obj:IsA("BasePart") then

            if obj.Name == WINDOW_NAMES[1]
                or obj.Name == WINDOW_NAMES[2] then

                obj.Color = WHITE
                obj.Material =
                    Enum.Material.SmoothPlastic
            end
        end
    end
end

local function updateChairs()

    for _, obj in ipairs(Workspace:GetDescendants()) do

        if obj:IsA("BasePart")
            and obj.Name == CHAIR_NAME then

            task.spawn(function()

                if not obj or not obj.Parent then
                    return
                end

                for i = 0, 1, 0.05 do

                    if not obj or not obj.Parent then
                        return
                    end

                    lerpColor(obj, i)

                    task.wait(0.05)
                end

                if obj and obj.Parent then
                    obj.Material =
                        Enum.Material.SmoothPlastic
                end
            end)
        end
    end
end

task.spawn(function()

    while true do

        updateWindows()
        updateChairs()

        task.wait(2)
    end
end)

-------------------------------------------------
-- ENTITY SPAWN LOOP
-------------------------------------------------

task.spawn(function()

    while true do

        task.wait(90)

        pcall(function()
            Spawn()
        end)
    end
end)

-------------------------------------------------
-- DONE
-------------------------------------------------
