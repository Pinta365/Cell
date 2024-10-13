local addonName, Cell = ...

-- number of built-in indicators
Cell.defaults.builtIns = 29

Cell.defaults.indicatorIndices = {
    ["nameText"] = 1,
    ["statusText"] = 2,
    ["healthText"] = 3,
    ["powerText"] = 4,
    ["healthThresholds"] = 5,
    ["statusIcon"] = 6,
    ["roleIcon"] = 7,
    ["leaderIcon"] = 8,
    ["readyCheckIcon"] = 9,
    ["playerRaidIcon"] = 10,
    ["targetRaidIcon"] = 11,
    ["aggroBlink"] = 12,
    ["aggroBar"] = 13,
    ["aggroBorder"] = 14,
    ["shieldBar"] = 15,
    ["aoeHealing"] = 16,
    ["externalCooldowns"] = 17,
    ["defensiveCooldowns"] = 18,
    ["allCooldowns"] = 19,
    ["tankActiveMitigation"] = 20,
    ["dispels"] = 21,
    ["debuffs"] = 22,
    ["raidDebuffs"] = 23,
    ["privateAuras"] = 24,
    ["targetedSpells"] = 25,
    ["targetCounter"] = 26,
    ["crowdControls"] = 27,
    ["actions"] = 28,
    ["missingBuffs"] = 29,
}

