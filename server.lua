ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("stress:add") -- stres arttır // add stress
AddEventHandler("stress:add", function (value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerid = xPlayer.name

	if xPlayer.job.name == "police" then -- Polis ise daha yarı yarıya stress ekleniyor, bu şekilde farklı meslekler ekleyebilirsiniz // if player is a police officer, he/she gaing half the stress, you can add different jobs using same method
		print("P_addedstress:"..playerid..":"..tostring(value/2/100)) -- printler spame dönüşür çünkü devamlı stres ya azılıyor ya da artıyor // prints will get spammy if you have more than 5 player in server :D
		TriggerClientEvent("esx_status:add", _source, "stress", value / 2)
	else
		print("addedstress:"..playerid..":"..value/100)
		TriggerClientEvent("esx_status:add", _source, "stress", value)
	end
end)

RegisterServerEvent("stress:remove") -- stres azalttır // remove stress
AddEventHandler("stress:remove", function (value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerid = xPlayer.name

    print("removedstress:"..playerid..":"..tostring(value/100))
    TriggerClientEvent("esx_status:remove", _source, "stress", value)
end)