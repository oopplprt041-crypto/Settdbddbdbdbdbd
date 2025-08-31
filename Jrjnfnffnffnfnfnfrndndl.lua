-- LocalScript (StarterPlayerScripts)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ตัวแปรเปิด/ปิด ESP
local espEnabled = true

-- ฟังก์ชันสร้าง ESP
local function createESP(character, player)
    local head = character:WaitForChild("Head", 5)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not head or not humanoid then return end

    -- ลบเก่าออกก่อน กันซ้อน
    if character:FindFirstChild("ESP_Box") then
        character.ESP_Box:Destroy()
    end
    if head:FindFirstChild("ESP_Name") then
        head.ESP_Name:Destroy()
    end

    -- BillboardGui (ชื่อ + HP + ระยะ)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Name"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 22) -- ความสูงตายตัว
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local textLabel = Instance.new("TextLabel")
    textLabel.AutomaticSize = Enum.AutomaticSize.X -- ✅ ยืดตามความยาวข้อความ
    textLabel.Size = UDim2.new(0, 0, 1, 0)
    textLabel.BackgroundTransparency = 0.3
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.BorderSizePixel = 2
    textLabel.BorderColor3 = Color3.fromRGB(255, 0, 255) -- ขอบชมพู
    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    textLabel.TextStrokeTransparency = 0.2
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextScaled = false
    textLabel.TextSize = 14 -- ฟอนต์เล็กลง
    textLabel.Parent = billboard

    -- Highlight (กล่องรอบตัว)
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Box"
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    highlight.Parent = character

    -- อัปเดตเรียลไทม์
    RunService.RenderStepped:Connect(function()
        if not character.Parent then return end
        if not espEnabled then
            billboard.Enabled = false
            highlight.Enabled = false
        else
            billboard.Enabled = true
            highlight.Enabled = true

            local distance = 0
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then
                distance = (LocalPlayer.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
            end

            local hp = math.floor(humanoid.Health)
            local maxhp = math.floor(humanoid.MaxHealth)

            -- ตั้งข้อความ
            if player.DisplayName == player.Name then
                textLabel.Text = string.format("%s | %d/%d HP | %d studs", player.DisplayName, hp, maxhp, math.floor(distance))
            else
                textLabel.Text = string.format("%s (@%s) | %d/%d HP | %d studs", player.DisplayName, player.Name, hp, maxhp, math.floor(distance))
            end
        end
    end)
end

-- ฟังก์ชันผูกกับ Player
local function setupPlayer(player)
    local function onCharacterAdded(char)
        createESP(char, player)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
    if player.Character then
        onCharacterAdded(player.Character)
    end
end

-- ผู้เล่นที่มีอยู่แล้ว
for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        setupPlayer(p)
    end
end

-- เมื่อมีผู้เล่นใหม่เข้ามา
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        setupPlayer(player)
    end
end)

-- GUI ปุ่มเปิด/ปิด
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 80, 0, 30) -- ปุ่มเล็กลง
ToggleButton.Position = UDim2.new(0, 20, 0, 200)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "ปิด วานลิต"
ToggleButton.Parent = ScreenGui
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextScaled = true
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.BorderSizePixel = 2
ToggleButton.BorderColor3 = Color3.fromRGB(255, 0, 255)

ToggleButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        ToggleButton.Text = "ปิด วานลิต"
    else
        ToggleButton.Text = "เปิด วานลิต"
    end
end)
