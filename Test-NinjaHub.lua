-- Setting
local Setting = {
    ["Team"] = "Pirates",
    ["Fast Attack"] = {
        ["Value"] = true,
        ["Delay"] = 0.27
    },
    ["Tween Speed"] = 300,
    ["Double Quest"] = false --Not Available
}
-- Auto Join
function Join(v2) 
    v2 = tostring(v2) or "Pirates"
    v2 = string.find(v2,"Marine") and "Marines" or "Pirates"
    for i, v in pairs(
        getconnections(
            game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container[v2].Frame.TextButton.Activated
        )
    ) do
        v.Function()
    end
end
if not game.Players.LocalPlayer.Team then 
    repeat
        pcall(function()
            task.wait()
            if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main"):FindFirstChild("ChooseTeam") then 
                Join(Setting["Team"])
            end  
        end)
    until game.Players.LocalPlayer.Team ~= nil 
end
-- Loader Noti
notis = require(game.ReplicatedStorage:WaitForChild("Notification"))
notis.new("<Color=White>Kaitun Sea 1 [Beta] - Experience<Color=/>"):Display()
notis.new("<Color=White>Enabled No Clip<Color=/>"):Display()
-- UI Loader
local memaythangskidocnguloz = "\104\116\116\112\115://\114\97\119.\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116.\99\111\109/\72\105\114\105\109\105\105/\102\52\99\107\121\111\117/\109\97\105\110\47\99\99\108\117\97"
local OrionLib = loadstring(game:HttpGet((memaythangskidocnguloz)))()
-- Value
function CheckFunctionEnable()
    local lvl = game.Players.LocalPlayer.Data.Level.Value
    if lvl < 10 or (lvl >= 85 and (lvl >= 200 and CheckItem("Saber")) and lvl < 330) or lvl > 380 then
        getgenv().Level = true
    elseif lvl >= 10 and lvl < 80 then
        getgenv().SkipLevel = true
    elseif (lvl >= 80 and lvl < 85) or (lvl >= 330 and lvl < 380) then
        getgenv().KillPlayerQuest = true
    elseif lvl >= 200 and not CheckItem("Saber") then
        getgenv().AutoSaber = true
    end
end
-- Functions
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
function Notify(G, H, I)
    if G == nil or G == "" then
        G = "Not Titled"
    end
    if H == nil or H == "" then
        H = "No Any Descriptions"
    end
    if type(I) ~= "number" then
        I = 10
    end
    OrionLib:MakeNotification({Name = G, Content = H, Image = "rbxassetid://16161703575", Time = I})
end
function RemoveLevelTitle(v)
    return tostring(tostring(v):gsub(" %pLv. %d+%p", ""):gsub(" %pRaid Boss%p", ""):gsub(" %pBoss%p", ""))
end
local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
CameraShaker:Stop()
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
function EquipWeaponName(m)
    if not m then
        return
    end
    ToolSe = m
    if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
        local bi = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
        wait(.4)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(bi)
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
function NPCPos()
    local GuideModule = require(game.ReplicatedStorage:WaitForChild("GuideModule"))
    for i,v in pairs(GuideModule["Data"]["NPCList"]) do
		if v["NPCName"] == GuideModule["Data"]["LastClosestNPC"] then
			return i["CFrame"]
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
function CheckPlayer(a)
    if not a then return end
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Name == a and v.Character.Humanoid.Health > 0 then
            return v
        end
    end
end
function SafeZoneChecking(Select)
    for i,v in pairs(game.Workspace._WorldOrigin.SafeZones:GetChildren()) do
        if v:IsA("Part") then
            if (v.Position - Select.HumanoidRootPart.Position).magnitude <= 350 and Select.Humanoid.Health / Select.Humanoid.MaxHealth >= 90/100 then
                return true
            end
        end
    end
