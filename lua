
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function new( ... )
	return Color3.fromRGB( ... )
end

local function drag(a)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		local Tween = TweenService:Create(a, TweenInfo.new(0.3), {Position = pos})
		Tween:Play()
	end

	a.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			StartPosition = a.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	a.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

local function selfRBX(r)
	return (typeof(r) == 'string' and r) or "rbxassetid://" .. r
end

local function tw(info)
	return TweenService:Create(info.v, TweenInfo.new(info.t, Enum.EasingStyle[info.s], Enum.EasingDirection[info.d]), info.g)
end

local function create(p)
	local Click = Instance.new("TextButton")

	Click.Name = "Click"
	Click.Parent = p
	Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Click.BackgroundTransparency = 1.000
	Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Click.BorderSizePixel = 0
	Click.Size = UDim2.new(1, 0, 1, 0)
	Click.Font = Enum.Font.SourceSans
	Click.Text = ""
	Click.TextColor3 = Color3.fromRGB(0, 0, 0)
	Click.TextSize = 14.000
	Click.ZIndex = p.ZIndex + 1

	return Click
end

local function effect(c, p)
	p.ClipsDescendants = true
	local Mouse = game.Players.LocalPlayer:GetMouse()

	local relativeX = Mouse.X - c.AbsolutePosition.X
	local relativeY = Mouse.Y - c.AbsolutePosition.Y

	if relativeX < 0 or relativeY < 0 or relativeX > c.AbsoluteSize.X or relativeY > c.AbsoluteSize.Y then
		return
	end

	local ClickButtonCircle = Instance.new("Frame")
	ClickButtonCircle.Parent = p
	ClickButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ClickButtonCircle.BackgroundTransparency = 0.5
	ClickButtonCircle.BorderSizePixel = 0
	ClickButtonCircle.AnchorPoint = Vector2.new(0.5, 0.5)
	ClickButtonCircle.Position = UDim2.new(0, relativeX, 0, relativeY)
	ClickButtonCircle.Size = UDim2.new(0, 0, 0, 0)
	ClickButtonCircle.ZIndex = p.ZIndex

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = ClickButtonCircle

	local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

	local goal = {
		Size = UDim2.new(0, c.AbsoluteSize.X * 1.5, 0, c.AbsoluteSize.X * 1.5),
		BackgroundTransparency = 1
	}

	local expandTween = TweenService:Create(ClickButtonCircle, tweenInfo, goal)

	expandTween.Completed:Connect(function()
		ClickButtonCircle:Destroy()
	end)

	expandTween:Play()
end

local Stop = false

