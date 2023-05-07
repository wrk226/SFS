print("Loading...");
Invisfunc = function()
	local removeNametags = false;
	local plr = game:GetService("Players").LocalPlayer;
	local character = plr.Character;
	local hrp = character.HumanoidRootPart;
	local old = hrp.CFrame;
	if (not character:FindFirstChild("LowerTorso") or (character.PrimaryPart ~= hrp)) then
		return print("unsupported");
	end
	if removeNametags then
		local tag = hrp:FindFirstChildOfClass("BillboardGui");
		if tag then
			tag:Destroy();
		end
		hrp.ChildAdded:Connect(function(item)
			if item:IsA("BillboardGui") then
				task.wait();
				item:Destroy();
			end
		end);
	end
	local newroot = character.LowerTorso:Clone();
	hrp.Parent = workspace;
	character.PrimaryPart = hrp;
	character:MoveTo(Vector3.new(old.X, 8999999488, old.Z));
	hrp.Parent = character;
	task.wait(0.5);
	newroot.Parent = hrp;
	hrp.CFrame = old;
end;

if ((#game.Players:GetPlayers() > 1) and isfile("SFS Sript/set") and (readfile("SFS Sript/set") == "true")) then
	Invisfunc();
end
local ConfigurationName = "SFS";
local closest = nil;
local selectedEgg = "Molten Egg";
local SelectedRelic = "";
local selecetWeaponGroup = "";
local ExpRelicList = {};
local Secret = {};
local RarityWl = {};
local DisRarityWl = {};
local Eggs = {};
local DisplayEggs = {};
local AreaMobsList = {};
local RelicLabelList = {};
local RelicButtonList = {};
local RelicPresetSetting = {Selected=nil,Default=nil,Dungeon=nil,BloodMoon=nil,Ngiht=nil};
local MobBlackList = {};
local MobWhiteList = {};
local SelectMobList = {};
local WeaponLabelList = {};
local WeaponButtonList = {};
local RollList = {};
local EnchantsRefuse = {};
local PetEnchantsRefuse = {};
local SelectedEnchant;
local SelectedPetEnchant;
local InfiniteJump = false;
local isBloodMoon = false;
local isServerBoss = false;
local isKillServerBoss = false;
local isSunBurst = false;
local isNight = false;
local hasUsed = false;
local nhasUsed = false;
local bhasUsed = false;
local InDungeon = false;
local BMing = false;
local Nighting = false;
local SunBursting = false;
local KillingGlobalBoss = false;
local ActiveRaid = nil;
local ContinueButtonUID = false;
local DungeonContinueButton = false;
local AreaMaps = {"Server Boss",
				  "Area 1","Area 2","Area 3","Area 4","Area 5",
				  "Area 6","Area 7","Area 8","Area 9","Area 10",
				  "Area 11","Area 12","Area 13","Area 14","Area 15",
				  "Area 16","Area 17","Area 18","Area 19"};
local Buy_Egg_Args = {eggName="Egg 25",auto=false,amount=4};
local AllMobs = {
    ["Server Boss"]={"Mummified Emperor","Chained Warrior","Water Drop OverLord","Kal'zim the Exiled Demon","Cherry Blossom Warrior","Firework Guardian","Unknown Viking Warrior"},
    ["Area 1"]={"Goblin","Orc","Dark Knight","Dark Commander","Sea Emperor"},
    ["Area 2"]={"Skeleton","Pirate Thief","Pirate Captain","Pirate Admiral"},
    ["Area 3"]={"Ninja","Samurai","Samurai Master","Oni"},
    ["Area 4"]={"Penguin","Snow Warrior","Yeti","Ice King"},
    ["Area 5"]={"Monk","Angel","Guardian","Zeus the God"},
    ["Area 6"]={"Imp","Demon","Lava Golem","Red Devil"},
    ["Area 7"]={"Mummy","Royal Warrior","Desert Beast","King Pharaoh"},
    ["Area 8"]={"Satyr","Cyclops","Purple Dragon","Adurite Warden","Lost Soul"},
    ["Area 9"]={"Mushy","Zombie Miner","Golem","Necromancer","Blood Zombie","Blood Vampire"},
    ["Area 10"]={"Power Force","Paladin","Warlock","Spirit Lord","Brown Insect","Green Insect","Mutant Insect"},
    ["Area 11"]={"Marine","Barbarian Pirate","Madman","Skye Knight","Malevolent Spirit","Lost Titan","Blood Knight"},
    ["Area 12"]={"Feathered Warrior","Cthulhu","Centaur King","Celestial Gatekeeper","Skywatcher","Stormbringer","Vulcanus Maximus","Demonic Altar"},
    ["Area 13"]={"Dune Critter","Reptilian Beast","Sandstone Golem","Scorpion Queen","Haunted Witch","Haunted Reaper","Nightstalker","Forsaken Hunter"},
    ["Area 14"]={"Small Titan","Cart Titan","Beast Titan","Colossus Titan","Founding Titan","Warhammer Titan","Jaw Titan"},
    ["Area 15"]={"Poseidon's Warrior","Undertides Bounty Hunter","Seaborn","Unknown Deep Sea Diver","Abyssal Hunter","Amaia","Gawain the Half Shark Man"},
    ["Area 16"]={"Magma Monster","Underwold Dealer","Undead Knight","Lucifer","Corrupted Demon","Scarlet Fiend","Hell's Warrior","Muay Thai Demon"},
    ["Area 17"]={"Hapkido Grandmaster","Black Tiger","Crimson Phoenix","Dragon Whisperer","Korean Wind","Korean Sunrise","Seoul Shogun"},
	["Area 18"]={"Blindfolded Fighter","Nunchaku Master","Marked Guardian","The Silent Oni","Novice","Lin Mei","Tribal Guardian"},
	["Area 19"]={"Jarl","Berserker","Spear Master","Wolf Hunter","Viking","Lagertha","Bear Leader"}
};
local BloodMoonMobs = {"Blood Zombie","Blood Vampire",
                       "Mutant Insect",
					   "Blood Knight",
					   "Vulcanus Maximus",
					   "Nightstalker","Forsaken Hunter",
					   "Warhammer Titan","Jaw Titan",
					   "Amaia","Gawain the Half Shark Man",
					   "Hell's Warrior","Muay Thai Demon",
					   "Korean Sunrise","Seoul Shogun",
					   "Lin Mei","Tribal Guardian",
					   "Lagertha","Bear Leader"};
local ServerBossList = {"Mummified Emperor","Chained Warrior","Water Drop Overlord",
                        "Kal'zim the Exiled Demon","Cherry Blossom Warrior","Firework Guardian",
					    "Unknown Viking Warrior"};
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local KnitService = game:GetService("ReplicatedStorage").Packages.Knit.Services;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Workspace = game:GetService("Workspace");
local Knit_Pkg = require(game:GetService("ReplicatedStorage").Packages.Knit);
local PlayerData = Knit_Pkg.GetController("DataController"):GetData("PlayerData");
local SwordDatabase = Knit_Pkg.GetController("DatabaseController"):GetDatabase("Weapons");
local EggsDatabase = Knit_Pkg.GetController("DatabaseController"):GetDatabase("Eggs");
local PetsDatabase = Knit_Pkg.GetController("DatabaseController"):GetDatabase("Pets");
local GlobalBoss = Knit_Pkg.GetController("DatabaseController"):GetDatabase("GlobalBoss");
local UIController = Knit_Pkg.GetController("UIController");
local TPController = Knit_Pkg.GetController("TeleportController");
local WController = Knit_Pkg.GetController("WheelController");
local KWController = Knit_Pkg.GetController("KoreanWheelController");
local NPCController = Knit_Pkg.GetController("NPCController");
local IllusionistService = Knit_Pkg.GetService("IllusionistService");
local SkillService = Knit_Pkg.GetService("SkillService");
local Dungeon_Service = Knit_Pkg.GetService("DungeonService");
local NPCService = Knit_Pkg.GetService("NPCService");
local LimitedController = Knit_Pkg.GetController("LimitedShopsController");
local Util = require(Knit_Pkg.Util.Utility);
local MyGui = Instance.new("ScreenGui");
task.spawn(function()
	local Foot = game:GetService("Players").LocalPlayer.Character:FindFirstChild("RightFoot");
	local Hrp = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
	local oldPos = Hrp.CFrame;
	local dConnection = false;
	task.spawn(function()
		task.wait(1);
		getgenv().Connection = Foot.Touched:Connect(function()
			dConnection = true;
		end);
	end);
	repeat
		task.wait();
		Hrp.CFrame = CFrame.new(Workspace:GetAttribute("DungeonSpawn"));
		wait(2);
	until dConnection == true 
	getgenv().Connection:Disconnect();
	wait(0.5);
	Hrp.CFrame = oldPos;
end);
wait(1);
TPController:Teleport({pos=GlobalBoss.spawnPos,areaName=nil,regionName="Global Boss",leaveGamemode=true});
wait(1);
local repo = "https://raw.githubusercontent.com/wrk226/SFS/main/LinoriaLibUI/";
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))();
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))();
SaveManager:SetFolder("SFSConfiguration");
SaveManager:SetLibrary(Library);
local Window = Library:CreateWindow({Title="SFS Sript",
									 Center=true,
									 AutoShow=true,
									--Size = UDim2.fromOffset(550, 340)
});
--added code
local my_UDatas = {}
--local my_Labels = {}
local Labels = {}
--------------------
--Library:CreateUserData("UDatas");
local Tabs = {MainTab=Window:AddTab("主目录-地牢"),RelicTab=Window:AddTab("饰品-事件"),Farm=Window:AddTab("扫荡-宠物-其他"),MiscTab=Window:AddTab("筛选器"),EnchantTab=Window:AddTab("附魔")};
local AutoClick = Tabs.MainTab:AddLeftGroupbox("自动点击");
local Pet = Tabs.MainTab:AddLeftGroupbox("宠物");
local Weapon = Tabs.MainTab:AddLeftGroupbox("武器");
local Dungeon = Tabs.MainTab:AddRightGroupbox("地牢");
local Tower = Tabs.MainTab:AddRightGroupbox("塔");
local Raid = Tabs.MainTab:AddRightGroupbox("突袭");
local BloodMoonEvent = Tabs.RelicTab:AddLeftGroupbox("血月事件");
local HightEvent = Tabs.RelicTab:AddLeftGroupbox("夜晚事件");
local Skillboss = Tabs.RelicTab:AddLeftGroupbox("技能Boss");
local Upgrade = Tabs.RelicTab:AddRightGroupbox("升级");
local UpgradeList = Tabs.RelicTab:AddRightGroupbox("升级列表");
local AutoFarmBox = Tabs.Farm:AddLeftGroupbox("自动扫荡");
local BlackList = Tabs.Farm:AddLeftGroupbox("排除列表");
local WhiteListList = Tabs.Farm:AddLeftGroupbox("保留列表");
local Egg = Tabs.Farm:AddRightGroupbox("宠物");
local Misc = Tabs.Farm:AddRightGroupbox("其他");
local Filter = Tabs.MiscTab:AddLeftGroupbox("武器筛选器");
local FilterList = Tabs.MiscTab:AddLeftGroupbox("武器筛选列表");
local PetFilter = Tabs.MiscTab:AddRightGroupbox("宠物筛选器");
local PetFilterList = Tabs.MiscTab:AddRightGroupbox("宠物筛选列表");
local Enchant = Tabs.EnchantTab:AddLeftGroupbox("附魔");
local RollList = Tabs.EnchantTab:AddRightGroupbox("附魔列表");
Library:OnUnload(function()
	MyGui:Destroy();
end);
AutoClick:AddToggle("AutoPower", {Text="快速点击",Default=false,Tooltip="快速点击"});
AutoClick:AddSlider("AuraDistance", {Text="索敌距离",Default=40,Min=0,Max=50,Rounding=0,Compact=false});
AutoClick:AddSlider("ClickSpeed", {Text="点击速度(建议1-5,高了容易崩溃)",Default=4,Min=0,Max=100,Rounding=0,Compact=false});
Pet:AddToggle("AutoDismantle", {Text="自动拆解",Default=false,Tooltip="自动拆解"});
Pet:AddSlider("DismantleDelay", {Text="拆解延迟",Default=60,Min=0,Max=100,Rounding=0,Compact=false});
Pet:AddToggle("DisRarityCheck", {Text="稀有度检测",Default=false,Tooltip="Rarity Check"});
Pet:AddDropdown("PetAddToWhitelist", {Values={"Common","Rare","Epic","Legendary","Mythic","Secret"},Default=0,Multi=true,Text="加入保留列表",Tooltip="加入保留列表"});
Weapon:AddToggle("AutoSell", {Text="自动售卖",Default=false,Tooltip="自动售卖"});
Weapon:AddSlider("SWordSellDelay", {Text="售卖延迟",Default=30,Min=0,Max=100,Rounding=0,Compact=false});
Weapon:AddToggle("WeaponRarityCheck", {Text="稀有度检测",Default=false,Tooltip="稀有度检测"});
Weapon:AddDropdown("WeaponAddtoWhitelist", {Values={"Common","Rare","Epic","Legendary","Mythic","Secret"},Default=0,Multi=true,Text="加入保留列表",Tooltip="加入保留列表"});
Egg:AddToggle("AutoOpenEggs", {Text="自动开蛋",Default=false,Tooltip="自动开蛋"});
Egg:AddToggle("IgnoreOpneAmination", {Text="跳过开蛋动画",Default=false,Tooltip="跳过开蛋动画"});
Egg:AddDropdown("EggsSelected", {Values={},Default=0,Multi=false,Text="目标蛋",Tooltip="目标蛋"});
Egg:AddDropdown("EggsAmounts", {Values={1,2,3,4},Default=0,Multi=false,Text="开蛋数量",Tooltip="开蛋数量"});
Egg:AddButton("传送到目标蛋", function()
	LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
end);
Dungeon:AddToggle("AutoEasy", {Text="自动简单地牢",Default=false,Tooltip="自动简单地牢"});
Dungeon:AddSlider("EasyRoom", {Text="层数",Default=30,Min=0,Max=50,Rounding=0,Compact=false});
Dungeon:AddToggle("AutoHard", {Text="自动困难地牢",Default=false,Tooltip="自动困难地牢"});
Dungeon:AddSlider("HardRoom", {Text="层数",Default=30,Min=0,Max=50,Rounding=0,Compact=false});
Dungeon:AddToggle("AutoInsane", {Text="自动炼狱地牢",Default=false,Tooltip="自动炼狱地牢"});
Dungeon:AddSlider("InsaneRoom", {Text="层数",Default=30,Min=0,Max=50,Rounding=0,Compact=false});
Dungeon:AddSlider("WaitTime", {Text="等待时间",Default=0,Min=0,Max=1,Rounding=2,Compact=false});
Dungeon:AddInput("UseDamageRooms", {Default="0",Numeric=true,Finished=false,Text="困难地牢自动使用攻击药的层数",Tooltip="困难地牢自动使用攻击药的层数",Placeholder="Placeholder text"});
Dungeon:AddInput("UseInsaneDamageRooms", {Default="0",Numeric=true,Finished=false,Text="炼狱地牢自动使用攻击药的层数",Tooltip="炼狱地牢自动使用攻击药的层数",Placeholder="Placeholder text"});
Dungeon:AddDropdown("DungeonWeapon", {Values={},Default=0,Multi=false,Text="炼狱地牢装备",Tooltip="选取炼狱地牢装备"});
Dungeon:AddButton("重置地牢状态", function()
	InDungeon = false;
end);
Tower:AddToggle("AutoTower", {Text="自动爬塔",Default=false,Tooltip="自动爬塔"});
Raid:AddToggle("AutoRaid", {Text="自动突袭",Default=false,Tooltip="自动突袭"});
Labels.UpgradeId = UpgradeList:AddLabel("升级饰品ID", "", true);
Labels.UpgradeName = UpgradeList:AddLabel("升级饰品名", "", true);
Labels.UpgradeExp = UpgradeList:AddLabel("升级饰品经验", "", true);
Upgrade:AddToggle("AutoUpgradeRelic", {Text="自动升级饰品",Default=false,Tooltip="自动升级饰品"});
Labels.BlackList = Upgrade:AddLabel("熔炼列表", "20/25");
Upgrade:AddButton("增加所有到熔炼列表", function()
	for i, v in pairs(PlayerData.RelicAutoDelete) do
		if not v then
			KnitService.RelicInvService.RF.ToggleAutoDelete:InvokeServer(i);
			wait();
		end
	end
end);
Upgrade:AddButton("保存熔炼清单", function()
	ExpRelicList = {};
	for i, v in pairs(PlayerData.RelicAutoDelete) do
		if v then
			table.insert(ExpRelicList, i);
			KnitService.RelicInvService.RF.ToggleAutoDelete:InvokeServer(i);
			wait();
		end
	end
	my_UDatas["ExpRelicList"] = ExpRelicList
	--UserDatas.UDatas:SetValue("ExpRelicList", ExpRelicList);
	--my_Labels['BlackList'] = "All:" .. #ExpRelicList
	Labels.BlackList:SetText("All:" .. #ExpRelicList);
end):AddButton("选择要升级的饰品", function()
	local selec = nil;
	for i, v in pairs(LocalPlayer.PlayerGui.Inventory.Background.ImageFrame.Window.Frames.ItemsFrame.ItemsHolder.ItemsScrolling:GetChildren()) do
		if (v:IsA("Frame") and (v.Frame.Selected.Visible == true)) then
			selec = v.Name;
		end
	end
	if selec then
		SelectedRelic = selec;
		--my_Labels["UpgradeId"] = selec
		Labels.UpgradeId:SetText(selec);
		my_UDatas["UpgradeId"] = PlayerData.RelicInv[selec].name
		--UserDatas.UDatas:SetValue("UpgradeId", selec);
		--my_Labels["UpgradeName"] = PlayerData.RelicInv[selec].name
		Labels.UpgradeName:SetText(PlayerData.RelicInv[selec].name);
		my_UDatas["UpgradeName"] = PlayerData.RelicInv[selec].name
		--UserDatas.UDatas:SetValue("UpgradeName", PlayerData.RelicInv[selec].name);
		--my_Labels["UpgradeExp"] = PlayerData.RelicInv[selec].exp
		Labels.UpgradeExp:SetText(PlayerData.RelicInv[selec].exp);
		my_UDatas["UpgradeExp"] = PlayerData.RelicInv[selec].exp
		--UserDatas.UDatas:SetValue("UpgradeExp", PlayerData.RelicInv[selec].exp);
	else
		--my_Labels["UpgradeId"] = "NULL"
		Labels.UpgradeId:SetText("NULL");
	end
end);
Upgrade:AddDropdown("Relic_DefaultWeaponGroup", {Values={},Default=0,Multi=false,Text="默认装备",Tooltip="默认装备"});
AutoFarmBox:AddToggle("autoFarm", {Text="自动扫荡",Default=false,Tooltip="自动扫荡"});
AutoFarmBox:AddToggle("FarmAllMap", {Text="扫荡所有地图",Default=false,Tooltip="扫荡所有地图"});
AutoFarmBox:AddToggle("FarmSelectedMobs", {Text="扫荡选定怪",Default=false,Tooltip="扫荡选定怪"});
Labels.MonstersLabel = AutoFarmBox:AddLabel("怪物列表", "list");
AutoFarmBox:AddDropdown("SelectedArea", {Values=AreaMaps,Default=0,Multi=false,Text="选择地图",Tooltip="选择地图"});
AutoFarmBox:AddDropdown("SelectedMob", {Values={},Default=0,Multi=true,Text="排除列表",Tooltip="排除列表"});
Labels.BlackListLabel = BlackList:AddLabel("排除列表", "", true);
Labels.WhiteListLabel =  WhiteListList:AddLabel("保留列表", "", true);
AutoFarmBox:AddDropdown("OtherMob", {Values={},Default=0,Multi=true,Text="保留列表",Tooltip="保留列表"});
AutoFarmBox:AddButton("保存排除列表", function()
	--my_Labels["BlackListLabel"] = ""
	Labels.BlackListLabel:SetText("");
	local MobBlackListStr = "";
	for key, value in next, Options.SelectedMob.Value do
		if not table.find(MobBlackList, key) then
			table.insert(MobBlackList, key);
		end
	end
	for key, value in next, MobBlackList do
		MobBlackListStr = MobBlackListStr .. value .. "\n";
	end
	if (#MobBlackList == 0) then
		MobBlackListStr = MobBlackListStr .. "is NULL";
	end
	--my_Labels["BlackListLabel"] = MobBlackListStr
	Labels.BlackListLabel:SetText(MobBlackListStr);
	my_UDatas["MobBlackList"] =  MobBlackList
	--UserDatas.UDatas:SetValue("MobBlackList", MobBlackList);
end):AddButton("保存保留列表", function()
	--my_Labels["WhiteListLabel"] = ""
	Labels.WhiteListLabel:SetText("");
	local MobWhiteListStr = "";
	for key, value in next, Options.OtherMob.Value do
		if not table.find(MobWhiteList, key) then
			table.insert(MobWhiteList, key);
		end
	end
	for key, value in next, MobWhiteList do
		MobWhiteListStr = MobWhiteListStr .. value .. "\n";
	end
	if (#MobWhiteList == 0) then
		MobWhiteListStr = MobWhiteListStr .. "is NULL";
	end
	--my_Labels["WhiteListLabel"] = MobWhiteListStr
	Labels.WhiteListLabel:SetText(MobWhiteListStr);
	my_UDatas["MobWhiteList"]=MobWhiteList
	--UserDatas.UDatas:SetValue("MobWhiteList", MobWhiteList);
end);
AutoFarmBox:AddButton("清除排除列表", function()
	--my_Labels["BlackListLabel"] = ""
	Labels.BlackListLabel:SetText("");
	MobBlackList = {};
	my_UDatas["MobBlackList"]=MobBlackList
	--UserDatas.UDatas:SetValue("MobBlackList", MobBlackList);
end):AddButton("清除保留列表", function()
	--my_Labels["WhiteListLabel"] = ""
	Labels.WhiteListLabel:SetText("");
	MobWhiteList = {};
	my_UDatas["MobWhiteList"]=MobWhiteList
	--UserDatas.UDatas:SetValue("MobWhiteList", MobWhiteList);
end);
BloodMoonEvent:AddToggle("BloodMoonCheck", {Text="血月事件监测",Default=false,Tooltip="血月事件检测"});
BloodMoonEvent:AddToggle("CorruptEventCheck", {Text="腐坏事件监测",Default=false,Tooltip="Corrupt Event Check"});
BloodMoonEvent:AddLabel("自动使用药水", "自动使用药水", false);
BloodMoonEvent:AddToggle("AutoUseLuck", {Text="幸运药水",Default=false,Tooltip="幸运药水"});
BloodMoonEvent:AddToggle("AutoUseSecretLuck", {Text="秘密幸运药水",Default=false,Tooltip="秘密幸运药水"});
BloodMoonEvent:AddToggle("AutoUseCoin", {Text="金币药水",Default=false,Tooltip="金币药水"});
BloodMoonEvent:AddToggle("AutoUsePower", {Text="力量药水",Default=false,Tooltip="力量药水"});
BloodMoonEvent:AddToggle("AutoUseDmg", {Text="伤害药水",Default=false,Tooltip="伤害药水"});
BloodMoonEvent:AddDropdown("SelectMob", {Values=BloodMoonMobs,Default=BloodMoonMobs,Multi=true,Text="扫荡列表",Tooltip="选择你要扫荡的怪物"});
BloodMoonEvent:AddDropdown("SetWeaponGroup", {Values={},Default=0,Multi=false,Text="设置装备",Tooltip="设置装备"});
HightEvent:AddToggle("EggNight", {Text="夜晚开蛋",Default=false,Tooltip="夜晚开蛋"});
HightEvent:AddToggle("EggBurst",{Text="日耀开蛋",Default= false,Tooltip="日耀开蛋"})
HightEvent:AddLabel("自动使用药水");
HightEvent:AddToggle("hAutoUseLuck", {Text="幸运药水",Default=false,Tooltip="幸运药水"});
HightEvent:AddToggle("hAutoUseSecretLuck", {Text="秘密幸运药水",Default=false,Tooltip="秘密幸运药水"});
HightEvent:AddToggle("hAutoUsePower", {Text="力量药水",Default=false,Tooltip="力量药水"});
HightEvent:AddDropdown("hSetWeaponGroup", {Values={},Default=0,Multi=false,Text="设置装备",Tooltip="设置装备"});
Skillboss:AddToggle("ServerBossCheck", {Text="自动开启服务器Boss箱子",Default=false,Tooltip="自动开启服务器Boss箱子"});
Misc:AddLabel("自动购买");
Misc:AddToggle("DungeonItems", {Text="地牢物品",Default=false,Tooltip="地牢物品"});
Misc:AddToggle("TravellingMerchantItems", {Text="旅行商人物品",Default=false,Tooltip="旅行商人物品"});
Misc:AddToggle("AutoClaimChests", {Text="自动开箱",Default=false,Tooltip="自动开箱"});
Misc:AddToggle("InfiniteJump", {Text="无限跳跃",Default=false,Tooltip="无限跳跃"});
Misc:AddInput("PickUpRange", {Default="",Numeric=true,Finished=true,Text="拾取半径",Tooltip="拾取半径",Placeholder="PickUp Range"});
Misc:AddButton("交任务", function()
	for i, v in pairs(Knit_Pkg.GetController("DatabaseController"):GetDatabase("Questlines")) do
		task.spawn(function()
			KnitService.QuestService.RF.ActionQuest:InvokeServer(tostring(i));
		end);
		wait(0.5);
	end
end);
Misc:AddButton("打开宠物附魔机", function()
	UIController:OpenScreen("Traits");
end):AddButton("打开武器附魔机", function()
	UIController:OpenScreen("Enchant");
end);
Misc:AddButton("腐化商店", function()
	if Workspace:GetAttribute("CORRUPT_EVENT") then
		LimitedController:LoadElements("LurkingShadow");
		LimitedController:Open();
	else
		Library:Notify("没有检测到腐化事件", 5);
	end
end);
Misc:AddToggle("UnlockTP", {Text="解锁传送",Default=false,Tooltip="解锁传送"});
Misc:AddToggle("UnlockAutoSwing", {Text="解锁自动挥剑",Default=false,Tooltip="解锁自动挥剑"});
Misc:AddToggle("Invisibility", {Text="隐身",Default=false,Tooltip="隐身"});
Filter:AddToggle("UseFilterForAutoShell", {Text="使用脚本设置筛选武器附魔",Default=false,Tooltip="使用脚本设置筛选武器附魔"});
Filter:AddToggle("UseFilterForAutoRoll", {Text="使用附魔机设置筛选武器附魔",Default=false,Tooltip="使用附魔机设置筛选武器附魔"});
Filter:AddDropdown("Enchant", {Values={},Default=0,Multi=false,Text="Enchant",Tooltip="Enchant"});
Filter:AddDropdown("Tiers", {Values={0,1,2,3,4,5},Default=0,Multi=false,Text="Tiers",Tooltip="Tiers"});
Labels.FList = FilterList:AddLabel("筛选列表", "", true);
PetFilter:AddToggle("UsePetFilterForAutoShell", {Text="使用脚本设置筛选宠物附魔",Default=false,Tooltip="使用脚本设置筛选宠物附魔"});
PetFilter:AddDropdown("PetEnchant", {Values={},Default=0,Multi=false,Text="附魔种类",Tooltip="附魔种类"});
PetFilter:AddDropdown("PetTiers", {Values={0,1,2,3,4,5},Default=0,Multi=false,Text="附魔等级",Tooltip="附魔等级"});
Labels.PetFList = PetFilterList:AddLabel("宠物附魔列表", "", true);
Enchant:AddToggle("AutoRoll", {Text="自动附魔",Default=false,Tooltip="自动附魔"});
Enchant:AddToggle("CloseRollAnimation", {Text="关闭附魔动画",Default=false,Tooltip="关闭附魔动画"});
Labels.RList = RollList:AddLabel("附魔列表", "", true);
Enchant:AddButton("添加", function()
end);
Enchant:AddButton("锁定", function()
end):AddButton("清除", function()
end);
getgenv()._MAIN = true;
getgenv()._POWER = false;
getgenv().AutoFarm = false;
getgenv().FarmAllMap = false;
getgenv().FarmSelected = false;
getgenv().BloodMoonCheck = false;
getgenv().ServerBossCheck = false;
getgenv().CorruptEventCheck = false;
getgenv().isCorruptEvent = false;
getgenv().PetDis = false;
getgenv().SwordSell = false;
getgenv().OpEgg = false;
getgenv().ignoreAmin = false;
getgenv().UpRelic = false;
getgenv().DungeonAutoBuy = false;
getgenv().TravellingMerchantAutoBuy = false;
getgenv().AutoClaimChests = false;
getgenv().EasyDungeon = false;
getgenv().HardDungeon = false;
getgenv().InsaneDungeon = false;
getgenv().HardDungeonUseDamage = 0;
getgenv().InsaneDungeonUseDamage = 0;
getgenv().AutoTower = false;
getgenv().AutoRaid = false;
getgenv().bAutoUseLuckBoost = false;
getgenv().bAutoUseSecretLuckBoost = false;
getgenv().bAutoUseCoinBoost = false;
getgenv().bAutoUsePowerBoost = false;
getgenv().bAutoUseDmgBoost = false;
getgenv().nAutoUseLuckBoost = false;
getgenv().nAutoUseSecretLuckBoost = false;
getgenv().nAutoUsePowerBoost = false;
getgenv().RarityCheck = false;
getgenv().DisRarityCheck = false;
getgenv().UseFilter = false;
getgenv().UsePetFilter = false;
getgenv().Distance = 45;
getgenv().ClickSpeed = 5;
getgenv().SwordSellDelay = 40;
getgenv().DismantleDelay = 60;
getgenv().EasyReach = 50;
getgenv().HardReach = 40;
getgenv().InsaneReach = 10;
getgenv().DungeonWaitTime = 0;
getgenv().TowerReach = 62;
getgenv().lastOpenTime = 0;
getgenv().beforePos = LocalPlayer.Character.HumanoidRootPart.CFrame;
getgenv().RollResult = {};
getgenv().AutoRoll = false;
getgenv().IgnRollAmin = false;
getgenv().RollUseFilter = false;
getgenv().enchantsLevel = {"I","II","III","IV","V"};
for i, v in next, EggsDatabase do
	Eggs[v.name] = i;
	table.insert(DisplayEggs, v.name);
end
Options.EggsSelected.Values = DisplayEggs;
Options.EggsSelected:SetValues();
local EnchantTables = Knit_Pkg.GetController("DatabaseController"):GetDatabase("EnchantTables");
local WeaponEnchantTable = {};
local PetEnchantTable = {};
for i, v in pairs(EnchantTables) do
	for i, v2 in pairs(v) do
		local Ratestable = Knit_Pkg.GetController("DatabaseController"):GetDatabase(v2);
		if not Ratestable then
			continue;
		end
		for i, v3 in pairs(Ratestable) do
			if not v3 then
				continue;
			end
			if (v2 == "EnchantRates") then
				table.insert(WeaponEnchantTable, v3.name);
				EnchantsRefuse[v3.name] = 0;
			end
			if (v2 == "PetEnchantRates") then
				table.insert(PetEnchantTable, v3.name);
				PetEnchantsRefuse[v3.name] = 0;
			end
		end
	end
end
Options.Enchant.Values = WeaponEnchantTable;
Options.Enchant:SetValues();
Options.PetEnchant.Values = PetEnchantTable;
Options.PetEnchant:SetValues();
local WeaponGroups = {};
local loadWeaponGroup = function()
	local Loadouts = PlayerData.Loadouts;
	local WeaponGroupOptions = {};
	for addressId, WeaponGroup in Loadouts, nil do
		WeaponGroups[WeaponGroup.Name] = addressId;
		table.insert(WeaponGroupOptions, WeaponGroup.Name);
	end
	Options.Relic_DefaultWeaponGroup.Values = WeaponGroupOptions;
	Options.Relic_DefaultWeaponGroup:SetValues();
	Options.DungeonWeapon.Values = WeaponGroupOptions;
	Options.DungeonWeapon:SetValues();
	Options.SetWeaponGroup.Values = WeaponGroupOptions;
	Options.SetWeaponGroup:SetValues();
	Options.hSetWeaponGroup.Values = WeaponGroupOptions;
	Options.hSetWeaponGroup:SetValues();
end;
local EquipRelics = function(Preset)
	print("EquipRelics");
	task.spawn(function()
		Knit_Pkg.GetService("LoadoutService").EquipLoadout:Fire(WeaponGroups[Preset]);
		wait(2);
		Knit_Pkg.GetService("LoadoutService").EquipLoadout:Fire(WeaponGroups[Preset]);
	end);
	Knit_Pkg.GetService("LoadoutService").EquipLoadout:Fire(WeaponGroups[Preset]);
end;
loadWeaponGroup();
Upgrade:AddButton("使用默认装备", function()
	if (selecetWeaponGroup ~= nil) then
		EquipRelics(selecetWeaponGroup);
		Knit_Pkg.GetController("NotificationController"):Notification({message=("使用装备组 " .. selecetWeaponGroup),color="Red",multipleAllowed=false});
	end
end):AddButton("重新加载装备", function()
	loadWeaponGroup();
end);
local useBoost = function(Name)
	local useBoostsTask = task.spawn(function()
		local timeleft = (20 * 60) - PlayerData.Boosts[Name].timeLeft;
		while timeleft > 300 do
			if ((Name == "SecretLuck") and (timeleft > 1200) and PlayerData.Boosts[Name].remaining[1200] and (PlayerData.Boosts[Name].remaining[1200] == 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "1800");
				break;
			end
			if ((timeleft > 1200) and PlayerData.Boosts[Name].remaining["1200"] and (PlayerData.Boosts[Name].remaining["1200"] > 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "1200");
			elseif ((timeleft > 900) and PlayerData.Boosts[Name].remaining["900"] and (PlayerData.Boosts[Name].remaining["900"] > 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "900");
			elseif ((timeleft > 600) and PlayerData.Boosts[Name].remaining["600"] and (PlayerData.Boosts[Name].remaining["600"] > 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "600");
			elseif ((timeleft > 300) and PlayerData.Boosts[Name].remaining["300"] and (PlayerData.Boosts[Name].remaining["300"] > 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "300");
			end
			wait(1);
			timeleft = (21 * 60) - PlayerData.Boosts[Name].timeLeft;
		end
	end);
end;
local Closest_NPC = function(AutoFarmMode)
	local Closest = nil;
	local Dist = Distance;
	if AutoFarmMode then
		Dist = 900000000;
	end
	if (BloodMoonCheck and isBloodMoon and next(SelectMobList) and AutoFarmMode) then
		for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
			if v:IsA("Part") then
				if table.find(SelectMobList, v:GetAttribute("Name")) then
					if (v:GetAttribute("Health") == 0) then
						continue;
					end
					return v;
				end
			end
		end
		return nil;
	end
	if (ServerBossCheck and isServerBoss) then
		for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
			if (v:IsA("Part") and table.find(ServerBossList, v:GetAttribute("Name"))) then
				if isKillServerBoss then
					return nil;
				end
				return v;
			end
		end
		print("No ServerBoss");
		isServerBoss = false;
		task.spawn(function()
			if (typeof(RelicPresetSetting.Default) == "string") then
				EquipRelics(RelicPresetSetting.Default);
			end
			wait(2);
			LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
		end);
	end
	if (FarmAllMap and not InDungeon) then
		for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
			if v:IsA("Part") then
				local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if not Root then
					continue;
				end
				if (not InDungeon and FarmSelected and next(MobWhiteList) and not table.find(MobWhiteList, v:GetAttribute("Name"))) then
					continue;
				end
				if (table.find(MobBlackList, v:GetAttribute("Name")) and not KillingGlobalBoss) then
					continue;
				end
				if (v:GetAttribute("Health") == 0) then
					continue;
				end
				local Magnitude = (Root.Position - v.Position).Magnitude;
				if (Magnitude < Dist) then
					Closest = v;
					Dist = Magnitude;
				end
			end
		end
		return Closest;
	end
	if (((InDungeon == 2) or (InDungeon == 3)) and (DungeonWaitTime > 0)) then
		wait(DungeonWaitTime);
	end
	for i, v in next, Workspace.Live.NPCs.Client:GetChildren() do
		if v:IsA("Model") then
			local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
			local DstRoot = v:FindFirstChild("HumanoidRootPart");
			if (not Root or not DstRoot) then
				continue;
			end
			if (not InDungeon and AutoFarm and not LocalPlayer:GetAttribute("Raid") and FarmSelected and next(MobWhiteList)) then
				local NPCTag = DstRoot:FindFirstChild("NPCTag");
				if (NPCTag and not table.find(MobWhiteList, NPCTag:FindFirstChild("NameLabel").Text)) then
					continue;
				end
			end
			local Magnitude = (Root.Position - DstRoot.Position).Magnitude;
			if (Magnitude < Dist) then
				Closest = v;
				Dist = Magnitude;
			end
		end
	end
	return Closest;
end;
local CheckBMSpawn = function()
	for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
		if v:IsA("Part") then
			if table.find(SelectMobList, v:GetAttribute("Name")) then
				print("Founded!");
				return v;
			end
		end
	end
	print("Not Found!");
	return false;
end;
local CheckAccept = function(v, mode)
	local TierAccepts = PlayerData.AutoRerollTierAccepts;
	local Accept = PlayerData.AutoRerollAccept;
	local isDelete = true;
	if (#v.enchants == 0) then
		return false;
	end
	if mode then
		for i = 1, EnchantsRefuse[v.enchants[1].name] do
			if (enchantsLevel[i] == v.enchants[1].tier) then
				isDelete = false;
				break;
			end
		end
		return isDelete;
	elseif (Accept[v.enchants[1].name] and TierAccepts[v.enchants[1].tier]) then
		return true;
	end
	if (#v.enchants == 1) then
		return false;
	end
	if mode then
		if (EnchantsRefuse[v.enchants[2].name] and table.find(EnchantsRefuse[v.enchants[2].name], v.enchants[2].tier)) then
			return false;
		end
	elseif ((Accept[v.enchants[2].name] == false) or (TierAccepts[v.enchants[2].tier] == false)) then
		return false;
	end
end;
local CheckPet = function(v, mode)
	local TierLevel = PlayerData.AutoRerollTierAccepts;
	local Accept = PlayerData.AutoRerollAccept;
	local isDelete = true;
	if (#v.enchants == 0) then
		return false;
	end
	if mode then
		for i = 1, PetEnchantsRefuse[v.enchants[1].name] do
			if (enchantsLevel[i] == v.enchants[1].tier) then
				isDelete = false;
				break;
			end
		end
		return isDelete;
	elseif (Accept[v.enchants[1].name] and TierLevel[v.enchants[1].tier]) then
		return true;
	end
end;
local vu = game:GetService("VirtualUser");
game:GetService("Players").LocalPlayer.Idled:connect(function()
	vu:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame);
	wait(1);
	vu:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame);
end);
Workspace:SetAttribute("PICKUP_RANGE", 1000);
for i, v in next, SwordDatabase do
	if (v.rarity == "Secret") then
		table.insert(Secret, v.name);
	end
end
coroutine.wrap(function()
	while wait() do
		closest = nil;
		closest = Closest_NPC();
	end
end)();
coroutine.wrap(function()
	while wait(0.2) do
		if (LocalPlayer:GetAttribute("NPC") ~= nil) then
			local Skills = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SkillsBottom"):WaitForChild("Skills");
			local u2 = {Skills:WaitForChild("Template"),Skills:WaitForChild("Template2"),Skills:WaitForChild("Template3")};
			for v48, v49 in u2, nil do
				SkillService:CastSpell(LocalPlayer:GetAttribute("NPC"), v49:GetAttribute("Skill"));
			end
		end
	end
end)();
game:GetService("ReplicatedStorage").ActiveRaids.ChildAdded:Connect(function()
	if AutoRaid then
		wait(3);
		getgenv().lastOpenTime = Workspace:GetAttribute("CURRENT_TIME");
		print("Raid Opened");
		Knit_Pkg.GetController("NotificationController"):Notification({message="突袭开始",color="RobuxColor",multipleAllowed=false});
		Knit_Pkg.GetController("NotificationController"):Notification({message="将在170秒后加入...",color="Orange",multipleAllowed=false});
	end
end);
coroutine.wrap(function()
	while wait(4) do
		if BloodMoonCheck then
			isBloodMoon = Workspace:GetAttribute("BLOOD_MOON_EVENT");
			if (isBloodMoon and not BMing) then
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = beforePos;
				local BMSpawn = CheckBMSpawn();
				if not BMSpawn then
					continue;
				end
				print("检测到血月事件");
				if (bAutoUseLuckBoost or bAutoUseSecretLuckBoost or bAutoUseCoinBoost or bAutoUsePowerBoost or (bAutoUseDmgBoost and not hasUsed)) then
					hasUsed = true;
					if bAutoUseLuckBoost then
						print("Blood moon event use Luck boosts");
						useBoost("Luck");
					end
					if bAutoUseSecretLuckBoost then
						print("Blood moon event use SecretLuck boosts");
						useBoost("SecretLuck");
					end
					if bAutoUseCoinBoost then
						print("Blood moon event use Coins boosts");
						useBoost("Coins");
					end
					if bAutoUsePowerBoost then
						print("Blood moon event use Power boosts");
						useBoost("Power");
					end
					if bAutoUseDmgBoost then
						print("Blood moon event use Damage boosts");
						useBoost("Damage");
					end
				end
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = BMSpawn.CFrame * CFrame.new(0, 6, -2.5);
				if (typeof(RelicPresetSetting.BloodMoon) == "string") then
					EquipRelics(RelicPresetSetting.BloodMoon);
				end
				BMing = true;
			end
			if (not isBloodMoon and BMing) then
				if (typeof(RelicPresetSetting.Default) == "string") then
					EquipRelics(RelicPresetSetting.Default);
				end
				BMing = false;
				hasUsed = false;
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if (Root and beforePos) then
					Root.CFrame = beforePos;
				end
				print("BloodMoon Event Off");
				isCorruptEvent = true;
			end
		end
		if (CorruptEventCheck and Workspace:GetAttribute("CORRUPT_EVENT") and isCorruptEvent) then
			isCorruptEvent = false;
			local autoFarmStart = Toggles.autoFarm.Value;
			Toggles.autoFarm:SetValue(false);
			TPController:TeleportArea(Workspace:GetAttribute("CORRUPT_EVENT"));
			wait(0.5);
			Toggles.autoFarm:SetValue(true);
			task.spawn(function()
				wait(10);
				Toggles.autoFarm:SetValue(autoFarmStart);
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
			end);
		else
			isCorruptEvent = false;
		end
		if NightCheck then
			isNight = Workspace:GetAttribute("NIGHT_EVENT");
			if (isNight and not Nighting) then
				print("Night Event On");
				if (typeof(RelicPresetSetting.Night) == "string") then
					EquipRelics(RelicPresetSetting.Night);
				end
				if (nAutoUseLuckBoost or nAutoUseSecretLuckBoost or (nAutoUsePowerBoost and not nhasUsed)) then
					hasUsed = true;
					if nAutoUseLuckBoost then
						print("Night event use Luck boosts");
						useBoost("Luck");
					end
					if nAutoUseSecretLuckBoost then
						print("Night event use SecretLuck boosts");
						useBoost("SecretLuck");
					end
					if nAutoUsePowerBoost then
						print("Night event use Power boosts");
						useBoost("Power");
					end
				end
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
				wait();
				Toggles.EggNight:SetValue(true);
				Nighting = true;
				wait();
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
				wait();
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
			end
			if (not isNight and Nighting) then
				Nighting = false;
				nhasUsed = false;
				if SunBurstCheck then
					isSunBurst = workspace:GetAttribute("SUNBURST_EVENT")
					if (not isSunBurst and not SunBursting) then
						if (typeof(RelicPresetSetting.Default) == "string") then
							EquipRelics(RelicPresetSetting.Default);
						end

						local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
						if (Root and beforePos) then
							Root.CFrame = beforePos;
						end
						print("Night Event Off");
					end
				else
						if (typeof(RelicPresetSetting.Default) == "string") then
							EquipRelics(RelicPresetSetting.Default);
						end

						local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
						if (Root and beforePos) then
							Root.CFrame = beforePos;
						end
						print("Night Event Off");
				end
			end
		end

		if SunBurstCheck then
			isSunBurst = workspace:GetAttribute("SUNBURST_EVENT")
			if (isSunBurst and not SunBursting) then
				print("Burst Event On");
				if (typeof(RelicPresetSetting.Night) == "string") then
					EquipRelics(RelicPresetSetting.Night);
				end
				if (nAutoUseLuckBoost or nAutoUseSecretLuckBoost or (nAutoUsePowerBoost and not bhasUsed)) then
					bhasUsed = true;
					if nAutoUseLuckBoost then
						print("SunBurst event use Luck boosts");
						useBoost("Luck");
					end
					if nAutoUseSecretLuckBoost then
						print("SunBurst event use SecretLuck boosts");
						useBoost("SecretLuck");
					end
					if nAutoUsePowerBoost then
						print("SunBurst event use Power boosts");
						useBoost("Power");
					end
				end
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
				wait();
				Toggles.EggBurst:SetValue(true);
				SunBursting = true;
				wait();
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
				wait();
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
			end

			if (not isSunBurst and SunBursting) then
				SunBursting = false;
				bhasUsed = false;
				if (typeof(RelicPresetSetting.Default) == "string") then
					EquipRelics(RelicPresetSetting.Default);
				end
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if (Root and beforePos) then
					Root.CFrame = beforePos;
				end
				print("Night Event Off");
			end
		end
		if next(Workspace.Resources.Gamemodes.DungeonLobby.ZoneAutoJoins:GetChildren()) then
			local currentTime = Workspace:GetAttribute("CURRENT_TIME") % 1800;
			if (not BMing and not Nighting and not SunBursting and (currentTime > (51 + (15 * 60))) and (currentTime < (58 + (15 * 60)))) then
				print("Hard Dungeon Open");
				ContinueButtonUID = nil;
				DungeonContinueButton = false;
				if (HardDungeon and not LocalPlayer:GetAttribute("Raid")) then
					local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
					if Root then
						_MAIN = false;
						local Dst = Workspace.Resources.Gamemodes.DungeonLobby.ZoneAutoJoins["Dungeon 2"].CFrame * CFrame.new(0, 6, 0);
						LocalPlayer:RequestStreamAroundAsync(Dst.Position);
						LocalPlayer.Character:SetPrimaryPartCFrame(Dst);
						wait(1);
						local Dungeon_Parts = Workspace.Resources.Gamemodes.DungeonLobby.JoinParts;
						for _, DungeonJoinPart in pairs(Dungeon_Parts:GetChildren()) do
							DungeonUID = DungeonJoinPart:GetAttribute("UID") or DungeonUID;
							local Join_Res = Dungeon_Service:JoinDungeon(DungeonUID);
							if Join_Res then
								TPController:Teleport({pos=Join_Res,areaName=nil,regionName="Dungeon",leaveGamemode=false});
								InDungeon = 2;
								print("Join Hard Dungeon");
								if (typeof(RelicPresetSetting.Default) == "string") then
									EquipRelics(RelicPresetSetting.Default);
								end
								break;
							end
						end
						wait(3);
						_MAIN = true;
					end
				end
			end
			if (not BMing and not Nighting and not SunBursting and (currentTime > 51) and (currentTime < 58)) then
				print("Easy And Insane Dungeon Open");
				ContinueButtonUID = nil;
				DungeonContinueButton = false;
				if ((EasyDungeon or InsaneDungeon) and not LocalPlayer:GetAttribute("Raid")) then
					local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
					if Root then
						_MAIN = false;
						local selectedDungeon = "Dungeon 1";
						if InsaneDungeon then
							selectedDungeon = "Dungeon 3";
						end
						local Dst = Workspace.Resources.Gamemodes.DungeonLobby.ZoneAutoJoins[selectedDungeon].CFrame * CFrame.new(0, 6, 0);
						LocalPlayer:RequestStreamAroundAsync(Dst.Position);
						LocalPlayer.Character:SetPrimaryPartCFrame(Dst);
						wait(1);
						local Dungeon_Parts = Workspace.Resources.Gamemodes.DungeonLobby.JoinParts;
						for _, DungeonJoinPart in pairs(Dungeon_Parts:GetChildren()) do
							if (EasyDungeon and (DungeonJoinPart.name == "Dungeon 1")) then
								local Join_Res = Dungeon_Service:JoinDungeon(DungeonJoinPart:GetAttribute("UID"));
								if Join_Res then
									TPController:Teleport({pos=Join_Res,areaName=nil,regionName="Dungeon",leaveGamemode=false});
									InDungeon = 1;
									print("Join Easy Dungeon");
									break;
								end
							end
							if (InsaneDungeon and (DungeonJoinPart.name == "Dungeon 3")) then
								local Join_Res = Dungeon_Service:JoinDungeon(DungeonJoinPart:GetAttribute("UID"));
								if Join_Res then
									TPController:Teleport({pos=Join_Res,areaName=nil,regionName="Dungeon",leaveGamemode=false});
									InDungeon = 3;
									print("Join Insane Dungeon");
									if (typeof(RelicPresetSetting.Dungeon) == "string") then
										EquipRelics(RelicPresetSetting.Dungeon);
									end
									break;
								end
							end
						end
						wait(3);
						_MAIN = true;
					end
				end
			end
		end
		ActiveRaid = game:GetService("ReplicatedStorage").ActiveRaids:FindFirstChildWhichIsA("BoolValue");
		if not (BMing or Nighting or InDungeon or SunBursting) then
			if (AutoRaid and ActiveRaid and not LocalPlayer:GetAttribute("Raid")) then
				local diffTime = Workspace:GetAttribute("CURRENT_TIME") - lastOpenTime;
				if ((diffTime >= 168) and (diffTime < 178)) then
					if not Workspace.Resources.Gamemodes.RaidJoins:FindFirstChild(ActiveRaid.Name) then
						_MAIN = false;
						wait();
						TPController:TeleportArea("Area " .. string.match(ActiveRaid.Name, "%d+"));
						wait();
						_MAIN = true;
					end
					if Workspace.Resources.Gamemodes.RaidJoins:FindFirstChild(ActiveRaid.Name) then
						uid = Workspace.Resources.Gamemodes.RaidJoins[ActiveRaid.Name]:GetAttribute("UID");
						if uid then
							_MAIN = false;
							wait(1);
							local res = KnitService.RaidService.RF.JoinRaid:InvokeServer(uid);
							print("Join " .. ActiveRaid.Name .. " ," .. PlayerData.RaidTickets .. " tickets remain");
							wait(2);
							_MAIN = true;
						end
					end
				end
			end
		end
		local RoomLabel = LocalPlayer.PlayerGui.Dungeon:FindFirstChild("Background"):FindFirstChild("Active"):FindFirstChild("RoomLabel");
		local Room = nil;
		local TimeChec = (((Workspace:GetAttribute("CURRENT_TIME") % 1800) > 120) and ((Workspace:GetAttribute("CURRENT_TIME") % 1800) < 900)) or (((Workspace:GetAttribute("CURRENT_TIME") % 1800) > (17 * 60)) and ((Workspace:GetAttribute("CURRENT_TIME") % 1800) < (30 * 60)));
		if RoomLabel then
			Room = tonumber(string.match(RoomLabel.Text, "%d+"));
		end
		if (((InDungeon == 2) and Room and (HardDungeonUseDamage > 0) and (Room >= HardDungeonUseDamage)) or ((InDungeon == 3) and Room and (InsaneDungeonUseDamage > 0) and (Room >= InsaneDungeonUseDamage))) then
			task.spawn(function()
				local boostsName = "Damage";
				local timeleft = PlayerData.Boosts[boostsName].timeLeft;
				while timeleft < 200 do
					if ((timeleft < 200) and PlayerData.Boosts[boostsName].remaining["300"] and (PlayerData.Boosts[boostsName].remaining["300"] > 0)) then
						KnitService.BoostService.RF.UseBoost:InvokeServer(boostsName, "300");
					elseif ((timeleft < 200) and PlayerData.Boosts[boostsName].remaining["600"] and (PlayerData.Boosts[boostsName].remaining["600"] > 0)) then
						KnitService.BoostService.RF.UseBoost:InvokeServer(boostsName, "600");
					end
					wait(1);
					timeleft = PlayerData.Boosts[boostsName].timeLeft;
				end
			end);
		end
		if (InDungeon and not LocalPlayer:GetAttribute("InDungeon") and (EasyDungeon or HardDungeon or InsaneDungeon) and TimeChec) then
			print("Error Leave");
			print(InDungeon);
			print(TimeChec);
			InDungeon = false;
			if (typeof(RelicPresetSetting.Default) == "string") then
				EquipRelics(RelicPresetSetting.Default);
			end
			KnitService.DungeonService.RF.LeaveDungeon:InvokeServer();
		else
			if ((InDungeon == 1) and EasyDungeon and Room and (Room > EasyReach) and TimeChec) then
				KnitService.DungeonService.RF.LeaveDungeon:InvokeServer();
				print("Reached and Leave EasyDungeon at Room " .. Room);
				wait(1);
			end
			if ((InDungeon == 2) and HardDungeon and Room and (Room > HardReach) and TimeChec) then
				KnitService.DungeonService.RF.LeaveDungeon:InvokeServer();
				print("Reached and Leave HardDungeon at Room " .. Room);
				wait(1);
			end
			if ((InDungeon == 3) and InsaneDungeon and Room and (Room > InsaneReach) and TimeChec) then
				KnitService.DungeonService.RF.LeaveDungeon:InvokeServer();
				print("Reached and Leave InsaneDungeon at Room " .. Room);
				wait(1);
			end
		end
	end
end)();
task.spawn(function()
	local Dungeon3 = false;
	local Tower2 = false;
	local Tower3 = false;
	local Raid2 = false;
	local Raid3 = false;
	task.spawn(function()
		RunService.Stepped:Connect(function()
			if not _MAIN then
				return;
			end
			if (AutoTower and LocalPlayer:GetAttribute("InTower") and (Tower2 == false) and not closest) then
				local Button = Workspace.Live.Towers:FindFirstChild("ContinueButton", true);
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if (Button and next(Button:GetAttributes())) then
					coroutine.wrap(function()
						Tower2 = true;
						task.wait(0.2);
						if not Root then
							return;
						end
						Root.CFrame = Button.CFrame * CFrame.new(0, 6.75, 0);
						task.wait(0.2);
						KnitService.TowerService.RF.ContinueTower:InvokeServer(Button:GetAttribute("UID"));
						task.wait(0.2);
						Tower2 = false;
					end)();
				end
			end
			if (AutoRaid and ActiveRaid and LocalPlayer:GetAttribute("Raid") and (Raid2 == false)) then
				local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
				local Background = PlayerGui:WaitForChild("Raid"):WaitForChild("Background");
				local Active = Background:WaitForChild("Active");
				local TimerLabel = Background:WaitForChild("TimerLabel");
				local EnemiesLeft = Active:WaitForChild("EnemiesLeft");
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if (EnemiesLeft and Root and (TimerLabel.Text == "STARTS IN 00:00") and Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].Boss:FindFirstChild("Spawn")) then
					EnemiesLeft = tonumber(EnemiesLeft.TextLabel.Text);
					coroutine.wrap(function()
						Raid2 = true;
						if (EnemiesLeft == 0) then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].Boss.Spawn.CFrame * CFrame.new(0, 3, -5.5);
							wait(1);
						end
						if (EnemiesLeft == 3) then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].NPCs:GetChildren()[1].Spawn.CFrame * CFrame.new(0, 3, -5.5);
							wait(1);
						end
						if (EnemiesLeft == 2) then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].NPCs:GetChildren()[2].Spawn.CFrame * CFrame.new(0, 3, -5.5);
							wait(1);
						end
						if (EnemiesLeft == 1) then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].NPCs:GetChildren()[3].Spawn.CFrame * CFrame.new(0, 3, -5.5);
							wait(1);
						end
						Raid2 = false;
					end)();
				end
			end
		end);
	end);
	task.spawn(function()
		RunService.Stepped:Connect(function()
			if (_MAIN and InDungeon and (EasyDungeon or HardDungeon or InsaneDungeon) and (Dungeon3 == false)) then
				coroutine.wrap(function()
					Dungeon3 = true;
					repeat
						wait();
					until LocalPlayer.PlayerGui.DungeonResult.Background.AbsolutePosition == Vector2.new(0, -36) 
					InDungeon = false;
					print("Finished and Leave");
					if (typeof(RelicPresetSetting.Default) == "string") then
						EquipRelics(RelicPresetSetting.Default);
					end
					_MAIN = false;
					task.wait(2);
					firesignal(LocalPlayer.PlayerGui.DungeonResult.Background.Frame.Continue.Button.MouseButton1Click);
					task.wait(1);
					LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = beforePos;
					task.wait(1);
					_MAIN = true;
					Dungeon3 = false;
				end)();
			end
			if (false and _MAIN and AutoTower and (Tower3 == false)) then
				coroutine.wrap(function()
					Tower3 = true;
					repeat
						wait();
					until LocalPlayer.PlayerGui.TowerResult.Background.AbsolutePosition == Vector2.new(0, -36) 
					task.wait(3);
					firesignal(LocalPlayer.PlayerGui.TowerResult.Background.Frame.Continue.Button.MouseButton1Click);
					task.wait(2);
					Tower3 = false;
				end)();
			end
			if (_MAIN and AutoRaid and (Raid3 == false)) then
				coroutine.wrap(function()
					Raid3 = true;
					repeat
						wait();
					until LocalPlayer.PlayerGui.RaidResult.Background.AbsolutePosition == Vector2.new(0, -36) 
					print("Leave Raid");
					_MAIN = false;
					task.wait(1);
					firesignal(LocalPlayer.PlayerGui.RaidResult.Background.Frame.Continue.Button.MouseButton1Click);
					task.wait(3);
					LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = beforePos;
					_MAIN = true;
					Raid3 = false;
				end)();
			end
		end);
	end);
end);
task.spawn(function()
	local Connection;
	local Force;
	local Attachment;
	if not Force then
		Force = Instance.new("VectorForce");
		Attachment = Instance.new("Attachment");
	end
	local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart");
	Force.ApplyAtCenterOfMass = true;
	Force.Attachment0 = Attachment;
	Force.Force = Util.GetMass(LocalPlayer.Character) * Vector3.new(0, workspace.Gravity, 0);
	Force.Parent = Root;
	Attachment.Parent = Root;
	Force.Enabled = false;
	local function Float(Character)
		if Connection then
			Connection:Disconnect();
			Connection = nil;
		end
		local stoptick = 0;
		local flag = true;
		Connection = game:GetService("RunService").Stepped:Connect(function()
			if (_MAIN and (AutoFarm or InDungeon)) then
				Root.Velocity = Vector3.new(Root.Velocity.X, 0, Root.Velocity.Z);
				Force.Enabled = true;
				if not closest then
					Force.Enabled = false;
				end
			else
				Force.Enabled = false;
			end
		end);
	end
	if LocalPlayer.Character then
		Float(LocalPlayer.Character);
	end
	LocalPlayer.CharacterAdded:Connect(Float);
end);
local zero = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (zero == false) then
			zero = true;
			coroutine.wrap(function()
				while _MAIN and (AutoFarm or InDungeon or (BloodMoonCheck and isBloodMoon) or (ServerBossCheck and isServerBoss)) and not Nighting and not LocalPlayer:GetAttribute("Raid") and not SunBursting do
					local currentClosest = Closest_NPC(true);
					local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
					if (currentClosest and Root) then
						if ((FarmAllMap and not InDungeon) or (BloodMoonCheck and isBloodMoon and next(SelectMobList)) or (ServerBossCheck and isServerBoss)) then
							local OldErr, OldMsg = pcall(function()
								return currentClosest.CFrame;
							end);
							if not OldErr then
								print("No currentClosest");
								continue;
							end
							Root.CFrame = currentClosest.CFrame * CFrame.new(0, 6, -2.5);
							local count = 0;
							repeat
								task.wait();
								coroutine.wrap(function()
									KnitService.ClickService.RF.Click:InvokeServer(tostring(currentClosest));
								end)();
								count = count + 1;
							until not _MAIN or not AutoFarm or (currentClosest:GetAttribute("Health") == 0) or (count > 20) 
							continue;
						else
							Root.CFrame = currentClosest:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 6, -2.5);
							KnitService.ClickService.RF.Click:InvokeServer(tostring(currentClosest));
							while _MAIN and LocalPlayer:GetAttribute("NPC") do
								task.wait();
							end
						end
					end
					task.wait();
				end
				zero = false;
			end)();
		end
	end);
end);
local one = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (one == false) then
			one = true;
			while task.wait() and _POWER do
				for i = 1, ClickSpeed do
					coroutine.wrap(function()
						KnitService.ClickService.RF.Click:InvokeServer(tostring(closest));
					end)();
				end
			end
			one = false;
		end
	end);
