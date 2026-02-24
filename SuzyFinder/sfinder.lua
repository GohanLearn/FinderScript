--[[
	SuzyFinder UI (LocalScript)
	UI + Status + Leitura HTTP
]]

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- ===== CONFIG =====
local CHECK_INTERVAL = 5
local SERVER_URL = "http://192.168.0.14:5000/server"
-- ==================

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Remove UI antiga
local oldGui = playerGui:FindFirstChild("SuzyFinderUI")
if oldGui then
	oldGui:Destroy()
end

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SuzyFinderUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.fromOffset(320, 190)
mainFrame.Position = UDim2.fromScale(0.5, 0.5)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = mainFrame

-- Título
local titleLabel = Instance.new("TextLabel")
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, -20, 0, 28)
titleLabel.Position = UDim2.fromOffset(10, 8)
titleLabel.Text = "SuzyFinder"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- Status
local statusLabel = Instance.new("TextLabel")
statusLabel.BackgroundTransparency = 1
statusLabel.Size = UDim2.new(1, -20, 0, 24)
statusLabel.Position = UDim2.fromOffset(10, 42)
statusLabel.Text = "Status: Aguardando fruta..."
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

-- Fruta
local fruitLabel = Instance.new("TextLabel")
fruitLabel.BackgroundTransparency = 1
fruitLabel.Size = UDim2.new(1, -20, 0, 26)
fruitLabel.Position = UDim2.fromOffset(10, 76)
fruitLabel.Text = "Fruit: -"
fruitLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fruitLabel.Font = Enum.Font.Gotham
fruitLabel.TextSize = 16
fruitLabel.TextXAlignment = Enum.TextXAlignment.Left
fruitLabel.Parent = mainFrame

-- Server ID
local serverIdLabel = Instance.new("TextLabel")
serverIdLabel.BackgroundTransparency = 1
serverIdLabel.Size = UDim2.new(1, -20, 0, 26)
serverIdLabel.Position = UDim2.fromOffset(10, 108)
serverIdLabel.Text = "Server ID: -"
serverIdLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
serverIdLabel.Font = Enum.Font.Gotham
serverIdLabel.TextSize = 16
serverIdLabel.TextXAlignment = Enum.TextXAlignment.Left
serverIdLabel.Parent = mainFrame

-- ===== Funções de UI =====
local function setStatus(text)
	statusLabel.Text = "Status: " .. text
end

local function setFruit(name)
	fruitLabel.Text = "Fruit: " .. tostring(name or "-")
end

local function setServerId(id)
	serverIdLabel.Text = "Server ID: " .. tostring(id or "-")
end

-- Exporta (opcional)
getgenv().setStatus = setStatus
getgenv().setFruit = setFruit
getgenv().setServerId = setServerId

-- ===== Loop HTTP =====
task.spawn(function()
	while true do
		task.wait(CHECK_INTERVAL)

		local success, response = pcall(function()
			return HttpService:GetAsync(SERVER_URL)
		end)

		if success then
			local data = HttpService:JSONDecode(response)

			if data.server_id and data.server_id ~= "" then
				setStatus("Fruta encontrada")
				setFruit(data.fruit)
				setServerId(data.server_id)
			else
				setStatus("Aguardando fruta...")
			end
		else
			setStatus("Erro ao conectar")
		end
	end
end)