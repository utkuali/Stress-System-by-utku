ESX = nil
local log = true -- set this to false if you don't want logging

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("stress:add")
AddEventHandler("stress:add", function (value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playername = xPlayer.name

	if xPlayer.job.name == "police" then -- Polis ise daha yarı yarıya stress ekleniyor, bu şekilde farklı meslekler ekleyebilirsiniz // if player is a police officer, he/she gaing half the stress, you can add different jobs using same method
		TriggerClientEvent("esx_status:add", _source, "stress", value / 10)
		if log then
			SaveLog("Stress added : "..value/10, playername)
		end
	else
		TriggerClientEvent("esx_status:add", _source, "stress", value)
		if log then
			SaveLog("Stress added : "..value, playername)
		end
	end
end)

RegisterServerEvent("stress:remove") -- stres azalttır // remove stress
AddEventHandler("stress:remove", function (value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playername = xPlayer.name

	TriggerClientEvent("esx_status:remove", _source, "stress", value)
	if log then
		SaveLog("Stress removed : "..value, playername)
	end
end)

function SaveLog(text, playername)
	local time = os.date("%d/%m/%Y %X")
	local name = playername
	local data = time .. ' : ' .. name .. ' - ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "logs.txt")
	local newContent = content .. '\r\n' .. data

	SaveResourceFile(GetCurrentResourceName(), "logs.txt", newContent, -1)
end
