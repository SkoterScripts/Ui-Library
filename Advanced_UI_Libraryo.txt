--// Advanced UI Library v2
--// Premium redesign + Minimize & Close
--// Original base by Biel Bueno | Redesigned by ChatGPT

if getgenv().ADV_UI_V2 then return end
getgenv().ADV_UI_V2 = true

--// SERVICES
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

--// LIB
local UILibrary = {}

--// THEME
UILibrary.Theme = {
	Primary = Color3.fromRGB(90,140,255),
	Secondary = Color3.fromRGB(32,34,44),
	Background = Color3.fromRGB(18,19,25),
	Accent = Color3.fromRGB(120,200,255),
	Text = Color3.fromRGB(240,240,255),
	SubText = Color3.fromRGB(170,170,190),
	Danger = Color3.fromRGB(255, заменено, 90)
}

--// UTILS
local function tween(obj, props, time, style)
	TweenService:Create(
		obj,
		TweenInfo.new(time or 0.25, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		props
	):Play()
end

local function corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = parent
end

local function stroke(parent, color, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0
	s.Parent = parent
end

local function gradient(parent, colors)
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new(colors)
	g.Parent = parent
end

--// WINDOW
function UILibrary:CreateWindow(title)
	local theme = self.Theme
	local player = Players.LocalPlayer

	local gui = Instance.new("ScreenGui")
	gui.Name = "AdvancedUIv2"
	gui.ResetOnSpawn = false
	gui.Parent = player:WaitForChild("PlayerGui")

	-- SHADOW
	local shadow = Instance.new("ImageLabel", gui)
	shadow.Size = UDim2.fromScale(0.38,0.48)
	shadow.Position = UDim2.fromScale(0.31,0.26)
	shadow.Image = "rbxassetid://1316045217"
	shadow.ImageTransparency = 0.35
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(10,10,118,118)
	shadow.BackgroundTransparency = 1

	-- MAIN
	local main = Instance.new("Frame", gui)
	main.Size = UDim2.fromScale(0.36,0.46)
	main.Position = UDim2.fromScale(0.32,0.27)
	main.BackgroundColor3 = theme.Background
	main.BorderSizePixel = 0
	corner(main, 16)
	stroke(main, theme.Accent, 1, 0.6)

	-- TOPBAR
	local top = Instance.new("Frame", main)
	top.Size = UDim2.new(1,0,0,50)
	top.BackgroundColor3 = theme.Secondary
	top.BorderSizePixel = 0
	corner(top, 16)
	gradient(top, {
		ColorSequenceKeypoint.new(0, theme.Primary),
		ColorSequenceKeypoint.new(1, theme.Accent)
	})

	-- TITLE
	local titleLbl = Instance.new("TextLabel", top)
	titleLbl.Size = UDim2.new(1,-110,1,0)
	titleLbl.Position = UDim2.new(0,15,0,0)
	titleLbl.Text = title or "Advanced UI"
	titleLbl.Font = Enum.Font.GothamBlack
	titleLbl.TextSize = 20
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.TextColor3 = theme.Text
	titleLbl.BackgroundTransparency = 1

	-- CLOSE BUTTON
	local close = Instance.new("TextButton", top)
	close.Size = UDim2.new(0,32,0,32)
	close.Position = UDim2.new(1,-38,0.5,-16)
	close.Text = "✕"
	close.Font = Enum.Font.GothamBold
	close.TextSize = 18
	close.TextColor3 = theme.Text
	close.BackgroundColor3 = Color3.fromRGB(200,70,70)
	close.BorderSizePixel = 0
	corner(close, 10)

	-- MINIMIZE BUTTON
	local minimize = Instance.new("TextButton", top)
	minimize.Size = UDim2.new(0,32,0,32)
	minimize.Position = UDim2.new(1,-76,0.5,-16)
	minimize.Text = "–"
	minimize.Font = Enum.Font.GothamBold
	minimize.TextSize = 22
	minimize.TextColor3 = theme.Text
	minimize.BackgroundColor3 = theme.Primary
	minimize.BorderSizePixel = 0
	corner(minimize, 10)

	-- CONTENT
	local content = Instance.new("ScrollingFrame", main)
	content.Position = UDim2.new(0,15,0,60)
	content.Size = UDim2.new(1,-30,1,-75)
	content.CanvasSize = UDim2.new(0,0,0,0)
	content.ScrollBarImageTransparency = 1
	content.AutomaticCanvasSize = Enum.AutomaticSize.Y
	content.BackgroundTransparency = 1

	local layout = Instance.new("UIListLayout", content)
	layout.Padding = UDim.new(0,12)

	-- STATES
	local minimized = false
	local originalSize = main.Size

	-- BUTTON LOGIC
	close.MouseButton1Click:Connect(function()
		tween(main, {Size = UDim2.fromScale(0,0), Transparency = 1}, 0.3)
		task.wait(0.3)
		gui:Destroy()
	end)

	minimize.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			tween(main, {Size = UDim2.new(originalSize.X.Scale,0,0,50)}, 0.35, Enum.EasingStyle.Back)
			content.Visible = false
		else
			tween(main, {Size = originalSize}, 0.35, Enum.EasingStyle.Back)
			content.Visible = true
		end
	end)

	-- DRAG
	local dragging = false
	local dragStart, startPos

	top.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = i.Position
			startPos = main.Position
		end
	end)

	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	RunService.RenderStepped:Connect(function()
		if dragging then
			local delta = UserInputService:GetMouseLocation() - dragStart
			main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			shadow.Position = main.Position - UDim2.fromOffset(10,10)
		end
	end)

	-- API
	local window = {}

	function window:AddButton(text, callback)
		local btn = Instance.new("TextButton", content)
		btn.Size = UDim2.new(1,0,0,45)
		btn.Text = text
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 16
		btn.TextColor3 = theme.Text
		btn.BackgroundColor3 = theme.Secondary
		btn.BorderSizePixel = 0
		corner(btn, 12)
		stroke(btn, theme.Primary, 1, 0.5)

		btn.MouseEnter:Connect(function()
			tween(btn, {BackgroundColor3 = theme.Primary}, 0.2)
		end)

		btn.MouseLeave:Connect(function()
			tween(btn, {BackgroundColor3 = theme.Secondary}, 0.2)
		end)

		btn.MouseButton1Click:Connect(function()
			if callback then callback() end
		end)
	end

	function window:AddToggle(text, default, callback)
		local state = default or false

		local holder = Instance.new("Frame", content)
		holder.Size = UDim2.new(1,0,0,45)
		holder.BackgroundColor3 = theme.Secondary
		holder.BorderSizePixel = 0
		corner(holder, 12)

		local label = Instance.new("TextLabel", holder)
		label.Size = UDim2.new(0.7,0,1,0)
		label.Position = UDim2.new(0,15,0,0)
		label.Text = text
		label.Font = Enum.Font.GothamSemibold
		label.TextSize = 15
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.TextColor3 = theme.Text
		label.BackgroundTransparency = 1

		local toggle = Instance.new("TextButton", holder)
		toggle.Size = UDim2.new(0,50,0,26)
		toggle.Position = UDim2.new(1,-70,0.5,-13)
		toggle.Text = ""
		toggle.BackgroundColor3 = theme.Background
		toggle.BorderSizePixel = 0
		corner(toggle, 20)

		local knob = Instance.new("Frame", toggle)
		knob.Size = UDim2.new(0,22,0,22)
		knob.Position = state and UDim2.new(1,-24,0.5,-11) or UDim2.new(0,2,0.5,-11)
		knob.BackgroundColor3 = state and theme.Primary or theme.SubText
		corner(knob, 20)

		toggle.MouseButton1Click:Connect(function()
			state = not state
			tween(knob, {
				Position = state and UDim2.new(1,-24,0.5,-11) or UDim2.new(0,2,0.5,-11),
				BackgroundColor3 = state and theme.Primary or theme.SubText
			}, 0.25)
			if callback then callback(state) end
		end)

		if callback then callback(state) end
	end

	return window
end

return UILibrary
