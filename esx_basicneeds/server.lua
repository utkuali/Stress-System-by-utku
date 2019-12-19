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
	TriggerClientEvent('esx_status:remove', source, 'stress', 250000) -- stres düşüyor // loWer stress
end) -- Bildirim eklemek istemedim // I didn't want to add a notification

-- UMARIM YARDIMCI OLMUŞTUR // HOPE THIS HELPED
-- utku