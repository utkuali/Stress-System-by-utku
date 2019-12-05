ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ped = PlayerPedId()

Citizen.CreateThread(function()
    while true do
        ped = PlayerPedId()
		Citizen.Wait(60000)
    end
end)

Citizen.CreateThread(function() -- Nişan almak // Aiming with a weapon
    while true do
        local status = GetPedConfigFlag(ped, 78, 1)
        if status then
            print("adding_aim")
            TriggerServerEvent("stress:add", 10000)
            Citizen.Wait(5000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Elinde silah tutarken (melee ve patlayıcılar kategorisi hariç) // Holding a weapon (except melee and explosives category)
    while true do
        local status = IsPedArmed(ped, 4)
        if status then
            print("adding_holdweapon")
            TriggerServerEvent("stress:add", 10000)
            Citizen.Wait(15000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Ateş ederken // While shooting
    while true do
        local status = IsPedShooting(ped)
        local silenced = IsPedCurrentWeaponSilenced(ped)
        if status and not silenced then
            print("adding_shooting")
            TriggerServerEvent("stress:add", 200000)
            Citizen.Wait(2000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Silah, yumruk vs sesi duyarsa / çalışmıyor gibi, büyük ihtimal npc lerde çalışan bir şey çünkü sadece npc ler bu tür olaylara tepki veriyor // Heard gunshot, melee hit etc., seems not to work, since player peds don't act like NPC's ?
    while true do
        local status = GetPedAlertness(ped)

        if status == 1 then
            print("adding_heard")
            TriggerServerEvent("stress:add", 10000)
            Citizen.Wait(10000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Yumruk atmak, yumruk yemek veya yakın mesafe silahı ile birine kitlenmek // Aiming with a melee, hitting with a melee or getting hit by a melee
    while true do
        local status = IsPedInMeleeCombat(ped)
        if status then
            print("adding_melee")
            TriggerServerEvent("stress:add", 5000)
            Citizen.Wait(5000)
        else
            Citizen.Wait(1)
        end
    end
end)


Citizen.CreateThread(function() -- Can 100(yarı) altındayken BUNU DENEYİN, SORUNLU OLABİLİR // While healt is below 100(half) TEST THIS BEFORE USE, CAN GET PROBLEMATIC
    while true do
        local amount = (GetEntityHealth(ped)-100)
        if amount <= 50 then
            print("adding_inj")
            TriggerServerEvent("stress:add", 100000)
            --exports['mythic_notify']:SendAlert("error", "METİN BURAYA // TEXT HERE") -- Örnek mythic notify // Example mythic notify
            Citizen.Wait(60000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Olduğun yerde kalmak veya yürümek // Staying still or walking
    while true do
        local status = IsPedStill(ped)
        local status_w = IsPedArmed(ped, 4)
        local status2 = IsPedWalking(ped)
		local status_v = IsPedInAnyVehicle(ped, false)

        if status and not status_w and not status_v and not GetPedStealthMovement(ped) then -- durmak // still
            Citizen.Wait(15000)
            print("removing_still")
            TriggerServerEvent("stress:remove", 30000)
            Citizen.Wait(15000)
        elseif status2 and not status_w and not GetPedStealthMovement(ped) then -- yürümek // walking
            Citizen.Wait(15000)
            print("removing_walking")
            TriggerServerEvent("stress:remove", 10000)
            Citizen.Wait(15000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Paraşütle skydive // Skydiving with parachute
    while true do
        local status = GetPedParachuteState(ped)
        if status == 0 then -- paraşütle dalış // freefall with chute (not falling without it)
            print("add_freefall")
            TriggerServerEvent("stress:add", 60000)
            Citizen.Wait(5000)
        elseif status == 1 or status == 2 then -- paraşüt açık // opened chute
            print("add_para")
            TriggerServerEvent("stress:add", 5000)
            Citizen.Wait(5000)
        else
            Citizen.Wait(5000) -- kontrol hızı düşük çünkü paraşüt atlaması çok olan bir şey değil // refresh rate is low on this one since it's not so common to skydive in RP servers
        end
    end
end)

Citizen.CreateThread(function() -- Gizli moda girmek // Stealth mode
    while true do
        local status = GetPedStealthMovement(ped)
        if status then
            print("add_stealth")
            TriggerServerEvent("stress:add", 10000)
            Citizen.Wait(8000)
        else
            Citizen.Wait(1) -- refresh rate
        end
    end
end)

Citizen.CreateThread(function() -- uyuma animasyonu // Sleeping animation || Bunu stres ekleyici veya azaltıcı animasyonlar eklerken template olarak kullanabilirsiniz. // You can use this as a template if you want to make an animation stressful or stress reliever
    while true do
        local status = IsEntityPlayingAnim(ped, "timetable@tracy@sleep@", "idle_c", 3)
        if status then
            print("remove_sleep")
            Citizen.Wait(20000)
            TriggerServerEvent("stress:remove", 200000)
        else
            Citizen.Wait(1) -- refresh rate
        end
    end
end)
-- utku
