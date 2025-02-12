-- Ссылка на Библиотеку
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Premiumezz/myscript/refs/heads/main/lib/ui_lib.lua"))()

-- Создать окно UI
local Window = Library.CreateLib("Name", "RJTheme3")

-- Изменяем функцию CreateLib для добавления кнопки сворачивания
function Library.CreateLib(name, themeList)
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
    title.Text = name
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(0, 200, 0, 30)

    -- Создаем кнопку сворачивания
    minimizeButton.Parent = MainHeader
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -35, 0, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.BackgroundTransparency = 1
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.TextSize = 20

    -- Логика сворачивания и разворачивания
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

    -- Пример добавления секции
    local Tab = Window:NewTab("TabName")
    local Section = Tab:NewSection("Section Name")

    -- Заголовок
    Section:NewLabel("LabelText")

    -- Кнопка
    Section:NewButton("ButtonText", "ButtonInfo", function()
        print("Clicked")
    end)

    -- Переключатель
    Section:NewToggle("ToggleText", "ToggleInfo", function(state)
        if state then
            print("Toggle On")
        else
            print("Toggle Off")
        end
    end)

    -- Слайдер
    Section:NewSlider("SliderText", "SliderInfo", 500, 0, function(s)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)

    -- Текст Бокс
    Section:NewTextBox("TextboxText", "TextboxInfo", function(txt)
        print(txt)
    end)

    -- Бинд на клавиши
    Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.F, function()
        print("You just clicked the bind")
    end)

    -- Дропдаун
    Section:NewDropdown("DropdownText", "DropdownInf", {"Option 1", "Option 2", "Option 3"}, function(currentOption)
        print(currentOption)
    end)

    return Window
end

-- Инициализация библиотеки
local Window = Library.CreateLib("Name", "RJTheme3")
