--[[
	Max stress is 1.000.000, same as hunger and thirst. Same working mehcanism as hunger-thirst.
	//
	Maksimum stress 1.000.000, açlık ve susuzluk ile aynı mantıkta çalışıyor.
]]

--[[ INSTALL GUIDE
Create a file in your resources folder and name it stress_utk
place client.lua, __resource.lua, server.lua logs.txt inside stress_utk
place start stress_utk under esx_status in your server.cfg
]]
-- If you want to make /heal command also reset stress then you need to replace these lines in esx_basicneeds:
AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)
--with these:
AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
	TriggerEvent('esx_status:set', 'stress', 10)
end)
-------------------------------------------------------
--And these:
RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)
-- with these:
RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'stress', 10)
	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)
-------------------------------------------------------
-- ADDING AND REMOVING STRESS FROM OTHER RESOURCES

-- CLIENT SIDE USING EXPORTS:

exports['stress_utk']:AddStress('instant', 100000) -- Adds 100.000 (%10) stress instantly

exports['stress_utk']:AddStress('slow', 100000, 5) -- Adds 100.000 (%10) stress gradually in 5 seconds

exports['stress_utk']:RemoveStress('instant', 100000) -- Removes 100.000 (%10) stress instantly

exports['stress_utk']:RemoveStress('slow', 100000, 5) -- Removes 100.000 (%10) stress gradually in 5 seconds

-- EXAMPLE THREAD

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

-- ALSO THERE IS AN EXAMPLE FOR ADDING OR REMOVING STRESS ON ITEM USAGE IN esx_basicneeds/server.lua --