end);
local two = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (two == false) then
			two = true;
			while getgenv().PetDis and wait(2) do
				local dPetFound = false;
				local dPets = {};
				for i, v in next, Knit_Pkg.GetController("DataController"):GetData("PlayerData").PetInv do
					if (DisRarityCheck and table.find(DisRarityWl, PetsDatabase[v.name].rarity)) then
						continue;
					end
					if CheckPet(v, UsePetFilter) then
						continue;
					end
					if ((v.locked ~= true) and (v.equipped ~= true)) then
						dPetFound = true;
						table.insert(dPets, v.uid);
					end
				end
				if (dPetFound == true) then
					KnitService.PetLevelingService.RF.Dismantle:InvokeServer(dPets);
					dPetFound = false;
					UIController:CloseScreen("PetLeveling");
				end
				wait(DismantleDelay);
			end
			two = false;
		end
	end);
end);
local three = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (three == false) then
			three = true;
			while getgenv().SwordSell and wait(2) do
				local SwordFound = false;
				local Swords = {};
				local Equipped = {};
				table.insert(Equipped, PlayerData.EquippedWeapon.Left);
				table.insert(Equipped, PlayerData.EquippedWeapon.Right);
				for i, v in next, PlayerData.WeaponInv do
					if (RarityCheck and table.find(RarityWl, SwordDatabase[v.name].rarity)) then
						continue;
					end
					if table.find(Secret, v.name) then
						continue;
					end
					if (v.locked or table.find(Equipped, v.uid)) then
						continue;
					end
					if not v.enchants then
						continue;
					end
					if not next(v.enchants) then
						SwordFound = true;
						Swords[tostring(v.uid)] = true;
						continue;
					end
					if CheckAccept(v, UseFilter) then
						continue;
					end
					SwordFound = true;
					Swords[tostring(v.uid)] = true;
					continue;
				end
				if (SwordFound == true) then
					KnitService.WeaponInvService.RF.MultiSell:InvokeServer(Swords);
					SwordFound = false;
				end
				wait(SwordSellDelay);
			end
			three = false;
		end
	end);
