-- Menu chính
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", ScreenGui)
frame.Size = UDim2.new(0, 30, 0, 30) -- 3mm ~ 30x30px
frame.Position = UDim2.new(0, 100, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Active = true
frame.Draggable = true

-- Biểu tượng cờ
local flag = Instance.new("TextLabel", frame)
flag.Size = UDim2.new(1, 0, 1, 0)
flag.Text = "🇻🇳"
flag.TextColor3 = Color3.new(1, 1, 1)
flag.BackgroundTransparency = 1

-- Khung menu mở rộng
local menu = Instance.new("Frame", frame)
menu.Size = UDim2.new(0, 120, 0, 100)
menu.Position = UDim2.new(1, 5, 0, 0)
menu.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
menu.Visible = false

-- Nút mở menu
frame.MouseButton1Click:Connect(function()
	menu.Visible = not menu.Visible
end)

-- Nút Noclip
local noclipButton = Instance.new("TextButton", menu)
noclipButton.Size = UDim2.new(0, 100, 0, 25)
noclipButton.Position = UDim2.new(0, 10, 0, 10)
noclipButton.Text = "Noclip: OFF"

local noclipEnabled = false
noclipButton.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	noclipButton.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
end)

-- Vòng lặp Noclip
game:GetService("RunService").Stepped:Connect(function()
	if noclipEnabled then
		local char = game.Players.LocalPlayer.Character
		if char then
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end
end)
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
local player = game.Players.LocalPlayer

while wait(1) do
    for _, v in pairs(game:GetService("Workspace").Tasks:GetChildren()) do
        if v:FindFirstChild("TaskProximityPrompt") then
            fireproximityprompt(v.TaskProximityPrompt)
        end
    end
end
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

while true do
    wait(0.1)
    if character:FindFirstChild("Stamina") then
        character.Stamina.Value = character.Stamina.MaxValue
    end
end
