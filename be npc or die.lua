local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

function applyESP(player)
    if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local existing = player.Character:FindFirstChild("ESPBox")
        if not existing then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "ESPBox"
            box.Adornee = player.Character.HumanoidRootPart
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Size = Vector3.new(4, 6, 2)
            box.Transparency = 0.5
            box.Color3 = (player.Team == lp.Team) and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 0, 0)
            box.Parent = player.Character
        end
    end
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            applyESP(player)
        end
    end
end)

-- Noclip
createButton("Noclip", 85, function()
    local noclip = true
    spawn(function()
        while noclip do
            local char = player.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
            wait()
        end
    end)
end)
local autoTask = false

local ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local dragFrame = Instance.new("Frame", ScreenGui)
dragFrame.Size = UDim2.new(0, 30, 0, 30) -- khoảng 3mm
dragFrame.Position = UDim2.new(0, 100, 0, 100)
dragFrame.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
dragFrame.Active = true
dragFrame.Draggable = true

local button = Instance.new("TextButton", dragFrame)
button.Size = UDim2.new(1, 0, 1, 0)
button.BackgroundTransparency = 1
button.Text = "AT"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextScaled = true

button.MouseButton1Click:Connect(function()
    autoTask = not autoTask
    dragFrame.BackgroundColor3 = autoTask and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 100, 100)
end)

-- Auto task loop
task.spawn(function()
    while true do
        if autoTask then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") and v.Enabled then
                    pcall(function()
                        fireproximityprompt(v, 1)
                    end)
                end
            end
        end
        task.wait(2)
    end
end)

-- Vô hiệu hóa mất stamina khi chạy
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Lặp lại để đảm bảo mỗi lần nhân vật mới vào
player.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:WaitForChild("Humanoid")
    local stamina = char:FindFirstChild("Stamina")
    if stamina then
        stamina:GetPropertyChangedSignal("Value"):Connect(function()
            stamina.Value = 100
        end)
        stamina.Value = 100
    end
end)

-- Gán cho nhân vật hiện tại (lúc mới chạy)
task.spawn(function()
    local char = player.Character or player.CharacterAdded:Wait()
    task.wait(1)
    local stamina = char:FindFirstChild("Stamina")
    if stamina then
        stamina:GetPropertyChangedSignal("Value"):Connect(function()
            stamina.Value = 100
        end)
        stamina.Value = 100
    end
end)
