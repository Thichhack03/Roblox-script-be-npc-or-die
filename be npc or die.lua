local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- Hàm tạo Highlight
function createHighlight(target, color)
    if target:FindFirstChild("Highlight") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    highlight.FillColor = color
    highlight.OutlineColor = Color3.new(0, 0, 0)
    highlight.OutlineTransparency = 0
    highlight.FillTransparency = 0.3
    highlight.Adornee = target
    highlight.Parent = target
end

-- ESP cho "Criminal" (đỏ)
spawn(function()
    while true do
        local zombiesFolder = workspace:FindFirstChild("Zombies")
        if zombiesFolder then
            for _, zombie in pairs(zombiesFolder:GetChildren()) do
                if zombie:IsA("Model") and zombie:FindFirstChild("HumanoidRootPart") then
                    -- Giả định: Những quái vật là "Criminal"
                    createHighlight(zombie, Color3.new(1, 0, 0)) -- Màu đỏ cho "Criminal"
                end
            end
        end
        wait(1)
    end
end)
-- ESP cho "Sheriff" (xanh lam)
spawn(function()
    while true do
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= localPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                -- Giả định: Những người chơi có "Sheriff" trong nhóm sẽ là "Sheriff"
                if plr.Team and plr.Team.Name == "Sheriff" then
                    createHighlight(plr.Character, Color3.new(0, 0.5, 1)) -- Màu xanh lam cho "Sheriff"
                end
            end
        end
        wait(1)
    end
end)