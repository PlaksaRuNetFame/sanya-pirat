--[[
    ═══════════════════════════════════════════
              S A N Y A   P I R A T E
            The Strongest Battlegrounds
    ═══════════════════════════════════════════
    Telegram: https://t.me/sanyapiratit
]]

local function notify(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5,
        })
    end)
end

if getgenv().SANYA_PIRAT_LOADED then
    notify("SANYA PIRATE", "Скрипт уже запущен")
    return
end
getgenv().SANYA_PIRAT_LOADED = true

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not game:GetService("Players").LocalPlayer then
    game:GetService("Players"):GetPropertyChangedSignal("LocalPlayer"):Wait()
end

notify("SANYA PIRATE", "Загрузка скрипта...")

local url = "https://raw.githubusercontent.com/PlaksaRuNetFame/sanya-pirat/refs/heads/main/sanya_pirat_main.lua" .. tostring(os.time())
local ok, body = pcall(function()
    return game:HttpGet(url, true)
end)

if not ok or type(body) ~= "string" or #body < 5000 then
    getgenv().SANYA_PIRAT_LOADED = nil
    warn("[SANYA PIRATE] Не удалось загрузить основной скрипт.")
    notify("SANYA PIRATE", "Ошибка загрузки! Проверь ссылку на GitHub.", 10)
    return
end

local chunk, err = loadstring(body, "=SANYA_PIRATE_MAIN")
if not chunk then
    getgenv().SANYA_PIRAT_LOADED = nil
    warn("[SANYA PIRATE] Ошибка компиляции: " .. tostring(err))
    return
end

local runOk, runErr = pcall(chunk)
if not runOk then
    getgenv().SANYA_PIRAT_LOADED = nil
    warn("[SANYA PIRATE] Ошибка выполнения: " .. tostring(runErr))
    return
end

notify("SANYA PIRATE", "Успешно загружено! t.me/sanypiratit", 6)
