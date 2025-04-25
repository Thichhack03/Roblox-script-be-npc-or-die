local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Khởi tạo menu chính
local toggle = Instance.new("TextButton", menu)
toggle.Size = UDim2.new(0, 30, 0, 30) -- 3mm ~ 30px
toggle.Position = UDim2.new(0, 100, 0, 100)
toggle.Text = "≡"
toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggle.Draggable = true
toggle.Active = true
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
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.Enabled then
            fireproximityprompt(v)
        end
    end
end)