local function RandomChar()
	local chars = "!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?`~"
	local index = math.random(1, #chars)
	return string.sub(chars, index, index)
end

local function RandomizeBuild(Build, Target, MaxTries, DelayTime)
	local current = string.rep(" ", #Target)

	for i = 1, #Target do
		if Stop then break end

		local targetChar = string.sub(Target, i, i)
		local built = false

		for t = 1, MaxTries do
			if Stop then break end 

			local char = RandomChar()
			local temp = string.sub(current, 1, i - 1) .. char .. string.rep(" ", #Target - i)
			Build.Text = tostring(temp)

			if char == targetChar then
				current = string.sub(current, 1, i - 1) .. char .. string.rep(" ", #Target - i)
				built = true
				break
			end

			task.wait(DelayTime or 0.01)
		end

		if not built and not Stop then
			current = string.sub(current, 1, i - 1) .. targetChar .. string.rep(" ", #Target - i)
			Build.Text = tostring(current)
		end
	end

	if not Stop then
		Build.Text = tostring(Target)
	end
end

local Theme = {
	['Background'] = new(37, 37, 38),
	['Background Stroke'] = new(48, 48, 48),
	['Header'] = {
		['Background'] = new(54, 54, 54),
		['Icon'] = new(255, 255, 255),
		['Title'] = new(255, 255, 255),
		['Desc'] = new(255, 255, 255),
		['Search'] = {
			['Stroke'] = new(110, 110, 110),
			['Background'] = new(54, 54, 54),
			['Icon'] = new(255, 255, 255)
		}
	},
	['Tabs'] = {
		['Transparency'] = 0.3,
		['Highlight'] = new(0, 255, 123)
	},
	['Page'] = {
		['Background'] = new(28, 28, 30),
		['Section'] = {
			['Background'] = new(31,31,33),
			['Background Stroke'] = new(61,61,61),
			['Line'] = new(61, 61, 61),
			['Toggle'] = {
				['OFF'] = new(67,67,69),
				['ON'] = new(0, 255, 123)
			}
		}
	}
}

local Visualized = {}

local Valid = { "rbxassetid://8992230677" }

function Visualized:Raw(a, b, c)
	local Raw = Instance.new("Frame")
	local Text_1 = Instance.new("Frame")
	local Title_1 = Instance.new("TextLabel")
	local UIListLayout_1 = Instance.new("UIListLayout")
	local UIPadding_1 = Instance.new("UIPadding")

	Raw.Name = "Raw"
	Raw.Parent = a
	Raw.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Raw.BackgroundTransparency = 1
	Raw.BorderColor3 = Color3.fromRGB(0,0,0)
	Raw.BorderSizePixel = 0
	Raw.Position = UDim2.new(0.030882353, 0,0, 0)
	Raw.Size = UDim2.new(0, 330,0, 40)

	Text_1.Name = "Text"
	Text_1.Parent = Raw
	Text_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Text_1.BackgroundTransparency = 1
	Text_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Text_1.BorderSizePixel = 0
	Text_1.Position = UDim2.new(0.00121151912, 0,0, 0)
	Text_1.Size = UDim2.new(1, 0,1, 0)

	Title_1.Name = "Title"
	Title_1.Parent = Text_1
	Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Title_1.BackgroundTransparency = 1
	Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Title_1.BorderSizePixel = 0
	Title_1.LayoutOrder = -1
	Title_1.Position = UDim2.new(0, 0,0.200000003, 0)
	Title_1.Font = Enum.Font.GothamMedium
	Title_1.Text = b
	Title_1.TextColor3 = Color3.fromRGB(255,255,255)
	Title_1.TextSize = 14
	Title_1.TextXAlignment = Enum.TextXAlignment.Left

	UIListLayout_1.Parent = Text_1
	UIListLayout_1.Padding = UDim.new(0, 2)
	UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

	UIPadding_1.Parent = Text_1
	UIPadding_1.PaddingLeft = UDim.new(0,10)

	if c then
		local Desc_1 = Instance.new("TextLabel")
		Desc_1.Name = "Desc"
		Desc_1.Parent = Text_1
		Desc_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Desc_1.BackgroundTransparency = 1
		Desc_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Desc_1.BorderSizePixel = 0
		Desc_1.Position = UDim2.new(0, 0,0.555555582, 0)
		Desc_1.Font = Enum.Font.GothamMedium
		Desc_1.Text = c
		Desc_1.TextColor3 = Color3.fromRGB(255,255,255)
		Desc_1.TextSize = 12
		Desc_1.TextTransparency = 0.5
		Desc_1.TextXAlignment = Enum.TextXAlignment.Left

		Title_1.Size = UDim2.new(0, 200,0, Title_1.TextBounds.Y)
		Desc_1.Size = UDim2.new(0, 200,0, Desc_1.TextBounds.Y)

		Raw.Size = UDim2.new(0, 330,0, 40)
	else
		Title_1.Size = UDim2.new(0, 200,0, Title_1.TextBounds.Y)
		Raw.Size = UDim2.new(0, 330,0, 30)
	end

	return Raw
end

Visualized.new = function(new)
	local Title = new.Title or 'Where is your Title?'
	local Logo = new.Logo
	local Keybind = new.Keybind or Enum.KeyCode.Q
	local Parent = new.Parent or not game:GetService("RunService"):IsStudio() and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui

	local Visualize = Instance.new("ScreenGui")
	local Background_1 = Instance.new("Frame")
	local DropShadow_1 = Instance.new("ImageLabel")
	local RE_Backgrund_1 = Instance.new("Frame")

	Visualize.Name = "Visualize"
	Visualize.Parent = Parent
	Visualize.ZIndexBehavior = Enum.ZIndexBehavior.Global

	Background_1.Name = "Background"
	Background_1.Parent = Visualize
	Background_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Background_1.BackgroundColor3 = Theme['Background']
	Background_1.BackgroundTransparency = Theme.Tabs.Transparency
	Background_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Background_1.BorderSizePixel = 0
	Background_1.Position = UDim2.new(0.5, 0,0.5, 0)
	Background_1.Size = UDim2.new(0, 500,0, 360)

	task.spawn(drag, Background_1)

	DropShadow_1.Name = "DropShadow"
	DropShadow_1.Parent = Background_1
	DropShadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_1.BackgroundColor3 = Color3.fromRGB(28,28,30)
	DropShadow_1.BackgroundTransparency = 1
	DropShadow_1.BorderColor3 = Color3.fromRGB(0,0,0)
	DropShadow_1.BorderSizePixel = 0
	DropShadow_1.Position = UDim2.new(0.5, 0,0.5, 0)
	DropShadow_1.Size = UDim2.new(1, 100,1, 100)
	DropShadow_1.ZIndex = -1
	DropShadow_1.Image = "rbxassetid://8992230677"
	DropShadow_1.ImageColor3 = Color3.fromRGB(0,0,0)
	DropShadow_1.ImageTransparency = 0.4000000059604645
	DropShadow_1.ScaleType = Enum.ScaleType.Slice
	DropShadow_1.SliceCenter = Rect.new(99, 99, 99, 99)

	RE_Backgrund_1.Name = "RE_Backgrund"
	RE_Backgrund_1.Parent = Background_1
	RE_Backgrund_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	RE_Backgrund_1.BackgroundTransparency = 1
	RE_Backgrund_1.BorderColor3 = Color3.fromRGB(0,0,0)
	RE_Backgrund_1.BorderSizePixel = 0
	RE_Backgrund_1.Size = UDim2.new(1, 0,1, 0)

	local CloseUI = Instance.new("TextButton")
	local UICorner_1z = Instance.new("UICorner")
	local Icon_1 = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")


	CloseUI.Name = "CloseUI"
	CloseUI.Parent = Visualize
	CloseUI.AnchorPoint = Vector2.new(0, 1)
	CloseUI.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CloseUI.BorderColor3 = Color3.fromRGB(0,0,0)
	CloseUI.BorderSizePixel = 0
	CloseUI.Position = UDim2.new(0.5, 0,0.1, 0)
	CloseUI.Size = UDim2.new(0, 50,0, 50)
	CloseUI.BackgroundTransparency = 0.35
	CloseUI.Text = ""

	drag(CloseUI)

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
	ImageLabel.Image = selfRBX(Logo)
	ImageLabel.ImageTransparency = 0

	local function closeopenui()
		task.spawn(function()
			tw({
				v = ImageLabel,
				t = 0.2,
				s = "Back",
				d = "Out",
				g = {Size = UDim2.new(0, 35, 0, 35)}
			}):Play()
			task.wait(0.016) 
			tw({
				v = ImageLabel,
				t = 0.2,
				s = "Back",
				d = "Out",
				g = {Size = UDim2.new(0, 45, 0, 45)}
			}):Play()
		end)
		Background_1.Visible = not Background_1.Visible
	end

	local On = true

	CloseUI.MouseButton1Click:Connect(function()
		closeopenui()
		On = not On
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Keybind then
			closeopenui()
			On = not On
		end
	end)

	local Tabs_1 = Instance.new("Frame")
	local RE_Light_1 = Instance.new("Frame")
	local UIListLayout_1 = Instance.new("UIListLayout")
	local Circle_1 = Instance.new("Frame")
	local UICorner_1 = Instance.new("UICorner")
	local Circle_2 = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local Circle_3 = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local UIPadding_1 = Instance.new("UIPadding")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local UICorner_8 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")

	UICorner_8.Parent = Background_1

	UIStroke_2.Parent = Background_1
	UIStroke_2.Color = Theme['Background Stroke']
	UIStroke_2.Thickness = 1

	Tabs_1.Name = "Tabs"
	Tabs_1.Parent = RE_Backgrund_1
	Tabs_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Tabs_1.BackgroundTransparency = 1
	Tabs_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Tabs_1.BorderSizePixel = 0
	Tabs_1.Size = UDim2.new(0, 135,0, 359)

	RE_Light_1.Name = "RE_Light"
	RE_Light_1.Parent = Tabs_1
	RE_Light_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	RE_Light_1.BackgroundTransparency = 1
	RE_Light_1.BorderColor3 = Color3.fromRGB(0,0,0)
	RE_Light_1.BorderSizePixel = 0
	RE_Light_1.LayoutOrder = -5
	RE_Light_1.Position = UDim2.new(0, 0,0.922005594, 0)
	RE_Light_1.Size = UDim2.new(1, 0,0, 45)

	UIListLayout_1.Parent = RE_Light_1
	UIListLayout_1.Padding = UDim.new(0,11)
	UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

	Circle_1.Name = "Circle"
	Circle_1.Parent = RE_Light_1
	Circle_1.BackgroundColor3 = Color3.fromRGB(255,112,112)
	Circle_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Circle_1.BorderSizePixel = 0
	Circle_1.Size = UDim2.new(0, 10,0, 10)

	UICorner_1.Parent = Circle_1
	UICorner_1.CornerRadius = UDim.new(1,0)

	Circle_2.Name = "Circle"
	Circle_2.Parent = RE_Light_1
	Circle_2.BackgroundColor3 = Color3.fromRGB(255,255,127)
	Circle_2.BorderColor3 = Color3.fromRGB(0,0,0)
	Circle_2.BorderSizePixel = 0
	Circle_2.Size = UDim2.new(0, 10,0, 10)

	UICorner_2.Parent = Circle_2
	UICorner_2.CornerRadius = UDim.new(1,0)

	Circle_3.Name = "Circle"
	Circle_3.Parent = RE_Light_1
	Circle_3.BackgroundColor3 = Color3.fromRGB(73,255,146)
	Circle_3.BorderColor3 = Color3.fromRGB(0,0,0)
	Circle_3.BorderSizePixel = 0
	Circle_3.Size = UDim2.new(0, 10,0, 10)

	UICorner_3.Parent = Circle_3
	UICorner_3.CornerRadius = UDim.new(1,0)

	UIPadding_1.Parent = RE_Light_1
	UIPadding_1.PaddingLeft = UDim.new(0,17)

	UIListLayout_2.Parent = Tabs_1
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

	local RE_Tabs_1 = Instance.new("Frame")
	local RF_Scrolling_1 = Instance.new("ScrollingFrame")

	RE_Tabs_1.Name = "RE_Tabs"
	RE_Tabs_1.Parent = Tabs_1
	RE_Tabs_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	RE_Tabs_1.BackgroundTransparency = 1
	RE_Tabs_1.BorderColor3 = Color3.fromRGB(0,0,0)
	RE_Tabs_1.BorderSizePixel = 0
	RE_Tabs_1.LayoutOrder = -4
	RE_Tabs_1.Position = UDim2.new(0, 0,0.0835654587, 0)
	RE_Tabs_1.Size = UDim2.new(1, 0,0, 300)

	RF_Scrolling_1.Name = "RF_Scrolling"
	RF_Scrolling_1.Parent = RE_Tabs_1
	RF_Scrolling_1.Active = true
	RF_Scrolling_1.AnchorPoint = Vector2.new(0.5, 0.5)
	RF_Scrolling_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	RF_Scrolling_1.BackgroundTransparency = 1
	RF_Scrolling_1.BorderColor3 = Color3.fromRGB(0,0,0)
	RF_Scrolling_1.BorderSizePixel = 0
	RF_Scrolling_1.Position = UDim2.new(0.5, 0,0.5, 0)
	RF_Scrolling_1.Size = UDim2.new(1, 0,1, 0)
	RF_Scrolling_1.ClipsDescendants = true
	RF_Scrolling_1.AutomaticCanvasSize = Enum.AutomaticSize.None
	RF_Scrolling_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
	RF_Scrolling_1.CanvasPosition = Vector2.new(0, 0)
	RF_Scrolling_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	RF_Scrolling_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	RF_Scrolling_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	RF_Scrolling_1.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
	RF_Scrolling_1.ScrollBarImageTransparency = 1
	RF_Scrolling_1.ScrollBarThickness = 0
	RF_Scrolling_1.ScrollingDirection = Enum.ScrollingDirection.XY
	RF_Scrolling_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
	RF_Scrolling_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
	RF_Scrolling_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

	local UIListLayout_3 = Instance.new("UIListLayout")
	local UIPadding_2 = Instance.new("UIPadding")

	UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		RF_Scrolling_1.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_3.AbsoluteContentSize.Y + 20)
	end)

	UIListLayout_3.Parent = RF_Scrolling_1
	UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

	UIPadding_2.Parent = RF_Scrolling_1
	UIPadding_2.PaddingTop = UDim.new(0,2)

	local Head_1 = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local Frame_1 = Instance.new("Frame")
	local Frame_2 = Instance.new("Frame")
	local RE_Window_1 = Instance.new("Frame")

	Head_1.Name = "Head"
	Head_1.Parent = RE_Backgrund_1
	Head_1.BackgroundColor3 = Theme.Header['Background']
	Head_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Head_1.BorderSizePixel = 0
	Head_1.Position = UDim2.new(0.270772964, 0,0, 0)
	Head_1.Size = UDim2.new(0, 365,0, 47)

	UICorner_5.Parent = Head_1

	Frame_1.Parent = Head_1
	Frame_1.BackgroundColor3 = Color3.fromRGB(54,54,54)
	Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Frame_1.BorderSizePixel = 0
	Frame_1.Size = UDim2.new(0, 100,0, 47)

	Frame_2.Parent = Head_1
	Frame_2.BackgroundColor3 = Color3.fromRGB(54,54,54)
	Frame_2.BorderColor3 = Color3.fromRGB(0,0,0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Position = UDim2.new(0, 0,0.595744669, 0)
	Frame_2.Size = UDim2.new(0, 365,0, 19)

	RE_Window_1.Name = "RE_Window"
	RE_Window_1.Parent = Head_1
	RE_Window_1.AnchorPoint = Vector2.new(0.5, 0.5)
	RE_Window_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	RE_Window_1.BackgroundTransparency = 1
	RE_Window_1.BorderColor3 = Color3.fromRGB(0,0,0)
	RE_Window_1.BorderSizePixel = 0
	RE_Window_1.Position = UDim2.new(0.5, 0,0.5, 0)
	RE_Window_1.Size = UDim2.new(1, 0,1, 0)

	local Textfield_1 = Instance.new("Frame")
	local Title_2 = Instance.new("TextLabel")
	local UIListLayout_5 = Instance.new("UIListLayout")
	local Desc_1 = Instance.new("TextLabel")
	local Icon_2 = Instance.new("ImageLabel")
	local UIListLayout_6 = Instance.new("UIListLayout")
	local UIPadding_4 = Instance.new("UIPadding")

	Textfield_1.Name = "Textfield"
	Textfield_1.Parent = RE_Window_1
	Textfield_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Textfield_1.BackgroundTransparency = 1
	Textfield_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Textfield_1.BorderSizePixel = 0
	Textfield_1.Position = UDim2.new(0.0845070407, 0,0, 0)
	Textfield_1.Size = UDim2.new(0, 325,0, 47)

	Title_2.Name = "Title"
	Title_2.Parent = Textfield_1
	Title_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Title_2.BackgroundTransparency = 1
	Title_2.BorderColor3 = Color3.fromRGB(0,0,0)
	Title_2.BorderSizePixel = 0
	Title_2.Position = UDim2.new(0, 0,0.280000001, 0)
	Title_2.Size = UDim2.new(0, 200,0, 16)
	Title_2.Font = Enum.Font.GothamSemibold
	Title_2.Text = Title
	Title_2.TextColor3 = Theme.Header.Title
	Title_2.TextSize = 15
	Title_2.TextXAlignment = Enum.TextXAlignment.Left

	UIListLayout_5.Parent = Textfield_1
	UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_5.VerticalAlignment = Enum.VerticalAlignment.Center

	Desc_1.Name = "Desc"
	Desc_1.Parent = Textfield_1
	Desc_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Desc_1.BackgroundTransparency = 1
	Desc_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Desc_1.BorderSizePixel = 0
	Desc_1.Position = UDim2.new(0, 0,0.280000001, 0)
	Desc_1.Size = UDim2.new(0, 200,0, 14)
	Desc_1.Font = Enum.Font.GothamMedium
	Desc_1.Text = "N/A"
	Desc_1.TextColor3 = Theme.Header.Desc
	Desc_1.TextSize = 10
	Desc_1.TextTransparency = 0.20000000298023224
	Desc_1.TextXAlignment = Enum.TextXAlignment.Left

	local function UpdateHeader(a)
		return RandomizeBuild(Desc_1, a, 5, 0.01)
	end

	Icon_2.Name = "Icon"
	Icon_2.Parent = RE_Window_1
	Icon_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Icon_2.BackgroundTransparency = 1
	Icon_2.BorderColor3 = Color3.fromRGB(0,0,0)
	Icon_2.BorderSizePixel = 0
	Icon_2.LayoutOrder = -1
	Icon_2.Size = UDim2.new(0, 18,0, 18)
	Icon_2.Image = ""
	Icon_2.ImageTransparency = 0.5
	Icon_2.ImageColor3 = Theme.Header.Icon

	UIListLayout_6.Parent = RE_Window_1
	UIListLayout_6.Padding = UDim.new(0,10)
	UIListLayout_6.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_6.VerticalAlignment = Enum.VerticalAlignment.Center

	UIPadding_4.Parent = RE_Window_1
	UIPadding_4.PaddingLeft = UDim.new(0,10)

	local Search_1 = Instance.new("Frame")
	local UICorner_6 = Instance.new("UICorner")
	local UIStroke_1 = Instance.new("UIStroke")
	local UIListLayout_7 = Instance.new("UIListLayout")
	local asset_1 = Instance.new("ImageLabel")
	local UIPadding_5 = Instance.new("UIPadding")
	local SearchBox_1 = Instance.new("TextBox")

	Search_1.Name = "Search"
	Search_1.Parent = Head_1
	Search_1.AnchorPoint = Vector2.new(1, 0.5)
	Search_1.BackgroundColor3 = Theme.Header.Search.Background
	Search_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Search_1.BorderSizePixel = 0
	Search_1.Position = UDim2.new(0, 355,0.5, 0)
	Search_1.Size = UDim2.new(0, 100,0, 25)

	UICorner_6.Parent = Search_1
	UICorner_6.CornerRadius = UDim.new(0,5)

	UIStroke_1.Parent = Search_1
	UIStroke_1.Color = Theme.Header.Search.Stroke
	UIStroke_1.Thickness = 1

	UIListLayout_7.Parent = Search_1
	UIListLayout_7.Padding = UDim.new(0,5)
	UIListLayout_7.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_7.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_7.VerticalAlignment = Enum.VerticalAlignment.Center

	asset_1.Name = "asset"
	asset_1.Parent = Search_1
	asset_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	asset_1.BackgroundTransparency = 1
	asset_1.BorderColor3 = Color3.fromRGB(0,0,0)
	asset_1.BorderSizePixel = 0
	asset_1.Size = UDim2.new(0, 15,0, 15)
	asset_1.Image = selfRBX(125928820284709)
	asset_1.ImageTransparency = 0.5

	UIPadding_5.Parent = Search_1
	UIPadding_5.PaddingLeft = UDim.new(0,5)

	SearchBox_1.Name = "SearchBox"
	SearchBox_1.Parent = Search_1
	SearchBox_1.Active = true
	SearchBox_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	SearchBox_1.BackgroundTransparency = 1
	SearchBox_1.BorderColor3 = Color3.fromRGB(0,0,0)
	SearchBox_1.BorderSizePixel = 0
	SearchBox_1.CursorPosition = -1
	SearchBox_1.Position = UDim2.new(0.157894731, 0,0.100000001, 0)
	SearchBox_1.Size = UDim2.new(0, 70,0, 20)
	SearchBox_1.Font = Enum.Font.GothamMedium
	SearchBox_1.PlaceholderText = "Search ..."
	SearchBox_1.Text = ""
	SearchBox_1.TextColor3 = Color3.fromRGB(178,178,178)
	SearchBox_1.TextSize = 12
	SearchBox_1.TextXAlignment = Enum.TextXAlignment.Left
	SearchBox_1.TextTruncate = Enum.TextTruncate.AtEnd

	SearchBox_1.Focused:Connect(function()
		SearchBox_1.TextTruncate = Enum.TextTruncate.None
	end)

	SearchBox_1.FocusLost:Connect(function()
		SearchBox_1.TextTruncate = Enum.TextTruncate.AtEnd
	end)

	SearchBox_1.Changed:Connect(function()
		local searchText = string.lower(SearchBox_1.Text)

		for _, page in pairs(RE_Backgrund_1:GetChildren()) do
			if page:IsA("Frame") and page.Name == "AddPage" and page.Visible then
				local scrolling = page.Byte_Tabs.Scrolling

				for _, section in pairs(scrolling:GetChildren()) do
					if section.Name == "PageTitle" or section.Name == "Section" then
						local foundSomething = false
						local visibleRows = {}

						for i, row in ipairs(section:GetChildren()) do
							if row:IsA("Frame") or row:IsA("TextLabel") then
								if row.Name ~= "Line" then
									local rowVisible = false

									if row:IsA("TextLabel") then
										local labelText = string.lower(row.Text)
										if string.find(labelText, searchText, 1, true) then
											rowVisible = true
											foundSomething = true
										end
									end

									if row:IsA("Frame") then
										for _, con in pairs(row:GetDescendants()) do
											if con:IsA("TextLabel") then
												local labelText = string.lower(con.Text)
												if string.find(labelText, searchText, 1, true) then
													rowVisible = true
													foundSomething = true
													break
												end
											end
										end
									end

									row.Visible = rowVisible

									if rowVisible then
										table.insert(visibleRows, i)
									end

									local nextRow = section:GetChildren()[i + 1]
									if nextRow and nextRow.Name == "Line" then
										nextRow.Visible = rowVisible
									end
								end
							end
						end

						if #visibleRows == 1 then
							for _, child in ipairs(section:GetChildren()) do
								if child.Name == "Line" then
									child.Visible = false
								end
							end
						elseif #visibleRows > 1 then
							local lastRowIndex = visibleRows[#visibleRows]
							local lastLine = section:GetChildren()[lastRowIndex + 1]
							if lastLine and lastLine.Name == "Line" then
								lastLine.Visible = false
							end
						end

						section.Visible = foundSomething
					end
				end
			end
		end
	end)

	local Tabs = {
		Value = false,
	}

	function Tabs:Add(new)
		local Title = new.Title
		local Desc = new.Desc
		local Icon = new.Icon

		local AddTab_1 = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local About_1 = Instance.new("Frame")
		local Title_1 = Instance.new("TextLabel")
		local UIListLayout_4 = Instance.new("UIListLayout")
		local Icon_1 = Instance.new("ImageLabel")
		local UIPadding_3 = Instance.new("UIPadding")
		local Button = create(AddTab_1)

		AddTab_1.Name = "AddTab"
		AddTab_1.Parent = RF_Scrolling_1
		AddTab_1.BackgroundColor3 = Theme.Tabs['Highlight']
		AddTab_1.BackgroundTransparency = 1
		AddTab_1.BorderColor3 = Color3.fromRGB(0,0,0)
		AddTab_1.BorderSizePixel = 0
		AddTab_1.Size = UDim2.new(0, 120,0, 30)

		UICorner_4.Parent = AddTab_1
		UICorner_4.CornerRadius = UDim.new(0,5)

		About_1.Name = "About"
		About_1.Parent = AddTab_1
		About_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		About_1.BackgroundTransparency = 1
		About_1.BorderColor3 = Color3.fromRGB(0,0,0)
		About_1.BorderSizePixel = 0
		About_1.Size = UDim2.new(1, 0,1, 0)

		Title_1.Name = "Title"
		Title_1.Parent = About_1
		Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
		Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Title_1.BackgroundTransparency = 1
		Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Title_1.BorderSizePixel = 0
		Title_1.Position = UDim2.new(0.586206913, 0,0.5, 0)
		Title_1.Size = UDim2.new(0.827586234, 0,1, 0)
		Title_1.Font = Enum.Font.GothamBold
		Title_1.Text = Title
		Title_1.TextColor3 = Color3.fromRGB(255,255,255)
		Title_1.TextSize = 13
		Title_1.TextTransparency = 0.30000001192092896
		Title_1.TextXAlignment = Enum.TextXAlignment.Left

		UIListLayout_4.Parent = About_1
		UIListLayout_4.Padding = UDim.new(0,6)
		UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_4.VerticalAlignment = Enum.VerticalAlignment.Center

		Icon_1.Name = "Icon"
		Icon_1.Parent = About_1
		Icon_1.BackgroundColor3 = Theme.Tabs.Highlight
		Icon_1.BackgroundTransparency = 1
		Icon_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Icon_1.BorderSizePixel = 0
		Icon_1.LayoutOrder = -1
		Icon_1.Size = UDim2.new(0, 15,0, 15)
		Icon_1.Image = selfRBX(Icon)
		Icon_1.ImageColor3 = Theme.Tabs.Highlight

		UIPadding_3.Parent = About_1
		UIPadding_3.PaddingLeft = UDim.new(0,6)

		local AddPage_1 = Instance.new("Frame")
		local UICorner_7 = Instance.new("UICorner")
		local Frame_3 = Instance.new("Frame")
		local Frame_4 = Instance.new("Frame")
		local Frame_5 = Instance.new("Frame")
		local Byte_Tabs_1 = Instance.new("Frame")
		local Scrolling_1 = Instance.new("ScrollingFrame")
		local UIListLayout_8 = Instance.new("UIListLayout")
		local UIPadding_6 = Instance.new("UIPadding")

		AddPage_1.Name = "AddPage"
		AddPage_1.Parent = RE_Backgrund_1
		AddPage_1.BackgroundColor3 = Theme.Page.Background
		AddPage_1.BorderColor3 = Color3.fromRGB(0,0,0)
		AddPage_1.BorderSizePixel = 0
		AddPage_1.Position = UDim2.new(0.270000011, 0,0.130555555, 0)
		AddPage_1.Size = UDim2.new(0, 365,0, 313)
		AddPage_1.Visible = false

		UICorner_7.Parent = AddPage_1

		Frame_3.Parent = AddPage_1
		Frame_3.BackgroundColor3 = Color3.fromRGB(28,28,30)
		Frame_3.BorderColor3 = Color3.fromRGB(0,0,0)
		Frame_3.BorderSizePixel = 0
		Frame_3.Size = UDim2.new(0, 100,0, 47)

		Frame_4.Parent = AddPage_1
		Frame_4.BackgroundColor3 = Color3.fromRGB(28,28,30)
		Frame_4.BorderColor3 = Color3.fromRGB(0,0,0)
		Frame_4.BorderSizePixel = 0
		Frame_4.Position = UDim2.new(0, 0,0.849840283, 0)
		Frame_4.Size = UDim2.new(0, 100,0, 47)

		Frame_5.Parent = AddPage_1
		Frame_5.BackgroundColor3 = Color3.fromRGB(28,28,30)
		Frame_5.BorderColor3 = Color3.fromRGB(0,0,0)
		Frame_5.BorderSizePixel = 0
		Frame_5.Position = UDim2.new(0.726027369, 0,0, 0)
		Frame_5.Size = UDim2.new(0, 100,0, 47)

		Byte_Tabs_1.Name = "Byte_Tabs"
		Byte_Tabs_1.Parent = AddPage_1
		Byte_Tabs_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Byte_Tabs_1.BackgroundTransparency = 1
		Byte_Tabs_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Byte_Tabs_1.BorderSizePixel = 0
		Byte_Tabs_1.Size = UDim2.new(0, 0,1, 0)

		Scrolling_1.Name = "Scrolling"
		Scrolling_1.Parent = Byte_Tabs_1
		Scrolling_1.Active = true
		Scrolling_1.AnchorPoint = Vector2.new(0.5, 0.5)
		Scrolling_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Scrolling_1.BackgroundTransparency = 1
		Scrolling_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Scrolling_1.BorderSizePixel = 0
		Scrolling_1.Position = UDim2.new(0.5, 0,0.5, 0)
		Scrolling_1.Size = UDim2.new(1, 0,1, 0)
		Scrolling_1.ClipsDescendants = true
		Scrolling_1.AutomaticCanvasSize = Enum.AutomaticSize.None
		Scrolling_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
		Scrolling_1.CanvasPosition = Vector2.new(0, 0)
		Scrolling_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
		Scrolling_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
		Scrolling_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		Scrolling_1.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
		Scrolling_1.ScrollBarImageTransparency = 1
		Scrolling_1.ScrollBarThickness = 0
		Scrolling_1.ScrollingDirection = Enum.ScrollingDirection.XY
		Scrolling_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
		Scrolling_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
		Scrolling_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

		UIListLayout_8.Parent = Scrolling_1
		UIListLayout_8.Padding = UDim.new(0,10)
		UIListLayout_8.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_8.SortOrder = Enum.SortOrder.LayoutOrder

		UIListLayout_8:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Scrolling_1.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_8.AbsoluteContentSize.Y + 20)
		end)

		UIPadding_6.Parent = Scrolling_1
		UIPadding_6.PaddingBottom = UDim.new(0,10)
		UIPadding_6.PaddingLeft = UDim.new(0,5)
		UIPadding_6.PaddingRight = UDim.new(0,5)
		UIPadding_6.PaddingTop = UDim.new(0,10)

		local function OnVisible()
			Stop = true

			for _, v in pairs(RE_Backgrund_1:GetChildren()) do
				if v:IsA("Frame") and v.Name == "AddPage" then
					v.Visible = false
					tw({
						v = v.Byte_Tabs,
						t = 0.3,
						s = "Back",
						d = "Out",
						g = {Size = UDim2.new(0, 0, 1, 0)}
					}):Play()
				end
			end

			for _, v in pairs(RF_Scrolling_1:GetChildren()) do
				if v:IsA("Frame") then
					v.About.Icon.ImageColor3 = Theme.Tabs.Highlight
					v.About.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
					tw({
						v = v.About.Title,
						t = 0.2,
						s = "Back",
						d = "Out",
						g = {TextTransparency = 0.3}
					}):Play()
					tw({
						v = v,
						t = 0.2,
						s = "Back",
						d = "Out",
						g = {BackgroundTransparency = 1}
					}):Play()
				end
			end

			Stop = false
			AddPage_1.Visible = true
			Icon_1.ImageColor3 = Color3.new(0, 0, 0)
			Icon_2.Image = selfRBX(Icon)
			Title_1.TextColor3 = Color3.fromRGB(0, 0, 0)
			tw({
				v = AddTab_1,
				t = 0.2,
				s = "Back",
				d = "Out",
				g = {BackgroundTransparency = 0}
			}):Play()
			tw({
				v = Byte_Tabs_1,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {Size = UDim2.new(1, 0, 1, 0)}
			}):Play()
			UpdateHeader(Desc)
		end

		delay(0.2,function()
			if not Tabs.Value then
				SearchBox_1.Text = ""
				Tabs.Value = true
				AddPage_1.Visible = true
				AddTab_1.BackgroundColor3 = Theme.Tabs['Highlight']
				Icon_1.ImageColor3 = Color3.new(0, 0, 0)
				Icon_2.Image = selfRBX(Icon)
				Title_1.TextColor3 = Color3.fromRGB(0, 0, 0)
				tw({
					v = AddTab_1,
					t = 0.2,
					s = "Back",
					d = "Out",
					g = {BackgroundTransparency = 0}
				}):Play()
				tw({
					v = Title_1,
					t = 0.2,
					s = "Back",
					d = "Out",
					g = {TextTransparency = 0}
				}):Play()
				tw({
					v = Byte_Tabs_1,
					t = 0.3,
					s = "Back",
					d = "Out",
					g = {Size = UDim2.new(1, 0, 1, 0)}
				}):Play()
				UpdateHeader(Desc)
			end
		end)

		Button.MouseButton1Click:Connect(OnVisible)

		local Section = {}

		function Section:PageTitle(new)
			local Title = new.Title
			local Desc = new.Desc

			local PageTitle = Instance.new("Frame")
			local Title_1 = Instance.new("TextLabel")
			local Desc_1 = Instance.new("TextLabel")
			local UIListLayout_1 = Instance.new("UIListLayout")

			PageTitle.Name = "PageTitle"
			PageTitle.Parent = Scrolling_1
			PageTitle.BackgroundColor3 = Color3.fromRGB(255,255,255)
			PageTitle.BackgroundTransparency = 1
			PageTitle.BorderColor3 = Color3.fromRGB(0,0,0)
			PageTitle.BorderSizePixel = 0
			PageTitle.LayoutOrder = 1

			Title_1.Name = "Title"
			Title_1.Parent = PageTitle
			Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Title_1.BackgroundTransparency = 1
			Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Title_1.BorderSizePixel = 0
			Title_1.Size = UDim2.new(0, 335,0, 11)
			Title_1.Font = Enum.Font.GothamSemibold
			Title_1.Text = Title
			Title_1.TextColor3 = Color3.fromRGB(255,255,255)
			Title_1.TextSize = 14
			Title_1.TextStrokeColor3 = Color3.fromRGB(255,255,255)
			Title_1.TextXAlignment = Enum.TextXAlignment.Left
			Title_1.TextWrapped = true
			Title_1.TextYAlignment = Enum.TextYAlignment.Top

			Desc_1.Name = "Desc"
			Desc_1.Parent = PageTitle
			Desc_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Desc_1.BackgroundTransparency = 1
			Desc_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Desc_1.BorderSizePixel = 0
			Desc_1.Position = UDim2.new(0, 0,0.439999998, 0)
			Desc_1.Size = UDim2.new(0, 335,0, 10)
			Desc_1.Font = Enum.Font.GothamMedium
			Desc_1.Text = Desc
			Desc_1.LayoutOrder = 2
			Desc_1.TextColor3 = Color3.fromRGB(255,255,255)
			Desc_1.TextSize = 11
			Desc_1.TextTransparency = 0.5
			Desc_1.TextXAlignment = Enum.TextXAlignment.Left
			Desc_1.TextWrapped = true
			Desc_1.TextYAlignment = Enum.TextYAlignment.Top
			Desc_1.RichText = true

			UIListLayout_1.Parent = PageTitle
			UIListLayout_1.Padding = UDim.new(0,4)
			UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

			Desc_1.Size = UDim2.new(0, 335,0, (Desc_1.TextBounds.Y + Title_1.TextBounds.Y))
			PageTitle.Size = UDim2.new(0, 335,0, (Desc_1.TextBounds.Y + Title_1.TextBounds.Y))

			Desc_1:GetPropertyChangedSignal('Text'):Connect(function()
				Desc_1.Size = UDim2.new(0, 335,0, (Desc_1.TextBounds.Y + Title_1.TextBounds.Y))
				PageTitle.Size = UDim2.new(0, 335,0, (Desc_1.TextBounds.Y + Title_1.TextBounds.Y))
			end)

			delay(0.2, function()
				Desc_1.Size = UDim2.new(0, 335,0, (Desc_1.TextBounds.Y + Title_1.TextBounds.Y))
				PageTitle.Size = UDim2.new(0, 335,0, (Desc_1.TextBounds.Y + Title_1.TextBounds.Y))
			end)
		end

		function Section.new(new)
			local Section = Instance.new("Frame")
			local UICorner_1 = Instance.new("UICorner")
			local UIStroke_1 = Instance.new("UIStroke")
			local UIListLayout_1 = Instance.new("UIListLayout")
			local UIPadding_1 = Instance.new("UIPadding")

			Section.Name = "Section"
			Section.Parent = Scrolling_1
			Section.BackgroundColor3 = Theme.Page.Section.Background
			Section.BorderColor3 = Color3.fromRGB(0,0,0)
			Section.BorderSizePixel = 0
			Section.LayoutOrder = 1
			Section.Position = UDim2.new(-0.356338024, 0,0, 0)
			Section.Size = UDim2.new(0, 340,0, 100)

			UICorner_1.Parent = Section

			UIStroke_1.Parent = Section
			UIStroke_1.Color = Theme.Page.Section["Background Stroke"]
			UIStroke_1.Thickness = 1

			UIListLayout_1.Parent = Section
			UIListLayout_1.Padding = UDim.new(0,5)
			UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

			UIPadding_1.Parent = Section
			UIPadding_1.PaddingBottom = UDim.new(0,5)
			UIPadding_1.PaddingTop = UDim.new(0,5)

			UIListLayout_1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Section.Size = UDim2.new(0, 340, 0, UIListLayout_1.AbsoluteContentSize.Y + 15)
			end)

			local Object = {}

			function Object:Line()
				local Line = Instance.new("Frame")

				Line.Name = "Line"
				Line.Parent = Section
				Line.BackgroundColor3 = Theme.Page.Section.Line
				Line.BorderColor3 = Color3.fromRGB(0,0,0)
				Line.BorderSizePixel = 0
				Line.Position = UDim2.new(-0.3140845, 0,0.349999994, 0)
				Line.Size = UDim2.new(0, 315,0, 1)

				return Line
			end

			function Object:Toggle(new)
				local Title = new.Title
				local Desc = new.Desc or nil
				local Raw = Visualized:Raw(Section, Title, Desc)
				local Button = create(Raw)
				local Line = (not new.DisbleLine and self:Line()) or nil
				local Value = new.Value or false
				local Callback = new.Call or function() return end

				local Vanity = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local Circle_1 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Button = create(Raw)

				Vanity.Name = "Vanity"
				Vanity.Parent = Raw
				Vanity.AnchorPoint = Vector2.new(0.5, 0.5)
				Vanity.BackgroundColor3 = Color3.fromRGB(67,67,69)
				Vanity.BorderColor3 = Color3.fromRGB(0,0,0)
				Vanity.BorderSizePixel = 0
				Vanity.Position = UDim2.new(0.920075774, 0,0.5, 0)
				Vanity.Size = UDim2.new(0, 35,0, 20)

				UICorner_1.Parent = Vanity
				UICorner_1.CornerRadius = UDim.new(1,0)

				Circle_1.Name = "Circle"
				Circle_1.Parent = Vanity
				Circle_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Circle_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Circle_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Circle_1.BorderSizePixel = 0
				Circle_1.Position = UDim2.new(0.300000012, 0,0.5, 0)
				Circle_1.Size = UDim2.new(0, 15,0, 15)

				UICorner_2.Parent = Circle_1
				UICorner_2.CornerRadius = UDim.new(1,0)

				local function OnChanged(value)
					if not value then 
						Callback(Value)
						tw({
							v = Circle_1,
							t = 0.1,
							s = "Exponential",
							d = "Out",
							g = {Size = UDim2.new(0, 15,0, 8)}
						}):Play()
						Vanity.BackgroundColor3 = Theme.Page.Section.Toggle.OFF
						tw({
							v = Circle_1,
							t = 0.25,
							s = "Back",
							d = "Out",
							g = {Position = UDim2.new(0.3, 0,0.5, 0)}
						}):Play()
						delay(0.05, function()
							tw({
								v = Circle_1,
								t = 0.1,
								s = "Bounce",
								d = "Out",
								g = {Size = UDim2.new(0, 15,0, 15)}
							}):Play()
						end)
					elseif value then 
						Callback(Value)
						tw({
							v = Circle_1,
							t = 0.1,
							s = "Exponential",
							d = "Out",
							g = {Size = UDim2.new(0, 15,0, 8)}
						}):Play()
						tw({
							v = Circle_1,
							t = 0.1,
							s = "Linear",
							d = "Out",
							g = {Position = UDim2.new(0.7, 0,0.5, 0)}
						}):Play()
						delay(0.05, function()
							tw({
								v = Circle_1,
								t = 0.1,
								s = "Bounce",
								d = "Out",
								g = {Size = UDim2.new(0, 15,0, 15)}
							}):Play()
						end)

						Vanity.BackgroundColor3 = Theme.Page.Section.Toggle.ON
					end
				end

				local function Init()
					Value = not Value
					OnChanged(Value)
				end

				Button.MouseButton1Click:Connect(Init)

				OnChanged(Value)

				local Constant = {}

				function Constant:ChangeValue(value)
					Value = value
					OnChanged(value)
				end

				return Constant
			end

			function Object:Button(new)
				local Title = new.Title
				local Desc = new.Desc or nil
				local Label = new.Label or 'Click!'
				local Raw = Visualized:Raw(Section, Title, Desc)
				local Line = (not new.DisbleLine and self:Line()) or nil
				local Callback = new.Call or function() return end

				local Clickable = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local UIGradient_1 = Instance.new("UIGradient")
				local Title_1 = Instance.new("TextLabel")
				local Button = create(Clickable)

				Clickable.Name = "Clickable"
				Clickable.Parent = Raw
				Clickable.AnchorPoint = Vector2.new(1, 0.5)
				Clickable.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Clickable.BorderColor3 = Color3.fromRGB(0,0,0)
				Clickable.BorderSizePixel = 0
				Clickable.Position = UDim2.new(0.977272749, 0,0.5, 0)
				Clickable.Size = UDim2.new(0, 52,0, 15)

				UICorner_1.Parent = Clickable
				UICorner_1.CornerRadius = UDim.new(0,4)

				UIGradient_1.Parent = Clickable
				UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 159, 77)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 123))}
				UIGradient_1.Rotation = 90

				Title_1.Name = "Title"
				Title_1.Parent = Clickable
				Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Title_1.BackgroundTransparency = 1
				Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Title_1.BorderSizePixel = 0
				Title_1.Position = UDim2.new(0.5, 0,0.449999988, 0)
				Title_1.Size = UDim2.new(0, 20,0, 14)
				Title_1.Font = Enum.Font.GothamSemibold
				Title_1.Text = Label
				Title_1.TextColor3 = Color3.fromRGB(255,255,255)
				Title_1.TextSize = 10

				Clickable.Size = UDim2.new(0, Title_1.TextBounds.X + 20, 0, 15)

				Button.MouseButton1Click:Connect(function()
					task.spawn(Callback)
					effect(Button, Clickable)
				end)
			end

			function Object:Textfield(new)
				local Title = new.Title
				local Desc = new.Desc or nil
				local Holder = new.Holder or ' ... '
				local Value = new.Value or ""
				local Raw = Visualized:Raw(Section, Title, Desc)
				local Line = (not new.DisbleLine and self:Line()) or nil
				local Callback = new.Call or function() return end

				local Box = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local UIStroke_1 = Instance.new("UIStroke")
				local TextBox_1 = Instance.new("TextBox")

				Box.Name = "Box"
				Box.Parent = Raw
				Box.AnchorPoint = Vector2.new(1, 0.5)
				Box.BackgroundColor3 = Color3.fromRGB(50,50,50)
				Box.BorderColor3 = Color3.fromRGB(0,0,0)
				Box.BorderSizePixel = 0
				Box.Position = UDim2.new(0.977272749, 0,0.5, 0)
				Box.Size = UDim2.new(0, 100,0, 18)

				UICorner_1.Parent = Box
				UICorner_1.CornerRadius = UDim.new(0,4)

				UIStroke_1.Parent = Box
				UIStroke_1.Color = Color3.fromRGB(75,75,75)
				UIStroke_1.Thickness = 1

				TextBox_1.Parent = Box
				TextBox_1.Active = true
				TextBox_1.AnchorPoint = Vector2.new(0.5, 0.5)
				TextBox_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				TextBox_1.BackgroundTransparency = 1
				TextBox_1.BorderColor3 = Color3.fromRGB(0,0,0)
				TextBox_1.BorderSizePixel = 0
				TextBox_1.CursorPosition = -1
				TextBox_1.Position = UDim2.new(0.5, 0,0.5, 0)
				TextBox_1.Size = UDim2.new(0.899999976, 0,1, 0)
				TextBox_1.Font = Enum.Font.GothamMedium
				TextBox_1.PlaceholderText = Holder
				TextBox_1.Text = Value
				TextBox_1.TextColor3 = Color3.fromRGB(178,178,178)
				TextBox_1.TextSize = 11
				TextBox_1.TextTruncate = Enum.TextTruncate.AtEnd

				TextBox_1.Focused:Connect(function()
					TextBox_1.TextColor3 = Color3.new(1, 1, 1)
					SearchBox_1.TextTruncate = Enum.TextTruncate.None
				end)

				TextBox_1.FocusLost:Connect(function()
					Value = TextBox_1.Text
					task.spawn(Callback, Value)
					TextBox_1.TextColor3 = Color3.fromRGB(178,178,178)
					SearchBox_1.TextTruncate = Enum.TextTruncate.AtEnd
				end)
			end

			function Object:Slider(new)
				local Title = new.Title
				local Desc = new.Desc or nil
				local Value = new.Value or ""
				local Min = new.Min or 1
				local Max = new.Max or 10
				local Rounding = new.Rounding or 0
				local Raw = Visualized:Raw(Section, Title, Desc)
				local Line = (not new.DisbleLine and self:Line()) or nil
				local Callback = new.Call or function() return end

				local Side = Instance.new("Frame")
				local Slider_1 = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local Color_1 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Circle_1 = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local Changed_1 = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local UIStroke_1 = Instance.new("UIStroke")
				local TextBox_1 = Instance.new("TextBox")
				local Slide = create(Side)

				Side.Name = "Side"
				Side.Parent = Raw
				Side.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Side.BackgroundTransparency = 1
				Side.BorderColor3 = Color3.fromRGB(0,0,0)
				Side.BorderSizePixel = 0
				Side.Size = UDim2.new(1, 0,1, 0)

				Slide.Size = UDim2.new(0, 175, 0.75, 0)
				Slide.Position = UDim2.new(0.85, 0, 0.5, 0)
				Slide.AnchorPoint = Vector2.new(1, 0.5)

				Slider_1.Name = "Slider"
				Slider_1.Parent = Side
				Slider_1.AnchorPoint = Vector2.new(1, 0.5)
				Slider_1.BackgroundColor3 = Color3.fromRGB(54,54,54)
				Slider_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Slider_1.BorderSizePixel = 0
				Slider_1.Position = UDim2.new(0.85, 0,0.5, 0)
				Slider_1.Size = UDim2.new(0, 120,0, 5)

				UICorner_1.Parent = Slider_1
				UICorner_1.CornerRadius = UDim.new(1,0)

				Color_1.Name = "Color"
				Color_1.Parent = Slider_1
				Color_1.AnchorPoint = Vector2.new(0, 0.5)
				Color_1.BackgroundColor3 = Theme.Tabs.Highlight
				Color_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Color_1.BorderSizePixel = 0
				Color_1.Position = UDim2.new(0, 0,0.5, 0)
				Color_1.Size = UDim2.new(0, 125,0, 5)

				UICorner_2.Parent = Color_1
				UICorner_2.CornerRadius = UDim.new(1,0)

				Circle_1.Name = "Circle"
				Circle_1.Parent = Color_1
				Circle_1.AnchorPoint = Vector2.new(1, 0.5)
				Circle_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Circle_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Circle_1.BorderSizePixel = 0
				Circle_1.Position = UDim2.new(1, 0,0.5, 0)
				Circle_1.Size = UDim2.new(0, 15,0, 15)

				UICorner_3.Parent = Circle_1
				UICorner_3.CornerRadius = UDim.new(1,0)

				Changed_1.Name = "Changed"
				Changed_1.Parent = Side
				Changed_1.AnchorPoint = Vector2.new(1, 0.5)
				Changed_1.BackgroundColor3 = Color3.fromRGB(50,50,50)
				Changed_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Changed_1.BorderSizePixel = 0
				Changed_1.Position = UDim2.new(0.98, 0,0.5, 0)
				Changed_1.Size = UDim2.new(0, 35,0, 20)

				UICorner_4.Parent = Changed_1
				UICorner_4.CornerRadius = UDim.new(0,4)

				UIStroke_1.Parent = Changed_1
				UIStroke_1.Color = Color3.fromRGB(75,75,75)
				UIStroke_1.Thickness = 1

				TextBox_1.Parent = Changed_1
				TextBox_1.Active = true
				TextBox_1.AnchorPoint = Vector2.new(0.5, 0.5)
				TextBox_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				TextBox_1.BackgroundTransparency = 1
				TextBox_1.BorderColor3 = Color3.fromRGB(0,0,0)
				TextBox_1.BorderSizePixel = 0
				TextBox_1.CursorPosition = -1
				TextBox_1.Position = UDim2.new(0.5, 0,0.449999988, 0)
				TextBox_1.Size = UDim2.new(0.899999976, 0,1, 0)
				TextBox_1.Font = Enum.Font.GothamMedium
				TextBox_1.PlaceholderText = "Value"
				TextBox_1.Text = Value
				TextBox_1.TextColor3 = Color3.fromRGB(178,178,178)
				TextBox_1.TextSize = 10
				TextBox_1.TextXAlignment = Enum.TextXAlignment.Center
				TextBox_1.TextTruncate = Enum.TextTruncate.AtEnd

				local function roundToDecimal(value, decimals)
					local factor = 10 ^ decimals
					return math.floor(value * factor + 0.5) / factor
				end

				local function updateSlider(value)
					value = math.clamp(value, Min, Max)
					value = roundToDecimal(value, Rounding)
					tw({
						v = Color_1,
						t = 0.15,
						s = "Exponential",
						d = "Out",
						g = {Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)}
					}):Play()
					local startValue = tonumber(TextBox_1.Text) or 0
					local targetValue = value

					local steps = 5
					local currentValue = startValue
					for i = 1, steps do
						task.wait(0.01 / steps)
						currentValue = currentValue + (targetValue - startValue) / steps
						TextBox_1.Text = tostring(roundToDecimal(currentValue, Rounding))
					end

					TextBox_1.Text = tostring(roundToDecimal(targetValue, Rounding))

					Callback(value)
				end

				updateSlider(Value or 0)

				local function move(input)
					local sliderBar = Slider_1
					local relativeX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
					local value = relativeX * (Max - Min) + Min
					updateSlider(value)
				end

				TextBox_1.FocusLost:Connect(function()
					local value = tonumber(TextBox_1.Text) or Min
					updateSlider(value)
				end)

				local dragging = false

				Slide.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						move(input)
					end
				end)

				Slide.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						move(input)
					end
				end)
			end

			function Object:Paragarp(new)
				local Title = new.Title
				local Desc = new.Desc or nil
				local Raw = Visualized:Raw(Section, Title, Desc)
				local Line = (not new.DisbleLine and self:Line()) or nil

				local New = {}

				local Title_1 = Raw.Text.Title
				local Desc_1 = Desc and Raw.Text.Desc

				Title_1.RichText = true
				Desc_1.TextWrapped = true
				Title_1.Size = UDim2.new(0, 315,0, Title_1.TextBounds.Y)
				Desc_1.Size = UDim2.new(0, 315,0, Desc_1.TextBounds.Y)
				Raw.Size = UDim2.new(0, 330,0, (Desc_1.TextBounds.Y + Title_1.TextBounds.Y))

				function New:SetTitle(a)
					Title_1.Text = a
				end

				if Desc then
					Desc_1.RichText = true

					function New:SetDesc(a)
						Desc_1.Text = a
					end

					Desc_1:GetPropertyChangedSignal('Text'):Connect(function()
						Desc_1.Size = UDim2.new(0, 315,0, Desc_1.TextBounds.Y)
						Raw.Size = UDim2.new(0, 330,0, (Desc_1.TextBounds.Y + Title_1.TextBounds.Y + 10))
					end)

					delay(0.2, function()
						Desc_1.Size = UDim2.new(0, 315,0, Desc_1.TextBounds.Y)
						Raw.Size = UDim2.new(0, 330,0, (Desc_1.TextBounds.Y + Title_1.TextBounds.Y + 10))
					end)
				end

				return New
			end
			
			function Object:List(new)
				local Title = new.Title or "Dropdown"
				local List = new.List or {}
				local Value = new.Value or "N/A"
				local Multi = (typeof(Value) == "table" and true)
				local Raw = Visualized:Raw(Section, Title, Desc)
				local Line = (not new.DisbleLine and self:Line()) or nil
				local Call = new.Call or function() return end
				
				local Desc_1 = Raw.Text.Desc

				local function ChangeText()
					if typeof(Value) == 'table' then
						Desc_1.Text = table.concat(Value, ", ")
					else
						Desc_1.Text = Value
					end
				end

				ChangeText()

				local asset = Instance.new("ImageLabel")
				asset.Name = "asset"
				asset.Parent = Raw
				asset.AnchorPoint = Vector2.new(0.5, 0.5)
				asset.BackgroundColor3 = Color3.fromRGB(255,255,255)
				asset.BackgroundTransparency = 1
				asset.BorderColor3 = Color3.fromRGB(0,0,0)
				asset.BorderSizePixel = 0
				asset.Position = UDim2.new(0.944999993, 0,0.5, 0)
				asset.Size = UDim2.new(0, 20,0, 20)
				asset.Image = "rbxassetid://100756722171557"

				local Buttons = create(Raw)
				
				local Dropdown = Instance.new("Frame")
				local UIStroke_1 = Instance.new("UIStroke")
				local ScrollingFrame_1 = Instance.new("ScrollingFrame")
				local UIListLayout_1 = Instance.new("UIListLayout")
				local UIPadding_1 = Instance.new("UIPadding")
				local DropShadow_1 = Instance.new("ImageLabel")
				local UICorner_1 = Instance.new("UICorner")
				local Search_1 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local UIListLayout_2 = Instance.new("UIListLayout")
				local UIPadding_2 = Instance.new("UIPadding")
				local UIStroke_2 = Instance.new("UIStroke")
				local SearchBox_1 = Instance.new("TextBox")
				local asset_1 = Instance.new("ImageLabel")

				SearchBox_1.Focused:Connect(function()
					SearchBox_1.TextTruncate = Enum.TextTruncate.None
				end)

				SearchBox_1.FocusLost:Connect(function()
					SearchBox_1.TextTruncate = Enum.TextTruncate.AtEnd
				end)

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Background_1
				Dropdown.AnchorPoint = Vector2.new(0.5, 0.5)
				Dropdown.BackgroundColor3 = Color3.fromRGB(54,54,54)
				Dropdown.BorderColor3 = Color3.fromRGB(0,0,0)
				Dropdown.BorderSizePixel = 0
				Dropdown.Position = UDim2.new(0.5, 0,0.35, 0)
				Dropdown.Size = UDim2.new(0, 275,0, 275)
				Dropdown.ZIndex = 20
				Dropdown.Visible = false
				UIStroke_1.Parent = Dropdown
				UIStroke_1.Color = Color3.fromRGB(100,100,100)
				UIStroke_1.Thickness = 1

				ScrollingFrame_1.Name = "ScrollingFrame"
				ScrollingFrame_1.Parent = Dropdown
				ScrollingFrame_1.Active = true
				ScrollingFrame_1.AnchorPoint = Vector2.new(0.5, 0.5)
				ScrollingFrame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				ScrollingFrame_1.BackgroundTransparency = 1
				ScrollingFrame_1.BorderColor3 = Color3.fromRGB(0,0,0)
				ScrollingFrame_1.BorderSizePixel = 0
				ScrollingFrame_1.Position = UDim2.new(0.5, 0,0.441818178, 0)
				ScrollingFrame_1.Size = UDim2.new(1, 0,0.883636355, 0)
				ScrollingFrame_1.ZIndex = 20
				ScrollingFrame_1.ClipsDescendants = true
				ScrollingFrame_1.AutomaticCanvasSize = Enum.AutomaticSize.None
				ScrollingFrame_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
				ScrollingFrame_1.CanvasPosition = Vector2.new(0, 0)
				ScrollingFrame_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
				ScrollingFrame_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
				ScrollingFrame_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				ScrollingFrame_1.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
				ScrollingFrame_1.ScrollBarImageTransparency = 1
				ScrollingFrame_1.ScrollBarThickness = 0
				ScrollingFrame_1.ScrollingDirection = Enum.ScrollingDirection.XY
				ScrollingFrame_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
				ScrollingFrame_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
				ScrollingFrame_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

				UIListLayout_1.Parent = ScrollingFrame_1
				UIListLayout_1.Padding = UDim.new(0,3)
				UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
				UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

				UIPadding_1.Parent = ScrollingFrame_1
				UIPadding_1.PaddingTop = UDim.new(0,10)

				DropShadow_1.Name = "DropShadow"
				DropShadow_1.Parent = Dropdown
				DropShadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
				DropShadow_1.BackgroundColor3 = Color3.fromRGB(28,28,30)
				DropShadow_1.BackgroundTransparency = 1
				DropShadow_1.BorderColor3 = Color3.fromRGB(0,0,0)
				DropShadow_1.BorderSizePixel = 0
				DropShadow_1.Position = UDim2.new(0.5, 0,0.5, 0)
				DropShadow_1.Size = UDim2.new(1, 100,1, 100)
				DropShadow_1.Image = "rbxassetid://8992230677"
				DropShadow_1.ImageColor3 = Color3.fromRGB(103,103,103)
				DropShadow_1.ImageTransparency = 0.4000000059604645
				DropShadow_1.ScaleType = Enum.ScaleType.Slice
				DropShadow_1.SliceCenter = Rect.new(99, 99, 99, 99)

				UICorner_1.Parent = Dropdown

				Search_1.Name = "Search"
				Search_1.Parent = Dropdown
				Search_1.BackgroundColor3 = Color3.fromRGB(33,33,33)
				Search_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Search_1.BorderSizePixel = 0
				Search_1.Position = UDim2.new(0.0218181815, 0,0.894545436, 0)
				Search_1.Size = UDim2.new(0, 263,0, 24)
				Search_1.ZIndex = 20

				UICorner_2.Parent = Search_1
				UICorner_2.CornerRadius = UDim.new(0,5)

				UIListLayout_2.Parent = Search_1
				UIListLayout_2.Padding = UDim.new(0,5)
				UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

				UIPadding_2.Parent = Search_1
				UIPadding_2.PaddingLeft = UDim.new(0,5)

				UIStroke_2.Parent = Search_1
				UIStroke_2.Color = Color3.fromRGB(110,110,110)
				UIStroke_2.Thickness = 1

				SearchBox_1.Name = "SearchBox"
				SearchBox_1.Parent = Search_1
				SearchBox_1.Active = true
				SearchBox_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				SearchBox_1.BackgroundTransparency = 1
				SearchBox_1.BorderColor3 = Color3.fromRGB(0,0,0)
				SearchBox_1.BorderSizePixel = 0
				SearchBox_1.Position = UDim2.new(0.157894731, 0,0.100000001, 0)
				SearchBox_1.Size = UDim2.new(0, 230,0, 20)
				SearchBox_1.ZIndex = 20
				SearchBox_1.Font = Enum.Font.GothamMedium
				SearchBox_1.PlaceholderText = "Search ..."
				SearchBox_1.Text = ""
				SearchBox_1.TextColor3 = Color3.fromRGB(178,178,178)
				SearchBox_1.TextSize = 12
				SearchBox_1.TextXAlignment = Enum.TextXAlignment.Left

				asset_1.Name = "asset"
				asset_1.Parent = Search_1
				asset_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				asset_1.BackgroundTransparency = 1
				asset_1.BorderColor3 = Color3.fromRGB(0,0,0)
				asset_1.BorderSizePixel = 0
				asset_1.LayoutOrder = -1
				asset_1.Size = UDim2.new(0, 15,0, 15)
				asset_1.ZIndex = 20
				asset_1.Image = "rbxassetid://125928820284709"
				
				local isOpen = false

				UserInputService.InputBegan:Connect(function(A)
					local mouse = game:GetService("Players").LocalPlayer:GetMouse()
					local mx, my = mouse.X, mouse.Y
					local DBP, DBS = Dropdown.AbsolutePosition, Dropdown.AbsoluteSize

					local function inside(pos, size)
						return mx >= pos.X and mx <= pos.X + size.X and my >= pos.Y and my <= pos.Y + size.Y
					end

					if A.UserInputType == Enum.UserInputType.MouseButton1 or A.UserInputType == Enum.UserInputType.Touch then
						if not inside(DBP, DBS) then
							isOpen = false
							Dropdown.Visible = false
							Dropdown.Position = UDim2.new(0.5, 0,0.35, 0)
						end
					end

					if A.UserInputType == Enum.UserInputType.MouseWheel then
						if not inside(DBP, DBS) then
							isOpen = false
							Dropdown.Visible = false
							Dropdown.Position = UDim2.new(0.5, 0,0.35, 0)
						end
					end
				end)

				local function OnDropdownChanged()
					for _, v in pairs(Background_1:GetChildren()) do
						if v.Name == "Dropdown" and v.Visible then
							return
						end
					end

					isOpen = not isOpen

					if isOpen then
						tw({
							v = Dropdown,
							t = 0.3,
							s = "Back",
							d = "Out",
							g = {Position = UDim2.new(0.5, 0,0.5, 0)}
						}):Play()
						Dropdown.Visible = true
					else
						Dropdown.Visible = false
						Dropdown.Position = UDim2.new(0.5, 0,0.35, 0)
					end
				end
				
				SearchBox_1.Changed:Connect(function()
					local SearchT = string.lower(SearchBox_1.Text)
					for i, v in pairs(ScrollingFrame_1:GetChildren()) do
						if v:IsA("Frame") then
							local labelText = string.lower(v.Title.Text)
							if string.find(labelText, SearchT, 1, true) then
								v.Visible = true
							else
								v.Visible = false
							end
						end
					end
				end)
				
				Buttons.MouseButton1Click:Connect(OnDropdownChanged)

				local itemslist = {}

				local selectedItem

				function itemslist:Clear(a)
					local function shouldClear(v)
						if a == nil then
							return true
						elseif type(a) == "string" then
							return v.Title.Text == a
						elseif type(a) == "table" then
							for _, name in ipairs(a) do
								if v.Title.Text == name then
									return true
								end
							end
						end
						return false
					end

					for _, v in ipairs(ScrollingFrame_1:GetChildren()) do
						if v:IsA("Frame") and shouldClear(v) then
							if selectedItem and v.Title.Text == selectedItem then
								selectedItem = nil
								Desc_1.Text = "N/A"
							end
							v:Destroy()
						end
					end

					if selectedItem == a or Desc_1.Text == a then
						selectedItem = nil
						Desc_1.Text = "N/A"
					end

					if a == nil then
						selectedItem = nil
						Desc_1.Text = "N/A"
					end
				end

				local selectedValues = {}

				local function isValueInTable(val, tbl)
					if type(tbl) ~= "table" then
						return false
					end

					for _, v in pairs(tbl) do
						if v == val then
							return true
						end
					end
					return false
				end
				
				function itemslist:AddList(i)

					local AddList = Instance.new("Frame")
					local Title_1 = Instance.new("TextLabel")
					local UICorner_1 = Instance.new("UICorner")
					local ClickList = create(AddList)

					AddList.Name = "AddList"
					AddList.Parent = ScrollingFrame_1
					AddList.BackgroundColor3 = Color3.fromRGB(38,38,38)
					AddList.BorderColor3 = Color3.fromRGB(0,0,0)
					AddList.BorderSizePixel = 0
					AddList.Position = UDim2.new(0.0309090912, 0,0, 0)
					AddList.Size = UDim2.new(0, 260,0, 25)
					AddList.ZIndex = 20
					
					Title_1.Name = "Title"
					Title_1.Parent = AddList
					Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
					Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
					Title_1.BackgroundTransparency = 1
					Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
					Title_1.BorderSizePixel = 0
					Title_1.Position = UDim2.new(0.5, 0,0.474999994, 0)
					Title_1.Size = UDim2.new(0.899999976, 0,1, 0)
					Title_1.ZIndex = 20
					Title_1.Font = Enum.Font.GothamMedium
					Title_1.Text = i
					Title_1.TextColor3 = Color3.fromRGB(255,255,255)
					Title_1.TextSize = 12
					Title_1.TextTransparency = 0.35
					Title_1.TextXAlignment = Enum.TextXAlignment.Left

					UICorner_1.Parent = AddList
					UICorner_1.CornerRadius = UDim.new(0,5)
					
					local function Changed(v)
						if v then
							tw({
								v = Title_1,
								t = 0.15,
								s = "Exponential",
								d = "Out",
								g = {TextTransparency = 0}
							}):Play()
							Title_1.TextColor3 = Color3.fromRGB(0, 0, 0)
							AddList.BackgroundColor3 = Theme.Tabs.Highlight
						else
							tw({
								v = Title_1,
								t = 0.15,
								s = "Exponential",
								d = "Out",
								g = {TextTransparency = 0.35}
							}):Play()
							Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
							AddList.BackgroundColor3 = Color3.fromRGB(38,38,38)
						end
					end

					local function OnSelected()
						if Multi then
							if selectedValues[i] then
								selectedValues[i] = nil
								Changed(false)
							else
								selectedValues[i] = true
								Changed(true)
							end

							local selectedList = {}

							for i, v in pairs(selectedValues) do
								table.insert(selectedList, i)
							end

							if #selectedList > 0 then
								table.sort(selectedList)
								Value = selectedList
								ChangeText()
							else
								Desc_1.Text = "N/A"
							end

							pcall(Call, selectedList)
						else
							for i,v in pairs(ScrollingFrame_1:GetChildren()) do
								if v:IsA("Frame") then
									v.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
									tw({
										v = v.Title,
										t = 0.15,
										s = "Exponential",
										d = "Out",
										g = {TextTransparency = 0.35}
									}):Play()
			
									v.BackgroundColor3 = Color3.fromRGB(38,38,38)
								end
							end

							Changed(true)
							Dropdown.Visible = false
							Dropdown.Position = UDim2.new(0.5, 0,0.35, 0)
							isOpen = false
							Value = i
							ChangeText()
							pcall(Call, Value)
						end
					end

					delay(0,function()
						if Multi then
							if isValueInTable(i, Value) then
								selectedValues[i] = true

								Changed(true)

								local selectedList = {}

								for i, v in pairs(selectedValues) do
									table.insert(selectedList, i)
								end

								if #selectedList > 0 then
									ChangeText()
								else
									Desc_1.Text = "N/A"
								end

								pcall(Call, selectedList)
							end
						else
							if i == Value then
								Value = i
								Changed(true)
								ChangeText()
								pcall(Call, Value)
							end
						end
					end)

					ClickList.MouseButton1Click:Connect(OnSelected)
				end

				for _, name in ipairs(List) do
					itemslist:AddList(name)
				end

				UIListLayout_1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					ScrollingFrame_1.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_1.AbsoluteContentSize.Y + 15)
				end)

				return itemslist
			end

			return Object
		end

		return Section
	end

	return Tabs
end

return Visualized
