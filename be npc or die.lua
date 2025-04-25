-- Script đơn giản cho Be NPC or Die | Thichhack03
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local taskFolder = workspace:WaitForChild("Tasks")

-- Cấu hình
local noclip = false
local infStamina = false
local autoTask = false

-- GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 200)
Frame.Position = UDim2.new(0, 10, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.2

-- Nút Noclip
local noclipBtn = Instance.new("TextButton", Frame)
noclipBtn.Size = UDim2.new(1, -20, 0, 40)
noclipBtn.Position = UDim2.new(0, 10, 0, 10)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)

-- Nút Infinite Stamina
local staminaBtn = Instance.new("TextButton", Frame)
staminaBtn.Size = UDim2.new(1, -20, 0, 40)
staminaBtn.Position = UDim2.new(0, 10, 0, 60)
staminaBtn.Text = "Infinite Stamina: OFF"
staminaBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)

-- Nút Auto Task
local taskBtn = Instance.new("TextButton", Frame)
taskBtn.Size = UDim2.new(1, -20, 0, 40)
taskBtn.Position = UDim2.new(0, 10, 0, 110)
taskBtn.Text = "Auto Task: OFF"
taskBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
-- Nút ESP
local espBtn = Instance.new("TextButton", Frame)
espBtn.Size = UDim2.new(1, -20, 0, 40)
espBtn.Position = UDim2.new(0, 10, 0, 160)
espBtn.Text = "ESP: OFF"
espBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)

-- Noclip
local function toggleNoclip()
    noclip = not noclip
    noclipBtn.Text = noclip and "Noclip: ON" or "Noclip: OFF"
    noclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 200, 50)

    -- Bật/Tắt noclip
    if noclip then
        character:WaitForChild("HumanoidRootPart").Anchored = true
        humanoid.PlatformStand = true
    else
        character:WaitForChild("HumanoidRootPart").Anchored = false
        humanoid.PlatformStand = false
    end
end

-- Infinite Stamina
local function toggleInfiniteStamina()
    infStamina = not infStamina
    staminaBtn.Text = infStamina and "Infinite Stamina: ON" or "Infinite Stamina: OFF"
    staminaBtn.BackgroundColor3 = infStamina and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 150, 255)
-- Giữ năng lượng đầy
    if infStamina then
        while infStamina do
            if player.Character and player.Character:FindFirstChild("Stamina") then
                player.Character.Stamina.Value = 100
            end
            wait(0.2)
        end
    end
end

-- Auto Complete Task
local function completeTasks()
    while autoTask do
        for _, task in pairs(taskFolder:GetChildren()) do
            if task:IsA("Part") and task:FindFirstChild("ProximityPrompt") and task.ProximityPrompt.Enabled then
                -- Di chuyển đến task
                player.Character:MoveTo(task.Position + Vector3.new(0, 0, -2))
                wait(0.2)
                fireproximityprompt(task.ProximityPrompt)
                wait(0.5)
            end
        end
        wait(0.2)
    end
end

-- ESP
local function toggleESP()
    espBtn.Text = espBtn.Text == "ESP: OFF" and "ESP: ON" or "ESP: OFF"
    espBtn.BackgroundColor3 = espBtn.Text == "ESP: ON" and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(255, 50, 50)
-- ESP: Hiển thị NPCs hoặc các mục tiêu khác trên màn hình
    if espBtn.Text == "ESP: ON" then
        -- Code hiển thị ESP cho NPC hoặc các mục tiêu khác (ví dụ: hiển thị khung quanh NPC)
        for _, npc in pairs(workspace:GetChildren()) do
            if npc:IsA("Model") and npc:FindFirstChild("Humanoid") then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = npc
                highlight.Parent = npc
                highlight.FillColor = Color3.fromRGB(255, 255, 0)
                highlight.FillTransparency = 0.5
            end
        end
    else
        -- Tắt ESP
        for _, npc in pairs(workspace:GetChildren()) do
            if npc:IsA("Model") and npc:FindFirstChild("Humanoid") then
                for _, child in pairs(npc:GetChildren()) do
                    if child:IsA("Highlight") then
                        child:Destroy()
                    end
                end
            end
        end
    end
end
-- Kết nối các nút với chức năng
noclipBtn.MouseButton1Click:Connect(toggleNoclip)
staminaBtn.MouseButton1Click:Connect(toggleInfiniteStamina)
taskBtn.MouseButton1Click:Connect(function()
    autoTask = not autoTask
    taskBtn.Text = autoTask and "Auto Task: ON" or "Auto Task: OFF"
    taskBtn.BackgroundColor3 = autoTask and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 200, 50)
    if autoTask then
        task.spawn(completeTasks)
    end
end)
espBtn.MouseButton1Click:Connect(toggleESP)
