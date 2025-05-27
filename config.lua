Config = {}

-- Locales en or fi
Config.Locale = 'fi'

-- Blip, you can change the name
Config.Blip = {
    coords = vector3(-625.75, -234.52, 38.05),
    sprite = 439,
    color = 5,
    scale = 0.9,
    name = "Korukauppa"
}

-- Cops required.
Config.RequiredCops = 3

-- Cooldown With seconds
Config.Cooldown = 900

-- Dispatches: "tk", "ps", "cd", "linden", "custom", "none"
Config.Dispatch = "tk" 

-- Allowed weapons to break vitrins.
Config.AllowedWeapons = {
    [`weapon_pistol`] = true,
    [`weapon_pistol_mk2`] = true,
    [`weapon_combatpistol`] = true,
    [`weapon_vintagepistol`] = true,
    [`weapon_heavypistol`] = true,
    [`weapon_snspistol`] = true,
    [`weapon_snspistol_mk2`] = true,
    [`weapon_assaultrifle_mk2`] = true,
    [`weapon_microsmg`] = true,
    [`weapon_pistol50`] = true,
    [`weapon_smg`] = true,
    [`weapon_musket`] = true,
    [`weapon_machete`] = true,
    [`weapon_bat`] = true,
    [`weapon_switchblade`] = true,
    [`weapon_knuckle`] = true,
    [`weapon_battleaxe`] = true,
    [`weapon_knife`] = true,
    [`weapon_golfclub`] = true,
    [`weapon_crowbar`] = true
}

-- Vitrine rewars, with min and max.
Config.VitrineRewards = {
    { item = "koru", min = 1, max = 3 },
    { item = "rolex", min = 1, max = 2 },
    { item = "goldearring", min = 1, max = 2 },
    { item = "bronzebracelet", min = 1, max = 3 },
    { item = "rubynecklace", min = 1, max = 2 },
}

-- All vitrines, if u have custom jewelry change these.
Config.Vitrines = {
    vector3(-626.92, -235.40, 38.06),
    vector3(-625.78, -234.57, 38.06),
    vector3(-626.92, -233.14, 38.06),
    vector3(-627.93, -233.83, 38.06),
    vector3(-626.78, -238.62, 38.06),
    vector3(-625.72, -237.84, 38.06),
    vector3(-623.06, -232.95, 38.06),
    vector3(-624.56, -230.88, 38.06),
    vector3(-621.06, -228.56, 38.06),
    vector3(-619.47, -230.61, 38.06),
    vector3(-618.79, -234.15, 37.64),
    vector3(-619.84, -234.91, 37.64),
    vector3(-620.52, -232.88, 37.64),
    vector3(-623.61, -228.62, 37.64),
    vector3(-624.27, -226.60, 37.64),
    vector3(-625.32, -227.36, 37.64),
    vector3(-619.20, -227.24, 37.64),
    vector3(-619.96, -226.19, 37.64),
    vector3(-617.84, -229.11, 37.64),
    vector3(-617.08, -230.16, 37.64),
}
