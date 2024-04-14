function GetDistance(q)
    if typeof(q) == "CFrame" then
        return game.Players.LocalPlayer:DistanceFromCharacter(q.Position)
    elseif typeof(q) == "Vector3" then
        return game.Players.LocalPlayer:DistanceFromCharacter(q)
    end
end
local ListNPC = {}

function GetNPCInTable(Table) 
    for k,v in Table do 
        if v:FindFirstChild("Head") then 
            if v.Head:FindFirstChild("QuestBBG") and v.Head.QuestBBG:FindFirstChild("Title") and v.Head.QuestBBG.Title.Text == "QUEST" then 
                ListNPC[v.Name] = v
            end
        end
    end
end
function GetNearestPartAB(startPos,Folder) 
    local Nearest
    for k,v in Folder:GetChildren() do 
        if not Nearest or (startPos - v.Position).magnitude < (startPos - Nearest.Position).magnitude then 
            Nearest = v
        end
    end
    return Nearest
end

local EnemyMidPoint = {}
local EnemyCount = {}
for k,v in workspace._WorldOrigin.EnemySpawns:GetChildren() do 
    if not EnemyMidPoint[v.Name] then 
        EnemyMidPoint[v.Name] = v.Position
        EnemyCount[v.Name] = 1
    else
        EnemyMidPoint[v.Name] = EnemyMidPoint[v.Name] + v.Position
        EnemyCount[v.Name] = EnemyCount[v.Name] + 1
    end
end
local EnemyPosition = {}
for k,v in EnemyMidPoint do 
    local MidPoint = v / EnemyCount[k]
    local NearestRegion = GetNearestPartAB(MidPoint,workspace._WorldOrigin.EnemyRegions)
    if NearestRegion then 
        EnemyPosition[k] = NearestRegion.CFrame
    end
end

function IsQuestEnable() 
    local s,e = pcall(function() 
        return game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
    end)
    if s then return e else return false end
end

GetNPCInTable(workspace.NPCs:GetChildren())
GetNPCInTable(getnilinstances())

local PSNPC = getscriptclosure(game.Players.LocalPlayer.PlayerScripts.NPC)
local listremote = {}
for k,v in debug.getprotos(PSNPC) do 
    if #debug.getconstants(v) == 1 then 
        table.insert(listremote,debug.getconstant(v, 1))    
    end
end
local start = false
local DialogueList = {}
for k,v in debug.getconstants(PSNPC) do
    if type(v) == "string" then 
        if v == "Players" then
            start = false
        end
        if not start then 
            if v == "Blox Fruit Dealer" then 
                start = true    
            end  
        end
        if start then 
            table.insert(DialogueList, v)    
        end
    end
end
local QuestModule = require(game.ReplicatedStorage.Quests)
local QuestData = {}
for QuestName,v in QuestModule do  
    if not string.match(QuestName,"MarineQuest") then 
        for k,v in v do 
            for k2,v2 in v.Task do 
                if v2 ~= 1 then 
                    QuestData[v.LevelReq] = {
                        Quest = QuestName,
                        Mob = k2,
                        LevelQuest = k
                    }
                end
            end
        end
    end
end
function GetCurrentQuest() 
    local Level = game.Players.LocalPlayer.Data.Level.Value
    local LevelQuest = -math.huge
    for k,v in QuestData do 
        if Level >= k then 
            if (Level - k) < (Level - LevelQuest) then 
                LevelQuest = k
            end
        end
    end
    return QuestData[LevelQuest]
end
function Buso()
    if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
    end
end
function RemoveLvTitle(mob)
    if type(mob) == "table" then
        for i,v in mob do
            mob = v:gsub(" %pLv. %d+%p", "")
        end
    else
        mob = mob:gsub(" %pLv. %d+%p", "")
    end
    return mob
end
local CurrentFarmQuest = GetCurrentQuest()
game.Players.LocalPlayer.Data.Level.Changed:Connect(function() 
    CurrentFarmQuest = GetCurrentQuest()
end)
function EquipTool(ToolSe)
    if va then
        return
    end
    if getgenv()["SelectTool"] == "" or getgenv()["SelectTool"] == nil then
        getgenv()["SelectTool"] = "Melee"
    end
    ToolSe = GetWeapon(getgenv()["SelectTool"])
    if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
        local bi = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
        wait(.4)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(bi)
    end
