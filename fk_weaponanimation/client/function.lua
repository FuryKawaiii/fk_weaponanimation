-- Functions
function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "open",
        status = bool
    })
end

function CheckWeapon(ped)
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #config.DrawingWeapons do
				if GetHashKey(config.DrawingWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function CheckWeapon2(ped)
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #config.AimWeapons do
				if GetHashKey(config.AimWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(50)
	end
end