end);
local four = false;
local fou = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (four == false) then
			four = true;
			coroutine.wrap(function()
				while getgenv().OpEgg do
					local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
					if not Root then
						continue;
					end
					local EggMagnitude = (Root.Position - Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.Position).Magnitude;
					if (EggMagnitude <= 60) then
						KnitService.EggService.RF.BuyEgg:InvokeServer(Buy_Egg_Args);
						if ignoreAmin then
							Knit_Pkg.GetController("EggOpenController"):Reset();
						else
							UIController:AlwaysOnTop(true);
							UIController:CloseScreen("EggEffect");
						end
					else
						wait(5);
					end
					wait(0.05);
				end
				four = false;
			end)();
		end
		if (AutoRoll and not fou) then
			fou = true;
			coroutine.wrap(function()
				while AutoRoll and next(RollList) do
					KnitService.EnchantService.RF.RequestRoll:InvokeServer({modeType="Weapons",weaponUID=RollList[1],enchantTableName="Normal",rollType="Shard",auto=false});
					wait(4);
					if (next(RollResult) and CheckAccept(RollResult, RollUseFilter)) then
						table.remove(RollList, 1);
						RollListDispaly:Set({Title="RollList :",Content=table.concat(RollList, "\n")});
						if not next(RollList) then
							AutoRollToggle:Set(false);
							print("Roll Finished");
							Knit_Pkg.GetController("NotificationController"):Notification({message="结束附魔",color="Orange",multipleAllowed=false});
							break;
						end
					end
					RollResult = {};
				end
				fou = false;
			end)();
		end
	end);
