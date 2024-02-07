if Config.ESX == "new" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.ESX == "old" then
    ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
end

local HolsterAnim = GetResourceKvpString("HolsterAnim")
local AimAnim = GetResourceKvpString("AimAnim")

OpenMenu = false
local mainMenu = RageUI.CreateMenu(_('mainMenu_title'), _('mainMenu_subtitle'))
mainMenu.Closed = function()
    OpenMenu = false
end

function MenuAnimationsHolster()
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(mainMenu, false)
        return
    else
        OpenMenu = true
        RageUI.Visible(mainMenu, true)


        CreateThread(function()
            while OpenMenu do
                Wait(1)

                RageUI.IsVisible(mainMenu, function()

                    RageUI.Button('~g~Par défaut', nil, {RightBadge = nil}, true, {
                        onSelected = function()
                            SetResourceKvp("HolsterAnim", "nil")
                            HolsterAnim = GetResourceKvpString("HolsterAnim")
                        end,

                        onActive = function()
                            RenderSprite("RageUI_", 'holsterdefault', 10, 450, 400, 200, 100)
                        end
                    })

                        RageUI.Separator(_('mainMenu_separator'))

                        RageUI.Button('Dégainer son arme en douce', nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, {
                            onSelected = function()
                                SetResourceKvp("HolsterAnim", "BackHolsterAnimation")
                                HolsterAnim = GetResourceKvpString("HolsterAnim")
                            end,

                            onActive = function()
                                RenderSprite("RageUI_", 'holsterback', 10, 450, 400, 200, 100)
                            end
                        })

                        RageUI.Button('Sortir son arme de l\'étui', nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, {
                            onSelected = function()
                                SetResourceKvp("HolsterAnim", "SideHolsterAnimation")
                                HolsterAnim = GetResourceKvpString("HolsterAnim")
                            end,

                            onActive = function()
                                RenderSprite("RageUI_", 'holstercop', 10, 450, 400, 200, 100)
                            end
                        })

                        RageUI.Button('Extraire son arme de la poche péctorale', nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, {
                            onSelected = function()
                                SetResourceKvp("HolsterAnim", "FrontHolsterAnimation")
                                HolsterAnim = GetResourceKvpString("HolsterAnim")
                            end,

                            onActive = function()
                                RenderSprite("RageUI_", 'holsterfront', 10, 450, 400, 200, 100)
                            end
                        })

                        RageUI.Button('Prendre violemment son arme', nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, {
                            onSelected = function()
                                SetResourceKvp("HolsterAnim", "AgressiveFrontHolsterAnimation")
                                HolsterAnim = GetResourceKvpString("HolsterAnim")
                            end,

                            onActive = function()
                                RenderSprite("RageUI_", 'holsterfrontagressive', 10, 450, 400, 200, 100)
                            end
                        })

                        RageUI.Button('Tirer son arme de sa poche', nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, {
                            onSelected = function()
                                SetResourceKvp("HolsterAnim", "SideLegHolsterAnimation")
                                HolsterAnim = GetResourceKvpString("HolsterAnim")
                            end,

                            onActive = function()
                                RenderSprite("RageUI_", 'holsterleg', 10, 450, 400, 200, 100)
                            end
                        })
                end)

            end
        end)
    end
end

RegisterCommand("holsteranim", function()
    MenuAnimationsHolster()
end)

-- First thread Weapon drawing
CreateThread(function()
    while true do
        if HolsterAnim == "SideHolsterAnimation" then
            loadAnimDict("rcmjosh4")
            loadAnimDict("reaction@intimidation@cop@unarmed")
            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            blocked   = true
                                SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
                                TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                                
                                    Citizen.Wait(100)
                                    SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
                                TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                                    Citizen.Wait(400)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(50)
                    else
                        if not holstered then
                                TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                                    Citizen.Wait(500)
                                TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                                    Citizen.Wait(60)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                    Citizen.Wait(50)
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            else
                holstered = true
            end
        elseif HolsterAnim == "BackHolsterAnimation" then
            loadAnimDict("reaction@intimidation@1h")

            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                            blocked   = true
                                TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
                                    Citizen.Wait(600)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(40)
                    else
                        if not holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                                TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
                                    Citizen.Wait(2000)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                    Citizen.Wait(50)
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            else
                holstered = true
            end
        end
        Citizen.Wait(40)
    end
end)

-- Second thread for Weapon drawing
CreateThread(function()
    while true do
        if HolsterAnim == "FrontHolsterAnimation" then
            loadAnimDict("combat@combat_reactions@pistol_1h_gang")

            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                            blocked   = true
                                TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
                                    Citizen.Wait(600)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(40)
                    else
                        if not holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                                TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
                                    Citizen.Wait(1000)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                    Citizen.Wait(50)
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            else
                holstered = true
            end
        elseif HolsterAnim == "AgressiveFrontHolsterAnimation" then
            loadAnimDict("combat@combat_reactions@pistol_1h_hillbilly")
            loadAnimDict("combat@combat_reactions@pistol_1h_gang")

            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                            blocked   = true
                                TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_hillbilly", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
                                    Citizen.Wait(600)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(40)
                    else
                        if not holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                                TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
                                    Citizen.Wait(1000)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                    Citizen.Wait(50)
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            else
                holstered = true
            end
        elseif HolsterAnim == "SideLegHolsterAnimation" then
            loadAnimDict("reaction@male_stand@big_variations@d")

            if not IsPedInAnyVehicle(ped, false) then
                if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                    if CheckWeapon(ped) then
                        if holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                            blocked   = true
                                TaskPlayAnimAdvanced(ped, "reaction@male_stand@big_variations@d", "react_big_variations_m", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
                                    Citizen.Wait(500)
                                ClearPedTasks(ped)
                            holstered = false
                        else
                            blocked = false
                        end
                        Citizen.Wait(40)
                    else
                        if not holstered then
                            pos = GetEntityCoords(ped, true)
		                    rot = GetEntityHeading(ped)
                                TaskPlayAnimAdvanced(ped, "reaction@male_stand@big_variations@d", "react_big_variations_m", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
                                    Citizen.Wait(500)
                                ClearPedTasks(ped)
                            holstered = true
                        end
                        Citizen.Wait(40)
                    end
                else
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
                Citizen.Wait(50)
            else
                holstered = true
            end
        end
        Citizen.Wait(40)
    end
end)

-- Block thread
CreateThread(function()
    while true do
        if blocked then
            DisableControlAction(1, 25, true ) -- aim
            DisableControlAction(1, 140, true) -- mele attack
            DisableControlAction(1, 141, true) -- mele attack heavy
            DisableControlAction(1, 142, true) -- mele attack alt
            DisableControlAction(1, 23, true) -- enter vehicle
            DisablePlayerFiring(ped, true) -- Disable weapon firing
        end
        Citizen.Wait(100)
    end
end)