end
function GetWeapon(cc)
    stringcurrent = ""
    for i, v in game.Players.LocalPlayer.Backpack:GetChildren() do
        if v:IsA("Tool") and v.ToolTip == cc then
            stringcurrent = v.Name
        end
    end
    for i, v in game.Players.LocalPlayer.Character:GetChildren() do
        if v:IsA("Tool") and v.ToolTip == cc then
            stringcurrent = v.Name
        end
    end
    return stringcurrent
end
function CheckEnemySpawns(b)
    for i,v in game.Workspace._WorldOrigin.EnemySpawns:GetChildren() do
        if type(b) == "table" then
            if table.find(b, v.Name) then
                return v
            end
        else
            if v.Name == b then
                return v
            end
        end
    end
end
local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
CameraShaker:Stop()
function ToTween(Pos, Speed)
    if not Speed or Speed == nil then
        Speed = 300
    end
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart", 9)
    game.Players.LocalPlayer.Character:WaitForChild("Head", 9)
    if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Hold") then
        local Hold = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
        Hold.Name = "Hold"
        Hold.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        Hold.Velocity = Vector3.new(0, 0, 0)
    else
        game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Hold"):Destroy()
    end
    for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
    tween = game:GetService("TweenService"):Create(
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = Pos}
    )
    tween:Play()
end
function UnEquipTool(Wa)
    if game.Players.LocalPlayer.Character:FindFirstChild(Wa) then
        game.Players.LocalPlayer.Character:FindFirstChild(Wa).Parent = game.Players.LocalPlayer.Backpack
    end
end
function Click()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 1, 0, 1))
end
local GuideModule = require(game.ReplicatedStorage.GuideModule)
function NPCPos()
    for i,v in pairs(GuideModule["Data"]["NPCList"]) do
		if v["NPCName"] == GuideModule["Data"]["LastClosestNPC"] then
			return i["CFrame"]
		end
	end