end);
local five = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (five == false) then
			five = true;
			local expRelicFound = false;
			if (UpRelic or DungeonAutoBuy or TravellingMerchantAutoBuy or AutoClaimChests) then
				if (UpRelic and (string.len(SelectedRelic) > 0) and PlayerData.RelicInv[SelectedRelic]) then
					local RelicExp = {};
					for i, v in next, PlayerData.RelicInv do
						if (v.equipped or v.locked) then
							continue;
						end
						if table.find(ExpRelicList, v.name) then
							table.insert(RelicExp, v.uid);
							expRelicFound = true;
						end
					end
					if expRelicFound then
						KnitService.RelicLevelingService.RF.LevelUp:InvokeServer(SelectedRelic, RelicExp);
						UIController:CloseScreen("RelicLeveling");
						--my_Labels["UpgradeExp"] = PlayerData.RelicInv[SelectedRelic].exp
						Labels.UpgradeExp:SetText(PlayerData.RelicInv[SelectedRelic].exp);
						my_UDatas["UpgradeExp"]=PlayerData.RelicInv[SelectedRelic].exp
						--UserDatas.UDatas:SetValue("UpgradeExp", PlayerData.RelicInv[SelectedRelic].exp);
					end
				end
				if DungeonAutoBuy then
					for j = 1, 3 do
						for i = 1, 5 do
							KnitService.LimitedShopsService.RF.BuyItem:InvokeServer("DungeonShop", i);
							wait(0.8);
						end
					end
				end
				if TravellingMerchantAutoBuy then
					for j = 1, 3 do
						for i = 1, 5 do
							KnitService.LimitedShopsService.RF.BuyItem:InvokeServer("TravellingMerchant", i);
							wait(0.8);
						end
					end
				end
				if AutoClaimChests then
					for i, v in {"Chest 1","Chest 2","Chest 3","Free Ticket 1","Free Ticket 2","Free Ticket 3"} do
						KnitService.ChestService.RF.ClaimChest:InvokeServer(v);
						wait(0.8);
					end
				end
				local WheelTime = 43200 - (os.time() - PlayerData.WheelStamp);
				if (WheelTime <= 0) then
					WController:SpinWheel(true);
				end
				local IllusionistTime = 172800 - (os.time() - PlayerData.IllusionistTicketStamp);
				if (WheelTime <= 0) then
					IllusionistService:ClaimTicket();
				end
                local KoreanWheelTime = 86400 - (os.time() - PlayerData.KoreanWheelStamp);
                if (KoreanWheelTime <= 0) then
                    KWController:SpinWheel(true);
                end
				wait(10);
			end
			wait(3);
			five = false;
		end
	end);
