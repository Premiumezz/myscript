local Kavo = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("User InputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}

function Kavo:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end

local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}

-- Create the main GUI
function Kavo.CreateLib(kavName, themeList)
    themeList = themeList or themes
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainHeader = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local minimizeButton = Instance.new("TextButton")
    local isMinimized = false

    ScreenGui.Parent = game.CoreGui
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.Size = UDim2.new(0, 525, 0, 318)

    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    MainHeader.Size = UDim2.new(1, 0, 0, 30)

    title.Parent = MainHeader
    title.Text = kavName
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(0, 200, 0, 30)

    -- Create minimize button
    minimizeButton.Parent = MainHeader
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -35, 0, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.BackgroundTransparency = 1
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.TextSize = 20

    -- Minimize/Expand logic
    minimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            Main.Size = UDim2.new(0, 525, 0, 318)
            minimizeButton.Text = "-"
        else
            Main.Size = UDim2.new(0, 525, 0, 30)
            minimizeButton.Text = "+"
        end
        isMinimized = not isMinimized
    end)

    Kavo:DraggingEnabled(MainHeader, Main)  -- Enable dragging for the header

    -- Add other elements and functionalities here...

    return Kavo
end

return Kavo