end
function CheckMob(d)
    for i,v in game.Workspace.Enemies:GetChildren() do
        if type(d) == "table" then
            if table.find(d, v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                return v
            end
        else
            if v.Name == d and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                return v
            end
        end
    end
    for i,v in game.ReplicatedStorage:GetChildren() do
        if type(d) == "table" then
            if table.find(d, v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                return v
            end
        else
            if v.Name == d and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                return v
            end
        end
    end
end
function BringMobNear(cc)
    if type(cc) == "table" then
        for i,v in game.Workspace.Enemies:GetChildren() do
            if table.find(cc, v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 270 then
                v.HumanoidRootPart.CFrame = PosBring
                v.Humanoid.JumpPower = 0
                v.Humanoid.WalkSpeed = 0
                v.HumanoidRootPart.CanCollide = false
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                v.Humanoid:ChangeState(14)
            end
        end
    else
        for i,v in game.Workspace.Enemies:GetChildren() do
            if v.Name == cc and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 270 then
                v.HumanoidRootPart.CFrame = PosBring
                v.Humanoid.JumpPower = 0
                v.Humanoid.WalkSpeed = 0
                v.HumanoidRootPart.CanCollide = false
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                v.Humanoid:ChangeState(14)
            end
        end
    end
end
local LibLoader = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dextral-Code/lua/main/ui-library.lua"))()
local HirimiHub = LibLoader:MakeGui({NameHub = "Hirimi Hub", NameGam = "by !DestroyX", Icon = "rbxassetid://16410678154"})
local A = HirimiHub:CreateTab({Name = "Main", Icon = "rbxassetid://16410678154"})
A:AddDropdown({Title = "Tool", Multi = false, Options = {"Melee", "Sword"}, Default = "Melee",
	Callback = function(vTool)
		getgenv()["SelectTool"] = vTool
	end
})
A:AddSeperator("Options")
A:AddToggle({Title = "Auto Level", Content = "", Default = false, Callback = function(vFarmLevel)
    getgenv().Level = vFarmLevel
end
})
spawn(function()
    while task.wait() do
        if getgenv().Level then
            if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                local NameQ, ID = GetCurrentQuest().Quest, GetCurrentQuest().LevelQuest
                local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - NPCPos().Position).Magnitude
                local QuestTitle = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                if not string.find(QuestTitle, GetCurrentQuest().Mob) then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if Distance <= 20 then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQ, ID)
                else
                    ToTween(NPCPos())
                end
            else
                if game.Workspace.Enemies:FindFirstChild(GetCurrentQuest().Mob) then
                    for i,v in game.Workspace.Enemies:GetChildren() do
                        if v.Name == GetCurrentQuest().Mob then
                            repeat task.wait()
                                ToTween(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                EquipTool()
                                PosBring = v.HumanoidRootPart.CFrame
                                BringMobNear(v.Name)
                                Buso()
                                Click()
                            until not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 or not getgenv().Level
                            UnEquipTool(GetWeapon(getgenv()["SelectTool"]))
                        end
                    end
                else
                    if CheckEnemySpawns(GetCurrentQuest().Mob) then
                        local v = CheckEnemySpawns(GetCurrentQuest().Mob)
                        repeat task.wait()
                            ToTween(v.CFrame * CFrame.new(0,10,0))
                        until game.Workspace.Enemies:FindFirstChild(GetCurrentQuest().Mob) or not getgenv().Level
                    end
                end
            end
            if game.Players.LocalPlayer.Data.Points.Value >= 1 then
                local args = {[1] = "AddPoint", [2] = "Melee", [3] = 1}
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
            end
        end
    end
end)
A:AddDropdown({Title = "Fast Delay", Multi = false, Options = {"0.1","0.15","0.175","0.2", "0.9"}, Default = "0.175",
	Callback = function(vFastD)
		getgenv()["FastDelay"] = vFastD
	end
})
game:GetService("RunService").RenderStepped:Connect(function()
    if FastDelay == nil then
        FastDelay = 0.3
    elseif FastDelay == "0.1" then
        FastDelay = 0.11
    elseif FastDelay == "0.15" then
        FastDelay = 0.18
    elseif FastDelay == "0.175" then
        FastDelay = 0.3
    elseif FastDelay == "0.2" then
        FastDelay = 0.5
    elseif FastDelay == "0.9" then
        FastDelay = 2
    end
end)
A:AddToggle({Title = "Fast Attack", Content = "Attack Faster", Default = true, Callback = function(vFast)
    getgenv()["FastAttack"] = vFast
end
})
A:AddToggle({Title = "Auto Turn On V4", Content = "Auto Awakening V4 If Full Race Energy", Default = false, Callback = function(vT4)
    getgenv().V4 = vT4
end
})
spawn(function()
    while wait() do
        if getgenv().V4 then
            if game.Players.LocalPlayer.Character:FindFirstChild("RaceEnergy") and game.Players.LocalPlayer.Character.RaceEnergy.Value >= 1 and not game.Players.LocalPlayer.Character.RaceTransformed.Value then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game)
                task.wait()
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "Y", false, game)
            end        
        end
    end
end)
local CurveFrame = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework")))[2]
local VirtualUser = game:GetService("VirtualUser")
local RigControllerR = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework.RigController))[2]
local Client = game:GetService("Players").LocalPlayer
local DMG = require(Client.PlayerScripts.CombatFramework.Particle.Damage)
function CurveFuckWeapon()
    local p13 = CurveFrame.activeController
    if not p13 then
        return nil
    end
    
    local wea = p13.blades[1]
    if not wea then
        return nil
    end
    
    while wea.Parent ~= game.Players.LocalPlayer.Character do
        wea = wea.Parent
    end
    
    return wea
end

function getHits(Size)
    local Hits = {}
    
    local function processHumanoid(Human)
        if Human and Human.RootPart and Human.Health > 0 and game.Players.LocalPlayer:DistanceFromCharacter(Human.RootPart.Position) < Size + 5 then
            table.insert(Hits, Human.RootPart)
        end
    end

    for _, v in pairs(workspace.Enemies:GetChildren()) do
        processHumanoid(v:FindFirstChildOfClass("Humanoid"))
    end

    for _, v in pairs(workspace.Characters:GetChildren()) do
        if v ~= game.Players.LocalPlayer.Character then
            processHumanoid(v:FindFirstChildOfClass("Humanoid"))
        end
    end
    return Hits
