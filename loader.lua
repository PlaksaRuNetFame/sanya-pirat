--[[
    ═══════════════════════════════════════════
              S A N Y A   P I R A T
            The Strongest Battlegrounds
    ═══════════════════════════════════════════
    Telegram: https://t.me/sanyapiratit
]]

local CONFIG = {
    Secret  = "2009",
    Version = "1.0.0",
    Sources = {
        "https://raw.githubusercontent.com/PlaksaRuNetFame/sanya-pirat/main/sanya_pirat_main.lua",
        "https://cdn.jsdelivr.net/gh/PlaksaRuNetFame/sanya-pirat@main/sanya_pirat_main.lua",
    },
    Telegram = "https://t.me/sanyapiratit",
}

local function notify(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5,
        })
    end)
end

local function fail(reason)
    warn("[SANYA PIRAT] " .. reason)
    notify("SANYA PIRAT", tostring(reason) .. "\n" .. CONFIG.Telegram, 10)
end

if getgenv().SANYA_PIRAT_LOADED then
    notify("SANYA PIRAT", "Скрипт уже запущен")
    return
end
getgenv().SANYA_PIRAT_LOADED = true

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not game:GetService("Players").LocalPlayer then
    game:GetService("Players"):GetPropertyChangedSignal("LocalPlayer"):Wait()
end

notify("SANYA PIRAT", "Загрузка v" .. CONFIG.Version .. "...")

local source

for i, base in ipairs(CONFIG.Sources) do
    local url = base .. "?v=" .. tostring(os.time())
    local ok, body = pcall(function()
        return game:HttpGet(url, true)
    end)

    if ok and type(body) == "string" and #body > 10000
        and body:find("ProtectionConfig", 1, true) then
        source = body
        break
    end

    warn("[SANYA PIRAT] источник " .. i .. " не ответил, пробую следующий")
    task.wait(1)
end

if not source then
    getgenv().SANYA_PIRAT_LOADED = nil
    fail("Не удалось скачать скрипт. Проверь интернет или обнови экзекутор.")
    return
end

local chunk, err = loadstring(source, "=SANYA_PIRAT_MAIN")
if not chunk then
    getgenv().SANYA_PIRAT_LOADED = nil
    fail("Ошибка компиляции: " .. tostring(err))
    return
end

_G[CONFIG.Secret] = true

local ok, runErr = pcall(chunk)

if not ok then
    getgenv().SANYA_PIRAT_LOADED = nil
    fail("Ошибка выполнения: " .. tostring(runErr))
    return
end

notify("SANYA PIRAT", "Загружено v" .. CONFIG.Version .. " | " .. CONFIG.Telegram, 6)
