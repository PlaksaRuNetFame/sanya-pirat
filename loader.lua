--[[ CYBRION PREMIUM PIRATED — loader, no key system ]]
local HUB     = "CYBRION PREMIUM PIRATED"
local CONTACT = "https://t.me/sanyapiratit"
local URL     = "https://raw.githubusercontent.com/PlaksaRuNetFame/sanya-pirat/refs/heads/main/sanya_pirat_main.lua"

local function httpGet(u)
	local req = (syn and syn.request) or (http and http.request) or http_request or request
	local ok, body = pcall(function() return game:HttpGet(u) end)
	if ok and type(body) == "string" and #body > 32 then return body end
	if req then
		local ok2, r = pcall(req, { Url = u, Method = "GET" })
		r = ok2 and r and (r.Body or r.body)
		if type(r) == "string" and #r > 32 then return r end
	end
	return nil
end

local src = httpGet(URL .. "?t=" .. tostring(os.time()))
if not src then
	warn("[" .. HUB .. "] не смог скачать скрипт: " .. URL)
	if setclipboard then setclipboard(CONTACT) end
	return
end

local chunk, cerr = loadstring(src, "@" .. HUB)
if not chunk then
	warn("[" .. HUB .. "] синтаксис: " .. tostring(cerr))
	return
end

print("[" .. HUB .. "] запуск...")
local ok, rerr = pcall(chunk)
if not ok then
	warn("[" .. HUB .. "] ошибка: " .. tostring(rerr))
	if setclipboard then setclipboard(CONTACT) end
end
