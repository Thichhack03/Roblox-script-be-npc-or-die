local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "HackerMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0

local function createButton(name, posY, callback)
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Position = UDim2.new(0, 10, 0, posY)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.MouseButton1Click:Connect(callback)
end
createButton("Bật ESP", 50, function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and not plr.Character:FindFirstChild("ESP") then
            local isSheriff = plr:GetAttribute("Role") == "Sheriff"
            local isPlayer = plr.UserId > 0

            local bb = Instance.new("BillboardGui", plr.Character)
            bb.Name = "ESP"
            bb.Size = UDim2.new(5, 0, 5, 0)
            bb.AlwaysOnTop = true

            local frame = Instance.new("Frame", bb)
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundTransparency = 0.5

            if isSheriff then
                frame.BackgroundColor3 = Color3.fromRGB(0, 150, 255) -- Sheriff
            elseif isPlayer then
                frame.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- Người thật
            else
                bb:Destroy() -- NPC thì xoá ESP
            end
        end
    end
end)