end);
local Loadouts = PlayerData.Loadouts;
local WeaponGroups = {};
local WeaponGroupOptions = {};
for addressId, WeaponGroup in Loadouts, nil do
	WeaponGroups[WeaponGroup.Name] = addressId;
	table.insert(WeaponGroupOptions, WeaponGroup.Name);
end
local Target = Knit_Pkg.GetController("EnchantRollController");
oldRoll = hookfunction(Target['Roll'], function(this, result)
	RollResult = result;
	if not (AutoRoll and IgnRollAmin) then
		return oldRoll(this, result);
	end
end);
local cButton;
local cRoot;
Dungeon_Service.DungeonReplicate:Connect(function(DungeonData)
	if (DungeonData and (DungeonData.roomReached > 0) and ((DungeonData.roomReached % 4) == 0)) then
		if (InDungeon and (EasyDungeon or HardDungeon or InsaneDungeon) and (DungeonContinueButton == false) and not closest) then
			DungeonContinueButton = true;
			coroutine.wrap(function()
				cButton = Workspace.Live.Dungeons:FindFirstChild("ContinueButton", true);
				cRoot = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if ContinueButtonUID then
					if (DungeonData.roomReached > 4) then
						task.wait(0.3);
						if (not cRoot or not cRoot.CFrame) then
							return;
						end
						cRoot.CFrame = CFrame.new(cRoot.CFrame.x - 200, cRoot.CFrame.y, cRoot.CFrame.z, 1, 0, 0, 0, 1, 0, -4, 0, 1);
					end
					task.wait(0.2);
					KnitService.DungeonService.RF.ContinueDungeon:InvokeServer(ContinueButtonUID);
				else
					task.wait(0.2);
					if (not cRoot or not cRoot.CFrame or not cButton or not cButton.CFrame) then
						return;
					end
					cRoot.CFrame = cButton.CFrame * CFrame.new(0, 7, -4);
				end
				DungeonContinueButton = false;
			end)();
		end
	end
end);
game:GetService("CollectionService"):GetInstanceAddedSignal("ServerNPC"):Connect(function(p9)
	task.wait();
	if (p9 and table.find(ServerBossList, p9:GetAttribute("Name"))) then
		print("Server Boss");
		wait(6);
		if (ServerBossCheck and typeof(RelicPresetSetting.BloodMoon) == "string") then
			EquipRelics(RelicPresetSetting.BloodMoon);
		end
		isServerBoss = true;
		isKillServerBoss = false;
	end
end);
game:GetService("CollectionService"):GetInstanceAddedSignal("SkillCrate"):Connect(function(p13)
	print("kkkkk");
	wait(0.5);
	if ServerBossCheck then
	Knit_Pkg.GetService("ServerBossService"):OpenCrate();
	end
	isKillServerBoss = true;
end);
game:GetService("CollectionService"):GetInstanceRemovedSignal("SkillCrate"):Connect(function(p14)
	print("next");
	wait(4);
	isKillServerBoss = false;
end);
game:GetService("CollectionService"):GetInstanceRemovedSignal("DungeonContinueButton"):Connect(function(Button)
	if (not ContinueButtonUID and Button:GetAttribute("UID")) then
		ContinueButtonUID = Button:GetAttribute("UID");
	end
end);
local DungeonController = Knit_Pkg.GetController("DungeonController");
local DCActivate;
DCActivate = hookfunction(DungeonController['Activate'], function(this, result)
	wait(0.2);
	if (result ~= nil) then
		if (not ContinueButtonUID and result:GetAttribute("UID")) then
			ContinueButtonUID = result:GetAttribute("UID");
		end
	end
	return DCActivate(this, result);
end);
hookfunction(require(game:GetService("ReplicatedStorage").ClientModules.Controllers.AfterLoad.ItemDropController.ItemDropNode)['Pickup'], function(this)
	return this:Claim();
end);
game.NetworkClient.ChildRemoved:Connect(function()
	game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer);
