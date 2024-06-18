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
    ["Auto Saber"] = false
    ["Auto Cursed Dual Katana"] = false,
    ["Auto Yama"] = false,
    ["Auto Tushita Fully"] = false
}
-- Create Local
local players = game.Players
local localplayers = players.LocalPlayer
local CSF = CheckStatusFeature
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
    local QuestReplicated = require(game.ReplicatedStorage.Quests)
    local UselessQuest = {"BartiloQuest","Trainees","MarineQuest","CitizenQuest"}
    local function CheckQuest()
        local levelV = game.Players.LocalPlayer.Data.Level.Value
        local min = 0
        if levelV >= 1450 and game.PlaceId == 4442272183 then
            Mob1 = "Water Fighter"
            Mob2 = "ForgottenQuest"
            Mob3 = 2
        elseif levelV >= 700 and game.PlaceId == 2753915549 then
            Mob1 = "Galley Captain"
            Mob2 = "FountainQuest"
            Mob3 = 2
        else
            for i,v in pairs(QuestReplicated) do
                for ik,vk in pairs(v) do
                    local LevelRequest = vk.LevelReq
                    for iz,vz in pairs(vk.Task) do
                        if levelV >= LevelRequest and LevelRequest >= min and vk.Task[iz] > 1 and not table.find(UselessQuest, tostring(i)) then
                            min = LevelRequest
                            Mob1 = tostring(iz)
                            Mob2 = i
                            Mob3 = ik
                        end
                    end
                end
            end
        end
    end
    function CFrameQuest()
        QuestPoses = {}
        for i, v in pairs(getnilinstances()) do
            if v:IsA("Model") and v:FindFirstChild("Head") and v.Head:FindFirstChild("QuestBBG") and v.Head.QuestBBG.Title.Text == "QUEST" then
                QuestPoses[v.Name] = v.Head.CFrame * CFrame.new(0, -2, 2)
            end
        end
        for i, v in pairs(game.Workspace.NPCs:GetDescendants()) do
            if v.Name == "QuestBBG" and v.Title.Text == "QUEST" then
                QuestPoses[v.Parent.Parent.Name] = v.Parent.Parent.Head.CFrame * CFrame.new(0, -2, 2)
            end
        end
        DialoguesList = {}
        for i,v in pairs(require(game.ReplicatedStorage.DialoguesList)) do
            DialoguesList[v] = i
        end
        local NpcScripts = getscriptclosure(game:GetService("Players").LocalPlayer.PlayerScripts.NPC)
        local listremote = {}
        for i,v in pairs(debug.getprotos(NpcScripts)) do
            if #debug.getconstants(v) == 1 then
                table.insert(listremote, debug.getconstant(v, 1))
            end
        end
        local start = false
        local listremotess = {}
        for i,v in pairs(debug.getconstants(NpcScripts)) do
            if type(v) == "string" then
                if v == "Players" then
                    start = false
                end
                if not start then
                    if v == "Blox Fruit Dealer" then
                        start = true
                    end
                else
                end
                if start then
                    table.insert(listremotess, v)
                end
            end
        end
        local QuestPoint1 = {}
        QuestPoint = {}
        for k, v in pairs(listremotess) do
            if QuestPoses[v] then
                QuestPoint1[listremote[k]] = listremotess[k]
            end
        end
        for i, v in next, QuestPoint1 do
            QuestPoint[i] = QuestPoses[v]
        end
        QuestPoint["SkyExp1Quest"] = CFrame.new(-7857.28516,5544.34033,-382.321503,-0.422592998,0,0.906319618,0,1,0,-0.906319618,0,-0.422592998)
    end
    function CheckDoubleQuest()
        local a = {}
        for i, v in pairs(Quest) do
            for i1, v1 in pairs(v) do
                local lvlreq = v1.LevelReq
                for i2, v2 in pairs(v1.Task) do
                    if i2 == Mob1 then
                        for i3, v3 in next, v do
                            if v3.LevelReq <= game.Players.LocalPlayer.Data.Level.Value and v3.Name ~= "Town Raid" then
                                for i4, v4 in next, v3.Task do
                                    if v4 > 1 then
                                        table.insert(a, i4)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return a
    end
    local v17 = require(game.ReplicatedStorage:WaitForChild("GuideModule"))
    function CheckQuestData()
        for i, v in next, v17.Data do
            if i == "QuestData" then
                return true
            end
        end
        return false
    end
    function CheckNameDoubleQuest()
        local a
        if CheckQuestData() then
            for i, v in next, v17.Data.QuestData.Task do
                a = i
            end
        end
        return a
    end
    function CheckNameDoubleQuest2()
        local a
        local a2 = {}
        if CheckQuestData() then
            for i, v in next, v17.Data.QuestData.Task do
                a = i
                table.insert(a2, i)
            end
        end
        return a2
    end
    function CheckDoubleQuest2()
        CheckQuest()
        local aa = {}
        if game.Players.LocalPlayer.Data.Level.Value >= 10 and Func_Settings["Double Quest"] and CheckQuestData() and CheckNameDoubleQuest() == Mob1 and #CheckNameDoubleQuest() > 2 then
            for i, v in pairs(Quest) do
                for i1, v1 in pairs(v) do
                    for i2, v2 in pairs(v1.Task) do
                        if tostring(i2) == Mob1 then
                            for quest1, quest2 in next, v do
                                for quest3, quest4 in next, quest2.Task do
                                    if quest3 ~= Mob1 and quest4 > 1 then
                                        if quest2.LevelReq <= game.Players.LocalPlayer.Data.Level.Value then
                                            aa["Name"] = tostring(quest3)
                                            aa["NameQuest"] = i
                                            aa["ID"] = quest1
                                        else
                                            aa["Name"] = Mob1
                                            aa["NameQuest"] = Mob2
                                            aa["ID"] = Mob3
                                        end
                                        return aa
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            aa["Name"] = Mob1
            aa["NameQuest"] = Mob2
            aa["ID"] = Mob3
            return aa
        end
        aa["Name"] = Mob1
        aa["NameQuest"] = Mob2
        aa["ID"] = Mob3
        return aa
    end
    function MobLevel1OrMobLevel2()
        local mbb = {}
        for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if not table.find(mbb, v.Name) and v:IsA("Model") and v.Name ~= "PirateBasic" and not string.find(v.Name, "Brigade") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                table.insert(mbb, v.Name)
            end
        end
        for i, v in pairs(mbb) do
            local b = v
            v = tostring(v:gsub(" %pLv. %d+%p", ""))
            if tostring(v) == CheckNameDoubleQuest() then
                return tostring(b)
            end
        end
        return false
    end
    function CheckQuestCustomLevel(lvlcus)
        min = 0
        if not lvlcus then
            lvlcus = 2275
        end
        for i, v in pairs(Quest) do
            for i1, v1 in pairs(v) do
                local lvlreq = v1.LevelReq
                for i2, v2 in pairs(v1.Task) do
                    if lvlcus >= lvlreq and lvlreq >= min and v1.Task[i2] > 1 and not table.find(UselessQuest, tostring(i)) then
                        min = lvlreq
                        Mob1 = tostring(i2)
                        Mob2 = i
                        Mob3 = i1
                    end
                end
            end
        end
        return Mob1, Mob2, Mob3
    end
    function CheckDoubleQuestCustom(cusz)
        Mob1, Mob2, Mob3 = CheckQuestCustomLevel(cusz)
        local aa = {}
        if game.Players.LocalPlayer.Data.Level.Value >= 10 and Func_Settings["Double Quest"] and CheckQuestData() and CheckNameDoubleQuest() == Mob1 and #CheckNameDoubleQuest() > 2 then
            for i, v in pairs(Quest) do
                for i1, v1 in pairs(v) do
                    for i2, v2 in pairs(v1.Task) do
                        if tostring(i2) == Mob1 then
                            for quest1, quest2 in next, v do
                                for quest3, quest4 in next, quest2.Task do
                                    if quest3 ~= Mob1 and quest4 > 1 then
                                        if quest2.LevelReq <= game.Players.LocalPlayer.Data.Level.Value then
                                            aa["Name"] = tostring(quest3)
                                            aa["NameQuest"] = i
                                            aa["ID"] = quest1
                                        else
                                            aa["Name"] = Mob1
                                            aa["NameQuest"] = Mob2
                                            aa["ID"] = Mob3
                                        end
                                        return aa
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            aa["Name"] = Mob1
            aa["NameQuest"] = Mob2
            aa["ID"] = Mob3
            return aa
        end
        aa["Name"] = Mob1
        aa["NameQuest"] = Mob2
        aa["ID"] = Mob3
        return aa
    end
    local AutoTp
    local TpCFrame
    function UpdateTPCFrame(FF)
        FF = FF or {}
        FF.CFrame = FF.CFrame or nil 
        FF.Enable = FF.Enable or false 
        AutoTp = FF.Enable 
        TpCFrame = FF.CFrame
    end
    spawn(function()
        while wait() do
            if AutoTp and TpCFrame then
                pcall(function()
                    if (TpCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 300 then
                        pcall(function()
                            ToTween(TpCFrame)
                        end)
                    else
                        pcall(function()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TpCFrame
                            ToTween(TpCFrame)
                        end)
                    end
                end)
            end
        end
    end)
    function GetQuest()
        if game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then
            return
        end 
        UpdateTPCFrame()
        if not QuestPoint[tostring(CheckDoubleQuest2().NameQuest)] then
            CFrameQuest()
            return
        end
        if
            (QuestPoint[CheckDoubleQuest2().NameQuest].Position -
                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8
         then
            CommF:InvokeServer("StartQuest", tostring(CheckDoubleQuest2().NameQuest), CheckDoubleQuest2().ID)
        else
            QuestCFrame = QuestPoint[CheckDoubleQuest2().NameQuest]
            Tweento(QuestCFrame)
        end
    end
    function GetQuestCustom(lvlcustom)
        if game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then
            return
        end
        if not QuestPoint[tostring(CheckDoubleQuestCustom(lvlcustom).NameQuest)] then
            CFrameQuest()
            return
        end
        MMBStatus = "Claiming Quest"
        if
            (QuestPoint[CheckDoubleQuestCustom(lvlcustom).NameQuest].Position -
                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8
         then 
            CommF:InvokeServer(
                "StartQuest",
                tostring(CheckDoubleQuestCustom(lvlcustom).NameQuest),
                CheckDoubleQuestCustom(lvlcustom).ID
            )
            wait(2.2)
        else
            QuestCFrame = QuestPoint[CheckDoubleQuestCustom(lvlcustom).NameQuest]
            Tweento(QuestCFrame)
            wait(0.75)
        end
    end
    function GetMob()
        local tablegetmob = {}
        for i, v in pairs(game.Workspace.MobSpawns:GetChildren()) do
            if not table.find(tablegetmob, v.Name) then
                table.insert(tablegetmob, v.Name)
            end
        end
        if string.find(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()[1].Name, "Lv.") then
            for i, v in pairs(tablegetmob) do
                local b = v
                v = tostring(v:gsub(" %pLv. %d+%p", ""))
                if v == CheckNameDoubleQuest() then
                    return b
                end
            end
        else
            return CheckNameDoubleQuest()
        end
    end
    local CommF = game.ReplicatedStorage.Remotes["CommF_"]
    CFrameQuest()
    -- Function Attack
    function CheckNearestTeleporter(P)
        local min = math.huge
        local min2 = math.huge
        local choose 
        if game.PlaceId == 7449423635 then
            TableLocations = {
                ["1"] = Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125),
                ["2"] = Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
                ["3"] = Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
                ["4"] = Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
                ["5"] = Vector3.new(-11993.580078125, 334.7812805175781, -8844.1826171875),
                ["6"] = Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
            }
        elseif game.PlaceId == 4442272183 then
            TableLocations = {
                ["1"] = Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
                ["2"] = Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
                ["3"] = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
                ["4"] = Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
            }
        elseif game.PlaceId == 2753915549 then
            TableLocations = {
                ["1"] = Vector3.new(-7894.6201171875, 5545.49169921875, -380.2467346191406),
                ["2"] = Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
                ["3"] = Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
                ["4"] = Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
            }
        end
        TableLocations2 = {}
        for r, v in pairs(TableLocations) do
            TableLocations2[r] = (v - P.Position).Magnitude
        end
        for r, v in pairs(TableLocations2) do
            if v < min then
                min = v
                min2 = v
            end
        end    
        for r, v in pairs(TableLocations2) do
            if v <= min then
                choose = TableLocations[r]
            end
        end
        if min2 <= GetDistance(P) then
            return choose
        end
    end
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
    local CurrentFarmQuest = GetCurrentQuest()
    game.Players.LocalPlayer.Data.Level.Changed:Connect(function() 
        CurrentFarmQuest = GetCurrentQuest()
    end)
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
    function requestEntrance(vector3)
        local args = {
            "requestEntrance",
            vector3
        }
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
        oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(oldcframe.X, oldcframe.Y + 50, oldcframe.Z)
        task.wait(0.5)
    end
    function ToTween(Pos, Speed)
        Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Pos.Position).Magnitude
        if not Speed or typeof(Speed) ~= "number" then
            Speed = Setting["Tween Speed"]
        end
        if Distance <= 220 then
            game.Players.LocalPlayer.Character.PrimaryPart.CFrame = Pos
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
    spawn(function()
        while task.wait() do
            if game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
                NoClip()
            elseif game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
                if game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity") then
                    game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity"):Destroy()
                end
                for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                    end
                end
            end
        end
    end)
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
                    NoClip()
                until v.Humanoid.Health <= 0 or value
                if value then
                    if game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity") then
                        game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity"):Destroy()
                    end
                end
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
            if CSF(Func_Farms["Auto Level"]) == "TRUE" then
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
                                        Tweento(v.CFrame * CFrame.new(0, 25, 8))
                                    end
                                end)
                            end
                        end
                    else
                        for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == MobLevel1OrMobLevel2() and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Quest").Visiblethen
                                repeat task.wait()
                                    KillMonster(v.Name, true, CSF(Func_Farms["Auto Level"]) == "FALSE")
                                until not v:FindFirstChild("Humanoid") or not v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health <= 0 or  CSF(Func_Farms["Auto Level"]) == "FALSE"
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
    local BringRadius = Tabs.Main:AddSlider("Bring Radius", {Title = "Bring Radius", Description = "", Default = 250, Min = 1, Max = 500, Rounding = 1,
        Callback = function(v)
            Func_Settings["Bring Radius"] = v
        end
    })
    local FastAttackSpeed = Tabs.Main:AddDropdown("Fast Attack Speed", {Title = "Fast Attack Speed", Values = {"Slow", "Normal"}, Multi = false, Default = "Normal",})
    FastAttackSpeed:OnChanged(function(v)
        Func_Settings["Fast Attack"]["Speed"] = v
    end)
    local DoubleQuest = A:AddToggle("Double Quest", {Title = "Double Quest", Default = false})
    DoubleQuest:OnChanged(function(v)
        Func_Settings["Double Quest"] = v
    end)
    local fastattack = {["Delay"] = 0}
    spawn(function()
        while wait() do
            if CSF(Func_Settings["Fast Attack"]["Value"]) == "TRUE" then
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
