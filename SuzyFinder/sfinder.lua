--[[
	SuzyFinder UI (LocalScript)
	Apenas interface: sem teleport, sem automações extras, sem HTTP.
]]

local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Remove UI antiga, se existir
local oldGui = playerGui:FindFirstChild("SuzyFinderUI")
if oldGui then
	oldGui:Destroy()
end

-- Cria ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SuzyFinderUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.fromOffset(300, 160)
mainFrame.Position = UDim2.fromScale(0.5, 0.5)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = mainFrame

-- Título no canto superior esquerdo
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.BackgroundTransparency = 1
titleLabel.BorderSizePixel = 0
titleLabel.Size = UDim2.new(1, -20, 0, 28)
titleLabel.Position = UDim2.fromOffset(10, 8)
titleLabel.Text = "SuzyFinder"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.Parent = mainFrame

-- Label da fruta
local fruitLabel = Instance.new("TextLabel")
fruitLabel.Name = "FruitLabel"
fruitLabel.BackgroundTransparency = 1
fruitLabel.BorderSizePixel = 0
fruitLabel.Size = UDim2.new(1, -20, 0, 28)
fruitLabel.Position = UDim2.fromOffset(10, 60)
fruitLabel.Text = "Fruit: Leopard"
fruitLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fruitLabel.Font = Enum.Font.Gotham
fruitLabel.TextSize = 16
fruitLabel.TextXAlignment = Enum.TextXAlignment.Left
fruitLabel.TextYAlignment = Enum.TextYAlignment.Center
fruitLabel.Parent = mainFrame

-- Label do servidor
local serverIdLabel = Instance.new("TextLabel")
serverIdLabel.Name = "ServerIdLabel"
serverIdLabel.BackgroundTransparency = 1
serverIdLabel.BorderSizePixel = 0
serverIdLabel.Size = UDim2.new(1, -20, 0, 28)
serverIdLabel.Position = UDim2.fromOffset(10, 94)
serverIdLabel.Text = "Server ID: abc123"
serverIdLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
serverIdLabel.Font = Enum.Font.Gotham
serverIdLabel.TextSize = 16
serverIdLabel.TextXAlignment = Enum.TextXAlignment.Left
serverIdLabel.TextYAlignment = Enum.TextYAlignment.Center
serverIdLabel.Parent = mainFrame

-- Funções para atualização fácil dos textos
local function setFruit(name)
	fruitLabel.Text = string.format("Fruit: %s", tostring(name or "Unknown"))
end

local function setServerId(id)
	serverIdLabel.Text = string.format("Server ID: %s", tostring(id or "N/A"))
end

-- Exemplo de atualização inicial (pode alterar conforme necessário)
setFruit("Leopard")
setServerId("abc123")

-- Exporta funções no ambiente global para facilitar uso em executor
getgenv().setFruit = setFruit
getgenv().setServerId = setServerId