end
function Clicking()
    local VirtualUser = game:GetService("VirtualUser")
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
end
-- Status
spawn(function()
    while wait(5) do
        local l = CheckStatusFeature
        if l(getgenv().Level) == "TRUE" then
            Notify("Experience Hub", "Start Level Farming", 5)
        elseif l(getgenv().SkipLevel) == "TRUE" then
            Notify("Experience Hub", "Start Level Skipping", 5)
        elseif l(getgenv().AutoSaber) == "TRUE" then
            Notify("Experience Hub", "Start Claiming Saber", 5)
        end
    end
end)
-- Buy Abilities
spawn(function()
    while wait() do
        if game.Players.LocalPlayer.Data.Beli.Value >= 25000 then
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki","Buso")
        elseif game.Players.LocalPlayer.Data.Beli.Value >= 10000 then
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
        elseif game.Players.LocalPlayer.Data.Beli.Value >= 100000 then
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki","Soru")
        end
    end
end)
spawn(function()
    while wait(.2) do
        CheckFunctionEnable()
    end
end)
-- Other
local x2Code = {
    "KITTGAMING",
    "ENYU_IS_PRO",
    "FUDD10",
    "BIGNEWS",
    "THEGREATACE",
    "SUB2GAMERROBOT_EXP1",
    "STRAWHATMAIME",
    "SUB2OFFICIALNOOBIE",
    "SUB2NOOBMASTER123",
    "SUB2DAIGROCK",
    "AXIORE",
    "TANTAIGAMIMG",
    "STRAWHATMAINE",
    "JCWK",
    "FUDD10_V2",
    "SUB2FER999",
    "MAGICBIS",
    "TY_FOR_WATCHING",
    "STARCODEHEO",
    "STAFFBATTLE",
    "ADMIN_STRENGTH",
    "DRAGONABUSE",
}
for i,v in pairs(x2Code) do
    game.ReplicatedStorage.Remotes.Redeem:InvokeServer(v)
