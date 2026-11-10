-- AutoRedeemer.client.lua
-- Roblox Studio LocalScript for YOUR OWN experience.
-- Place in StarterPlayer > StarterPlayerScripts.
-- The server must validate rewards; never trust the client.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local redeemEvent = ReplicatedStorage:WaitForChild("RedeemReward")

local gui = Instance.new("ScreenGui")
gui.Name = "AutoRedeemer"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(310, 220)
frame.Position = UDim2.new(0.5, -155, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 42)
title.Position = UDim2.fromOffset(10, 8)
title.BackgroundTransparency = 1
title.Text = "AUTO REDEEMER"
title.TextColor3 = Color3.fromRGB(240, 190, 80)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local codeBox = Instance.new("TextBox")
codeBox.Size = UDim2.new(1, -30, 0, 42)
codeBox.Position = UDim2.fromOffset(15, 62)
codeBox.PlaceholderText = "Enter reward code"
codeBox.Text = ""
codeBox.ClearTextOnFocus = false
codeBox.BackgroundColor3 = Color3.fromRGB(42, 42, 52)
codeBox.TextColor3 = Color3.new(1, 1, 1)
codeBox.PlaceholderColor3 = Color3.fromRGB(165, 165, 175)
codeBox.Font = Enum.Font.Gotham
codeBox.TextSize = 14
codeBox.Parent = frame
Instance.new("UICorner", codeBox).CornerRadius = UDim.new(0, 8)

local redeem = Instance.new("TextButton")
redeem.Size = UDim2.new(1, -30, 0, 38)
redeem.Position = UDim2.fromOffset(15, 116)
redeem.Text = "Redeem code"
redeem.BackgroundColor3 = Color3.fromRGB(190, 135, 48)
redeem.TextColor3 = Color3.new(1, 1, 1)
redeem.Font = Enum.Font.GothamBold
redeem.TextSize = 14
redeem.Parent = frame
Instance.new("UICorner", redeem).CornerRadius = UDim.new(0, 8)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 42)
status.Position = UDim2.fromOffset(15, 164)
status.BackgroundTransparency = 1
status.Text = "Ready"
status.TextColor3 = Color3.fromRGB(190, 190, 200)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextWrapped = true
status.Parent = frame

redeem.MouseButton1Click:Connect(function()
    local code = codeBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
    if code == "" then
        status.Text = "Enter a code first."
        return
    end
    status.Text = "Checking..."
    redeemEvent:FireServer(code)
end)

-- Server can reply through this RemoteEvent.
local resultEvent = ReplicatedStorage:WaitForChild("RedeemRewardResult")
resultEvent.OnClientEvent:Connect(function(success, message)
    status.Text = tostring(message or (success and "Redeemed!" or "Code not accepted."))
end)
