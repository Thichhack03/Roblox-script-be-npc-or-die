local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Khởi tạo menu chính
local menu = Instance.new("ScreenGui", game.CoreGui)
menu.Name = "HackMenu"

local toggle = Instance.new("TextButton", menu)
toggle.Size = UDim2.new(0, 100, 0, 100) -- 10mm ~ 100px
toggle.Position = UDim2.new(0, 100, 0, 100)
toggle.Text = "≡"
toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggle.Draggable = true
toggle.Active = true

local frame = Instance.new("Frame", toggle)
frame.Position = UDim2.new(1, 5, 0, 0)
frame.Size = UDim2.new(0, 140, 0, 170)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Visible = false

toggle.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

function createButton(name, y, func)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.MouseButton1Click:Connect(func)
end
-- ESP (phân biệt phe)
createButton("ESP", 5, function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and not plr.Character:FindFirstChild("ESP") then
            local isPlayer = plr.UserId > 0
            if not isPlayer then continue end

            local bb = Instance.new("BillboardGui", plr.Character)
            bb.Name = "ESP"
            bb.Size = UDim2.new(5, 0, 5, 0)
            bb.AlwaysOnTop = true

            local frame = Instance.new("Frame", bb)
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundTransparency = 0.5

            if plr.Team == player.Team then
                frame.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            else
                frame.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            end
        end
    end
end)
-- God mode
createButton("God Mode", 45, function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        spawn(function()
            while true do
                if char:FindFirstChild("Humanoid") then
                    char.Humanoid.Health = char.Humanoid.MaxHealth
                end
                wait(0.2)
            end
        end)
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

-- Auto task
createButton("Auto Task", 125, function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            fireclickdetector(obj)
        end
    end
end)
