local _ENV = getgenv()

local Process = game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService('VirtualUser')
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

if _ENV.Connect then
	_ENV.Connect:Disconnect()
	_ENV.Connect = nil
end

_ENV.Connect = RunService.RenderStepped:Connect(function()
	local Equipped = Character and Character:FindFirstChildOfClass("Tool")
	if not Equipped then return end

	if Equipped:GetAttribute("lastActivated8") then
		Process:FireServer(buffer.fromstring("\b\8\8\b\2\2\b\4\4\b\4\4\b\b\1"), {
			Equipped:GetAttribute("lastActivated8"),
			Equipped:GetAttribute("lastActivated8"),
			Equipped:GetAttribute("lastActivated8"),
			Equipped:GetAttribute("lastActivated8"),
			Equipped:GetAttribute("lastActivated8"),
		})
	end
	
	--\b\8\8
end)


local Activated = {} do
	function Activated.new(Logo, Enums, Call)
		local Toggle = Instance.new('ScreenGui')
		local CloseUI = Instance.new("TextButton")
		local UICorner_1z = Instance.new("UICorner")
		local Icon_1 = Instance.new("Frame")
		local ImageLabel = Instance.new("ImageLabel")

		Toggle.Parent = game.CoreGui
		Toggle.Name = "\1"
		Toggle.IgnoreGuiInset = true
		Toggle.ZIndexBehavior = Enum.ZIndexBehavior.Global
		
		CloseUI.Name = "CloseUI"
		CloseUI.Parent = Toggle
		CloseUI.AnchorPoint = Vector2.new(0, 1)
		CloseUI.BackgroundColor3 = Color3.fromRGB(0,0,0)
		CloseUI.BorderColor3 = Color3.fromRGB(0,0,0)
		CloseUI.BorderSizePixel = 0
		CloseUI.Position = UDim2.new(0.5, 0,0.1, 0)
		CloseUI.Size = UDim2.new(0, 50,0, 50)
		CloseUI.BackgroundTransparency = 0.35
		CloseUI.Text = ""

		UICorner_1z.Parent = CloseUI
		UICorner_1z.CornerRadius = UDim.new(0,15)

		Icon_1.Name = "Icon"
		Icon_1.Parent = CloseUI
		Icon_1.BackgroundColor3 = Color3.fromRGB(22,22,22)
		Icon_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Icon_1.BorderSizePixel = 0
		Icon_1.Size = UDim2.new(0, 50,0, 50)
		Icon_1.BackgroundTransparency = 1
		Icon_1.Position = UDim2.new(0.5, 0, 0.55, 0)
		Icon_1.AnchorPoint = Vector2.new(0.5, 0.5)

		ImageLabel.Parent = Icon_1
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.BorderColor3 = Color3.fromRGB(0,0,0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.5, 0,0.5, 0)
		ImageLabel.Size = UDim2.new(0, 45,0, 45)
		ImageLabel.Image = 'rbxassetid://' .. Logo
		ImageLabel.ImageTransparency = 0

		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function Update(input)
			local Delta = input.Position - DragStart
			local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
			local Tween = game.TweenService:Create(CloseUI, TweenInfo.new(0.3), {Position = pos})
			Tween:Play()
		end

		CloseUI.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = CloseUI.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		CloseUI.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				DragInput = input
			end
		end)

		game.UserInputService.InputChanged:Connect(function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end)

		local On = true

		CloseUI.MouseButton1Click:Connect(function()
			On = not On
			Call(On)
		end)

		game.UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == Enums then
				On = not On
				Call(On)
			end
		end)
	end
end

return Activated
