local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NPCMenu"

local function createToggle(name, posY, callback)
    local btn = Instance.new("TextButton", gui)
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.Text = name..": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = name .. ": " .. (active and "ON" or "OFF")
        callback(active)
    end)
end

-- Khai báo trạng thái từng chức năng
espEnabled = false
godModeEnabled = false
autoTaskEnabled = false
noclipEnabled = false

-- Tạo các nút
createToggle("ESP", 10, function(state) espEnabled = state end)
createToggle("God Mode", 60, function(state) godModeEnabled = state end)
createToggle("Auto Task", 110, function(state) autoTaskEnabled = state end)
createToggle("Noclip", 160, function(state) noclipEnabled = state end)

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

game:GetService("RunService").RenderStepped:Connect(function()
    if not espEnabled then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            local role = plr:GetAttribute("Role") or ""
            local color = role == "Sheriff" and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 0, 0)

            if not plr.Character:FindFirstChild("Highlight") then
                local hl = Instance.new("Highlight")
                hl.Name = "Highlight"
                hl.FillTransparency = 0.5
                hl.OutlineTransparency = 1
                hl.FillColor = color
                hl.Parent = plr.Character
            else
                plr.Character.Highlight.FillColor = color
            end
        end
    end
end)

local RunService = game:GetService("RunService")
RunService.Heartbeat:Connect(function()
    if not godModeEnabled then return end
    local lp = game.Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        local role = lp:GetAttribute("Role") or ""
        local hum = lp.Character.Humanoid
        if (role == "Criminal" or role == "Innocent") then
            hum.Health = math.min(hum.Health + 3, hum.MaxHealth)
        end
    end
end)

local taskRemote = game:GetService("ReplicatedStorage"):WaitForChild("DoTask")

task.spawn(function()
    while true do
        if autoTaskEnabled then
            taskRemote:FireServer("DoAllTasks")
        end
        task.wait(5)
    end
end)
game:GetService("RunService").Stepped:Connect(function()
    if not noclipEnabled then return end
    local lp = game.Players.LocalPlayer
    if lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end
end)
