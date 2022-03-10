local _, Cell = ...
local L = Cell.L
local F = Cell.funcs

-------------------------------------------------
-- game version
-------------------------------------------------
function F:IsAsian()
    return LOCALE_zhCN or LOCALE_zhTW or LOCALE_koKR
end

function F:IsClassic()
    return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

function F:IsBCC()
    return WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
end

function F:IsRetail()
    return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end

-------------------------------------------------
-- color
-------------------------------------------------
function F:ConvertRGB(r, g, b, a, desaturation)
    if not desaturation then desaturation = 1 end
    r = r / 255 * desaturation
    g = g / 255 * desaturation
    b = b / 255 * desaturation
    a = a and (a / 255) or 1
    return r, g, b, a
end

-- https://wowpedia.fandom.com/wiki/ColorGradient
function F:ColorGradient(perc, r1,g1,b1, r2,g2,b2, r3,g3,b3)
    perc = perc or 1
    if perc >= 1 then
        return r3, g3, b3
    elseif perc <= 0 then
        return r1, g1, b1
    end
 
    local segment, relperc = math.modf(perc * 2)
    local rr1, rg1, rb1, rr2, rg2, rb2 = select((segment * 3) + 1, r1,g1,b1, r2,g2,b2, r3,g3,b3)
 
    return rr1 + (rr2 - rr1) * relperc, rg1 + (rg2 - rg1) * relperc, rb1 + (rb2 - rb1) * relperc
end

-------------------------------------------------
-- number
-------------------------------------------------
local symbol_1K, symbol_10K, symbol_1B
if LOCALE_zhCN then
    symbol_1K, symbol_10K, symbol_1B = "千", "万", "亿"
elseif LOCALE_zhTW then
    symbol_1K, symbol_10K, symbol_1B = "千", "萬", "億"
elseif LOCALE_koKR then
    symbol_1K, symbol_10K, symbol_1B = "천", "만", "억"
end

if F:IsAsian() then
    function F:FormatNumber(n)
        if abs(n) >= 100000000 then
            return string.format("%.3f"..symbol_1B, n/100000000)
        elseif abs(n) >= 10000 then
            return string.format("%.2f"..symbol_10K, n/10000)
        elseif abs(n) >= 1000 then
            return string.format("%.1f"..symbol_1K, n/1000)
        else
            return n
        end
    end
else
    function F:FormatNumber(n)
        if abs(n) >= 1000000000 then
            return string.format("%.3fB", n/1000000000)
        elseif abs(n) >= 1000000 then
            return string.format("%.2fM", n/1000000)
        elseif abs(n) >= 1000 then
            return string.format("%.1fK", n/1000)
        else
            return n
        end
    end
end

-------------------------------------------------
-- string
-------------------------------------------------
function F:UpperFirst(str)
    return (str:gsub("^%l", string.upper))
end

function F:SplitToNumber(sep, str)
    if not str then return end
    
    local ret = {strsplit(sep, str)}
    for i, v in ipairs(ret) do
        ret[i] = tonumber(v) or ret[i] -- keep non number
    end
    return unpack(ret)
end

local function Chsize(char)
    if not char then
        return 0
    elseif char > 240 then
        return 4
    elseif char > 225 then
        return 3
    elseif char > 192 then
        return 2
    else
        return 1
    end
end

function F:Utf8sub(str, startChar, numChars)
    if not str then return "" end
    local startIndex = 1
    while startChar > 1 do
        local char = string.byte(str, startIndex)
        startIndex = startIndex + Chsize(char)
        startChar = startChar - 1
    end
    
    local currentIndex = startIndex
    
    while numChars > 0 and currentIndex <= #str do
        local char = string.byte(str, currentIndex)
        currentIndex = currentIndex + Chsize(char)
        numChars = numChars -1
    end
    return str:sub(startIndex, currentIndex - 1)
end