end
function Boost()
    task.spawn(function()
        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", tostring(CurveFuckWeapon()))
    end)
end
function Unboost()
    task.spawn(function()
        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("unequipWeapon", tostring(CurveFuckWeapon()))
    end)
end
local cdnormal = 0
local Animation = Instance.new("Animation")
local CooldownFastAttack = 0
FastAttack = function()
    local ac = CurveFrame.activeController
    if ac and ac.equipped then
        task.spawn(function()
            if tick() - cdnormal > 0.5 then
                ac:attack()
                cdnormal = tick()
            else
                Animation.AnimationId = ac.anims.basic[2]
                ac.humanoid:LoadAnimation(Animation):Play(1, 1)
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", getHits(120), 2, "")
            end
        end)
    end
end
bs = tick()
task.spawn(function()
    while task.wait(getgenv()["FastDelay"]) do
        if getgenv()["FastAttack"] then
            FastI = true
            if bs - tick() > 0.75 then
                task.wait()
                bs = tick()
            end
            pcall(function()
                for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Humanoid.Health > 0 then
                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                            FastAttack()
                            task.wait()
                            Boost()
                            EClick()
                        end
                    end
                end
            end)
        end
    end
end)
k = tick()
task.spawn(function()
    if FastI then
        while task.wait(.2) do
            if k - tick() > 0.75 then
                task.wait()
                k = tick()
            end
            pcall(function()
                for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Humanoid.Health > 0 then
                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                            task.wait(.000025)
                            Unboost()
                        end
                    end
                end
            end)
        end
    end
end)
task.spawn(function()
    while task.wait() do
        if FastI then
            pcall(function()
                CurveFrame.activeController.timeToNextAttack = -1
                CurveFrame.activeController.focusStart = 0
                CurveFrame.activeController.hitboxMagnitude = 40
                CurveFrame.activeController.humanoid.AutoRotate = true
                CurveFrame.activeController.increment = 1 + 1 / 1
            end)
        end
    end
end)
EnableCurv = true
task.spawn(function()
    local a = game.Players.LocalPlayer
    local b = require(a.PlayerScripts.CombatFramework.Particle)
    local c = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
    if not shared.orl then
        shared.orl = c.wrapAttackAnimationAsync
    end
    if not shared.cpc then
        shared.cpc = b.play
    end
    if EnableCurv then
        pcall(function()
            c.wrapAttackAnimationAsync = function(d, e, f, g, h)
                local i = c.getBladeHits(e, f, g)
                if i then
                    b.play = function()
                    end
                    d:Play(0.25, 0.25, 0.25)
                    h(i)
                    b.play = shared.cpc
                    wait(.5)
                    d:Stop()
                end
            end
        end)
    end
end)
CombatFrameworkR = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework)
y = debug.getupvalues(CombatFrameworkR)[2]
spawn(function()
    while wait() do
        if getgenv()["FastAttack"] then
            if typeof(y) == "table" then
                pcall(function()
                    CameraShaker:Stop()
                    y.activeController.timeToNextAttack = (math.huge^math.huge^math.huge)
                    y.activeController.timeToNextAttack = -1
                    y.activeController.hitboxMagnitude = 60
                    y.activeController.active = false
                    y.activeController.timeToNextBlock = 0
                    y.activeController.focusStart = 1655503339.0980349
                    y.activeController.increment = 3
                    y.activeController.blocking = false
                    y.activeController.attacking = false
                    y.activeController.humanoid.AutoRotate = true
                end)
            end
        end
        if getgenv()["FastAttack"] then
            if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
                game.Players.LocalPlayer.Character.Stun.Value = 0
                game.Players.LocalPlayer.Character.Busy.Value = false        
            end
        end
    end
end)
A:AddToggle({Title = "Auto Bone", Content = "Kill Bone Mobs In Haunted Castle", Default = false, Callback = function(vBone)
    getgenv().Bone = vBone
end
})
spawn(function()
    while task.wait() do
        if getgenv().Bone then
            local table_BonesMob = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
            if CheckMob(table_BonesMob) then
                local Mob = CheckMob(table_BonesMob)
                repeat task.wait()
                    if getgenv().ClaimQuest then
                        if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Demonic Soul") then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                        end
                        if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                            ToTween(CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0))
                            if (LP.Character.HumanoidRootPart.Position - CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0).Position).Magnitude <= 5 then
                                local args = {[1] = "StartQuest", [2] = "HauntedQuest2", [3] = 1}
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                            end
                        elseif getgenv().ClaimQuest and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            ToTween(Mob.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                        end
                    else
                        ToTween(Mob.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                    end
                    EquipTool()
                    PosBring = Mob.HumanoidRootPart.CFrame
                    BringMobNear(Mob.Name)
                    Buso()
                    Click()
                until not getgenv().Bone or not Mob:FindFirstChild("Humanoid") or not Mob:FindFirstChild("HumanoidRootPart") or Mob.Humanoid.Health <= 0
                UnEquipTool(GetWeapon(getgenv()["SelectTool"]))
            else
                ToTween(CFrame.new(-9368.34765625, 222.10060119628906, 6239.904296875))
            end
        end
    end
end)
A:AddToggle({Title = "Auto Katakuri", Content = "Kill Cake Mobs In Candy Island", Default = false, Callback = function(vKatakuri)
    getgenv().Katakuri = vKatakuri
end
})
spawn(function()
    while task.wait() do
        if getgenv().Katakuri then
            local table_CakeMobs = {"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"}
            local table_CakeBoss = {"Dough King", "Cake Prince"}
            if CheckMob(table_CakeMobs) then
                local Mob = CheckMob(table_CakeMobs)
                repeat task.wait()
                    if getgenv().ClaimQuest then
                        if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Demonic Soul") then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                        end
                        if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                            ToTween(CFrame.new(-2020.6177978515625, 37.793975830078125, -12029.17578125))
                            if (LP.Character.HumanoidRootPart.Position - CFrame.new(-2020.6177978515625, 37.793975830078125, -12029.17578125).Position).Magnitude <= 5 then
                                local args = {[1] = "StartQuest", [2] = "CakeQuest1", [3] = 1}
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                        elseif getgenv().ClaimQuest and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            ToTween(Mob.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                        end
                    else
                        ToTween(Mob.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                    end
                    EquipTool()
                    PosBring = Mob.HumanoidRootPart.CFrame
                    BringMobNear(Mob.Name)
                    Buso()
                    Click()
                until not getgenv().Katakuri or not Mob:FindFirstChild("Humanoid") or not Mob:FindFirstChild("HumanoidRootPart") or Mob.Humanoid.Health <= 0 or CheckMob(table_CakeBoss)
                UnEquipTool(GetWeapon(getgenv()["SelectTool"]))
                if getgenv().SummonC then
                    if string.find(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner"),"Do you want to open the portal now?") then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                    end
                end
            elseif CheckMob(table_CakeBoss) then
                local Mob = CheckMob(table_CakeBoss)
                repeat task.wait()
                    ToTween(Mob.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                    EquipTool()
                    PosBring = Mob.HumanoidRootPart.CFrame
                    BringMobNear(Mob.Name)
                    Buso()
                    Click()
                until not getgenv().Katakuri or not Mob:FindFirstChild("Humanoid") or not Mob:FindFirstChild("HumanoidRootPart") or Mob.Humanoid.Health <= 0
                UnEquipTool(GetWeapon(getgenv()["SelectTool"]))
            else
                ToTween(CFrame.new(-2091.911865234375, 70.00884246826172, -12142.8359375))
            end
        end
    end
end)
A:AddToggle({Title = "Auto Summon Cake Prince", Content = "", Default = false, Callback = function(vKatakuriC)
    getgenv().SummonC = vKatakuriC
end
})
A:AddToggle({Title = "Claim Quest", Content = "Auto Claim Quest If You Enable Auto Bone or Auto Katakuri", Default = false, Callback = function(vClaimQuest)
    getgenv().ClaimQuest = vClaimQuest
end
})
A:AddButton({Title = "Disable NoClip", Content = "Destroy Body Velocity", Icon = "",Callback = function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Hold"):Destroy()
end
})
