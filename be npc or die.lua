-- Đảm bảo bạn có quyền để chạy script này trong game.
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera

-- Tạo một function để vẽ ESP
local function createESP(target)
    local espPart = Instance.new("Part")
    espPart.Parent = workspace
    espPart.Size = Vector3.new(5, 5, 5)
    espPart.Shape = Enum.PartType.Ball
    espPart.Anchored = true
    espPart.CanCollide = false
    espPart.Color = Color3.fromRGB(255, 0, 0)
    espPart.Transparency = 0.5
    espPart.Material = Enum.Material.Neon
    
    -- Làm cho ESP luôn theo sát NPC hoặc người chơi
    local function updateESP()
        if target and target:FindFirstChild("HumanoidRootPart") then
            espPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
        else
            espPart:Destroy()
        end
    end
    
    -- Cập nhật ESP theo thời gian
    while target and target.Parent do
        updateESP()
        wait(0.1)
    end
end

-- Tạo ESP cho tất cả NPC trong game
for _, player in pairs(workspace:GetChildren()) do
    if player:IsA("Model") and player:FindFirstChild("HumanoidRootPart") then
        createESP(player)
    end
end

-- Kiểm tra các NPC mới xuất hiện
workspace.ChildAdded:Connect(function(child)
    if child:IsA("Model") and child:FindFirstChild("HumanoidRootPart") then
        createESP(child)
    end
end)
