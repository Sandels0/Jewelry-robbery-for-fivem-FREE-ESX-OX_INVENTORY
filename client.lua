local locale = Locales[Config.Locale] or {}
local vitrines = {}

local function SendDispatchAlert()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = GetStreetNameFromHashKey(streetHash) or "Unknown"

    if Config.Dispatch == "tk" then
        exports.tk_dispatch:addCall({
            title = locale.dispatchTitle or "Jewelry store robbery",
            code = '10-58',
            priority = 'Priority 1',
            coords = coords,
            showLocation = true,
            showGender = true,
            playSound = true,
            blip = {
                color = 1,
                sprite = 161,
                scale = 1.0,
            },
            jobs = {'police'},
            extra = { street = streetName }
        })

    elseif Config.Dispatch == "ps" then
        exports["ps-dispatch"]:CustomAlert({
            coords = coords,
            job = "police",
            title = "10-90 | Jewelry Store Robbery",
            message = "Suspicious activity at the jewelry store.",
            blip = {
                sprite = 617,
                color = 1,
                scale = 1.5,
            }
        })

    elseif Config.Dispatch == "cd" then
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'},
            coords = coords,
            title = "10-90 | Jewelry Store",
            message = "A jewelry store robbery is in progress!",
            flash = 1,
            unique_id = tostring(math.random(100000, 999999)),
            blip = {
                sprite = 161,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = "Jewelry Robbery",
                time = (5 * 60 * 1000),
                sound = 1
            }
        })

    elseif Config.Dispatch == "linden" then
        TriggerServerEvent('linden_outlawalert:server:Alert', {
            title = 'Jewelry Store Robbery',
            coords = coords,
            id = GetPlayerServerId(PlayerId()),
            description = 'A robbery is occurring at the jewelry store.',
            vehicle = false,
            type = 'police',
        })
    end
end

for i, coords in ipairs(Config.Vitrines) do
    vitrines[i] = { robbed = false }

    exports.ox_target:addBoxZone({
        coords = coords,
        size = vec3(1, 1, 1),
        rotation = 0.0,
        options = {
            {
                name = "jewel_vitrine_" .. i,
                icon = "fa-solid fa-gem",
                label = locale.breaking or "Smashing the glass...",
                onSelect = function()
                    TriggerServerEvent('jewelheist:attemptHeist', i)
                end
            }
        }
    })
end

RegisterNetEvent('jewelheist:startHeist', function(index)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)

    if not Config.AllowedWeapons[weapon] then
        lib.notify({ type = 'error', description = locale.noWeapon })
        return
    end

    local success = lib.skillCheck({'medium', 'medium', 'medium'}, {'w', 'a', 's','d'})
    if not success then
        lib.notify({ type = 'error', description = locale.skillFailed })
        return
    end

    local dict = "missheist_jewel"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end

    local progress = lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        label = locale.breaking or "Smashing the glass...",
        anim = { dict = dict, clip = "smash_case" },
        disable = { move = true, car = true, combat = true },
    })

    if not progress then
        lib.notify({ type = 'error', description = locale.cancel })
        return
    end

    SendDispatchAlert()
    TriggerServerEvent('jewelheist:rewardPlayer', index)
end)

RegisterNetEvent('jewelheist:notify', function(msg)
    lib.notify({ type = 'error', description = msg })
end)

CreateThread(function()
    local blip = AddBlipForCoord(Config.Blip.coords)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.Blip.scale)
    SetBlipColour(blip, Config.Blip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.name)
    EndTextCommandSetBlipName(blip)
end)
