local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local menuBtn = Instance.new("TextButton", ScreenGui)

menuBtn.Size = UDim2.new(0, 30, 0, 30) -- ~3mm
menuBtn.Position = UDim2.new(0, 100, 0, 100)
menuBtn.Text = "🇻🇳"
menuBtn.TextScaled = true
menuBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
menuBtn.Draggable = true
menuBtn.Active = true
menuBtn.BorderSizePixel = 0
menuBtn.Name = "VNButton"

-- Noclip --
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tạo Button Noclip
local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0, 200, 0, 50)
noclipButton.Position = UDim2.new(0.5, -100, 0.5, 75)  -- Điều chỉnh vị trí nút theo menu
noclipButton.Text = "Toggle Noclip"
noclipButton.Parent = screenGui

-- Biến xác định trạng thái Noclip
local noclipEnabled = false

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")

    -- Bật/tắt Noclip
    if noclipEnabled then
        humanoid.PlatformStand = true
    else
        humanoid.PlatformStand = false
    end
end

-- Kết nối sự kiện cho nút Noclip
noclipButton.MouseButton1Click:Connect(toggleNoclip)

-- Noclip liên tục với CanCollide = false
local RunService = game:GetService("RunService")
RunService.Stepped:Connect(function()
    if noclipEnabled then
        local char = player.Character or player.CharacterAdded:Wait()
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Velocity = Vector3.new(0, 0, 0) -- Giảm giật
            end
        end
    end
end)

-- GUI Auto Task + Infinite Stamina cho Be NPC or Die | By Thichhack03
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local taskFolder = workspace:WaitForChild("Tasks")

local autoTask = false
local infStamina = false

-- GUI khởi tạo
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0, 10, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.2

local autoBtn = Instance.new("TextButton", Frame)
autoBtn.Size = UDim2.new(1, -20, 0, 40)
autoBtn.Position = UDim2.new(0, 10, 0, 10)
autoBtn.Text = "Bật Auto Task"
autoBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)

local staminaBtn = Instance.new("TextButton", Frame)
staminaBtn.Size = UDim2.new(1, -20, 0, 40)
staminaBtn.Position = UDim2.new(0, 10, 0, 60)
staminaBtn.Text = "Bật Infinite Stamina"
staminaBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)

-- Auto Task
local function doTasks()
	while autoTask do
		for _, task in pairs(taskFolder:GetChildren()) do
			if task:IsA("Part") and task:FindFirstChild("ProximityPrompt") and task.ProximityPrompt.Enabled then
				player.Character:MoveTo(task.Position + Vector3.new(0, 0, -2))
				wait(0.2)
				fireproximityprompt(task.ProximityPrompt)
				wait(0.5)
			end
		end
		wait(0.2)
	end
end

-- Infinite Stamina
local function keepStamina()
	while infStamina do
		if player.Character and player.Character:FindFirstChild("Stamina") then
			player.Character.Stamina.Value = 100
		end
		wait(0.1)
	end
end

-- Nút Auto Task
autoBtn.MouseButton1Click:Connect(function()
	autoTask = not autoTask
	autoBtn.Text = autoTask and "Tắt Auto Task" or "Bật Auto Task"
	autoBtn.BackgroundColor3 = autoTask and Color3.fromRGB(200,50,50) or Color3.fromRGB(50,200,50)
	if autoTask then task.spawn(doTasks) end
end)

-- Nút Infinite Stamina
staminaBtn.MouseButton1Click:Connect(function()
	infStamina = not infStamina
	staminaBtn.Text = infStamina and "Tắt Infinite Stamina" or "Bật Infinite Stamina"
	staminaBtn.BackgroundColor3 = infStamina and Color3.fromRGB(200,100,50) or Color3.fromRGB(50,150,255)
	if infStamina then task.spawn(keepStamina) end
end)

-- ESP --
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

function createESP(character, color)
    local existing = character:FindFirstChild("ESP")
    if existing then
        existing.FillColor = color
        return
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP"
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.2
    highlight.OutlineTransparency = 0
    highlight.Adornee = character
    highlight.Parent = character
end

function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local isSheriff = player.Team and player.Team.Name == "Sheriff"
            local color = isSheriff and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(255, 0, 0)
            createESP(player.Character, color)
        end
    end
end

updateESP()
while true do
    task.wait(3)
    updateESP()
end
