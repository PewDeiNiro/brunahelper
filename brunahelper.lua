script_name("bruna_helper")
script_author("Zhenya_Bruna")
script_description("")

require "lib.moonloader"
local scr_tag = "{FF6600}[Bruna helper]"
function createFolder(path)
	os.execute("mkdir " .. path)
end
--??????? ??????
if not doesFileExist("moonloader\\lib\\asyncoperations.lua") or not doesFileExist("moonloader\\lib\\handlers.lua") or not doesFileExist("moonloader\\lib\\util.lua") or not doesFileExist("moonloader\\lib\\luairc.lua") or not doesFileExist("moonloader\\lib\\socket.lua") or not doesFileExist("moonloader\\lib\\samp\\events\\core.lua") then
		if not isSampLoaded() or not isSampfuncsLoaded() then return end
		while not isSampAvailable() do wait(100) end
		sampAddChatMessage(scr_tag .. "{FFFFFF} Начинаю загрузку зависимостей...", 0xFFFFFF)
		if not doesFileExist("moonloader\\lib\\asyncoperations.lua") then
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/asyncoperations.lua", "moonloader\\lib\\asyncoperations.lua")
		end
		if not doesFileExist("moonloader\\lib\\handlers.lua") then
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/handlers.lua", "moonloader\\lib\\handlers.lua")
		end
		if not doesFileExist("moonloader\\lib\\util.lua") then
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/util.lua", "moonloader\\lib\\util.lua")
		end
		if not doesFileExist("moonloader\\lib\\luairc.lua") then
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/luairc.lua", "moonloader\\lib\\luairc.lua")
		end
		if not doesFileExist("moonloader\\lib\\socket.lua") then
			createFolder("moonloader\\lib\\mime")
			createFolder("moonloader\\lib\\socket")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/ltn12.lua", "moonloader\\lib\\ltn12.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/mime.lua", "moonloader\\lib\\mime.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/mime/core.dll", "moonloader\\lib\\mime\\core.dll")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/socket/core.dll", "moonloader\\lib\\socket\\core.dll")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/socket/ftp.lua", "moonloader\\lib\\socket\\ftp.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/socket/headers.lua", "moonloader\\lib\\socket\\headers.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/socket/http.lua", "moonloader\\lib\\socket\\http.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/socket/smtp.lua", "moonloader\\lib\\socket\\smtp.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/socket/tp.lua", "moonloader\\lib\\socket\\tp.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/socket/url.lua", "moonloader\\lib\\socket\\url.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/socket.lua", "moonloader\\lib\\socket.lua")
		end
		if not doesFileExist("moonloader\\lib\\samp\\events\\core.lua") then
			createFolder("moonloader\\lib\\samp")
			createFolder("moonloader\\lib\\samp\\events")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/samp/events.lua", "moonloader\\lib\\samp\\events.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/samp/synchronization.lua", "moonloader\\lib\\samp\\synchronization.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/samp/raknet.lua", "moonloader\\lib\\samp\\raknet.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/samp/events/bitstream_io.lua", "moonloader\\lib\\samp\\events\\bitstream_io.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/samp/events/extra_types.lua", "moonloader\\lib\\samp\\events\\extra_types.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/samp/events/handlers.lua", "moonloader\\lib\\samp\\events\\handlers.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/samp/events/utils.lua", "moonloader\\lib\\samp\\events\\utils.lua")
			local res = downloadUrlToFile("https://raw.githubusercontent.com/PewDeiNiro/luasocket/master/samp/events/core.lua", "moonloader\\lib\\samp\\events\\core.lua")
		end
		sampAddChatMessage(scr_tag .. "{FFFFFF} Загрука зависимостей завершена", 0xFFFFFF)
end

local dlstatus = require("moonloader").download_status
local inicfg = require "inicfg"

local script_vers = 1
local script_vers_str = "1.00"
local script_path = thisScript().path
local script_url = "https://github.com/PewDeiNiro/brunahelper/blob/main/brunahelper.luac?raw=true"
local update_path = getWorkingDirectory() .. "/update.ini"
local update_url = "https://raw.githubusercontent.com/PewDeiNiro/brunahelper/main/update.ini"

require "luairc"
local sampev = require "lib.samp.events"
local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
local nickname = sampGetPlayerNickname(id) .. "[" .. id .. "]"
if string.sub(nickname, 1, 4) == "[11]" then
	nickname = string.sub(nickname, 5, string.len(nickname))
