-- Gui หลัก
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleButton = Instance.new("TextButton")

-- ตั้งค่า ScreenGui
ScreenGui.Parent = game:GetService("CoreGui")

-- MainFrame
MainFrame.Size = UDim2.new(0, 220, 0, 200)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- ไล่เฉดสี RGB
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0,255,0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0,0,255)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255,0,255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,0))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- ทำให้สีไล่เฉดเปลี่ยนวนเรื่อยๆ
task.spawn(function()
    while task.wait(0.05) do
        UIGradient.Rotation = (UIGradient.Rotation + 2) % 360
    end
end)

-- UIListLayout
UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ฟังก์ชันสร้างปุ่ม
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = name
    btn.Parent = MainFrame

    -- เอฟเฟกต์ hover
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ปุ่มต่างๆ
createButton("ESPวานลิต", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/ESPRR/refs/heads/main/ESPRR.lua"))()
end)

createButton("ทะลุวานลิต", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/-/refs/heads/main/Nokip.lua"))()
end)

createButton("วาปไปหาวานลิต", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/TOOUUUU/refs/heads/main/TOOOIIIIII.lua"))()
end)

-- ปุ่มที่ 4 (Nameless Admin)
createButton("🌈 Nameless Admin", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-nameless-admin-15646"))()
end)

-- ปุ่มพับ/กาง GUI (อยู่นอก MainFrame)
ToggleButton.Size = UDim2.new(0, 80, 0, 35)
ToggleButton.Position = UDim2.new(0.35, 0, 0.25, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
ToggleButton.Text = "เปิดวานลิต"
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.Parent = ScreenGui
ToggleButton.Active = true
ToggleButton.Draggable = true

local isCollapsed = false
ToggleButton.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    MainFrame.Visible = not isCollapsed
    ToggleButton.Text = isCollapsed and "เปิดวานลิต" or "ปิดวานลิต"
end)
