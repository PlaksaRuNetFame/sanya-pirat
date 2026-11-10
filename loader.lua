local URL = "https://raw.githubusercontent.com/PlaksaRuNetFame/sanya-pirat/main/alexander_pirat_main.lua"

local function say(text, color)
    print("[DIAG] " .. text)
    pcall(function()
        local sg = Instance.new("ScreenGui")
        sg.Name = "ALEXANDER_DIAG"
        sg.ResetOnSpawn = false
        sg.DisplayOrder = 999999
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0, 460, 0, 300)
        f.Position = UDim2.new(0.5, -230, 0, 90)
        f.BackgroundColor3 = Color3.fromRGB(8, 13, 10)
        f.BorderSizePixel = 0
        f.Parent = sg
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 8)
        c.Parent = f
        local l = Instance.new("TextLabel")
        l.Size = UDim2.fromScale(1, 1)
        l.Position = UDim2.fromOffset(0, 0)
        l.BackgroundTransparency = 1
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.TextYAlignment = Enum.TextYAlignment.Top
        l.TextWrapped = true
        l.Font = Enum.Font.Code
        l.TextSize = 13
        l.TextColor3 = color or Color3.fromRGB(228, 246, 234)
        l.Text = "DIAG\n\n" .. text
        l.Parent = f
        task.delay(9, function()
            pcall(function() sg:Destroy() end)
        end)
        local parent = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        sg.Parent = parent
    end)
end

say("executor: " .. tostring(identifyexecutor and identifyexecutor() or "?"))
say("PlaceId: " .. tostring(game.PlaceId))
say("HttpGet: " .. type(game.HttpGet))

if not game:IsLoaded() then
    say("жду загрузку игры...", Color3.fromRGB(240, 176, 108))
    game.Loaded:Wait()
end

if not game:GetService("Players").LocalPlayer then
    say("нет LocalPlayer — ты в меню, зайди в игру", Color3.fromRGB(240, 120, 120))
    return
end

local ok, body = pcall(function()
    return game:HttpGet(URL .. "?v=" .. os.time(), true)
end)

if not ok then
    say("HTTP УПАЛ:\n" .. tostring(body), Color3.fromRGB(240, 120, 120))
    return
end

say("получено байт: " .. tostring(#body))
say("начало ответа:\n" .. tostring(body):sub(1, 200))

if #body < 10000 then
    say("ОТВЕТ СЛИШКОМ КОРОТКИЙ — это 404 или страница ошибки", Color3.fromRGB(240, 120, 120))
    return
end

say("файл скачан, компилирую...", Color3.fromRGB(45, 235, 132))
local chunk, err = loadstring(body, "=ALEX_MAIN")
if not chunk then
    say("СИНТАКСИС БИТ:\n" .. tostring(err), Color3.fromRGB(240, 120, 120))
    return
end

local runOk, runErr = pcall(chunk)
if not runOk then
    say("ОШИБКА ВЫПОЛНЕНИЯ:\n" .. tostring(runErr), Color3.fromRGB(240, 120, 120))
    return
end

say("ЗАПУЩЕНО", Color3.fromRGB(45, 235, 132)