end);
print("Done!");
Toggles.AutoPower:OnChanged(function()
	getgenv()._POWER = Toggles.AutoPower.Value;
end);
Options.AuraDistance:OnChanged(function()
	getgenv().Distance = Options.AuraDistance.Value;
end);
Options.ClickSpeed:OnChanged(function()
	getgenv().ClickSpeed = Options.ClickSpeed.Value;
end);
Toggles.AutoDismantle:OnChanged(function()
	getgenv().PetDis = Toggles.AutoDismantle.Value;
end);
Options.AuraDistance:OnChanged(function()
	getgenv().Distance = Options.AuraDistance.Value;
end);
Options.DismantleDelay:OnChanged(function()
	getgenv().DismantleDelay = Options.DismantleDelay.Value;
end);
Toggles.DisRarityCheck:OnChanged(function()
	getgenv().DisRarityCheck = Toggles.DisRarityCheck.Value;
end);
Options.PetAddToWhitelist:OnChanged(function()
	DisRarityWl = {};
	for key, value in next, Options.PetAddToWhitelist.Value do
		if not table.find(DisRarityWl, key) then
			table.insert(DisRarityWl, key);
		end
	end
end);
Toggles.AutoSell:OnChanged(function()
	getgenv().SwordSell = Toggles.AutoSell.Value;
end);
Options.SWordSellDelay:OnChanged(function()
	SwordSellDelay = Options.SWordSellDelay.Value;
end);
Toggles.WeaponRarityCheck:OnChanged(function()
	getgenv().RarityCheck = Toggles.WeaponRarityCheck.Value;
end);
Options.WeaponAddtoWhitelist:OnChanged(function()
	RarityWl = {};
	for key, value in next, Options.WeaponAddtoWhitelist.Value do
		if not table.find(RarityWl, key) then
			table.insert(RarityWl, key);
		end
	end
end);
Toggles.AutoOpenEggs:OnChanged(function()
	getgenv().OpEgg = Toggles.AutoOpenEggs.Value;
end);
Toggles.IgnoreOpneAmination:OnChanged(function()
	getgenv().ignoreAmin = Toggles.IgnoreOpneAmination.Value;
end);
Options.EggsSelected:OnChanged(function()
	if not Options.EggsSelected.Value then
		return;
	end
	selectedEgg = Options.EggsSelected.Value;
	Buy_Egg_Args.eggName = Eggs[selectedEgg];
	beforePos = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 6, -3.5);
