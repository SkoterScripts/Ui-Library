-- EvadeHubMock.lua
-- Réplica visual do hub mostrado, sem qualquer funcionalidade de exploit.
-- Coloque este script como LocalScript dentro de StarterGui (ou dentro de um ScreenGui).

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local function new(class, props)
    local obj = Instance.new(class)
    if props then
        for k, v in pairs(props) do obj[k] = v end
    end
    return obj
end

local screenGui = new("ScreenGui", {
    Name = "EvadeHubMock",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = player:WaitForChild("PlayerGui")
})

local mainFrame = new("Frame", {
    Name = "MainFrame",
    Parent = screenGui,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 820, 0, 240),
    BackgroundColor3 = Color3.fromRGB(18, 24, 31),
    BorderSizePixel = 0
})

new("UICorner", {Parent = mainFrame, CornerRadius = UDim.new(0, 14)})
new("UIStroke", {Parent = mainFrame, Color = Color3.fromRGB(30, 37, 46), Thickness = 1})

local leftPanel = new("Frame", {
    Parent = mainFrame,
    Size = UDim2.new(0, 220, 1, 0),
    BackgroundColor3 = Color3.fromRGB(10, 14, 18),
    BorderSizePixel = 0
})
new("UICorner", {Parent = leftPanel, CornerRadius = UDim.new(0, 14)})

local logoText = new("TextLabel", {
    Parent = leftPanel,
    Text = "Evade",
    Font = Enum.Font.GothamBold,
    TextSize = 28,
    TextColor3 = Color3.fromRGB(220, 225, 230),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 16, 0, 14),
    Size = UDim2.new(1, -32, 0, 34)
})

local rightPanel = new("Frame", {
    Parent = mainFrame,
    Size = UDim2.new(1, -240, 1, -32),
    Position = UDim2.new(0, 232, 0, 16),
    BackgroundColor3 = Color3.fromRGB(16, 20, 24),
    BorderSizePixel = 0
})
new("UICorner", {Parent = rightPanel, CornerRadius = UDim.new(0, 12)})

local headerLabel = new("TextLabel", {
    Parent = rightPanel,
    Text = "Movement",
    Font = Enum.Font.GothamBold,
    TextSize = 22,
    TextColor3 = Color3.fromRGB(230, 235, 238),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 16, 0, 16),
    Size = UDim2.new(1, -32, 0, 30),
    TextXAlignment = Enum.TextXAlignment.Left
})

print("[EvadeHubMock] UI loaded.")
