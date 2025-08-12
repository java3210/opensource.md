-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-08-12 00:34:07
-- Luau version 6, Types version 3
-- Time taken: 0.018783 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local UserInputService_upvr = game:GetService("UserInputService")
local HapticService_upvr = game:GetService("HapticService")
local Players_upvr = game:GetService("Players")
local SOME_3_upvr = ReplicatedStorage_upvr.Packages:WaitForChild(string.gsub(game.JobId, '-', ""))
local var6_upvw
local SOME_2_upvr = ReplicatedStorage_upvr.Packages:WaitForChild(string.gsub(game.JobId, '-', "")..'-')
task.spawn(function() -- Line 19
	--[[ Upvalues[2]:
		[1]: var6_upvw (read and write)
		[2]: SOME_2_upvr (readonly)
	]]
	var6_upvw = SOME_2_upvr:InvokeServer()
	SOME_2_upvr:Destroy()
end)
local ShouldPlayerJump_upvr = ReplicatedStorage_upvr.Remotes:WaitForChild("ShouldPlayerJump")
local GetOpponentPosition_upvr = ReplicatedStorage_upvr.Remotes:WaitForChild("GetOpponentPosition")
local tbl_upvr_2 = {game:GetService("AnimationFromVideoCreatorService"), game:GetService("AdService"), game:GetService("BadgeService"), game:GetService("CookiesService")}
task.spawn(function() -- Line 35
	--[[ Upvalues[4]:
		[1]: ShouldPlayerJump_upvr (readonly)
		[2]: tbl_upvr_2 (readonly)
		[3]: SOME_3_upvr (readonly)
		[4]: GetOpponentPosition_upvr (readonly)
	]]
	while true do
		ShouldPlayerJump_upvr.Name = string.rep('\n', math.random(1, 10))
		ShouldPlayerJump_upvr.Parent = tbl_upvr_2[math.random(1, #tbl_upvr_2)]
		SOME_3_upvr.Name = string.rep('\n', math.random(1, 10))
		SOME_3_upvr.Parent = tbl_upvr_2[math.random(1, #tbl_upvr_2)]
		GetOpponentPosition_upvr.Name = string.rep('\n', math.random(1, 10))
		GetOpponentPosition_upvr.Parent = tbl_upvr_2[math.random(1, #tbl_upvr_2)]
		task.wait()
	end
end)
local Swords_upvr = require(ReplicatedStorage_upvr.Shared.ReplicatedInstances.Swords)
local AnimationController_upvr = require(ReplicatedStorage_upvr.Controllers.AnimationController)
local ServerInfo_upvr = require(ReplicatedStorage_upvr.ServerInfo)
local SwordAPI_upvr = require(ReplicatedStorage_upvr.Shared.SwordAPI)
local var17_upvw = true
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local CurrentCamera_upvr = workspace.CurrentCamera
local var20_upvw
local var21_upvw = false
local var22_upvw = false
local var23_upvw = false
local var24_upvw = false
local var25_upvw = false
local const_number_upvw = 1.3
local tbl_upvr_3 = {
	CharacterSword = "Base Sword";
	AnimationCollection = "Single";
	SwordType = "Single";
	OnCharacterSwordUpdate = require(ReplicatedStorage_upvr.Packages.Signal).new();
}
local function _() -- Line 131
	--[[ Upvalues[2]:
		[1]: UserInputService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local any_GetMouseLocation_result1 = UserInputService_upvr:GetMouseLocation()
	local any_ScreenPointToRay_result1 = CurrentCamera_upvr:ScreenPointToRay(any_GetMouseLocation_result1.X, any_GetMouseLocation_result1.Y, 0)
	return CFrame.lookAt(any_ScreenPointToRay_result1.Origin, any_ScreenPointToRay_result1.Origin + any_ScreenPointToRay_result1.Direction)
end
local function _() -- Line 137
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvr (readonly)
	]]
	return CurrentCamera_upvr.CFrame
end
function tbl_upvr_3._changeSwordMotorRightArm(arg1, arg2, arg3, arg4) -- Line 141
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local Character_5 = LocalPlayer_upvr.Character
	local var33_upvr
	if Character_5 then
		var33_upvr = Character_5:FindFirstChild("Torso")
	else
		var33_upvr = nil
	end
	if Character_5 then
		local _ = Character_5:FindFirstChild("Right Arm")
	else
	end
	if var33_upvr and nil and var33_upvr:FindFirstChild("Motor6D") then
		var33_upvr.Motor6D.Enabled = false
		local Adjustment6D = var33_upvr.Motor6D.Part1:FindFirstChild("Adjustment6D")
		if Adjustment6D then
			Adjustment6D:Destroy()
		end
		local Motor6D_upvr = Instance.new("Motor6D")
		Motor6D_upvr.Name = "Adjustment6D"
		Motor6D_upvr.Parent = var33_upvr.Motor6D.Part1
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		Motor6D_upvr.Part0 = nil
		Motor6D_upvr.Part1 = var33_upvr.Motor6D.Part1
		Motor6D_upvr.C0 = arg2
		Motor6D_upvr.C1 = arg3
		task.delay(arg4 or 1, function() -- Line 163
			--[[ Upvalues[2]:
				[1]: Motor6D_upvr (readonly)
				[2]: var33_upvr (readonly)
			]]
			if Motor6D_upvr then
				Motor6D_upvr:Destroy()
			end
			if var33_upvr:FindFirstChild("Motor6D") then
				var33_upvr.Motor6D.Enabled = true
			end
		end)
	end
end
local var38_upvw = false
local var39_upvw = 0
function tbl_upvr_3.OnParrySuccess(arg1, arg2) -- Line 177
	--[[ Upvalues[12]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var39_upvw (read and write)
		[3]: AnimationController_upvr (readonly)
		[4]: SwordAPI_upvr (readonly)
		[5]: tbl_upvr_3 (readonly)
		[6]: var21_upvw (read and write)
		[7]: UserInputService_upvr (readonly)
		[8]: HapticService_upvr (readonly)
		[9]: var25_upvw (read and write)
		[10]: var23_upvw (read and write)
		[11]: var24_upvw (read and write)
		[12]: const_number_upvw (read and write)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 68 start (CF ANALYSIS FAILED)
	local Character = LocalPlayer_upvr.Character
	if not Character:IsDescendantOf(workspace) then
	else
		local var61 = Character:WaitForChild("Humanoid", 5)
		if var61 then
			var61 = Character:WaitForChild("Humanoid", 5):WaitForChild("Animator", 5)
		end
		if not var61 or not Character then return end
		var39_upvw = os.clock()
		for var66, v_4 in AnimationController_upvr:GetPlayingAnimationTracks(var61) do
			if v_4:GetAttribute("GrabParry") or v_4:GetAttribute("Parry") then
				v_4:Stop(v_4:GetAttribute("StopFadeTime"))
			end
		end
		-- KONSTANTERROR: [0] 1. Error Block 68 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [66] 52. Error Block 16 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [66] 52. Error Block 16 end (CF ANALYSIS FAILED)
		if (arg1.SwordType or "Single") == "Single" and var21_upvw then
			var66 = Enum.UserInputType.Gamepad1
			if UserInputService_upvr:GetGamepadConnected(var66) then
				var66 = Enum.UserInputType.Gamepad1
				v_4 = Enum.VibrationMotor.Large
				HapticService_upvr:SetMotor(var66, v_4, 1)
				function var66() -- Line 248
					--[[ Upvalues[1]:
						[1]: HapticService_upvr (copied, readonly)
					]]
					HapticService_upvr:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0)
				end
				task.delay(0.15, var66)
			end
		end
		-- KONSTANTERROR: [299] 225. Error Block 83 start (CF ANALYSIS FAILED)
		var25_upvw = false
		var23_upvw = false
		if not arg2 then
			local class_Highlight = Character:FindFirstChildWhichIsA("Highlight")
			if class_Highlight then
				class_Highlight:Destroy()
			end
			var66 = "ParticleShine"
			local SOME_4 = Character:FindFirstChild(var66)
			if SOME_4 then
				SOME_4:Destroy()
			end
		end
		task.spawn(function() -- Line 269
			--[[ Upvalues[2]:
				[1]: var24_upvw (copied, read and write)
				[2]: const_number_upvw (copied, read and write)
			]]
			var24_upvw = true
			task.wait(const_number_upvw)
			var24_upvw = false
		end)
		-- KONSTANTERROR: [299] 225. Error Block 83 end (CF ANALYSIS FAILED)
	end
end
local DebugFlags_upvr = require(ReplicatedStorage_upvr.Shared.DebugFlags)
local EmoteController_upvr = require(ReplicatedStorage_upvr.Controllers.EmoteController)
local UseBall2_upvr = require(ReplicatedStorage_upvr.Shared.UseBall2)
local CollectionService_upvr = game:GetService("CollectionService")
local function var70_upvr(arg1, arg2, arg3, arg4) -- Line 276
	--[[ Upvalues[24]:
		[1]: var22_upvw (read and write)
		[2]: var25_upvw (read and write)
		[3]: var23_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: DebugFlags_upvr (readonly)
		[6]: var17_upvw (read and write)
		[7]: EmoteController_upvr (readonly)
		[8]: var20_upvw (read and write)
		[9]: var38_upvw (read and write)
		[10]: ServerInfo_upvr (readonly)
		[11]: const_number_upvw (read and write)
		[12]: AnimationController_upvr (readonly)
		[13]: UseBall2_upvr (readonly)
		[14]: CurrentCamera_upvr (readonly)
		[15]: UserInputService_upvr (readonly)
		[16]: ShouldPlayerJump_upvr (readonly)
		[17]: var6_upvw (read and write)
		[18]: SOME_3_upvr (readonly)
		[19]: GetOpponentPosition_upvr (readonly)
		[20]: Players_upvr (readonly)
		[21]: CollectionService_upvr (readonly)
		[22]: SwordAPI_upvr (readonly)
		[23]: tbl_upvr_3 (readonly)
		[24]: var24_upvw (read and write)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 112 start (CF ANALYSIS FAILED)
	xpcall(function() -- Line 282
		PluginManager():CreatePlugin():Deactivate()
	end, function() -- Line 284
	end)
	if var22_upvw or var25_upvw or var23_upvw or LocalPlayer_upvr:GetAttribute("CurrentlyEquippedSword") == "COAL" then return end
	-- KONSTANTERROR: [0] 1. Error Block 112 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [28] 24. Error Block 143 start (CF ANALYSIS FAILED)
	if LocalPlayer_upvr.Character.Parent ~= workspace.Dead then
	else
	end
	-- KONSTANTERROR: [28] 24. Error Block 143 end (CF ANALYSIS FAILED)
end
function tbl_upvr_3.SetSword(arg1, arg2) -- Line 452
	local var77 = arg2 or "Base Sword"
	arg1.CharacterSword = var77
	arg1.OnCharacterSwordUpdate:Fire(var77, arg1.CharacterSword)
end
function tbl_upvr_3.UpdateIdle(arg1, arg2, arg3, arg4, arg5) -- Line 459
	--[[ Upvalues[3]:
		[1]: AnimationController_upvr (readonly)
		[2]: SwordAPI_upvr (readonly)
		[3]: tbl_upvr_3 (readonly)
	]]
	for _, v in AnimationController_upvr:GetPlayingAnimationTracks(arg3) do
		if v:GetAttribute("Idle") then
			v:Stop(v:GetAttribute("StopFadeTime"))
		end
	end
	if not arg4 then
	end
	local var89 = arg5
	if not var89 then
		var89 = tbl_upvr_3.SwordType
	end
	for _, v_2 in SwordAPI_upvr:GetAnimations(arg2, "Idle", tbl_upvr_3.AnimationCollection, var89) do
		AnimationController_upvr:LoadAnimation(arg3, v_2, true):Play()
	end
end
function tbl_upvr_3.UpdateSwordFor(arg1, arg2) -- Line 471
	--[[ Upvalues[1]:
		[1]: Swords_upvr (readonly)
	]]
	local CharacterSword = arg1.CharacterSword
	local any_GetSword_result1 = Swords_upvr:GetSword(CharacterSword)
	if not any_GetSword_result1 then
		warn("Failed to find sword info for:", CharacterSword)
		any_GetSword_result1 = Swords_upvr:GetSword("Base Sword")
	end
	assert(any_GetSword_result1, "Failed to find sword info, and Base Sword doesn't exists??")
	arg1.AnimationCollection = any_GetSword_result1.AnimationType
	arg1.SwordType = any_GetSword_result1.SwordType
	if not arg2:IsDescendantOf(workspace) then
	else
		local var96 = arg2:WaitForChild("Humanoid", 5)
		if var96 then
			var96 = arg2:WaitForChild("Humanoid", 5):WaitForChild("Animator", 5)
		end
		if not var96 then return end
		arg1:UpdateIdle(arg2, var96)
	end
end
local Replion_upvr = require(ReplicatedStorage_upvr.Packages.Replion)
local FFlagClient_upvr = require(ReplicatedStorage_upvr.ClientGameModules.FFlagClient)
local SettingsController_upvr = require(ReplicatedStorage_upvr.Controllers.SettingsController)
local Observers_upvr = require(ReplicatedStorage_upvr.Packages.Observers)
local AnalyticsController_upvr = require(ReplicatedStorage_upvr.Controllers.AnalyticsController)
local Utils_upvr = require(ReplicatedStorage_upvr.Common.Utils)
local VRService_upvr = require(ReplicatedStorage_upvr.Shared.VRService)
local StarterGui_upvr = game:GetService("StarterGui")
local TweenService_upvr = game:GetService("TweenService")
task.defer(function() -- Line 497
	--[[ Upvalues[26]:
		[1]: tbl_upvr_3 (readonly)
		[2]: var20_upvw (read and write)
		[3]: Replion_upvr (readonly)
		[4]: var17_upvw (read and write)
		[5]: FFlagClient_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var23_upvw (read and write)
		[9]: var24_upvw (read and write)
		[10]: var25_upvw (read and write)
		[11]: var22_upvw (read and write)
		[12]: var70_upvr (readonly)
		[13]: UserInputService_upvr (readonly)
		[14]: SettingsController_upvr (readonly)
		[15]: Observers_upvr (readonly)
		[16]: HapticService_upvr (readonly)
		[17]: AnalyticsController_upvr (readonly)
		[18]: var21_upvw (read and write)
		[19]: ServerInfo_upvr (readonly)
		[20]: Utils_upvr (readonly)
		[21]: var38_upvw (read and write)
		[22]: VRService_upvr (readonly)
		[23]: StarterGui_upvr (readonly)
		[24]: CurrentCamera_upvr (readonly)
		[25]: TweenService_upvr (readonly)
		[26]: Swords_upvr (readonly)
	]]
	local var107_upvr = tbl_upvr_3
	var20_upvw = Replion_upvr.Client:WaitReplion("Data")
	local function var108() -- Line 503
		--[[ Upvalues[2]:
			[1]: var17_upvw (copied, read and write)
			[2]: FFlagClient_upvr (copied, readonly)
		]]
		var17_upvw = not not FFlagClient_upvr:GetKey("CancelEmoteOnParry")
	end
	FFlagClient_upvr.DataUpdatedEvent:Connect(var108)
	task.spawn(var108)
	var107_upvr:SetSword(LocalPlayer_upvr:GetAttribute("CurrentlyEquippedSword"))
	var107_upvr._equippedSwordConn = LocalPlayer_upvr:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(function() -- Line 512
		--[[ Upvalues[2]:
			[1]: var107_upvr (readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
		]]
		var107_upvr:SetSword(LocalPlayer_upvr:GetAttribute("CurrentlyEquippedSword"))
	end)
	var107_upvr._swordInfoConn = ReplicatedStorage_upvr.Remotes.FireSwordInfo.OnClientEvent:Connect(function(arg1) -- Line 517
		--[[ Upvalues[1]:
			[1]: var107_upvr (readonly)
		]]
		var107_upvr:SetSword(arg1)
	end)
	local function var111_upvr(arg1) -- Line 522
		--[[ Upvalues[2]:
			[1]: var107_upvr (readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
		]]
		local var112
		if var112 then
			var112 = var107_upvr._accessoryUpdateConn:Disconnect
			var112()
			var112 = var107_upvr
			var112._accessoryUpdateConn = nil
		end
		var112 = arg1
		if not var112 then
			var112 = LocalPlayer_upvr.Character
		end
		if var112 then
			if var112:WaitForChild("Humanoid", 5) then
			end
			var107_upvr:UpdateSwordFor(var112)
			var107_upvr._accessoryUpdateConn = var112:GetAttributeChangedSignal("HasAccessoryEquipped"):Connect(function() -- Line 536
				--[[ Upvalues[2]:
					[1]: var107_upvr (copied, readonly)
					[2]: LocalPlayer_upvr (copied, readonly)
				]]
				var107_upvr:SetSword(LocalPlayer_upvr:GetAttribute("CurrentlyEquippedSword"))
			end)
		end
	end
	var107_upvr._onCharacterAddedConn = LocalPlayer_upvr.CharacterAdded:Connect(function(arg1) -- Line 542
		--[[ Upvalues[1]:
			[1]: var111_upvr (readonly)
		]]
		while not arg1:IsDescendantOf(workspace) do
			task.wait()
		end
		var111_upvr(arg1)
	end)
	var107_upvr._onCharacterAppearanceConn = LocalPlayer_upvr.CharacterAppearanceLoaded:Connect(function(arg1) -- Line 550
		--[[ Upvalues[1]:
			[1]: var111_upvr (readonly)
		]]
		var111_upvr(arg1)
	end)
	var107_upvr._onSwordUpdateConn = var107_upvr.OnCharacterSwordUpdate:Connect(function() -- Line 554
		--[[ Upvalues[1]:
			[1]: var111_upvr (readonly)
		]]
		var111_upvr()
	end)
	task.spawn(var111_upvr)
	var107_upvr._parrySuccessConn = ReplicatedStorage_upvr.Remotes.ParrySuccess.OnClientEvent:Connect(function(...) -- Line 561
		--[[ Upvalues[1]:
			[1]: var107_upvr (readonly)
		]]
		var107_upvr:OnParrySuccess(...)
	end)
	var107_upvr._parryCooldownResetConn = ReplicatedStorage_upvr.Remotes.NoobParryHappened.OnClientEvent:Connect(function(...) -- Line 566
		--[[ Upvalues[3]:
			[1]: var23_upvw (copied, read and write)
			[2]: var24_upvw (copied, read and write)
			[3]: var25_upvw (copied, read and write)
		]]
		task.wait(0.11)
		var23_upvw = false
		var24_upvw = false
		var25_upvw = false
	end)
	var107_upvr._m1StopConn = ReplicatedStorage_upvr.Remotes.M1Stop.Event:Connect(function(arg1) -- Line 573
		--[[ Upvalues[1]:
			[1]: var22_upvw (copied, read and write)
		]]
		var22_upvw = arg1
	end)
	local function var121_upvr(arg1) -- Line 578
		--[[ Upvalues[2]:
			[1]: var107_upvr (readonly)
			[2]: var70_upvr (copied, readonly)
		]]
		xpcall(function() -- Line 579
			PluginManager():CreatePlugin():Deactivate()
		end, function() -- Line 581
		end)
		return not not var70_upvr(var107_upvr.CharacterSword or "Base Sword", var107_upvr.SwordType or "Single", var107_upvr.AnimationCollection or "Single", not not arg1)
	end
	UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 592
		--[[ Upvalues[2]:
			[1]: SettingsController_upvr (copied, readonly)
			[2]: var121_upvr (readonly)
		]]
		if not arg2 and SettingsController_upvr:UseBind(arg1, "Block") then
			var121_upvr()
		end
	end)
	UserInputService_upvr.TouchTapInWorld:Connect(function(arg1, arg2) -- Line 598
		--[[ Upvalues[2]:
			[1]: var20_upvw (copied, read and write)
			[2]: var121_upvr (readonly)
		]]
		if arg2 then
		else
			local any_Get_result1 = var20_upvw:Get({"Settings", "Misc", "Tap Screen To Block"})
			if any_Get_result1 and not any_Get_result1.Enabled then return end
			var121_upvr()
		end
	end)
	var107_upvr._parryButtonPressConn = ReplicatedStorage_upvr.Remotes.ParryButtonPress.Event:Connect(function() -- Line 611
		--[[ Upvalues[1]:
			[1]: ReplicatedStorage_upvr (copied, readonly)
		]]
		ReplicatedStorage_upvr.Remotes.ParryAttempt:FireServer()
	end)
	Observers_upvr.observeTag("BlockButton", function(arg1) -- Line 615
		--[[ Upvalues[1]:
			[1]: var121_upvr (readonly)
		]]
		local any_Connect_result1_upvr = arg1.Activated:Connect(function() -- Line 616
			--[[ Upvalues[1]:
				[1]: var121_upvr (copied, readonly)
			]]
			xpcall(function() -- Line 617
				PluginManager():CreatePlugin():Deactivate()
			end, function() -- Line 619
			end)
			var121_upvr()
		end)
		return function() -- Line 626
			--[[ Upvalues[1]:
				[1]: any_Connect_result1_upvr (readonly)
			]]
			any_Connect_result1_upvr:Disconnect()
		end
	end)
	if HapticService_upvr:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large) then
		AnalyticsController_upvr:GetRemoteConfigValue("HapticsEnabled", false):andThen(function(arg1) -- Line 633
			--[[ Upvalues[1]:
				[1]: var21_upvw (copied, read and write)
			]]
			var21_upvw = arg1
		end)
	end
	if not ServerInfo_upvr.isDungeonsMatchServer() and not ServerInfo_upvr.isRankedMatchServer() and not ServerInfo_upvr.isMedalServer() and not ServerInfo_upvr.isClanWarServer() and not ServerInfo_upvr.isTournamentMatchServer() and Utils_upvr.FFlag.GetInstantFFlag("NoobParryEnabled", true) then
		var38_upvw = true
	end
	local var136_upvw
	local var137_upvw
	local var138_upvw
	local var139_upvw = "RightHand"
	local tbl_upvw = {}
	local tbl_upvr = {
		LeftHand = Vector3.new(0, 0, 0);
		RightHand = Vector3.new(0, 0, 0);
	}
	local function var142() -- Line 657
		--[[ Upvalues[5]:
			[1]: LocalPlayer_upvr (copied, readonly)
			[2]: VRService_upvr (copied, readonly)
			[3]: var137_upvw (read and write)
			[4]: tbl_upvw (read and write)
			[5]: var136_upvw (read and write)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local Character_3 = LocalPlayer_upvr.Character
		local var160
		if not Character_3 then
		else
			if VRService_upvr.VREnabled then
				var160 = 0
			else
				var160 = 75
			end
			LocalPlayer_upvr.CameraMaxZoomDistance = var160
			var160 = VRService_upvr
			if not var160.VREnabled then
				if var137_upvw then
					var137_upvw:Destroy()
					var137_upvw = nil
				end
				var160 = nil
				for i_5, v_5 in tbl_upvw, var160 do
					if i_5 and i_5.Parent and i_5:IsDescendentOf(game) then
						for i_6, v_6 in v_5 do
							i_5[i_6] = v_6
						end
					end
				end
				tbl_upvw = {}
			end
			if var136_upvw then
				var160 = 0
				LocalPlayer_upvr.CameraMaxZoomDistance = var160
				var160 = var136_upvw
				local function INLINED() -- Internal function, doesn't exist in bytecode
					var160 = workspace
					return var160
				end
				if not VRService_upvr.VREnabled or not INLINED() then
					var160 = nil
				end
				var160.LeftHand.Parent = var160
				var160 = var136_upvw
				local function INLINED_2() -- Internal function, doesn't exist in bytecode
					var160 = workspace
					return var160
				end
				if not VRService_upvr.VREnabled or not INLINED_2() then
					var160 = nil
				end
				var160.RightHand.Parent = var160
				return var136_upvw
			end
			if not VRService_upvr.VREnabled then return end
			var136_upvw = Instance.new("Model")
			var136_upvw.Name = LocalPlayer_upvr.Name.."_VR_ORBS"
			local Body_Colors = Character_3:WaitForChild("Body Colors", 5)
			Instance.new("Part").Name = "LeftHand"
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			Instance.new("Part").CanCollide = false
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			Instance.new("Part").Anchored = true
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			Instance.new("Part").Transparency = 0.5
			if Body_Colors then
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				Instance.new("Part").Color = Body_Colors.LeftArmColor3
			end
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			Instance.new("Part").Material = Enum.Material.SmoothPlastic
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			Instance.new("Part").Size = Vector3.new(0.10000, 0.10000, 0.10000)
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			Instance.new("Part").Shape = Enum.PartType.Ball
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			Instance.new("Part").Parent = var136_upvw
			local Part = Instance.new("Part")
			Part.Name = "RightHand"
			Part.CanCollide = false
			Part.Anchored = true
			Part.Transparency = 0.5
			if Body_Colors then
				Part.Color = Body_Colors.LeftArmColor3
			end
			Part.Material = Enum.Material.SmoothPlastic
			Part.Size = Vector3.new(0.10000, 0.10000, 0.10000)
			Part.Shape = Enum.PartType.Ball
			Part.Parent = var136_upvw
			if not VRService_upvr.VREnabled or not workspace then
			end
			var136_upvw.Parent = nil
		end
	end
	if VRService_upvr.VREnabled then
		var142()
	end
	VRService_upvr.VREnabledChanged:Connect(var142)
	local function _() -- Line 737
		--[[ Upvalues[1]:
			[1]: StarterGui_upvr (copied, readonly)
		]]
		return pcall(function() -- Line 738
			--[[ Upvalues[1]:
				[1]: StarterGui_upvr (copied, readonly)
			]]
			StarterGui_upvr:SetCore("VREnableControllerModels", false)
			StarterGui_upvr:SetCore("VRLaserPointerMode", 0)
		end)
	end
	task.spawn(function() -- Line 745
		--[[ Upvalues[1]:
			[1]: StarterGui_upvr (copied, readonly)
		]]
		while not pcall(function() -- Line 738
			--[[ Upvalues[1]:
				[1]: StarterGui_upvr (copied, readonly)
			]]
			StarterGui_upvr:SetCore("VREnableControllerModels", false)
			StarterGui_upvr:SetCore("VRLaserPointerMode", 0)
		end) and 0 < 3 do
			task.wait(1)
			local function _() -- Line 738
				--[[ Upvalues[1]:
					[1]: StarterGui_upvr (copied, readonly)
				]]
				StarterGui_upvr:SetCore("VREnableControllerModels", false)
				StarterGui_upvr:SetCore("VRLaserPointerMode", 0)
			end
		end
	end)
	VRService_upvr.CFrameChanged:Connect(function(arg1, arg2, arg3) -- Line 756
		--[[ Upvalues[5]:
			[1]: var136_upvw (read and write)
			[2]: CurrentCamera_upvr (copied, readonly)
			[3]: var137_upvw (read and write)
			[4]: var138_upvw (read and write)
			[5]: var139_upvw (read and write)
		]]
		if arg1 == "Head" or not var136_upvw then
		else
			var136_upvw[arg1].CFrame = CurrentCamera_upvr.CFrame * arg2
			if var137_upvw then
				if not var138_upvw or var138_upvw == "Single" or arg1 == var139_upvw then
					var137_upvw:PivotTo(CurrentCamera_upvr.CFrame * arg2 * CFrame.new(0, 1, 0))
					return
				end
				local var170
				if var138_upvw == "Fist" then
					if arg1 == "LeftHand" then
						var170 = "Cestus"
					else
						var170 = "Cestus2"
					end
					var170 = CurrentCamera_upvr.CFrame * arg2 * CFrame.new(0, 1, 0)
					var137_upvw[var170]:PivotTo(var170)
					return
				end
				if arg1 == "LeftHand" then
					var170 = "blade"
				else
					var170 = "blade1"
				end
				var137_upvw[var170]:PivotTo(CurrentCamera_upvr.CFrame * arg2 * CFrame.new(0, 1, 0))
			end
		end
	end)
	VRService_upvr.SpeedChanged:Connect(function(arg1, arg2) -- Line 775
		--[[ Upvalues[7]:
			[1]: var20_upvw (copied, read and write)
			[2]: tbl_upvr (readonly)
			[3]: VRService_upvr (copied, readonly)
			[4]: var139_upvw (read and write)
			[5]: var121_upvr (readonly)
			[6]: var137_upvw (read and write)
			[7]: TweenService_upvr (copied, readonly)
		]]
		if arg1 == "Head" then
		else
			local var174 = (100 - var20_upvw:Get({"Settings", "Misc", "VR Parry Sensitivity", "Current"})) / 10
			if arg2 < math.min(var174, 2.5) then
				tbl_upvr[arg1] = nil
			end
			if (100 - var20_upvw:Get({"Settings", "Misc", "VR Hand Switch Sensitivity", "Current"})) / 10 <= arg2 and VRService_upvr:GetSpeedOf(var139_upvw) < arg2 then
				var139_upvw = arg1
			end
			if var174 == 10 or arg2 < var174 then return end
			local any_GetDirectionOf_result1 = VRService_upvr:GetDirectionOf(arg1)
			if -0.3 < any_GetDirectionOf_result1.LookVector:Dot(any_GetDirectionOf_result1.RightVector) then return end
			local var176 = tbl_upvr[arg1]
			if var176 and 0.7 < any_GetDirectionOf_result1.LookVector:Dot(var176) then return end
			tbl_upvr[arg1] = any_GetDirectionOf_result1.LookVector
			if not var121_upvr(true) then return end
			local Flash = var137_upvw.Flash
			Flash.FillTransparency = 0
			TweenService_upvr:Create(Flash, TweenInfo.new(0.25), {
				FillTransparency = 1;
			}):Play()
		end
	end)
	ReplicatedStorage_upvr.Remotes.FireSwordInfo.OnClientEvent:Connect(function(arg1) -- Line 816
		--[[ Upvalues[5]:
			[1]: var137_upvw (read and write)
			[2]: var136_upvw (read and write)
			[3]: VRService_upvr (copied, readonly)
			[4]: Swords_upvr (copied, readonly)
			[5]: var138_upvw (read and write)
		]]
		if var137_upvw then
			var137_upvw:Destroy()
			var137_upvw = nil
		end
		if not var136_upvw or not VRService_upvr.VREnabled then
		else
			local any_GetSword_result1_2 = Swords_upvr:GetSword(arg1)
			if not any_GetSword_result1_2 then return end
			var138_upvw = any_GetSword_result1_2.SwordType
			var137_upvw = Swords_upvr:GetInstance(arg1):Clone()
			var137_upvw.Parent = var136_upvw
			local Highlight = Instance.new("Highlight")
			Highlight.Name = "Flash"
			Highlight.OutlineColor = Color3.new(1, 1, 1)
			Highlight.FillColor = Color3.new(1, 1, 1)
			Highlight.OutlineTransparency = 1
			Highlight.FillTransparency = 1
			Highlight.Parent = var137_upvw
		end
	end)
	local function var182_upvr(arg1) -- Line 845
		--[[ Upvalues[2]:
			[1]: VRService_upvr (copied, readonly)
			[2]: tbl_upvw (read and write)
		]]
		if not VRService_upvr.VREnabled then
		else
			if arg1:IsA("Beam") then
				tbl_upvw[arg1] = {
					Enabled = arg1.Enabled;
				}
				arg1.Enabled = false
				return
			end
			if arg1:IsA("ParticleEmitter") then
				tbl_upvw[arg1] = {
					Lifetime = arg1.Lifetime;
				}
				arg1.Lifetime = NumberRange.new(0)
			end
		end
	end
	local function var185(arg1) -- Line 859
		--[[ Upvalues[1]:
			[1]: var182_upvr (readonly)
		]]
		arg1.DescendantAdded:Connect(var182_upvr)
		for _, v_3 in arg1:GetDescendants() do
			var182_upvr(v_3)
		end
	end
	LocalPlayer_upvr.CharacterAdded:Connect(var185)
	LocalPlayer_upvr.CharacterRemoving:Connect(function(arg1) -- Line 867
		--[[ Upvalues[1]:
			[1]: var136_upvw (read and write)
		]]
		if var136_upvw then
			var136_upvw:Destroy()
			var136_upvw = nil
		end
	end)
	local Character_2 = LocalPlayer_upvr.Character
	if Character_2 then
		task.spawn(var185, Character_2)
	end
end)
return nil