end);
Options.EggsAmounts:OnChanged(function()
	Buy_Egg_Args.amount = Options.EggsAmounts.Value;
end);
Toggles.AutoUpgradeRelic:OnChanged(function()
	getgenv().UpRelic = Toggles.AutoUpgradeRelic.Value;
end);
Options.Relic_DefaultWeaponGroup:OnChanged(function()
	RelicPresetSetting.Default = Options.Relic_DefaultWeaponGroup.Value;
	selecetWeaponGroup = Options.Relic_DefaultWeaponGroup.Value;
end);
Toggles.AutoEasy:OnChanged(function()
	getgenv().EasyDungeon = Toggles.AutoEasy.Value;
	if Toggles.AutoEasy.Value then
		Toggles.AutoInsane:SetValue(false);
	end
end);
Options.EasyRoom:OnChanged(function()
	getgenv().EasyReach = Options.EasyRoom.Value;
end);
Toggles.AutoHard:OnChanged(function()
	getgenv().HardDungeon = Toggles.AutoHard.Value;
end);
Options.HardRoom:OnChanged(function()
	getgenv().HardReach = Options.HardRoom.Value;
end);
Toggles.AutoInsane:OnChanged(function()
	getgenv().InsaneDungeon = Toggles.AutoInsane.Value;
	if Toggles.AutoInsane.Value then
		Toggles.AutoEasy:SetValue(false);
	end
end);
Options.InsaneRoom:OnChanged(function()
	getgenv().InsaneReach = Options.InsaneRoom.Value;
end);
Options.WaitTime:OnChanged(function()
	getgenv().DungeonWaitTime = Options.WaitTime.Value;
end);
Options.DungeonWeapon:OnChanged(function()
	RelicPresetSetting.Dungeon = Options.DungeonWeapon.Value;
end);
Options.UseDamageRooms:OnChanged(function()
	HardDungeonUseDamage = tonumber(Options.UseDamageRooms.Value);
end);
Options.UseInsaneDamageRooms:OnChanged(function()
	InsaneDungeonUseDamage = tonumber(Options.UseInsaneDamageRooms.Value);
end);
Toggles.AutoTower:OnChanged(function()
	getgenv().AutoTower = Toggles.AutoTower.Value;
end);
Toggles.AutoRaid:OnChanged(function()
	getgenv().AutoRaid = Toggles.AutoRaid.Value;
end);
Toggles.autoFarm:OnChanged(function()
	getgenv().AutoFarm = Toggles.autoFarm.Value;
end);
Toggles.FarmAllMap:OnChanged(function()
	getgenv().FarmAllMap = Toggles.FarmAllMap.Value;
end);
Toggles.FarmSelectedMobs:OnChanged(function()
	getgenv().FarmSelected = Toggles.FarmSelectedMobs.Value;
end);
Options.SelectedArea:OnChanged(function()
	if not Options.SelectedArea.Value then
		return;
	end
	Options.SelectedMob.Values = AllMobs[Options.SelectedArea.Value];
	Options.OtherMob.Values = AllMobs[Options.SelectedArea.Value];
	Options.SelectedMob:SetValues();
	Options.OtherMob:SetValues();
	local B_List = {};
	local M_List = {};
	for k, v in AllMobs[Options.SelectedArea.Value] do
		if table.find(MobBlackList, v) then
			B_List[v] = true;
		end
		if table.find(MobWhiteList, v) then
			M_List[v] = true;
		end
	end
	Options.SelectedMob:SetValue(B_List);
	Options.OtherMob:SetValue(M_List);
end);
Toggles.BloodMoonCheck:OnChanged(function()
	getgenv().BloodMoonCheck = Toggles.BloodMoonCheck.Value;
end);
Toggles.CorruptEventCheck:OnChanged(function()
	getgenv().CorruptEventCheck = Toggles.CorruptEventCheck.Value;
end);
Toggles.AutoUseLuck:OnChanged(function()
	getgenv().bAutoUseLuckBoost = Toggles.AutoUseLuck.Value;
end);
Toggles.AutoUseSecretLuck:OnChanged(function()
	getgenv().bAutoUseSecretLuckBoost = Toggles.AutoUseSecretLuck.Value;
end);
Toggles.AutoUseCoin:OnChanged(function()
	getgenv().bAutoUseCoinBoost = Toggles.AutoUseCoin.Value;
end);
Toggles.AutoUsePower:OnChanged(function()
	getgenv().bAutoUsePowerBoost = Toggles.AutoUsePower.Value;
end);
Toggles.AutoUseDmg:OnChanged(function()
	getgenv().bAutoUseDmgBoost = Toggles.AutoUseDmg.Value;
end);
Options.SelectMob:OnChanged(function()
	SelectMobList = {};
	for key, value in next, Options.SelectMob.Value do
		if not table.find(SelectMobList, key) then
			table.insert(SelectMobList, key);
		end
	end
end);
Options.SetWeaponGroup:OnChanged(function()
	RelicPresetSetting.BloodMoon = Options.SetWeaponGroup.Value;
end);
Toggles.EggNight:OnChanged(function()
	getgenv().NightCheck = Toggles.EggNight.Value;
end);
Toggles.EggBurst:OnChanged(function()
	getgenv().SunBurstCheck = Toggles.EggBurst.Value;
end);
Toggles.hAutoUseLuck:OnChanged(function()
	getgenv().nAutoUseLuckBoost = Toggles.hAutoUseLuck.Value;
end);
Toggles.hAutoUseSecretLuck:OnChanged(function()
	getgenv().nAutoUseSecretLuckBoost = Toggles.hAutoUseSecretLuck.Value;
end);
Toggles.hAutoUsePower:OnChanged(function()
	getgenv().nAutoUsePowerBoost = Toggles.hAutoUsePower.Value;
end);
Options.hSetWeaponGroup:OnChanged(function()
	RelicPresetSetting.Night = Options.hSetWeaponGroup.Value;
end);
Toggles.ServerBossCheck:OnChanged(function()
	getgenv().ServerBossCheck = Toggles.ServerBossCheck.Value;
end);
Toggles.DungeonItems:OnChanged(function()
	getgenv().DungeonAutoBuy = Toggles.DungeonItems.Value;
end);
Toggles.TravellingMerchantItems:OnChanged(function()
	getgenv().TravellingMerchantAutoBuy = Toggles.TravellingMerchantItems.Value;
end);
Toggles.AutoClaimChests:OnChanged(function()
	getgenv().AutoClaimChests = Toggles.AutoClaimChests.Value;
end);
Toggles.InfiniteJump:OnChanged(function()
	InfiniteJump = Toggles.InfiniteJump.Value;
	game:GetService("UserInputService").JumpRequest:connect(function()
		if InfiniteJump then
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping");
		end
	end);
end);
Options.PickUpRange:OnChanged(function()
	Text = tonumber(Options.PickUpRange.Value);
	if Text then
		Workspace:SetAttribute("PICKUP_RANGE", Text);
	end
end);
Toggles.UnlockTP:OnChanged(function()
	if Toggles.UnlockTP.Value then
		local Button = LocalPlayer.PlayerGui.LeftSidebar.Background.Frame.MinorButtons.Teleport.Button;
		local ButtonC = Button:Clone();
		ButtonC.Parent = Button.Parent;
		Button:Remove();
		ButtonC.Activated:Connect(function()
			UIController:OpenScreen("Teleport");
		end);
	end
end);
Toggles.UnlockAutoSwing:OnChanged(function()
	if Toggles.UnlockAutoSwing.Value then
		local Button = LocalPlayer.PlayerGui.RightSidebar.Background.Frame.Window.Items.AutoSwing.Button;
		local ButtonC = Button:Clone();
		ButtonC.Parent = Button.Parent;
		Button:Remove();
		ButtonC.Activated:Connect(function()
			Knit_Pkg.GetService("SettingsService"):ToggleAuto();
		end);
	end
end);
Toggles.Invisibility:OnChanged(function()
	if Toggles.Invisibility.Value then
		Invisfunc();
		writefile("SFS Sript/set", "true");
	else
		writefile("SFS Sript/set", "false");
	end
end);
Toggles.UseFilterForAutoShell:OnChanged(function()
	UseFilter = Toggles.UseFilterForAutoShell.Value;
end);
Toggles.UseFilterForAutoRoll:OnChanged(function()
	RollUseFilter = Toggles.UseFilterForAutoRoll.Value;
end);
Options.Enchant:OnChanged(function()
	SelectedEnchant = Options.Enchant.Value;
	Options.Tiers:SetValue(0);
end);
Options.Tiers:OnChanged(function()
	if not SelectedEnchant then
		return;
	end
	if not EnchantsRefuse[SelectedEnchant] then
		EnchantsRefuse[SelectedEnchant] = 0;
	end
	EnchantsRefuse[SelectedEnchant] = Options.Tiers.Value;
	--my_Labels["FList"] = ""
	Labels.FList:SetText("");
	local TiersStr = "";
	for key, value in EnchantsRefuse do
		TiersStr = TiersStr .. key .. ":" .. value .. "\n";
	end
	--my_Labels["FList"] = TiersStr
	Labels.FList:SetText(TiersStr);
end);
Toggles.UsePetFilterForAutoShell:OnChanged(function()
	UsePetFilter = Toggles.UsePetFilterForAutoShell.Value;
end);
Options.PetEnchant:OnChanged(function()
	SelectedPetEnchant = Options.PetEnchant.Value;
	Options.PetTiers:SetValue(0);
end);
Options.PetTiers:OnChanged(function()
	if not SelectedPetEnchant then
		return;
	end
	if not PetEnchantsRefuse[SelectedPetEnchant] then
		PetEnchantsRefuse[SelectedPetEnchant] = 0;
	end
	PetEnchantsRefuse[SelectedPetEnchant] = Options.PetTiers.Value;
	--my_Labels["PetFList"] = ""
	Labels.PetFList:SetText("");
	local TiersStr = "";
	for key, value in PetEnchantsRefuse do
		TiersStr = TiersStr .. key .. ":" .. value .. "\n";
	end
	--my_Labels["PetFList"] = TiersStr
	Labels.PetFList:SetText(TiersStr);
end);
local MyButton = Instance.new("ImageButton");
MyGui.Parent = game.CoreGui;
MyGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
MyButton.Parent = MyGui;
MyButton.Position = UDim2.new(0, 50, 0, 20);
MyButton.Size = UDim2.new(0, 35, 0, 35);
MyButton.Image = "rbxassetid://5198838744";
MyButton.BackgroundTransparency = 1;
local dragging;
local dragInput;
local dragStart;
local startPos;
local function update(input)
	local delta = input.Position - dragStart;
	MyButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
