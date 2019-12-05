--[[
	Max stress is 1.000.000, same as hunger and thirst. Same working mehcanism as hunger-thirst.
	//
	Maksimum stress 1.000.000, açlık ve susuzluk ile aynı mantıkta çalışıyor.
]]

--IMPORTANT--
-- print(...) in server.lua will get spammy, it's there for testing purposes, you should erase it or comment it
--ÖNEMLİ--
-- server.lua daki print(...) ler konsolu spammler, test için koydum oraya, onları silin veya yorumlayın[--]

-- Find the handler name and replace it with this // Handler isimlerini bulun ve alttaki kod ile değiştirin

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
	TriggerEvent('esx_status:set', 'stress', 1)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()

	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'stress', 1)

	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

-- Same in here too, just find the handler name "esx_status:loaded" and replace the code // aynı şekilde burayı da bulup kopyalayın

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#FFFF00', function(status)
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0099FF', function(status)
		return true
	end, function(status)
		status.remove(75)
	end)

	TriggerEvent('esx_status:registerStatus', 'stress', 100000, '#FF3700', function(status)
		return false
	end, function(status)
		status.add(20)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(600)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'stress', function(status) -- Bu eventi stressi hudda göstermek için de kullanabilirsiniz // you can also use this event to show stress on your hud
				stress = status.val
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
			if stress == 1000000 then -- max stress
				SetTimecycleModifier("WATER_silty") -- hafif blurlanır ve görüş düşer // a bit blur and vision distance reduce
				SetTimecycleModifierStrength(1)
			else
				ClearExtraTimecycleModifier()
			end
			if stress >= 900000 then
				local veh = GetVehiclePedIsUsing(playerPed)
			  	if IsPedInAnyVehicle(playerPed) and GetPedInVehicleSeat(veh, -1) == playerPed then -- eğer oyuncu araçtaysa ve ayrıca o aracı kullanıyorsa // if ped "driving" a vehicle
					Citizen.Wait(1000)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.15) -- kamera sallanmaları // cam shake
					TaskVehicleTempAction(playerPed, veh, 7, 500) -- aracı hafif sola kırma // turn left a bit
					Citizen.Wait(500)
					TaskVehicleTempAction(playerPed, veh, 8, 500) -- aracı hafif sağa kırma // turn right a bit
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.15)
					Citizen.Wait(500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.15)
			  	else
					Citizen.Wait(1500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.15)
			  	end
			elseif stress >= 800000 then
				local veh = GetVehiclePedIsUsing(playerPed)
			  	if IsPedInAnyVehicle(playerPed) and GetPedInVehicleSeat(veh, -1) == playerPed then
					Citizen.Wait(1000)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.10)
					TaskVehicleTempAction(playerPed, veh, 7, 300)
					Citizen.Wait(500)
					TaskVehicleTempAction(playerPed, veh, 8, 300)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.10)
					Citizen.Wait(500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.10)
			  	else
					Citizen.Wait(2000)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.10)
			  	end
			elseif stress >= 700000 then
				local veh = GetVehiclePedIsUsing(playerPed)
			  	if IsPedInAnyVehicle(playerPed) and GetPedInVehicleSeat(veh, -1) == playerPed then
					Citizen.Wait(1000)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
					TaskVehicleTempAction(playerPed, veh, 7, 100)
					Citizen.Wait(500)
					TaskVehicleTempAction(playerPed, veh, 8, 100)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
					Citizen.Wait(500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
			  	else
					Citizen.Wait(2500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
			  	end
			elseif stress >= 600000 then -- %60 altındayken araç sürüşüne bir etkisi olmuyor // Below ½60 no effect to driving
				Citizen.Wait(3500) -- sıklık // frequency
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07) -- efekt // effect
			elseif stress >= 500000 then
				Citizen.Wait(4500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
			elseif stress >= 350000 then
				Citizen.Wait(5500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.05)
			elseif stress >= 200000 then
				Citizen.Wait(6500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.03)
			end
		end
	end)
end)

--EXAMPLE THREAD

Citizen.CreateThread(function()
    while true do -- döngü // loop
        local test = IsPedShooting(ped) -- kontrol etmek istediğiniz nativeler // native you want to check (natives: https://runtime.fivem.net/doc/natives/)
        if test then -- eğer native true dönerse alttaki olaylar yaşanacak // if the native returns true below action will happen
            TriggerServerEvent("stress:add", 500000) -- stres ekleme // adding stress
        else -- eğer native false dönerse bir şey yapmayıp döngü devam edecek // while the native returns false do nothing and keep the loop
            Citizen.Wait(1) -- nativeyi ne kadar sık kontrol etmek istediğinizi buraya yazın ms olarak (genelde 1000 altı olmalı) // how often you want to check the native in ms (should generally be smaller then 1000)
        end
    end
end)

-- AYRICA esx_basicneeds/server.lua 'DA İTEM KULLANIMINDA STRESS ETKİSİ ÖRNEĞİ VARDIR --

-- ALSO THERE IS A EXAMPLE FOR ADDING OR REMOVING STRESS ON ITEM USAGE IN esx_basicneeds/server.lua --