-------------------------------------------------
-- table
-------------------------------------------------
function F:Getn(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

function F:GetIndex(t, e)
    for i, v in pairs(t) do
        if e == v then
            return i
        end
    end
    return nil
end

function F:Copy(t)
    local newTbl = {}
    for k, v in pairs(t) do
        if type(v) == "table" then  
            newTbl[k] = F:Copy(v)
        else  
            newTbl[k] = v  
        end  
    end
    return newTbl
end

function F:TContains(t, v)
    for _, value in pairs(t) do
        if value == v then return true end
    end
    return false
end

function F:TInsert(t, v)
    local i, done = 1
    repeat
        if not t[i] then
            t[i] = v
            done = true
        end
        i = i + 1
    until done
end

function F:TRemove(t, v)
    for i = #t, 1, -1 do
        if t[i] == v then
            table.remove(t, i)
        end
    end
end

function F:RemoveElementsExceptKeys(tbl, ...)
    local keys = {}
    for _, v in ipairs({...}) do
        keys[v] = true
    end

    for k in pairs(tbl) do
        if not keys[k] then
            tbl[k] = nil
        end
    end
end

function F:RemoveElementsByKeys(tbl, ...)
    local keys = {}
    for _, v in ipairs({...}) do
        keys[v] = true
    end

    for k in pairs(tbl) do
        if keys[k] then
            tbl[k] = nil
        end
    end
end

function F:Sort(t, k1, order1, k2, order2, k3, order3)
    table.sort(t, function(a, b)
        if a[k1] ~= b[k1] then
            if order1 == "ascending" then
                return a[k1] < b[k1]
            else -- "descending"
                return a[k1] > b[k1]
            end
        elseif k2 and order2 and a[k2] ~= b[k2] then
            if order2 == "ascending" then
                return a[k2] < b[k2]
            else -- "descending"
                return a[k2] > b[k2]
            end
        elseif k3 and order3 and a[k3] ~= b[k3] then
            if order3 == "ascending" then
                return a[k3] < b[k3]
            else -- "descending"
                return a[k3] > b[k3]
            end
        end
    end)
end

function F:StringToTable(s, sep)
    local t = {}
    for i, v in pairs({string.split(sep, s)}) do
        v = strtrim(v)
        if v ~= "" then
            tinsert(t, v)
        end
    end
    return t
end

function F:TableToString(t, sep)
    return table.concat(t, sep)
end

function F:ConvertTable(t)
    local temp = {}
    for k, v in ipairs(t) do
        temp[v] = k
    end
    return temp
end

function F:CheckTableRemoved(previous, after)
    local aa = {}
    local ret = {}

    for k,v in pairs(previous) do aa[v] = true end
    for k,v in pairs(after) do aa[v] = nil end

    for k,v in pairs(previous) do
        if aa[v] then
            tinsert(ret, v)
        end
    end
    return ret
end

-------------------------------------------------
-- general
-------------------------------------------------
function F:GetRealmName()
    return string.gsub(GetRealmName(), " ", "")
end

function F:UnitName(unit)
    if not unit then return "" end

    local name = UnitName(unit)
    if not string.find(name, "-") then name = name .. "-" .. F:GetRealmName() end
    return name
end

function F:GetShortName(fullName)
    if not fullName then return "" end

    local shortName = strsplit("-", fullName)
    return shortName
end

function F:FormatTime(s)
    if s >= 3600 then
        return "%dh", ceil(s / 3600)
    elseif s >= 60 then
        return "%dm", ceil(s / 60)
    end
    return "%ds", floor(s)
end

-------------------------------------------------
-- unit buttons
-------------------------------------------------
function F:IterateAllUnitButtons(func)
    -- solo
    for _, b in pairs(Cell.unitButtons.solo) do
        func(b)
    end
    -- party
    for index, b in pairs(Cell.unitButtons.party) do
        if index ~= "units" then
            func(b)
        end
    end
    -- raid
    for index, header in pairs(Cell.unitButtons.raid) do
        if index ~= "units" then
            for _, b in ipairs(header) do
                func(b)
            end
        end
    end
    -- npc
    for _, b in pairs(Cell.unitButtons.npc) do
        func(b)
    end
    -- arena pet
    for _, b in pairs(Cell.unitButtons.arena) do
        func(b)
    end
end

function F:GetUnitButtonByGUID(guid)
    if not Cell.vars.guid[guid] then return end

    if Cell.vars.groupType == "raid" then
        return Cell.unitButtons.raid.units[Cell.vars.guid[guid]]
    elseif Cell.vars.groupType == "party" then
        return Cell.unitButtons.party.units[Cell.vars.guid[guid]]
    else -- solo
        return Cell.unitButtons.solo[Cell.vars.guid[guid]]
    end
end

function F:UpdateTextWidth(fs, text, width)
    if not text or not width then return end

    if width == "unlimited" then
        fs:SetText(text)
    elseif width[1] == "percentage" then
        local percent = width[2] or 0.75
        local width = fs:GetParent():GetWidth() - 2
        for i = string.utf8len(text), 0, -1 do
            fs:SetText(string.utf8sub(text, 1, i))
            if fs:GetWidth() / width <= percent then
                break
            end
        end
    elseif width[1] == "length" then
        if LOCALE_zhCN then
            if string.len(text) == string.utf8len(text) then -- en
                fs:SetText(string.utf8sub(text, 1, width[3] or width[2]))
            else
                fs:SetText(string.utf8sub(text, 1, width[2]))
            end
        else
            fs:SetText(string.utf8sub(text, 1, width[2]))
        end
    end
end

function F:GetMarkEscapeSequence(index)
    index = index - 1
    local left, right, top, bottom
    local coordIncrement = 64 / 256
    left = mod(index , 4) * coordIncrement
    right = left + coordIncrement
    top = floor(index / 4) * coordIncrement
    bottom = top + coordIncrement
    return string.format("|TInterface\\TargetingFrame\\UI-RaidTargetingIcons:0:0:0:0:64:64:%d:%d:%d:%d|t", left*64, right*64, top*64, bottom*64)
end

-- local scriptObjects = {}
-- local frame = CreateFrame("Frame")
-- frame:RegisterEvent("PLAYER_REGEN_DISABLED")
-- frame:RegisterEvent("PLAYER_REGEN_ENABLED")
-- frame:SetScript("OnEvent", function(self, event)
--     if event == "PLAYER_REGEN_ENABLED" then
--         for _, obj in pairs(scriptObjects) do
--             obj:Show()
--         end
--     else
--         for _, obj in pairs(scriptObjects) do
--             obj:Hide()
--         end
--     end
-- end)
-- function F:SetHideInCombat(obj)
--     tinsert(scriptObjects, obj)
-- end

-------------------------------------------------
-- frame colors
-------------------------------------------------
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
function F:GetClassColor(class)
    if class and class ~= "" then
        if CUSTOM_CLASS_COLORS then
            return CUSTOM_CLASS_COLORS[class].r, CUSTOM_CLASS_COLORS[class].g, CUSTOM_CLASS_COLORS[class].b
        else
            return RAID_CLASS_COLORS[class]:GetRGB()
        end
    else
        return 1, 1, 1
    end
end

function F:GetClassColorStr(class)
    if class and class ~= "" then
        return "|c"..RAID_CLASS_COLORS[class].colorStr
    else
        return "|cffffffff"
    end
end

local function GetPowerColor(unit)
    local r, g, b, t
    -- https://wow.gamepedia.com/API_UnitPowerType
    local powerType, powerToken, altR, altG, altB = UnitPowerType(unit)
    t = powerType

    local info = PowerBarColor[powerToken]
    if powerType == 0 then -- MANA
        info = {r=0, g=.5, b=1} -- default mana color is too dark!
    elseif powerType == 13 then -- INSANITY
        info = {r=.6, g=.2, b=1}
    end

    if info then
        --The PowerBarColor takes priority
        r, g, b = info.r, info.g, info.b
    else
        if not altR then
            -- Couldn't find a power token entry. Default to indexing by power type or just mana if  we don't have that either.
            info = PowerBarColor[powerType] or PowerBarColor["MANA"]
            r, g, b = info.r, info.g, info.b
        else
            r, g, b = altR, altG, altB
        end
    end
    return r, g, b, t
end

function F:GetPowerColor(unit, class)
    local r, g, b, lossR, lossG, lossB, t
    r, g, b, t = GetPowerColor(unit)

    if not Cell.loaded then
        return r, g, b, r*0.2, g*0.2, b*0.2, t
    end
    
    if CellDB["appearance"]["powerColor"][1] == "Power Color (dark)" then
        lossR, lossG, lossB = r, g, b
        r, g, b = r*0.2, g*0.2, b*0.2
    elseif CellDB["appearance"]["powerColor"][1] == "Class Color" then
        r, g, b = F:GetClassColor(class)
        lossR, lossG, lossB = r*0.2, g*0.2, b*0.2
    elseif CellDB["appearance"]["powerColor"][1] == "Custom Color" then
        r, g, b = unpack(CellDB["appearance"]["powerColor"][2])
        lossR, lossG, lossB = r*0.2, g*0.2, b*0.2
    else
        lossR, lossG, lossB = r*0.2, g*0.2, b*0.2
    end
    return r, g, b, lossR, lossG, lossB, t
end

function F:GetHealthColor(percent, r, g, b)
    if not Cell.loaded then
        return r, g, b, r*0.2, g*0.2, b*0.2      
    end

    local barR, barG, barB, lossR, lossG, lossB
    -- bar
    if CellDB["appearance"]["barColor"][1] == "Class Color" then
        barR, barG, barB = r, g, b
    elseif CellDB["appearance"]["barColor"][1] == "Class Color (dark)" then
        barR, barG, barB = r*0.2, g*0.2, b*0.2
    elseif CellDB["appearance"]["barColor"][1] == "Gradient" then
        barR, barG, barB = F:ColorGradient(percent, 1,0,0, 1,0.7,0, 0.7,1,0)
    else
        barR, barG, barB = unpack(CellDB["appearance"]["barColor"][2])
    end
    -- loss
    if CellDB["appearance"]["lossColor"][1] == "Class Color" then
        lossR, lossG, lossB = r, g, b
    elseif CellDB["appearance"]["lossColor"][1] == "Class Color (dark)" then
        lossR, lossG, lossB = r*0.2, g*0.2, b*0.2
    elseif CellDB["appearance"]["lossColor"][1] == "Gradient" then
        lossR, lossG, lossB = F:ColorGradient(percent, 1,0,0, 1,0.7,0, 0.7,1,0)
    else
        lossR, lossG, lossB = unpack(CellDB["appearance"]["lossColor"][2])
    end
    return barR, barG, barB, lossR, lossG, lossB
end

-------------------------------------------------
-- units
-------------------------------------------------
function F:GetUnitsInSubGroup(group)
    local units = {}
    for i = 1, GetNumGroupMembers() do
        -- name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(raidIndex)
        local name, _, subgroup = GetRaidRosterInfo(i)
        if subgroup == group then
            tinsert(units, "raid"..i)
        end
    end
    return units
end

function F:GetPetUnit(playerUnit)
    if Cell.vars.groupType == "party" then
        return "partypet"..strfind(playerUnit, "^party(%d+)$")
    elseif Cell.vars.groupType == "raid" then
        return "raidpet"..strfind(playerUnit, "^raid(%d+)$")
    else
        return "pet"
    end
end

function F:IterateGroupMembers()
    local groupType = IsInRaid() and "raid" or "party"
    local numGroupMembers = GetNumGroupMembers()
    local i = groupType == "party" and 0 or 1

    return function()
        local ret
        if i == 0 and groupType == "party" then
            ret = "player"
        elseif i <= numGroupMembers and i > 0 then
            ret = groupType .. i
        end
        i = i + 1
        return ret
    end
end

function F:GetGroupType()
    if IsInRaid() then
        return "raid"
    elseif IsInGroup() then
        return "party"
    else
        return "solo"
    end
end

function F:UnitInGroup(unit, ignorePets)
    if ignorePets then
        return UnitInParty(unit) or UnitInRaid(unit)
    else
        return UnitPlayerOrPetInParty(unit) or UnitPlayerOrPetInRaid(unit)
    end
end

-- https://wowpedia.fandom.com/wiki/UnitFlag
local OBJECT_AFFILIATION_MINE = 0x00000001
local OBJECT_AFFILIATION_PARTY = 0x00000002
local OBJECT_AFFILIATION_RAID = 0x00000004

function F:IsFriend(unitFlags)
    if not unitFlags then return false end
    return (bit.band(unitFlags, OBJECT_AFFILIATION_MINE) ~= 0) or (bit.band(unitFlags, OBJECT_AFFILIATION_RAID) ~= 0) or (bit.band(unitFlags, OBJECT_AFFILIATION_PARTY) ~= 0)
end

function F:GetTargetUnitInfo()
    if UnitIsUnit("target", "player") then
        return "player", UnitName("player"), select(2, UnitClass("player"))
    elseif UnitIsUnit("target", "pet") then
        return "pet", UnitName("pet")
    end
    if not F:UnitInGroup("target") then return end

    if IsInRaid() then
        for i = 1, GetNumGroupMembers() do
            if UnitIsUnit("target", "raid"..i) then
                return "raid"..i, UnitName("raid"..i), select(2, UnitClass("raid"..i))
            end
            if UnitIsUnit("target", "raidpet"..i) then
                return "raidpet"..i, UnitName("raidpet"..i)
            end
        end
    elseif IsInGroup() then
        for i = 1, GetNumGroupMembers()-1 do
            if UnitIsUnit("target", "party"..i) then
                return "party"..i, UnitName("party"..i), select(2, UnitClass("party"..i))
            end
            if UnitIsUnit("target", "partypet"..i) then
                return "partypet"..i, UnitName("partypet"..i)
            end
        end
    end
end

function F:HasPermission(isPartyMarkPermission)
    if isPartyMarkPermission and IsInGroup() and not IsInRaid() then return true end
    return UnitIsGroupLeader("player") or (IsInRaid() and UnitIsGroupAssistant("player"))
end

-------------------------------------------------
-- LibSharedMedia
-------------------------------------------------
local LSM = LibStub("LibSharedMedia-3.0", true)
function F:GetBarTexture()
    --! update Cell.vars.texture for further use in UnitButton_OnLoad
    if LSM and LSM:IsValid("statusbar", CellDB["appearance"]["texture"]) then
        Cell.vars.texture = LSM:Fetch("statusbar", CellDB["appearance"]["texture"])
    else
        Cell.vars.texture = "Interface\\AddOns\\Cell\\Media\\statusbar.tga"
    end
    return Cell.vars.texture
end

function F:GetFont(font)
    if font and LSM and LSM:IsValid("font", font) then
        return LSM:Fetch("font", font)
    else
        if CellDB["appearance"]["useGameFont"] then
            return GameFontNormal:GetFont()
        else
            return "Interface\\AddOns\\Cell\\Media\\Accidental_Presidency.ttf"
        end
    end
end

local defaultFontName = "Cell ".._G.DEFAULT
local defaultFont
function F:GetFontItems()
    if CellDB["appearance"]["useGameFont"] then
        defaultFont = GameFontNormal:GetFont()
    else
        defaultFont = "Interface\\AddOns\\Cell\\Media\\Accidental_Presidency.ttf"
    end

    local items = {}
    local fonts, fontNames
    
    if LSM then
        fonts, fontNames = F:Copy(LSM:HashTable("font")), F:Copy(LSM:List("font"))
        -- insert default font
        tinsert(fontNames, 1, defaultFontName)
        fonts[defaultFontName] = defaultFont

        for _, name in pairs(fontNames) do
            tinsert(items, {
                ["text"] = name,
                ["font"] = fonts[name],
                -- ["onClick"] = function()
                --     CellDB["appearance"]["font"] = name
                --     Cell:Fire("UpdateAppearance", "font")
                -- end,
            })
        end
    else
        fontNames = {defaultFontName}
        fonts = {[defaultFontName] = defaultFont}

        tinsert(items, {
            ["text"] = defaultFontName,
            ["font"] = defaultFont,
            -- ["onClick"] = function()
            --     CellDB["appearance"]["font"] = defaultFontName
            --     Cell:Fire("UpdateAppearance", "font")
            -- end,
        })
    end
    return items, fonts, defaultFontName, defaultFont 
end

-------------------------------------------------
-- texture
-------------------------------------------------
function F:GetTexCoord(width, height)
    -- ULx,ULy, LLx,LLy, URx,URy, LRx,LRy
    local texCoord = {.12, .12, .12, .88, .88, .12, .88, .88}
    local aspectRatio = width / height

    local xRatio = aspectRatio < 1 and aspectRatio or 1
    local yRatio = aspectRatio > 1 and 1 / aspectRatio or 1

    for i, coord in ipairs(texCoord) do
        local aspectRatio = (i % 2 == 1) and xRatio or yRatio
        texCoord[i] = (coord - 0.5) * aspectRatio + 0.5
    end
    
    return texCoord
end

-------------------------------------------------
-- frame position
-------------------------------------------------
-- function F:SavePosition(frame, pTable)
--     local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint(1)
--     pTable[1], pTable[2], pTable[3], pTable[4] = point, relativePoint, xOfs, yOfs
-- end

-- function F:RestorePosition(frame, pTable)
--     frame:ClearAllPoints()
--     frame:SetPoint(pTable[1], UIParent, pTable[2], pTable[3], pTable[4])
-- end

-------------------------------------------------
-- instance
-------------------------------------------------
function F:GetInstanceName()
    if IsInInstance() then
        local name = GetInstanceInfo()
        if not name then name = GetRealZoneText() end
        return name
    else
        local mapID = C_Map.GetBestMapForUnit("player")
        if type(mapID) ~= "number" or mapID < 1 then
            return ""
        end

        local info = MapUtil.GetMapParentInfo(mapID, Enum.UIMapType.Continent, true)
        if info then
            return info.name, info.mapID
        end

        return ""
    end
end

-------------------------------------------------
-- spell description
-------------------------------------------------
-- https://wow.gamepedia.com/UIOBJECT_GameTooltip
-- local function EnumerateTooltipLines_helper(...)
--     for i = 1, select("#", ...) do
--        local region = select(i, ...)
--        if region and region:GetObjectType() == "FontString" then
--           local text = region:GetText() -- string or nil
--           print(region:GetName(), text)
--        end
--     end
-- end

local lines = {}
function F:GetSpellInfo(spellId)
    wipe(lines)

    local name, _, icon = GetSpellInfo(spellId)
    if not name then return end
    
    CellScanningTooltip:ClearLines()
    CellScanningTooltip:SetHyperlink("spell:"..spellId)
    for i = 2, min(5, CellScanningTooltip:NumLines()) do
        tinsert(lines, _G["CellScanningTooltipTextLeft"..i]:GetText())
    end
    -- CellScanningTooltip:SetOwner(CellOptionsFrame_RaidDebuffsTab, "ANCHOR_RIGHT")
    -- CellScanningTooltip:Show()
    return name, icon, table.concat(lines, "\n")
end