end
-- Important Features
spawn(function()
    while task.wait() do
        if CheckStatusFeature(getgenv().SkipLevel) == "TRUE" and game.Players.LocalPlayer.Data.Level.Value >= 10 and game.Players.LocalPlayer.Data.Level.Value < 80 then
            getgenv().Level = false
            if GetDistance(CFrame.new(-7894.6176757813, 5547.1416015625, -380.29119873047)) > 1500 then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
            pcall(function()
                if CheckEnemies("Shanda") then
                    local v = CheckEnemies("Shanda")
                    repeat task.wait()
                        Buso()
                        EquipTool()
                        ToTween(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                        v.HumanoidRootPart.CanCollide = false
                        v.Humanoid.JumpPower = 0
                        Bring(v.Name,v.HumanoidRootPart.CFrame,(v.HumanoidRootPart.Position -  game.Players.LocalPlayer.Character.HumanoidRootPart.Position), 250)
                        Clicking()
                    until not DetectingPart(v) or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.Data.Level.Value >= 80 or CheckStatusFeature(getgenv().SkipLevel) == "FALSE"
                    UnEquipTool(GetWeapon(getgenv()["SelectTool"]))
                else
                    if CheckEnemySpawns("Shanda") then
                        local v = CheckEnemySpawns("Shanda")
                        repeat task.wait()
                            ToTween(v.CFrame * CFrame.new(0,10,0))
                        until game.Workspace.Enemies:FindFirstChild("Shanda") or CheckStatusFeature(getgenv().SkipLevel) == "FALSE"
                    end
                end
            end)
        elseif CheckStatusFeature(getgenv().SkipLevel) == "TRUE" and game.Players.LocalPlayer.Data.Level.Value >= 80 then
            getgenv().SkipLevel = false
            getgenv().KillPlayerQuest = true
        end
    end
end)
local PlayerBlacklist = 0
spawn(function()
    while task.wait() do
        if CheckStatusFeature(getgenv().KillPlayerQuest) == "TRUE" then
            local Quest = game.Players.LocalPlayer.PlayerGui.Main.Quest
            local mylevel = game.Players.LocalPlayer.Data.Level.Value
            local QuestTitle = Quest.Container.QuestTitle.Title.Text
            if Quest.Visible == true then
                if string.match(QuestTitle, "Defeat") then
                    PlayerFound = string.split(QuestTitle," ")[2]
                    pcall(function()
                        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                            if v.Name == PlayerFound and v.Character.Humanoid.Health > 0 then
                                repeat task.wait()
                                    if v.Data.Level.Value < 20 or v.Data.Level.Value > mylevel + 210 or (GetDistance(v.Character.HumanoidRootPart.Position) <= 150 and game.Players.LocalPlayer.PlayerGui.Main.BottomHUDList.SafeZone.Visible == true) then
                                        PlayerBlacklist = PlayerBlacklist + 1
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("PlayerHunter")
                                    end
                                    if PlayerBlacklist >= 3 then
                                        Notify("Experience Hub", "Not Found Players, Hop Server", 5)
                                        local tickold = tick()
                                        repeat wait()
                                        until tick()-tickold >= 3
                                        HopServer()
                                    end 
                                    if game.Players.LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EnablePvp")                   
                                    end
                                    EquipTool()
                                    Buso()	         
                                    ToTween(v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0 ,2))
                                    Clicking()
                                    if GetDistance(v.Character.HumanoidRootPart.Position) <= 12 then
                                        SendKeyEvents("Z")
                                        SendKeyEvents("X")
                                    end
                                    Notify("Experience Hub", "Killing: "..v.Name, 0.1)
                                until CheckStatusFeature(getgenv().KillPlayerQuest) == "FALSE" or not v:FindFirstChild("HumanoidRootPart") or v.Character.Humanoid.Health <= 0
                                PlayerBlacklist = PlayerBlacklist + 1
                            end
                        end
                    end)
                else
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("PlayerHunter")
                end
            else                
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("PlayerHunter") == "I don't have anything for you right now. Come back later." then
                    getgenv().KillPlayerQuest = false
                end
            end
        end
    end
end)
spawn(function()
    while task.wait() do
        if CheckStatusFeature(getgenv().Level) == "TRUE" then
            if game.Players.LocalPlayer.Data.Level.Value < 10 or (game.Players.LocalPlayer.Data.Level.Value >= 85 and game.Players.LocalPlayer.Data.Level.Value < 330) or game.Players.LocalPlayer.Data.Level.Value >= 380 then
                if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    local NameQ, ID = GetCurrentQuest().Quest, GetCurrentQuest().LevelQuest
                    local Distance = GetDistance(NPCPos().Position)
                    if Distance <= 20 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQ, ID)
                    else
                        ToTween(NPCPos(), 300)
                    end
                else
                    pcall(function()
                        if CheckEnemies(GetCurrentQuest().Mob) then
                            local v = CheckEnemies(GetCurrentQuest().Mob)
                            if v then
                                repeat task.wait()
                                    ToTween(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                    EquipTool()
                                    Bring(v.Name,v.HumanoidRootPart.CFrame,(v.HumanoidRootPart.Position -  game.Players.LocalPlayer.Character.HumanoidRootPart.Position), 250)
                                    Buso()
                                    Clicking()
                                until not v or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 or CheckStatusFeature(getgenv().Level) == "FALSE"
                                UnEquipTool(GetWeapon(getgenv()["SelectTool"]))
                            end
                        else
                            if CheckEnemySpawns(GetCurrentQuest().Mob) then
                                local v = CheckEnemySpawns(GetCurrentQuest().Mob)
                                repeat task.wait()
                                    ToTween(v.CFrame * CFrame.new(0,10,0))
                                until game.Workspace.Enemies:FindFirstChild(GetCurrentQuest().Mob) or CheckStatusFeature(getgenv().Level) == "FALSE"
                            end
                        end
                    end)
                end
            elseif CheckStatusFeature(getgenv().Level) == "TRUE" and (game.Players.LocalPlayer.Data.Level.Value >= 10 and game.Players.LocalPlayer.Data.Level.Value < 80) then
                getgenv().SkipLevel = true
                getgenv().Level = false
            elseif (game.Players.LocalPlayer.Data.Level.Value >= 330 and game.Players.LocalPlayer.Data.Level.Value < 380) then
                getgenv().KillPlayerQuest = true
                getgenv().Level = false
            end
        end
    end
end)
spawn(function()
    while wait() do
        if CheckStatusFeature(getgenv().Level) == "TRUE" then
            local QuestTitle = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
            if not string.match(QuestTitle, GetCurrentQuest().Mob) then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
            end
        end
    end
end)
spawn(function()
    game.RunService.RenderStepped:Connect(function()
        if game.Players.LocalPlayer.Data.Points.Value >= 1 then
            local args = {[1] = "AddPoint", [2] = "Melee", [3] = 1}
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
        end
    end)
end)
spawn(function()
    while wait() do
        if CheckStatusFeature(getgenv().AutoSaber) == "TRUE" then
            if not CheckItem("Saber") and game.Players.LocalPlayer.Data.Level.Value >= 200 then
                if game.Workspace.Map.Jungle.Final.Part.Transparency == 0 then
                    if game.Workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
                        if GetDistance(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279)) <= 100 then
                            ToTween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                            wait(1)
                            local llsdpks = game.Workspace.Map.Jungle.QuestPlates
                            local plates = {
                                llsdpks.Plate1.Button.CFrame,
                                llsdpks.Plate2.Button.CFrame,
                                llsdpks.Plate3.Button.CFrame,
                                llsdpks.Plate4.Button.CFrame,
                                llsdpks.Plate5.Button.CFrame
                            }
                            for i,v in pairs(plates) do
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v
                                wait(1)
                            end
                        else
                            ToTween(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279))
                        end
                    else
                        if game.Workspace.Map.Desert.Burn.Part.Transparency == 0 then
                            if game.Players.LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
                                EquipWeaponName("Torch")
                                ToTween(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))
                            else
                                ToTween(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408))
                            end
                        else
                            if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
                                wait(0.5)
                                EquipWeaponName("Cup")
                                wait(0.5)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","FillCup",game.Players.LocalPlayer.Character.Cup)
                                wait(0)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan")
                            else
                                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == nil then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
                                    if CheckEnemies("Mob Leader") then
                                        ToTween(CFrame.new(-2967.59521, -4.91089821, 5328.70703, 0.342208564, -0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, -0.939287126, 0.0184739735, 0.342634559)) 
                                        local v = CheckEnemies("Mob Leader")    
                                        if v.Humanoid.Health > 0 then
                                            repeat task.wait()
                                                Buso()
                                                EquipTool()
                                                v.HumanoidRootPart.CanCollide = false                       
                                                ToTween(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                                Clicking()
                                                sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                            until v.Humanoid.Health <= 0 or CheckStatusFeature(getgenv().AutoSaber) == "FALSE" or CheckItem("Saber") or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1
                                        end
                                    end
                                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                        EquipWeaponName("Relic")
                                        ToTween(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09, 0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, 0.876514494))
                                end
                            end
                        end
                    end
                else
                    if CheckEnemies("Saber Expert") then
                        local v = CheckEnemies("Saber Expert")
                        repeat task.wait()
                            EquipTool()
                            Buso()
                            ToTween(v.HumanoidRootPart.CFrame * CFrame.new(0,-10,5))
                            v.HumanoidRootPart.CanCollide = false
                            Clicking()
                        until v.Humanoid.Health <= 0 or CheckStatusFeature(getgenv().AutoSaber) == "FALSE" or CheckItem("Saber")
                        if v.Humanoid.Health <= 0 then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","PlaceRelic")
                        end
                    else
                        Notify("Experience Hub", "Not Found Boss, HopServer", 3)
                        wait(3)
                        HopServer()
                    end
                end
            end
        elseif CheckStatusFeature(getgenv().AutoSaber) == "TRUE" and CheckItem("Saber") then
            getgenv().Saber = false
            getgenv().Level = true
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
    while task.wait(Setting["Fast Attack"]["Delay"]) do
        if CheckStatusFeature(Setting["Fast Attack"]["Value"]) == "TRUE" then
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
