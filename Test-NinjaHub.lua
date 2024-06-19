-- Create Functions
local Func_Farms = {
    ["Auto Level"] = false,
    ["Auto Bone"] = false,
    ["Auto Katakuri"] = false
}
local Func_Settings = {
    ["Fast Attack"] = {
        ["Value"] = true,
        ["Speed"] = "Normal"
    },
    ["Bring Radius"] = 250,
    ["Auto Ken"] = false,
    ["Double Quest"] = false,
    ["Claim Quest Cake And Haunted"] = false
}
local Func_Items = {
    ["Auto Saber"] = false,
    ["Auto Cursed Dual Katana"] = false,
    ["Auto Yama"] = false,
    ["Auto Tushita Fully"] = false
}
-- Create Local
local players = game.Players
local localplayers = players.LocalPlayer
-- Loader Library
local LibLoader = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
-- Load Hub
local function UIOpen()
    -- Functions Unnecessary
    function noti(name, content, subc, time)
        if name == nil or name == "" then
            name = "Not Titled"
        end
        if content == nil or content == "" then
            content = "No Any Descriptions"
        end
        if subc == nil or subc == "" then
            subc = "No Any Sub Descriptions"
        end
        if type(I) ~= "number" then
            time = 10
        end
        LibLoader:Notify({Title = name,Content = content, SubContent = subc,Duration = time})
    end
    -- Functions Necessary
    function CFrameQuest()
        QuestPoses = {}
        for r, v in pairs(getnilinstances()) do
            if v:IsA("Model") and v:FindFirstChild("Head") and v.Head:FindFirstChild("QuestBBG") and v.Head.QuestBBG.Title.Text == "QUEST" then
                QuestPoses[v.Name] = v.Head.CFrame * CFrame.new(0, -2, 2)
            end
        end
        for r, v in pairs(game.Workspace.NPCs:GetDescendants()) do
            if v.Name == "QuestBBG" and v.Title.Text == "QUEST" then
                QuestPoses[v.Parent.Parent.Name] = v.Parent.Parent.Head.CFrame * CFrame.new(0, -2, 2)
            end
        end
        DialoguesList = {}
        for r, v in pairs(require(game.ReplicatedStorage.DialoguesList)) do
            DialoguesList[v] = r
        end
        local V = getscriptclosure(game:GetService("Players").LocalPlayer.PlayerScripts.NPC)
        local W = {}
        for k, v in pairs(debug.getprotos(V)) do
            if #debug.getconstants(v) == 1 then
                table.insert(W, debug.getconstant(v, 1))
            end
        end
        local X = false
        local Y = {}
        for k, v in pairs(debug.getconstants(V)) do
            if type(v) == "string" then
                if v == "Players" then
                    X = false
                end
                if not X then
                    if v == "Blox Fruit Dealer" then
                        X = true
                    end
                else
                end
                if X then
                    table.insert(Y, v)
                end
            end
        end
        local Z = {}
        QuestPoint = {}
        for k, v in pairs(Y) do
            if QuestPoses[v] then
                Z[W[k]] = Y[k]
            end
        end
        for r, v in next, Z do
            QuestPoint[r] = QuestPoses[v]
        end
        QuestPoint["SkyExp1Quest"] = CFrame.new(-7857.28516,5544.34033,-382.321503,-0.422592998,0,0.906319618,0,1,0,-0.906319618,0,-0.422592998)
    end
    local Q = require(game.ReplicatedStorage.Quests)
    local a3 = require(game.ReplicatedStorage:WaitForChild("GuideModule"))
    function CheckDataQuest()
        for r, v in next, a3.Data do
            if r == "QuestData" then
                return true
            end
        end
        return false
    end
    function CheckNameMobDoubleQuest()
        local a
        if CheckDataQuest() then
            for r, v in next, a3.Data.QuestData.Task do
                a = r
            end
        end
        return a
    end
    function CheckDoubleQuestSkidcuaYMF()
        S()
        local a5 = {}
        if game.Players.LocalPlayer.Data.Level.Value >= 10 and _G.S.DoubleQuest and CheckDataQuest() and CheckNameMobDoubleQuest() == Mob1 and #CheckNameMobDoubleQuest() > 2 then
            for r, v in pairs(Q) do
                for M, N in pairs(v) do
                    for O, P in pairs(N.Task) do
                        if tostring(O) == Mob1 then
                            for a6, a7 in next, v do
                                for a8, a9 in next, a7.Task do
                                    if a8 ~= Mob1 and a9 > 1 then
                                        if a7.LevelReq <= game.Players.LocalPlayer.Data.Level.Value then
                                            a5["Name"] = tostring(a8)
                                            a5["Mob2"] = r
                                            a5["ID"] = a6
                                        else
                                            a5["Name"] = Mob1
                                            a5["Mob2"] = Mob2
                                            a5["ID"] = Mob3
                                        end
                                        return a5
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            a5["Name"] = Mob1
            a5["Mob2"] = Mob2
            a5["ID"] = Mob3
            return a5
        end
        a5["Name"] = Mob1
        a5["Mob2"] = Mob2
        a5["ID"] = Mob3
        return a5
    end
    function MobLevel1OrMobLevel2()
        local aa = {}
        for r, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if not table.find(aa, v.Name) and v:IsA("Model") and v.Name ~= "PirateBasic" and not string.find(v.Name, "Brigade") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                table.insert(aa, v.Name)
            end
        end
        for r, v in pairs(aa) do
            local ab = v
            v = tostring(v:gsub(" %pLv. %d+%p", ""))
            if tostring(v) == CheckNameMobDoubleQuest() then
                return tostring(ab)
            end
        end
        return false
    end
    local ad = game.ReplicatedStorage.Remotes["CommF_"]
    CFrameQuest()
    function GetQuest()
        if game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then
            return
        end
        if not QuestPoint[tostring(CheckDoubleQuestSkidcuaYMF().Mob2)] then
            CFrameQuest()
            return
        end
        if (QuestPoint[CheckDoubleQuestSkidcuaYMF().Mob2].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
            ad:InvokeServer("StartQuest", tostring(CheckDoubleQuestSkidcuaYMF().Mob2), CheckDoubleQuestSkidcuaYMF().ID)
        else
            QuestCFrame = QuestPoint[CheckDoubleQuestSkidcuaYMF().Mob2]
            ToTween(QuestCFrame)
        end
    end
    function GetMob()
        local tablegetmob = {}
        for i, v in pairs(game.Workspace.MobSpawns:GetChildren()) do
            if not table.find(tablegetmob, v.Name) then
                table.insert(tablegetmob, v.Name)
            end
        end
        if string.find(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()[1].Name, "Lv.") then
            for i, v in pairs(tablegetmob) do
                local b = v
                v = tostring(v:gsub(" %pLv. %d+%p", ""))
                if v == CheckNameMobDoubleQuest() then
                    return b
                end
            end
        else
            return CheckNameMobDoubleQuest()
        end
    end
    -- Function Attack
    function HopServer(bO)
        if not bO then
            bO = 10
        end
        ticklon = tick()
        repeat
            task.wait()
        until tick() - ticklon >= 1
        local function Hop()
            for r = 1, math.huge do
                if ChooseRegion == nil or ChooseRegion == "" then
                    ChooseRegion = "Singapore"
                else
                    game.Players.LocalPlayer.PlayerGui.ServerBrowser.Frame.Filters.SearchRegion.TextBox.Text =
                        ChooseRegion
                end
                local bP = game.ReplicatedStorage.__ServerBrowser:InvokeServer(r)
                for k, v in pairs(bP) do
                    if k ~= game.JobId and v["Count"] < bO then
                        game.ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", k)
                    end
                end
            end
            return false
        end 
        if not getgenv().Loaded then
            local function bQ(v)
                if v.Name == "ErrorPrompt" then
                    if v.Visible then
                        if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                            HopServer()
                            v.Visible = false
                        end
                    end
                    v:GetPropertyChangedSignal("Visible"):Connect(
                        function()
                            if v.Visible then
                                if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                                    HopServer()
                                    v.Visible = false
                                end
                            end
                        end
                    )
                end
            end
            for k, v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren()) do
                bQ(v)
            end
            game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(bQ)
            getgenv().Loaded = true
        end
        while not Hop() do
            wait()
        end
    end
    function CheckItem(item)
        for i, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do
            if v.Name == item then
                return v
            end
        end
    end
    function Buso()
        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end
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
    function SendKeyEvents(vb ,cc)
        if not cc then
            cc = 0
        end
        game:service("VirtualInputManager"):SendKeyEvent(true, vb, false, game)
        task.wait(cc)
        game:service("VirtualInputManager"):SendKeyEvent(false, vb, false, game)
    end
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
    function UnEquipTool(Wa)
        if game.Players.LocalPlayer.Character:FindFirstChild(Wa) then
            game.Players.LocalPlayer.Character:FindFirstChild(Wa).Parent = game.Players.LocalPlayer.Backpack
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
    function ToTween(Pos, Speed)
        Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Pos.Position).Magnitude
        if not Speed or typeof(Speed) ~= "number" then
            Speed = Setting["Tween Speed"]
        end
        if Distance <= 220 then
            game.Players.LocalPlayer.Character.PrimaryPart.CFrame = Pos
        end
        function CheckState(StatusPBS)
            if StatusPBS == Enum.PlaybackState.Completed or StatusPBS == Enum.PlaybackState.Cancelled then
                if game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity") then
                    game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity"):Destroy()
                end
            else
                NoClip()
            end
        end
        local ac = CheckNearestTeleporter(Pos)
        if ac then
            pcall(function()
                tween:Cancel()
            end)
            requestEntrance(ac)
        end
        tween = game:GetService("TweenService"):Create(
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = Pos}
        )
        tween:Play()
        tween.Completed:Connect(CheckState)
    end
    function NoClip()
        if not game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity") then
            local ag = Instance.new("BodyVelocity")
            ag.Velocity = Vector3.new(0, 0, 0)
            ag.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            ag.P = 9000
            ag.Parent = game.Players.LocalPlayer.Character.Head
            for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
    function CheckStatusFeature(feature)
        InputedFeature = feature
        if InputedFeature == true then
            return "TRUE"
        else
            return "FALSE"
        end
        return "FALSE"
    end
    function DetectingPart(v1)
        if not v1 then return end
        if v1 and v1:FindFirstChild("HumanoidRootPart") and v1:FindFirstChild("Humanoid") then
            return true
        else
            return false
        end
        return false
    end
    function CheckEnemies(v)
        if not v then return end
        for _,n in pairs(game.Workspace.Enemies:GetChildren()) do
            if type(v) == "table" then
                if table.find(n.Name, v) and DetectingPart(n) and n.Humanoid.Health > 0 then
                    return n
                end
            else
                if n.Name == v and DetectingPart(n) and n.Humanoid.Health > 0 then
                    return n
                end
            end
        end
        for _,n in pairs(game.ReplicatedStorage:GetChildren()) do
            if type(v) == "table" then
                if table.find(n.Name, v) then
                    return n
                end
            else
                if n.Name == v then
                    return n
                end
            end
        end
    end
    function Bring(nameMob,BringC,DistanceF,radius)
        inputed = nameMob
        inputed2 = DistanceF
        inputed3 = radius
        inputed4 = BringC
        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
            if v.Name == inputed and DetectingPart(v) and v.Humanoid.Health > 0 and inputed2.Magnitude <= inputed3 then
                v.HumanoidRootPart.CFrame = BringC
                v.HumanoidRootPart.CanCollide = false
                v.Humanoid.WalkSpeed = 0
                v.Humanoid:ChangeState(14)
                if v.Humanoid:FindFirstChild("Animator") then
                    v.Humanoid.Animator:Destroy()
                end
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
            end
        end
    end
    -- MobSpawns
    plr = game.Players.LocalPlayer
    if game.Workspace:FindFirstChild("MobSpawns") then
        for i, v in pairs(game.Workspace:GetChildren()) do
            if v.Name == "MobSpawns" then
                v:Destroy()
            end
        end
    end
    local CreateFoldermmb = Instance.new("Folder")
    CreateFoldermmb.Parent = game.Workspace
    CreateFoldermmb.Name = "MobSpawns"
    function RemoveLevelTitle(v)
        return tostring(tostring(v):gsub(" %pLv. %d+%p", ""):gsub(" %pRaid Boss%p", ""):gsub(" %pBoss%p", ""))
    end 
    task.spawn(
        function()
            while task.wait() do 
                pcall(function()
                    for i,v in pairs(game.workspace.MobSpawns:GetChildren()) do  
                        v.Name = RemoveLevelTitle(v.Name)
                    end
                end)
                task.wait(50)
            end
        end
    )
    function MobDepTrai()
        MobDepTraiTable = {}
        for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
            table.insert(MobDepTraiTable, v)
        end
        local tablefoldermmb = {}
        for i, v in next, require(game:GetService("ReplicatedStorage").Quests) do
            for i1, v1 in next, v do
                for i2, v2 in next, v1.Task do
                    if v2 > 1 then
                        table.insert(tablefoldermmb, i2)
                    end
                end
            end
        end
        for i, v in pairs(getnilinstances()) do
            if table.find(tablefoldermmb, RemoveLevelTitle(v.Name)) then
                table.insert(MobDepTraiTable, v)
            end
        end
        return MobDepTraiTable
    end
    local MobSpawnList = MobDepTrai()
    function ReloadFolderMob()
        for i, v in next, game.Workspace.MobSpawns:GetChildren() do
            v:Destroy()
        end
        for i, v in pairs(MobSpawnList) do
            if v then
                if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
                    MobNew = Instance.new("Part")
                    MobNew.CFrame = v.HumanoidRootPart.CFrame
                    MobNew.Name = v.Name
                    MobNew.Parent = game.Workspace.MobSpawns
                elseif v:IsA("Part") then
                    MobNew = v:Clone()
                    MobNew.Parent = game.Workspace.MobSpawns
                end
            end
        end
    end
    ReloadFolderMob()
    function GetMobSpawnList(a)
        a = RemoveLevelTitle(a)
        k = {}
        for i, v in pairs(game.Workspace.MobSpawns:GetChildren()) do
            if v.Name == a then
                table.insert(k, v)
            end
        end
        return k
    end
    -- Kill Mob Functions
    local KillMonster = function(mob,bring,value)
        if CheckEnemies(mob) then
            local v = CheckEnemies(mob)
            if v.Humanoid.Health > 0 then
                repeat task.wait()
                    EquipTool()
                    Buso()
                    if bring then
                        Bring(v.Name, v.HumanoidRootPart.CFrame, (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position), Func_Settings["Bring Radius"])
                    end
                    ToTween(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                    Clicking()
                until v.Humanoid.Health <= 0 or value
            end
        end
    end
    -- Create Window
    local Window = LibLoader:CreateWindow({Title = "Experience Script", SubTitle = "by Memories", TabWidth = 160, Size = UDim2.fromOffset(500, 360), Acrylic = true, Theme = "Dark", MinimizeKey = Enum.KeyCode.LeftControl})
    -- Create Tabs
    local A = Window:AddTab({ Title = "Farm Tab", Icon = "rbxassetid://4483345998"})
    local B = Window:AddTab({ Title = "Setting Tab", Icon = "settings"})
    -- Create Features
    -- Farm Tab
    local LevelFarming = A:AddToggle("Auto Level", {Title = "Auto Level", Default = false})
    if game.PlaceId == 7449423635 then
        local BoneFarming = A:AddToggle("Auto Bone", {Title = "Auto Bone", Default = false})
        local KatakuriFarming = A:AddToggle("Auto Katakuri", {Title = "Auto Katakuri", Default = false})
        BoneFarming:OnChanged(function(v)
            Func_Farms["Auto Bone"] = v
        end)
        KatakuriFarming:OnChanged(function(v)
            Func_Farms["Auto Katakuri"] = v
        end)
    end
    LevelFarming:OnChanged(function(v)
        Func_Farms["Auto Level"] = v
    end)
    spawn(function()
        while task.wait() do
            if CheckStatusFeature(Func_Farms["Auto Level"]) == "TRUE" then
                if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                    if not MobLevel1OrMobLevel2() then
                        tick1 = tick()
                        p2 = GetMobSpawnList(GetMob())
                        if tick() - tick1 >= 3*60 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude <= 1500 then
                            game.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
                        else
                            local p2 = GetMobSpawnList(GetMob())
                            for i, v in pairs(p2) do
                                pcall(function()
                                    if not MobLevel1OrMobLevel2() and Func_Farms["Auto Level"] then
                                        if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                                            repeat wait()
                                            until game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
                                        end
                                        ToTween(v.CFrame * CFrame.new(0, 25, 8))
                                        NoClip()
                                    end
                                end)
                            end
                        end
                    else
                        for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == MobLevel1OrMobLevel2() and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then
                                repeat task.wait()
                                    KillMonster(v.Name, true, CheckStatusFeature(Func_Farms["Auto Level"]) == "FALSE")
                                until not v:FindFirstChild("Humanoid") or not v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health <= 0 or  CheckStatusFeature(Func_Farms["Auto Level"]) == "FALSE"
                            end
                        end
                    end
                else
                    GetQuest()
                end
            end
        end
    end)
    -- Settings Tab
    local BringRadius = B:AddSlider("Bring Radius", {Title = "Bring Radius", Description = "", Default = 250, Min = 1, Max = 500, Rounding = 1,
        Callback = function(v)
            Func_Settings["Bring Radius"] = v
        end
    })
    local FastAttackSpeed = B:AddDropdown("Fast Attack Speed", {Title = "Fast Attack Speed", Values = {"Slow", "Normal"}, Multi = false, Default = "Normal",})
    FastAttackSpeed:OnChanged(function(v)
        Func_Settings["Fast Attack"]["Speed"] = v
    end)
    local DoubleQuest = B:AddToggle("Double Quest", {Title = "Double Quest", Default = false})
    DoubleQuest:OnChanged(function(v)
        Func_Settings["Double Quest"] = v
    end)
    local fastattack = {["Delay"] = 0}
    spawn(function()
        while wait() do
            if CheckStatusFeature(Func_Settings["Fast Attack"]["Value"]) == "TRUE" then
                if Func_Settings["Fast Attack"]["Speed"] == "Slow" then
                    fastattack["Delay"] = 0.4
                elseif Func_Settings["Fast Attack"]["Speed"] == "Normal" then
                    fastattack["Delay"] = 0.25
                end
            end
        end
    end)
    local CurveFrame = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework")))[2]
    local VirtualUser = game:GetService("VirtualUser")
    local RigControllerR = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework.RigController))[1]
    local Client = game:GetService("Players").LocalPlayer
    local DMG = require(Client.PlayerScripts.CombatFramework.Particle.Damage)
    local CamShake = require(game.ReplicatedStorage.Util.CameraShaker)
    CamShake:Stop()
    
    workspace._WorldOrigin.ChildAdded:Connect(function(v)
        if v.Name =='DamageCounter' then 
            v.Enabled  = false 
        end
    end)
    hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function()end)
    hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Respawn), function()end)
    
    task.delay(10,function()
        for i,v2 in pairs(game.ReplicatedStorage.Effect.Container:GetDescendants()) do 
            pcall(function()
                if v2.ClassName =='ModuleScript' and typeof(require(v2)) == 'function' then 
                    hookfunction(require(v2),function()end)
                end
            end)
        end
    end)
    function CurveFuckWeapon()
        local p13 = CurveFrame.activeController
        if not p13 then
            return nil
        end
        if not p13.blades then return end
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
            pcall(function()
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", tostring(CurveFuckWeapon()))
            end)
        end)
    end
    function Unboost()
        task.spawn(function()
            pcall(function()
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("unequipWeapon", tostring(CurveFuckWeapon()))
            end)
        end)
    end
    
    local cdnormal = 0
    local Animation = Instance.new("Animation")
    local CooldownFastAttack = 0
    
    
    FastAttack = function()
        local ac = CurveFrame.activeController
        if ac and ac.equipped then
            task.spawn(function()
                if tick() - cdnormal > 0.2 then
                    VirtualUser:Button1Down(Vector2.new())
                    VirtualUser:Button1Up(Vector2.new())
                    cdnormal = tick()
                else
                    Animation.AnimationId = ac.anims.basic[2]
                    ac.humanoid:LoadAnimation(Animation):Play(1, 1)
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                        game.Players.LocalPlayer.Character,
                        {game.Players.LocalPlayer.Character.HumanoidRootPart},
                        60
                    ), 2, "")
                end
            end)
        end
    end
    
    bs = tick()
    task.spawn(function()
        while task.wait(fastattack["Delay"]) do
            if CheckStatusFeature(Func_Settings["Fast Attack"]["Value"]) == "TRUE" then
                _G.Fast = true
                if bs - tick() > 0.55 then
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
                            end
                        end
                    end
                end)
            else
                _G.Fast = false
            end
        end
    end)
    
    k = tick()
    task.spawn(function()
        if _G.Fast then
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
            if _G.Fast then
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
    
    abc = true
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
        if abc then
            pcall(function()
                c.wrapAttackAnimationAsync = function(d, e, f, g, h)
                    local i = c.getBladeHits(e, f, g)
                    if i then
                        b.play = function()
                        end
                        d:Play(0.1, 0.1, 0.1)
                        h(i)
                        b.play = shared.cpc
                        wait(.5)
                        d:Stop()
                    end
                end
            end)
        end
    end)
end
UIOpen()
