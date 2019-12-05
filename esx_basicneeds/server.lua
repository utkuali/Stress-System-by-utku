-- ŞABLON // TEMPLATE

ESX.RegisterUsableItem('İTEM_İSMİ', function(source) -- İTEM_İSMİ kısmına item ismini yazın (sigara) // replace your item with İTEM_İSMİ
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('İTEM_İSMİ', 1) -- kullanınca bir tane envanterden siler // removes 1 when used

	TriggerClientEvent('esx_status:OLAY', source, 'stress', MİKTAR) -- MİKTAR kısmına miktar, OLAY kısmına ekleme ise "add", azaltama ise "remove" yazın // replace MİKTAR with the amount you want, and replace OLAY with "add" or "remove"
	TriggerClientEvent('esx_basicneeds:ANIM', source) -- eğer item kullanımında animasyon ya da farklı bir client event istiyorsanız burada triggerlayın // if you want animation or something else on item usage trigger it here
	TriggerClientEvent('esx:showNotification', source, "BİLDİRİM") -- BİLDİRİM yerine eğer bildirim gitmesini istiyorsanız bir şey yazın // replace BİLDİRİM with the notification you want
end)


-- ÖRNEK: SİGARA // EXAMPLE: CIGARETTES

ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    	xPlayer.removeInventoryItem('cigarett', 1)
	TriggerClientEvent('esx_basicneeds:cigarett', source) -- ilk önce animasyon oynatıyoruz // first we play animation
    	Citizen.Wait(8000) -- Birazcık bekliyoruzki kullandığı gibi stress değişmesin, animasyon oynasın // wait a bit so stress won't change instantly and animation can be played
	TriggerClientEvent('esx_status:remove', source, 'stress', 250000) -- stres düşüyor // lover stress
end) -- Bildirim eklemek istemedim // I didn't want to add a notification

-- To add animation to usage you need to open esx_basicneeds/client.lua
-- Animasyon eklemek için esx_basicneeds/client.lua yı açın

-----------------------------------------------------------------------

-- Bu çikolatalı donut için basit bir animasyon örnek olması için :D
-- This is a example animaton on client side for eating chocolate donut :D
RegisterNetEvent('esx_basicneeds:onDonut2Eat')
AddEventHandler('esx_basicneeds:onDonut2Eat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or "prop_donut_02"
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict("mp_player_inteat@burger", function()
				TaskPlayAnim(playerPed, "mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)
	end
end)

-- UMARIM YARDIMCI OLMUŞTUR // HOPE THIS HELPED
-- utku