end
local vk = require 'vkeys'
local scFamChat = true
update_state = false
local alive = true
local connected = false
if string.sub(sampGetPlayerNickname(id), -5, -1) ~= "Bruna" then
	sampAddChatMessage(scr_tag .. "{FFFFFF} К соажалению, вы не состоите в семье Bruna, скрипт отключен", 0xFFFFFF)
	alive = false
end
local s = irc.new{nick = nickname}
if alive then
	s:connect("irc.esper.net")
	local t_nick = sampGetPlayerNickname(id)
	if string.sub(t_nick, 1, 4) == "[11]" then
		t_nick = string.sub(t_nick, 5, string.len(nickname))
	end

	s:hook("OnChat", function(user, channel, message)
	    sampAddChatMessage("{1E1E1E}[Семья] " .. user.nick .. ":{FFFFFF} " ..  message, 0xFFFFFF)
	end)
	s:join("#bruna")
	if t_nick == "Zhenya_Bruna" then
		s:sendChat("#bruna", "{FF0000}Zhenya_Bruna{FFFFFF} зашел в игру")
	else
		s:sendChat("#bruna", "{00FFFF}" .. t_nick .. "{FFFFFF} зашел в игру")
	end
end
connected = true





function main()
	if not isSampLoaded() or not isSampfuncsLoaded() or not alive then return end
	while not isSampAvailable() do wait(100) end
	
	sampRegisterChatCommand("cfam", function() 
		scFamChat = not scFamChat
		if scFamChat then
			sampAddChatMessage(scr_tag .. " {FFFFFF}Вы выбрали новую семейную рацию!", 0xFFFFFF)
		else
			sampAddChatMessage(scr_tag .. " {FFFFFF}Вы выбрали старую семейную рацию!", 0xFFFFFF)
		end
	end)
	sampAddChatMessage("{FF6600}---------------------------------------------------------------------------", 0xFFFFFF)
	sampAddChatMessage("[{00FF00}${FFFFFF}] Helper {1E1E1E}Bruna Squad {FFFFFF} [{00FF00}${FFFFFF}]", 0xFFFFFF)
	sampAddChatMessage("[{00FF00}${FFFFFF}] Автор скрипта: {FF0000}Zhenya_Bruna{FFFFFF} [{00FF00}${FFFFFF}]", 0xFFFFFF)
	sampAddChatMessage("[{00FF00}${FFFFFF}] Версия: {FFFF00}1.0.1{FFFFFF} [{00FF00}${FFFFFF}]", 0xFFFFFF)
	sampAddChatMessage("{FF6600}---------------------------------------------------------------------------", 0xFFFFFF)

	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				sampAddChatMessage(scr_tag .. " {FFFFFF} Вышло новое обновление! Начинаю загрузку...", 0xFFFFFF)
				update_state = true
			end
			script_vers = tonumber(updateIni.info.vers)
		end
	end)

	while true do
		wait(1000)
		if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage(scr_tag .. " {FFFFFF} Загрузка обновления завершена успешно, скрипт обновил свою работу!", 0xFFFFFF)
					thisScript():reload()
				end
			end)
			break
		end

		if connected then
			s:think()
		end
	end
end

function sendBrunaChat(message)
	if connected and message then
		s:sendChat("#bruna", message)
		sampAddChatMessage("{1E1E1E}[Семья] " .. nickname .. ":{FFFFFF} " ..  message, 0xFFFFFF)
	end
end

function sampev.onSendCommand(command)
	if string.sub(command, 1, 4) == "/fam" and scFamChat then
		sendBrunaChat(string.sub(command, 6, string.len(command)))
		return false
	end
	if string.sub(command, 1, 2) == "/q" then
		local t_nick = sampGetPlayerNickname(id)
		if string.sub(t_nick, 1, 4) == "[11]" then
			t_nick = string.sub(t_nick, 5, string.len(nickname))
		end
		if t_nick == "Zhenya_Bruna" then
			s:sendChat("#bruna", "{FF0000}Zhenya_Bruna{FFFFFF} вышел из игры")
		else
			s:sendChat("#bruna", "{00FFFF}" .. t_nick .. "{FFFFFF} вышел из игры")
		end
	end
end