end
MyButton.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		dragging = true;
		dragStart = input.Position;
		startPos = MyButton.Position;
		input.Changed:Connect(function()
			if (input.UserInputState == Enum.UserInputState.End) then
				dragging = false;
			end
		end);
	end
end);
MyButton.InputChanged:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch)) then
		dragInput = input;
	end
end);
game:GetService("UserInputService").InputChanged:Connect(function(input)
	if ((input == dragInput) and dragging) then
		update(input);
	end
end);
MyButton.MouseButton1Click:connect(function()
	if Debounce then
		return;
	end
	Library.Toggle();
	my_UDatas["EnchantsRefuse"]=EnchantsRefuse
	--UserDatas.UDatas:SetValue("EnchantsRefuse", EnchantsRefuse);
	my_UDatas["PetEnchantsRefuse"]=PetEnchantsRefuse
	--UserDatas.UDatas:SetValue("PetEnchantsRefuse", PetEnchantsRefuse);
	SaveManager:Save(ConfigurationName);
end);
local loadData = function()
	local uData = my_UDatas
	--local uData = UserDatas.UDatas.Value;
	if uData["UpgradeId"] then
		--my_Labels["UpgradeId"] = uData["UpgradeId"]
		Labels.UpgradeId:SetText(uData["UpgradeId"]);
		SelectedRelic = uData["UpgradeId"];
		--my_Labels["UpgradeName"] = uData["UpgradeName"]
		Labels.UpgradeName:SetText(uData["UpgradeName"]);
		--my_Labels["UpgradeExp"] = uData["UpgradeExp"]
		Labels.UpgradeExp:SetText(uData["UpgradeExp"]);
	end
	local MobBlackListStr = "";
	MobBlackList = uData["MobBlackList"];
	MobWhiteList = uData["MobWhiteList"];
	EnchantsRefuse = uData["EnchantsRefuse"];
	PetEnchantsRefuse = uData["PetEnchantsRefuse"];
	ExpRelicList = uData["ExpRelicList"];
	if (MobBlackList ~= nil) then
		for key, value in next, MobBlackList do
			MobBlackListStr = MobBlackListStr .. value .. "\n";
		end
		if (#MobBlackList == 0) then
			MobBlackListStr = MobBlackListStr .. "is NULL";
		end
		--my_Labels["BlackListLabel"] = MobBlackListStr
		Labels.BlackListLabel:SetText(MobBlackListStr);
	else
		MobBlackList = {};
	end
	MobBlackListStr = "";
	if (MobWhiteList ~= nil) then
		for key, value in next, MobWhiteList do
			MobBlackListStr = MobBlackListStr .. value .. "\n";
		end
		if (#MobWhiteList == 0) then
			MobBlackListStr = MobBlackListStr .. "is NULL";
		end
		--my_Labels["WhiteListLabel"] = MobBlackListStr
		Labels.WhiteListLabel:SetText(MobBlackListStr);
	else
		MobWhiteList = {};
	end
	if (EnchantsRefuse ~= nil) then
		local TiersStr = "";
		for key, value in EnchantsRefuse do
			TiersStr = TiersStr .. key .. ":" .. value .. "\n";
		end
		--my_Labels["FList"] = TiersStr
		Labels.FList:SetText(TiersStr);
	end
	if (PetEnchantsRefuse ~= nil) then
		local TiersStr = "";
		for key, value in PetEnchantsRefuse do
			TiersStr = TiersStr .. key .. ":" .. value .. "\n";
		end
		--my_Labels["PetFList"] = TiersStr
		Labels.PetFList:SetText(TiersStr);
	end
	if ExpRelicList then
		--my_Labels["BlackList"] = "All:" .. #ExpRelicList
		Labels.BlackList:SetText("All:" .. #ExpRelicList);
	end
end;
if SaveManager:Load(ConfigurationName) then
	wait(1.5);
	loadData();
end
print("End");