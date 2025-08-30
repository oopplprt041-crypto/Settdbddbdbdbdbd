-- LocalScript (StarterGui)

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.IgnoreGuiInset = true

-- กรอบหลัก
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 150)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0

-- มุมโค้ง
local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 20)

-- เงา
local shadow = Instance.new("ImageLabel", mainFrame)
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.new(0, -20, 0, -20)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = -1

-- ไล่สีรุ้ง
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Rotation = 45
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),     -- แดง
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),-- ส้ม
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),-- เหลือง
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),   -- เขียว
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),  -- น้ำเงิน
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)), -- ม่วงคราม
    ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 211))    -- ม่วง
})

-- ข้อความตรงกลาง
local label = Instance.new("TextLabel", mainFrame)
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.Text = "สคริปนี้ ปิดอัพเดท"
label.Font = Enum.Font.FredokaOne
label.TextScaled = true
label.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ไล่เฉดในตัวหนังสือ
local textGradient = Instance.new("UIGradient", label)
textGradient.Color = gradient.Color
textGradient.Rotation = 90

-- ทำให้กราเดี้ยนขยับ
task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            gradient.Offset = Vector2.new(i, 0)
            textGradient.Offset = Vector2.new(i, 0)
            task.wait(0.05)
        end
    end
end)