Cell.defaults.layout = {
    -- ["syncWith"] = "layoutName",
    ["main"] = {
        ["combineGroups"] = false,
        ["sortByRole"] = false,
        ["roleOrder"] = {"TANK", "HEALER", "DAMAGER"},
        ["hideSelf"] = false,
        ["size"] = {66, 46},
        ["position"] = {},
        ["powerSize"] = 2,
        ["orientation"] = "vertical",
        ["anchor"] = "TOPLEFT",
        ["spacingX"] = 3,
        ["spacingY"] = 3,
        ["maxColumns"] = 8,
        ["unitsPerColumn"] = 5,
        ["groupSpacing"] = 0,
    },
    ["pet"] = {
        ["partyEnabled"] = true,
        ["raidEnabled"] = false,
        ["sameSizeAsMain"] = true,
        ["sameArrangementAsMain"] = true,
        ["size"] = {66, 46},
        ["position"] = {},
        ["powerSize"] = 2,
        ["orientation"] = "vertical",
        ["anchor"] = "TOPLEFT",
        ["spacingX"] = 3,
        ["spacingY"] = 3,
    },
    ["npc"] = {
        ["enabled"] = true,
        ["separate"] = false,
        ["sameSizeAsMain"] = true,
        ["sameArrangementAsMain"] = true,
        ["size"] = {66, 46},
        ["position"] = {},
        ["powerSize"] = 2,
        ["orientation"] = "vertical",
        ["anchor"] = "TOPLEFT",
        ["spacingX"] = 3,
        ["spacingY"] = 3,
    },
    ["spotlight"] = {
        ["enabled"] = false,
        ["hidePlaceholder"] = false,
        ["units"] = {},
        ["sameSizeAsMain"] = true,
        ["sameArrangementAsMain"] = true,
        ["size"] = {66, 46},
        ["position"] = {},
        ["powerSize"] = 2,
        ["orientation"] = "vertical",
        ["anchor"] = "TOPLEFT",
        ["spacingX"] = 3,
        ["spacingY"] = 3,
    },
    -- ["npc"] = {true, false, {}, false, {66, 46}}, -- npcEnabled, separateNpc, position, sizeEnabled, size
    -- ["pet"] = {true, false, {}, false, {66, 46}}, -- partyPetsEnabled, raidPetsEnabled, raidPetsPosition, sizeEnabled, size
    -- ["spotlight"] = {false, {}, {}, false, {66, 46}}, -- enabled, units, position, sizeEnabled, size
    ["barOrientation"] = {"horizontal", false},
    ["groupFilter"] = {true, true, true, true, true, true, true, true},
    ["powerFilters"] = {
        ["DEATHKNIGHT"] = {["TANK"] = true, ["DAMAGER"] = true},
        ["DEMONHUNTER"] = {["TANK"] = true, ["DAMAGER"] = true},
        ["DRUID"] = {["TANK"] = true, ["DAMAGER"] = true, ["HEALER"] = true},
        ["EVOKER"] = {["DAMAGER"] = true, ["HEALER"] = true},
        ["HUNTER"] = true,
        ["MAGE"] = true,
        ["MONK"] = {["TANK"] = true, ["DAMAGER"] = true, ["HEALER"] = true},
        ["PALADIN"] = {["TANK"] = true, ["DAMAGER"] = true, ["HEALER"] = true},
        ["PRIEST"] = {["DAMAGER"] = true, ["HEALER"] = true},
        ["ROGUE"] = true,
        ["SHAMAN"] = {["DAMAGER"] = true, ["HEALER"] = true},
        ["WARLOCK"] = true,
        ["WARRIOR"] = {["TANK"] = true, ["DAMAGER"] = true},
        ["PET"] = true,
        ["VEHICLE"] = true,
        ["NPC"] = true,
    },
    ["indicators"] = {
        {
            ["name"] = "Name Text",
            ["indicatorName"] = "nameText",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"CENTER", "CENTER", 0, 0},
            ["frameLevel"] = 1,
            ["font"] = {"Cell ".._G.DEFAULT, 13, "None", true},
            ["color"] = {"custom_color", {1, 1, 1}},
            ["vehicleNamePosition"] = {"TOP", 0},
            ["textWidth"] = {"percentage", 0.75},
            ["showGroupNumber"] = false,
        }, -- 1
        {
            ["name"] = "Status Text",
            ["indicatorName"] = "statusText",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"BOTTOM", 0, "justify"},
            ["frameLevel"] = 30,
            ["font"] = {"Cell ".._G.DEFAULT, 11, "None", true},
            ["showTimer"] = true,
            ["showBackground"] = true,
            ["colors"] = {
                ["AFK"] = {1, 0.19, 0.19, 1},
                ["OFFLINE"] = {1, 0.19, 0.19, 1},
                ["DEAD"] = {1, 0.19, 0.19, 1},
                ["GHOST"] = {1, 0.19, 0.19, 1},
                ["FEIGN"] = {1, 1, 0.12, 1},
                ["DRINKING"] = {0.12, 0.75, 1, 1},
                ["PENDING"] = {1, 1, 0.12, 1},
                ["ACCEPTED"] = {0.12, 1, 0.12, 1},
                ["DECLINED"] = {1, 0.19, 0.19, 1},
            },
        }, -- 2
        {
            ["name"] = "Health Text",
            ["indicatorName"] = "healthText",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["position"] = {"TOP", "CENTER", 0, -5},
            ["frameLevel"] = 2,
            ["font"] = {"Cell ".._G.DEFAULT, 10, "None", true},
            ["color"] = {"custom_color", {1, 1, 1}},
            ["format"] = "[effective_percent]",
            ["hideIfEmptyOrFull"] = true,
        }, -- 3
        {
            ["name"] = "Power Text",
            ["indicatorName"] = "powerText",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["position"] = {"BOTTOMRIGHT", "BOTTOMRIGHT", 0, 3},
            ["frameLevel"] = 2,
            ["font"] = {"Cell ".._G.DEFAULT, 10, "None", true},
            ["color"] = {"custom_color", {1, 1, 1}},
            ["format"] = "number",
            ["hideIfEmptyOrFull"] = true,
        }, -- 4
        {
            ["name"] = "Health Thresholds",
            ["indicatorName"] = "healthThresholds",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["thickness"] = 1,
            ["thresholds"] = {
                {0.35, {1, 0, 0, 1}},
            },
        }, -- 5
        {
            ["name"] = "Status Icon",
            ["indicatorName"] = "statusIcon",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"TOP", "TOP", 0, -3},
            ["frameLevel"] = 10,
            ["size"] = {18, 18},
        }, -- 6
        {
            ["name"] = "Role Icon",
            ["indicatorName"] = "roleIcon",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["hideDamager"] = false,
            ["position"] = {"TOPLEFT", "TOPLEFT", 0, 0},
            ["size"] = {11, 11},
            ["roleTexture"] = {"default", "Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\Tank.tga", "Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\Healer.tga", "Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\DPS.tga"},
            ["frameLevel"] = 5,
        }, -- 7
        {
            ["name"] = "Leader Icon",
            ["indicatorName"] = "leaderIcon",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["hideInCombat"] = true,
            ["position"] = {"TOPLEFT", "TOPLEFT", 1, -10},
            ["size"] = {11, 11},
        }, -- 8
        {
            ["name"] = "Ready Check Icon",
            ["indicatorName"] = "readyCheckIcon",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"CENTER", "CENTER", 0, 0},
            ["frameLevel"] = 100,
            ["size"] = {16, 16},
        }, -- 9
        {
            ["name"] = "Raid Icon (player)",
            ["indicatorName"] = "playerRaidIcon",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"TOP", "TOP", 0, 3},
            ["frameLevel"] = 5,
            ["size"] = {14, 14},
            ["alpha"] = 0.77,
        }, -- 10
        {
            ["name"] = "Raid Icon (target)",
            ["indicatorName"] = "targetRaidIcon",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["position"] = {"TOP", "TOP", -14, 3},
            ["frameLevel"] = 5,
            ["size"] = {14, 14},
            ["alpha"] = 0.77,
        }, -- 11
        {
            ["name"] = "Aggro (blink)",
            ["indicatorName"] = "aggroBlink",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"TOPLEFT", "TOPLEFT", 0, 0},
            ["frameLevel"] = 7,
            ["size"] = {11, 11},
        }, -- 12
        {
            ["name"] = "Aggro (bar)",
            ["indicatorName"] = "aggroBar",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"BOTTOMLEFT", "TOPLEFT", 0, -1},
            ["frameLevel"] = 1,
            ["size"] = {20, 4},
        }, -- 13
        {
            ["name"] = "Aggro (border)",
            ["indicatorName"] = "aggroBorder",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["frameLevel"] = 3,
            ["thickness"] = 2,
        }, -- 14
        {
            ["name"] = "Shield Bar",
            ["indicatorName"] = "shieldBar",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["position"] = {"BOTTOMLEFT", "BOTTOMLEFT", 0, 0},
            ["frameLevel"] = 5,
            ["height"] = 4,
            ["color"] = {1, 1, 0, 1},
            ["onlyShowOvershields"] = false,
        }, -- 15
        {
            ["name"] = "AoE Healing",
            ["indicatorName"] = "aoeHealing",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["height"] = 10,
            ["color"] = {1, 1, 0},
        }, -- 16
        {
            ["name"] = "External Cooldowns",
            ["indicatorName"] = "externalCooldowns",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"RIGHT", "RIGHT", 2, 5},
            ["frameLevel"] = 10,
            ["size"] = {12, 20},
            ["showDuration"] = false,
            ["showAnimation"] = true,
            ["num"] = 2,
            ["orientation"] = "right-to-left",
            ["font"] = {
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "TOPRIGHT", 2, 1, {1, 1, 1}},
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "BOTTOMRIGHT", 2, -1, {1, 1, 1}},
            },
        }, -- 17
        {
            ["name"] = "Defensive Cooldowns",
            ["indicatorName"] = "defensiveCooldowns",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"LEFT", "LEFT", -2, 5},
            ["frameLevel"] = 10,
            ["size"] = {12, 20},
            ["showDuration"] = false,
            ["showAnimation"] = true,
            ["num"] = 2,
            ["orientation"] = "left-to-right",
            ["font"] = {
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "TOPRIGHT", 2, 1, {1, 1, 1}},
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "BOTTOMRIGHT", 2, -1, {1, 1, 1}},
            },
        }, -- 18
        {
            ["name"] = "Externals + Defensives",
            ["indicatorName"] = "allCooldowns",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["position"] = {"LEFT", "LEFT", -2, 5},
            ["frameLevel"] = 10,
            ["size"] = {12, 20},
            ["showDuration"] = false,
            ["showAnimation"] = true,
            ["num"] = 2,
            ["orientation"] = "left-to-right",
            ["font"] = {
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "TOPRIGHT", 2, 1, {1, 1, 1}},
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "BOTTOMRIGHT", 2, -1, {1, 1, 1}},
            },
        }, -- 19
        {
            ["name"] = "Tank Active Mitigation",
            ["indicatorName"] = "tankActiveMitigation",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"TOPLEFT", "TOPLEFT", 10, 0},
            ["frameLevel"] = 5,
            ["size"] = {20, 6},
            ["color"] = {"class_color", {0.25, 1, 0}},
        }, -- 20
        {
            ["name"] = "Dispels",
            ["indicatorName"] = "dispels",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"BOTTOMRIGHT", "BOTTOMRIGHT", 0, 4},
            ["frameLevel"] = 15,
            ["size"] = {12, 12},
            ["filters"] = {
                ["dispellableByMe"] = true,
                ["Curse"] = true,
                ["Disease"] = true,
                ["Magic"] = true,
                ["Poison"] = true,
                ["Bleed"] = true,
            },
            ["highlightType"] = "gradient-half",
            ["iconStyle"] = "blizzard",
            ["orientation"] = "right-to-left",
        }, -- 21
        {
            ["name"] = "Debuffs",
            ["indicatorName"] = "debuffs",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"BOTTOMLEFT", "BOTTOMLEFT", 1, 4},
            ["frameLevel"] = 5,
            ["size"] = {{13, 13}, {17, 17}},
            ["showDuration"] = false,
            ["showAnimation"] = true,
            ["showTooltip"] = false,
            ["enableBlacklistShortcut"] = false,
            ["num"] = 3,
            ["font"] = {
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "TOPRIGHT", 2, 1, {1, 1, 1}},
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "BOTTOMRIGHT", 2, -1, {1, 1, 1}},
            },
            ["dispellableByMe"] = false,
            ["orientation"] = "left-to-right",
        }, -- 22
        {
            ["name"] = "Raid Debuffs",
            ["indicatorName"] = "raidDebuffs",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"CENTER", "CENTER", 0, 3},
            ["frameLevel"] = 20,
            ["size"] = {22, 22},
            ["border"] = 2,
            ["num"] = 1,
            ["showDuration"] = true,
            ["font"] = {
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "TOPRIGHT", 2, 1, {1, 1, 1}},
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "BOTTOMRIGHT", 2, -1, {1, 1, 1}},
            },
            ["onlyShowTopGlow"] = true,
            ["orientation"] = "left-to-right",
            ["showTooltip"] = false,
        }, -- 23
        {
            ["name"] = "Private Auras",
            ["indicatorName"] = "privateAuras",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["position"] = {"TOP", "TOP", 0, 3},
            ["frameLevel"] = 25,
            ["size"] = {18, 18},
            ["privateAuraOptions"] = {true, false},
        }, -- 24
        {
            ["name"] = "Targeted Spells",
            ["indicatorName"] = "targetedSpells",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["showAllSpells"] = false,
            ["position"] = {"TOPLEFT", "TOPLEFT", -4, 4},
            ["frameLevel"] = 50,
            ["size"] = {20, 20},
            ["border"] = 2,
            ["num"] = 1,
            ["font"] = {"Cell ".._G.DEFAULT, 12, "Outline", false, "TOPRIGHT", 2, 1, {1, 1, 1}},
            ["orientation"] = "left-to-right",
        }, -- 25
        {
            ["name"] = "Target Counter",
            ["indicatorName"] = "targetCounter",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["position"] = {"TOP", "TOP", 0, 5},
            ["frameLevel"] = 15,
            ["font"] = {"Cell ".._G.DEFAULT, 15, "Outline", false},
            ["color"] = {1, 0.1, 0.1},
            ["filters"] = {
                ["outdoor"] = false,
                ["pve"] = false,
                ["pvp"] = true,
            },
        }, -- 26
        {
            ["name"] = "Crowd Controls",
            ["indicatorName"] = "crowdControls",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["position"] = {"CENTER", "CENTER", 0, 0},
            ["frameLevel"] = 20,
            ["size"] = {22, 22},
            ["border"] = 2,
            ["num"] = 3,
            ["showDuration"] = true,
            ["font"] = {
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "TOPRIGHT", 2, 1, {1, 1, 1}},
                {"Cell ".._G.DEFAULT, 11, "Outline", false, "BOTTOMRIGHT", 2, -1, {1, 1, 1}},
            },
            ["dispellableByMe"] = false,
            ["orientation"] = "left-to-right",
        }, -- 27
        {
            ["name"] = "Actions",
            ["indicatorName"] = "actions",
            ["type"] = "built-in",
            ["enabled"] = true,
            ["speed"] = 1,
        }, -- 28
        {
            ["name"] = "Missing Buffs",
            ["indicatorName"] = "missingBuffs",
            ["type"] = "built-in",
            ["enabled"] = false,
            ["filters"] = {
                ["buffByMe"] = true,
                ["PWF"] = true,
                ["MotW"] = true,
                ["AB"] = true,
                ["BS"] = true,
                ["BotB"] = true,
                ["SF"] = true,
            },
            ["position"] = {"BOTTOMRIGHT", "BOTTOMRIGHT", 0, 4},
            ["frameLevel"] = 10,
            ["size"] = {13, 13},
            ["num"] = 3,
            ["orientation"] = "right-to-left",
        }, -- 29
    },
}

Cell.defaults.layoutAutoSwitch = {
    ["solo"] = "default",
    ["party"] = "default",
    ["raid_outdoor"] = "default",
    ["raid_instance"] = "default",
    ["raid_mythic"] = "default",
    ["arena"] = "default",
    ["battleground15"] = "default",
    ["battleground40"] = "default",
}