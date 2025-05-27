local vitrineCooldowns = {}

ESX = exports["es_extended"]:getSharedObject()

local function isAllowedWeapon(weapon)
    return Config.AllowedWeapons[weapon] == true
end

local function enoughCopsOnline()
    local cops = ESX.GetExtendedPlayers('job', 'police')
    return #cops >= Config.RequiredCops
end

RegisterServerEvent('jewelheist:attemptHeist', function(index)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local ped = GetPlayerPed(src)

    if vitrineCooldowns[index] and vitrineCooldowns[index] > os.time() then
        TriggerClientEvent('jewelheist:notify', src, Locales[Config.Locale].alreadyRobbed or "This vitrine was just robbed!")
        return
    end

    if not enoughCopsOnline() then
        TriggerClientEvent('jewelheist:notify', src, Locales[Config.Locale].notEnoughPolice or "Not enough police in the city!")
        return
    end

    local weapon = GetSelectedPedWeapon(ped)
    if not isAllowedWeapon(weapon) then
        TriggerClientEvent('jewelheist:notify', src, Locales[Config.Locale].need_weapon or "You need a weapon to break the glass.")
        return
    end

    TriggerClientEvent('jewelheist:startHeist', src, index)
end)

RegisterServerEvent('jewelheist:rewardPlayer', function(index)
    local src = source
    local reward = Config.VitrineRewards[math.random(#Config.VitrineRewards)]
    local amount = math.random(reward.min, reward.max)

    exports.ox_inventory:AddItem(src, reward.item, amount)

    vitrineCooldowns[index] = os.time() + Config.Cooldown
end)
