--[[
    common.lua
    A collection of frequently used functions and values!
]]--
require 'origin.common_gen'
require 'what_does_n_stand_for.menu.MemberReturnMenu'
require 'what_does_n_stand_for.common_vars'
print ('Stuff is working')

----------------------------------------
-- Lib Definitions
----------------------------------------
--Reserve the "class" symbol for instantiating classes
 --I'm not seeing this in the diff. Removed?
--Reserve the "Mediator" symbol for instantiating the message lib class
 
--Reserve the "Serpent" symbol for the serializer


LoadGenType = luanet.import_type('RogueEssence.LevelGen.LoadGen')
ChanceFloorGenType = luanet.import_type('RogueEssence.LevelGen.ChanceFloorGen')

----------------------------------------------------------
-- Console Writing
----------------------------------------------------------

--Prints to console!
function PrintInfo(text)
  if DiagManager then 
    DiagManager.Instance:LogInfo( '[SE]:' .. text) 
  else
    print('[SE]:' .. text)
  end
end

--Prints to console!
function PrintError(text)
  if DiagManager then 
    DiagManager.Instance:LogInfo( '[SE]:' .. text) 
  else
    print('[SE](ERROR): ' .. text)
  end
end

--Will print the stack and the specified error message
function PrintStack(err)
  PrintInfo(debug.traceback(tostring(err),2)) 
end

function PrintSVAndStrings(mapstr)
  print("DUMPING SCRIPT VARIABLE STATE..")
  print(Serpent.block(SV))
  print(Serpent.block(mapstr))
  print("-------------------------------")
end

----------------------------------------
-- Common namespace
----------------------------------------


require 'origin.common_talk'
require 'origin.common_shop'

--Automatically load the appropriate localization for the specified package, or defaults to english!
function COMMON.AutoLoadLocalizedStrings()
  PrintInfo("AutoLoading Strings!..")
  --Get the package path
  local packagepath = SCRIPT:CurrentScriptDir()
  
  --After we made the path, load the file
  return STRINGS:MakePackageStringTable(packagepath)
end

function COMMON.GetSortedKeys(dict)
  keys = {}
  for key, _ in pairs(dict) do
    table.insert(keys, key)
  end
  table.sort(keys)
  return keys
end

COMMON.MISSION_TYPE_OUTLAW = 4
COMMON.MISSION_TYPE_EXPLORATION = 5
COMMON.MISSION_TYPE_LOST_ITEM = 6
COMMON.MISSION_TYPE_OUTLAW_ITEM = 7
COMMON.MISSION_TYPE_OUTLAW_FLEE = 8
COMMON.MISSION_TYPE_OUTLAW_MONSTER_HOUSE = 9
COMMON.MISSION_TYPE_DELIVERY = 10

COMMON.MISSION_BOARD_MISSION = 0
COMMON.MISSION_BOARD_OUTLAW = 1
COMMON.MISSION_BOARD_TAKEN = 2

local characters = {
    --Head of Police
    Magnezone = {
        species = "magnezone",
        nickname = 'Magnezone',
        instance = 'Magnezone',
        gender = Gender.Male,
        form = 0,
        skin = "normal"
    },

    Magnemite_Left = {
        species = "magnemite",
        nickname = 'Magnemite',
        instance = 'Magnemite_Left',
        gender = Gender.Male,
        form = 0,
        skin = "normal"
    },

    Magnemite_Right = {
        species = "magnemite",
        nickname = 'Magnemite',
        instance = 'Magnemite_Right',
        gender = Gender.Female,
        form = 0,
        skin = "normal"
    },
}

----------------------------------------------------------
-- Convenience Scription Functions
----------------------------------------------------------
function COMMON.RespawnStarterPartner()
  -- SV.test_grounds.Starter.Gender = LUA_ENGINE:EnumToNumeric(Gender.Female)
  local character = RogueEssence.Dungeon.CharData()
  character.BaseForm = RogueEssence.Dungeon.MonsterID(SV.eontestroom.Starter.Species, SV.eontestroom.Starter.Form, SV.eontestroom.Starter.Skin, LUA_ENGINE:LuaCast(SV.eontestroom.Starter.Gender, Gender))
  GROUND:SetPlayer(character)
  GROUND:RemoveCharacter("Partner")
  local p = RogueEssence.Dungeon.CharData()
  p.BaseForm = RogueEssence.Dungeon.MonsterID(SV.eontestroom.Partner.Species, SV.eontestroom.Partner.Form, SV.eontestroom.Partner.Skin, LUA_ENGINE:LuaCast(SV.eontestroom.Partner.Gender, Gender))
  GROUND:SpawnerSetSpawn("PARTNER_SPAWN", p)
  local chara = GROUND:SpawnerDoSpawn("PARTNER_SPAWN")
end

function COMMON.RespawnAllies()
  GROUND:RefreshPlayer()
  

  local party = GAME:GetPlayerPartyTable()
  local playeridx = GAME:GetTeamLeaderIndex()

  --Place player teammates
  for i = 1,3,1
  do
    GROUND:RemoveCharacter("Teammate" .. tostring(i))
  end
  local total = 1
  for i,p in ipairs(party) do
    if i ~= (playeridx + 1) then --Indices in lua tables begin at 1
      GROUND:SpawnerSetSpawn("TEAMMATE_" .. tostring(total),p)
      local chara = GROUND:SpawnerDoSpawn("TEAMMATE_" .. tostring(total))
      --GROUND:GiveCharIdleChatter(chara)
      total = total + 1
    end
  end
end

function COMMON.ShowTeamAssemblyMenu(obj, init_fun)
  SOUND:PlaySE("Menu/Skip")
  UI:AssemblyMenu()
  UI:WaitForChoice()
  result = UI:ChoiceResult()
  if result then
    GAME:WaitFrames(10)
	SOUND:PlayBattleSE("EVT_Assembly_Bell")
	GROUND:ObjectSetAnim(obj, 6, -1, -1, RogueElements.Dir8.Down, 3)
	GAME:FadeOut(false, 20)
	init_fun()
    GAME:FadeIn(20)
  end
end

function COMMON.ShowDestinationMenu(dungeon_entrances, ground_entrances, force_list, speaker, confirm_msg)  --get dungeons with a taken mission
    local mission_dests = {}

    for i = 1, 8, 1 do
        local zone = SV.TakenBoard[i].Zone
        if zone ~= nil and zone ~= '' and SV.TakenBoard[i].Taken then
            mission_dests[zone] = 1
        end
    end

    local open_dests = {}

    --check for unlock of grounds
    for ii = 1,#ground_entrances,1 do
        if ground_entrances[ii].Flag then
            local ground_id = ground_entrances[ii].Zone
            local zone_summary = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get(ground_id)
            local ground = _DATA:GetGround(zone_summary.Grounds[ground_entrances[ii].ID])
            local ground_name = ground:GetColoredName()
            table.insert(open_dests, { Name=ground_name, Dest=RogueEssence.Dungeon.ZoneLoc(ground_id, -1, ground_entrances[ii].ID, ground_entrances[ii].Entry) })
        end
    end

    --check for unlock of dungeons
    for ii = 1,#dungeon_entrances,1 do
        local zone = dungeon_entrances[ii]
        if GAME:DungeonUnlocked(zone) then
            local zone_summary = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get(zone)
            if zone_summary.Released then
                local zone_name = ""
                if _DATA.Save:GetDungeonUnlock(zone) == RogueEssence.Data.GameProgress.UnlockState.Completed then
                    zone_name = zone_summary:GetColoredName()
                else
                    zone_name = "[color=#00FFFF]"..zone_summary.Name:ToLocal().."[color]"
                end
                if SV.MissionsEnabled then
                    if mission_dests[zone] ~= nil then
                        zone_name = STRINGS:Format("\\uE10F") .. zone_name --open letter
                    elseif COMMON.HasSidequestInZone(zone) then
                        zone_name = STRINGS:Format("\\uE111") .. zone_name --exclamation point
                    end
                end
                table.insert(open_dests, { Name=zone_name, Dest=RogueEssence.Dungeon.ZoneLoc(zone, 0, 0, 0) })
            end
        end
    end

    local dest = RogueEssence.Dungeon.ZoneLoc.Invalid
    if #open_dests > 1 or force_list then
        if before_list ~= nil then
            before_list(dest)
        end

        SOUND:PlaySE("Menu/Skip")
        default_choice = 1
        while true do
            UI:ResetSpeaker()
            UI:DestinationMenu(open_dests, default_choice)
            UI:WaitForChoice()
            default_choice = UI:ChoiceResult()

            if default_choice == nil then
                break
            end
            ask_dest = open_dests[default_choice].Dest
            if ask_dest.StructID.Segment >= 0 then
                --chosen dungeon entry
                if speaker ~= nil then
                    UI:SetSpeaker(speaker)
                else
                    UI:ResetSpeaker(false)
                end
                UI:DungeonChoice(open_dests[default_choice].Name, ask_dest)
                UI:WaitForChoice()
                if UI:ChoiceResult() then
                    dest = ask_dest
                    break
                end
            else
                dest = ask_dest
                break
            end
        end
    elseif #open_dests == 1 then
        if open_dests[1].Dest.StructID.Segment < 0 then
            --single ground entry
            if speaker ~= nil then
                UI:SetSpeaker(speaker)
            else
                UI:ResetSpeaker(false)
                SOUND:PlaySE("Menu/Skip")
            end
            UI:ChoiceMenuYesNo(STRINGS:FormatKey("DLG_ASK_ENTER_GROUND", open_dests[1].Name))
            UI:WaitForChoice()
            if UI:ChoiceResult() then
                dest = open_dests[1].Dest
            end
        else
            --single dungeon entry
            if speaker ~= nil then
                UI:SetSpeaker(speaker)
            else
                UI:ResetSpeaker(false)
                SOUND:PlaySE("Menu/Skip")
            end
            UI:DungeonChoice(open_dests[1].Name, open_dests[1].Dest)
            UI:WaitForChoice()
            if UI:ChoiceResult() then
                dest = open_dests[1].Dest
            end
        end
    else
        PrintInfo("No valid destinations found!")
    end

    if dest:IsValid() then
        if confirm_msg ~= nil then
            UI:WaitShowDialogue(confirm_msg)
        end
        if dest.StructID.Segment > -1 then
            --pre-loads the zone on a separate thread while we fade out, just for a little optimization
            _DATA:PreLoadZone(dest.ID)
            SOUND:PlayBGM("", true)
            GAME:FadeOut(false, 20)
            GAME:EnterDungeon(dest.ID, dest.StructID.Segment, dest.StructID.ID, dest.EntryPoint, RogueEssence.Data.GameProgress.DungeonStakes.Risk, true, false)
        else
            SOUND:PlayBGM("", true)
            GAME:FadeOut(false, 20)
            GAME:EnterZone(dest.ID, dest.StructID.Segment, dest.StructID.ID, dest.EntryPoint)
        end
    end
end

function COMMON.LearnMoveFlow(member, move, replace_msg)
 		UI:WaitForChoice()
 		local result = UI:ChoiceResult()
 		if result > -1 and result < 4 then
			GAME:SetCharacterSkill(member, move, result, _DATA.Save:GetDefaultEnable(move))
 			return true
 		end
 	end

function COMMON.CreateWalkArea(name, x, y, w, h)

  --Set Char AI
  local chara = CH(name)
  if chara == nil then
    return
  end
  --Set the area to wander in
  AI:SetCharacterAI(chara,                                      --[[Entity that will use the AI]]--
                    "what_does_n_stand_for.ai.ground_default",                         --[[Class path to the AI class to use]]--
                    RogueElements.Loc(x, y), --[[Top left corner pos of the allowed idle wander area]]--
                    RogueElements.Loc(w, h), --[[Width and Height of the allowed idle wander area]]--
                    1,                                         --[[Wandering speed]]--
                    16,                                          --[[Min move distance for a single wander]]--
                    32,                                          --[[Max move distance for a single wander]]--
                    40,                                         --[[Min delay between idle actions]]--
                    180)                                        --[[Max delay between idle actions]]--
  --chara:EnableCharacterAI(chara)
end

function COMMON.MakeWhoosh(center, y, tier, reversed)
    local whoosh1 = RogueEssence.Content.FiniteOverlayEmitter()
    whoosh1.FadeIn = 30
    whoosh1.TotalTime = 90
    whoosh1.RepeatX = true
	if reversed then
		whoosh1.Movement = RogueElements.Loc(-360, 0)
	else
		whoosh1.Movement = RogueElements.Loc(360, 0)
	end
    whoosh1.Layer = DrawLayer.Top
    whoosh1.Anim = RogueEssence.Content.BGAnimData("Pre_Battle", 1, tier, tier)
	GROUND:PlayVFX(whoosh1, center.X, center.Y + y)
end

function COMMON.BossTransition()
    local center = GAME:GetCameraCenter()
    SOUND:FadeOutBGM(20)
    local emitter = RogueEssence.Content.FlashEmitter()
    emitter.FadeInTime = 2
    emitter.HoldTime = 2
    emitter.FadeOutTime = 2
    emitter.StartColor = Color(0, 0, 0, 0)
    emitter.Layer = DrawLayer.Top
    emitter.Anim = RogueEssence.Content.BGAnimData("White", 0)
    GROUND:PlayVFX(emitter, center.X, center.Y)
    SOUND:PlayBattleSE("EVT_Battle_Flash")
    GAME:WaitFrames(16)
    GROUND:PlayVFX(emitter, center.X, center.Y)
    SOUND:PlayBattleSE("EVT_Battle_Flash")
    GAME:WaitFrames(46)
    
    SOUND:PlayBattleSE('EVT_Battle_Transition')
	COMMON.MakeWhoosh(center, -32, 0, false)
    GAME:WaitFrames(5)
	COMMON.MakeWhoosh(center, -64, 0, true)
	COMMON.MakeWhoosh(center, 0, 0, true)
    GAME:WaitFrames(5)
	COMMON.MakeWhoosh(center, -112, 1, false)
	COMMON.MakeWhoosh(center, 48, 1, false)
    GAME:WaitFrames(5)
	COMMON.MakeWhoosh(center, -144, 2, true)
	COMMON.MakeWhoosh(center, 80, 2, true)
    GAME:WaitFrames(5)
	COMMON.MakeWhoosh(center, -176, 3, false)
	COMMON.MakeWhoosh(center, 112, 3, false)
    GAME:WaitFrames(40)
    GAME:FadeOut(true, 30)
    GAME:WaitFrames(80)
	
	
    --GAME:FadeIn(20) --Did not disable this at all, even when the new update came out.
end

function COMMON.GiftItem(player, receive_item)
  COMMON.GiftItemFull(player, receive_item, true, false)
end

function COMMON.GiftItemFull(player, receive_item, fanfare, force_storage)
  if fanfare then
    SOUND:PlayFanfare("Fanfare/Item")
  end
  UI:ResetSpeaker(false)
  UI:SetCenter(true)
  if not force_storage and GAME:GetPlayerBagCount() + GAME:GetPlayerEquippedCount() < GAME:GetPlayerBagLimit() then
    --give to inventory
	UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_RECEIVE_ITEM"):ToLocal(), player:GetDisplayName(), receive_item:GetDisplayName()))
	GAME:GivePlayerItem(receive_item)
  else
    --give to storage
	UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_RECEIVE_ITEM_STORAGE"):ToLocal(), player:GetDisplayName(), receive_item:GetDisplayName()))
	GAME:GivePlayerStorageItem(receive_item)
  end
  UI:SetCenter(false)
  UI:ResetSpeaker()
end


function COMMON.UnlockWithFanfare(dungeon_id, from_dungeon)
  if not GAME:DungeonUnlocked(dungeon_id) then
    if from_dungeon then
      UI:ResetSpeaker()
      UI:SetCenter(true)
      UI:WaitShowDialogue(STRINGS:FormatKey("DLG_NEW_AREA_TO"))
	end
    GAME:UnlockDungeon(dungeon_id)
    UI:ResetSpeaker(false)
	UI:SetCenter(true)
	local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get(dungeon_id)
    SOUND:PlayFanfare("Fanfare/NewArea")
    UI:WaitShowDialogue(STRINGS:FormatKey("DLG_NEW_AREA", zone:GetColoredName()))
    UI:SetCenter(false)
    UI:ResetSpeaker()
  end

end

function COMMON.ClearPlayerPrices()
  local item_count = GAME:GetPlayerBagCount()
  for item_idx = 0, item_count-1, 1 do
    local inv_item = GAME:GetPlayerBagItem(item_idx)
	inv_item.Price = 0
  end
  local player_count = _DUNGEON.ActiveTeam.Players.Count
  for player_idx = 0, player_count-1, 1 do
    local inv_item = GAME:GetPlayerEquippedItem(player_idx)
	inv_item.Price = 0
  end
  
  COMMON.ClearMapTeamPrices(_ZONE.CurrentMap.AllyTeams)
  COMMON.ClearMapTeamPrices(_ZONE.CurrentMap.MapTeams)
end

function COMMON.ClearMapTeamPrices(team_list)

  local team_count = team_list.Count
  for team_idx = 0, team_count-1, 1 do
	local player_count = team_list[team_idx].Players.Count
	for player_idx = 0, player_count-1, 1 do
      local inv_item = team_list[team_idx].Players[player_idx].EquippedItem
	  inv_item.Price = 0
	end
  end
end

function COMMON.ClearAllPrices()
  COMMON.ClearPlayerPrices()

  -- clear map prices
  local item_count = _ZONE.CurrentMap.Items.Count
  for item_idx = 0, item_count-1, 1 do
    local map_item = _ZONE.CurrentMap.Items[item_idx]
	map_item.Price = 0
  end
end

function COMMON.PayDungeonCartPrice(price)
  COMMON.ClearPlayerPrices()
  
  -- clear map prices if not on mat
  local item_count = _ZONE.CurrentMap.Items.Count
  for item_idx = 0, item_count-1, 1 do
    local map_item = _ZONE.CurrentMap.Items[item_idx]
	if map_item.Price > 0 then
	  local tile = _ZONE.CurrentMap.Tiles[map_item.TileLoc.X][map_item.TileLoc.Y]
	  -- only subtract price if on shop mat
	  if tile.Effect.ID ~= "area_shop" then
	    map_item.Price = 0
	  end
	end
  end
  
  GAME:RemoveFromPlayerMoney(price)
  
  local security_price = COMMON.GetShopPriceState()
  security_price.Amount = security_price.Amount - price
  security_price.Cart = 0
end

function COMMON.PayDungeonSellPrice(price)
  -- set prices for all items placed on the shop
  local item_count = _ZONE.CurrentMap.Items.Count
  for item_idx = 0, item_count-1, 1 do
    local map_item = _ZONE.CurrentMap.Items[item_idx]
	-- they should not already have a price
	if map_item.Price <= 0 then
	  local sell_value = map_item:GetSellValue()
	  -- they should have value as sold items
	  if sell_value > 0 then
	    local tile = _ZONE.CurrentMap.Tiles[map_item.TileLoc.X][map_item.TileLoc.Y]
	    -- only add price if on shop mat
	    if tile.Effect.ID == "area_shop" then
	      map_item.Price = sell_value * 2
	    end
	  end
	end
  end
  
  GAME:AddToPlayerMoney(price)
  local security_price = COMMON.GetShopPriceState()
  security_price.Amount = security_price.Amount + price * 2
end

ShopPriceType = luanet.import_type('PMDC.Dungeon.ShopPriceState')
function COMMON.GetShopPriceState()
  local security_status = "shop_security"
  local status = _DUNGEON:GetMapStatus(security_status)
  if status then
	if status.StatusStates:Contains(luanet.ctype(ShopPriceType)) then
	  return status.StatusStates:Get(luanet.ctype(ShopPriceType))
	end
  end
  return nil
end

function COMMON.GetDungeonCartPrice()

  local price = 0
  local security_price = COMMON.GetShopPriceState()
  price = security_price.Amount
  
  -- iterate items on shop mats and subtract total price
  local item_count = _ZONE.CurrentMap.Items.Count
  for item_idx = 0, item_count-1, 1 do
    local map_item = _ZONE.CurrentMap.Items[item_idx]
	if map_item.Price > 0 then
	  local tile = _ZONE.CurrentMap.Tiles[map_item.TileLoc.X][map_item.TileLoc.Y]
	  -- only subtract price if on shop mat
	  if tile.Effect.ID == "area_shop" then
	    price = price - map_item.Price
	  end
	end
  end
  return price
end

function COMMON.GetDungeonSellPrice()

  local price = 0
  -- iterate items on shop mats and add total price
  local item_count = _ZONE.CurrentMap.Items.Count
  for item_idx = 0, item_count-1, 1 do
    local map_item = _ZONE.CurrentMap.Items[item_idx]
	-- they should not already have a price
	if map_item.Price <= 0 then
	  local sell_value = map_item:GetSellValue()
	  -- they should have value as sold items
	  if sell_value > 0 then
	    local tile = _ZONE.CurrentMap.Tiles[map_item.TileLoc.X][map_item.TileLoc.Y]
	    -- only add price if on shop mat
	    if tile.Effect.ID == "area_shop" then
	      price = price + sell_value
	    end
	  end
	end
  end
  return price
end


function COMMON.ThiefReturn()
  _GAME:BGM("", false)
  COMMON.ClearAllPrices()
  
  local thief_check_idx = "shop_security"
  local thief_idx = "thief"
  local check_status = _DUNGEON:GetMapStatus(thief_check_idx)
  
  local index_from = check_status.StatusStates:Get(luanet.ctype(MapIndexType))
  UI:WaitShowDialogue(RogueEssence.StringKey(string.format("TALK_SHOP_SUSPECT_%04d", index_from.Index)):ToLocal())
  _DUNGEON:LogMsg(RogueEssence.StringKey(string.format("TALK_SHOP_THIEF_RETURN_%04d", index_from.Index)):ToLocal())
  
  local thief_status = RogueEssence.Dungeon.MapStatus(thief_idx)
  thief_status:LoadFromData()
  -- put spawner from security status in thief status
  local security_to = thief_status.StatusStates:Get(luanet.ctype(ShopSecurityType))
  local security_from = check_status.StatusStates:Get(luanet.ctype(ShopSecurityType))
  security_to.Security = security_from.Security
  TASK:WaitTask(_DUNGEON:RemoveMapStatus(thief_check_idx))
  TASK:WaitTask(_DUNGEON:AddMapStatus(thief_status))
  GAME:WaitFrames(60)
end

function COMMON.ShopTileCheck(baseLoc, dir)
  local dirLoc = RogueElements.DirExt.GetLoc(dir)
  local loc = RogueElements.Loc(baseLoc.X + dirLoc.X, baseLoc.Y + dirLoc.Y)
  if not RogueElements.Collision.InBounds(_ZONE.CurrentMap.Width, _ZONE.CurrentMap.Height, loc) then
    return false
  end
  return (_ZONE.CurrentMap.Tiles[loc.X][loc.Y].Effect.ID == "area_shop")
end



function COMMON.FindNpcWithTable(foes, key, value)
  local team_list = _ZONE.CurrentMap.AllyTeams
  if foes then
    team_list = _ZONE.CurrentMap.MapTeams
  end
  local team_count = team_list.Count
  for team_idx = 0, team_count-1, 1 do
	-- search for a wild mon with the table value
	local player_count = team_list[team_idx].Players.Count
	for player_idx = 0, player_count-1, 1 do
	  player = team_list[team_idx].Players[player_idx]
	  local player_tbl = LTBL(player)
	  if player_tbl[key] == value then
		return player
	  end
	end
  end
  return nil
end

function COMMON.CanTalk(chara)
  if chara:GetStatusEffect("sleep") ~= nil then
    return false
  end
  if chara:GetStatusEffect("freeze") ~= nil then
    return false
  end
  if chara:GetStatusEffect("confuse") ~= nil then
    return false
  end
  return true
end


function COMMON.DungeonInteract(chara, target, action_cancel, turn_cancel)
  action_cancel.Cancel = true
  -- TODO: create a charstate for being unable to talk and have talk-interfering statuses cause it
  if COMMON.CanTalk(target) then
    
    local ratio = target.HP * 100 // target.MaxHP
    
    local mon = _DATA:GetMonster(target.BaseForm.Species)
    local form = mon.Forms[target.BaseForm.Form]
    
    UI:SetSpeaker(target)
  
    local personality = form:GetPersonalityType(target.Discriminator)
    
    local personality_group = COMMON.PERSONALITY[personality]
    local pool = {}
    local key = ""
    if ratio <= 25 then
      UI:SetSpeakerEmotion("Pain")
      pool = personality_group.PINCH
      key = "TALK_PINCH_%04d"
    elseif ratio <= 50 then
      UI:SetSpeakerEmotion("Worried")
      pool = personality_group.HALF
      key = "TALK_HALF_%04d"
    else
      pool = personality_group.FULL
      key = "TALK_FULL_%04d"
    end
    
    local running_pool = {table.unpack(pool)}
    local valid_quote = false
    local chosen_quote = ""
    
    while not valid_quote and #running_pool > 0 do
      valid_quote = true
      local chosen_idx = math.random(1, #running_pool)
  	  local chosen_pool_idx = running_pool[chosen_idx]
      chosen_quote = RogueEssence.StringKey(string.format(key, chosen_pool_idx)):ToLocal()
  	
      chosen_quote = string.gsub(chosen_quote, "%[player%]", chara:GetDisplayName(true))
      chosen_quote = string.gsub(chosen_quote, "%[myname%]", target:GetDisplayName(true))
      
      if string.find(chosen_quote, "%[move%]") then
        local moves = {}
  	    for move_idx = 0, 3 do
  	      if target.BaseSkills[move_idx].SkillNum ~= "" then
  	        table.insert(moves, target.BaseSkills[move_idx].SkillNum)
  	      end
  	    end
  	    if #moves > 0 then
  	      local chosen_move = _DATA:GetSkill(moves[math.random(1, #moves)])
  	      chosen_quote = string.gsub(chosen_quote, "%[move%]", chosen_move:GetIconName())
  	    else
  	      valid_quote = false
  	    end
      end
      
      if string.find(chosen_quote, "%[kind%]") then
  	    if GAME:GetCurrentFloor().TeamSpawns.CanPick then
          local team_spawn = GAME:GetCurrentFloor().TeamSpawns:Pick(GAME.Rand)
  	      local chosen_list = team_spawn:ChooseSpawns(GAME.Rand)
  	      if chosen_list.Count > 0 then
  	        local chosen_mob = chosen_list[math.random(0, chosen_list.Count-1)]
  	        local mon = _DATA:GetMonster(chosen_mob.BaseForm.Species)
            chosen_quote = string.gsub(chosen_quote, "%[kind%]", mon:GetColoredName())
  	      else
  	        valid_quote = false
  	      end
  	    else
  	      valid_quote = false
  	    end
      end
      
      if string.find(chosen_quote, "%[item%]") then
        if GAME:GetCurrentFloor().ItemSpawns.CanPick then
          local item = GAME:GetCurrentFloor().ItemSpawns:Pick(GAME.Rand)
          chosen_quote = string.gsub(chosen_quote, "%[item%]", item:GetDisplayName())
  	    else
  	      valid_quote = false
  	    end
      end
  	
  	  if not valid_quote then
        -- PrintInfo("Rejected "..chosen_quote)
  	    table.remove(running_pool, chosen_idx)
  	    chosen_quote = ""
  	  end
    end
    -- PrintInfo("Selected "..chosen_quote)
	
	local oldDir = target.CharDir
    DUNGEON:CharTurnToChar(target, chara)
  
    UI:WaitShowDialogue(chosen_quote)
  
    target.CharDir = oldDir
  else
  
    UI:ResetSpeaker()
	
	local chosen_quote = RogueEssence.StringKey("TALK_CANT"):ToLocal()
    chosen_quote = string.gsub(chosen_quote, "%[myname%]", target:GetDisplayName(true))
	
    UI:WaitShowDialogue(chosen_quote)
  
  end
  
  --characters can comment on:

  --flavour for the dungeon (talk about the area and its lore)
  --being able to evolve
  --nearly reaching the end of the dungeon
  --being hungry
  --out of PP
  --being able to recruit someone
  --tutorial tips
  ---gaining EXP while in assembly
  ---apricorns
  ---sleeping pokemon
  --commenting on how long they've been on the team
  ---I know we just met, but...
  ---We've been together for over 10 floors now, don't leave me now!
  --beginning a fight "do you think we can take them?"
  --upon recruitment "explore the world, you say?  I'm in!" "yay, friends!" "fine, I'll come with you.  just don't slow me down" "oh my... you smell heavenly.  can I come with you?"
  --"you look tasty- I mean X, can I come with you?", "Team X, huh?  I like the sound of that!", "you lot seem smart/wise, I think you have what it takes to reach the top."
  --when/after someone faints "X isn't with us anymore... but we have to keep going."
  --"if you faint as the leader, I'll gladly take your place."
  --specific personalities for mechanical creatures
  --specific personalities for childish creatures
  --verbal tics (chirp/tweet, meow, woof/arf, squeak, pika)
  --third-person dialogue
  --burned "ow, ow ,ow!  hot, hot!, hot!"
  --paralyzed "I can't feel my legs..." (check body type for this)
  --when there's only 2 members left, and no means to summon more recruits "we're the only ones left." "come on!  we can't give up!"
  --"I wonder what [fainted mon] would've done..."
  --lore on the legendary guildmasters
  ---
  --the rise of recent disasters- mystery dungeons
  --the guildmaster's treasures?
  --a challenge that no one has passed yet; people stopped bothering
  --but as the disasters appear, the pokemon begin to search for a leader
  --At low HP: "X's resolve is being tested..."
  --isn't my fur just luxurious? (vain personality)
  --first priority is for phrases that occur at each break point
  --would you like to hear a song? (if knows sing, round, or perish song)
  --"so it's just us now, huh?" (two pokemon, one or more has fainted)
  --We're going to be okay, right?  Tell me we're going to be okay.
  --Hey... if I don't make it out of here, tell (assembly mon) I love her.
  --talk about how one of their moves is a type, and it will be super-effective on an enemy found on the floor
  --rumors spread of a treasure in a dangerous location
  ----actually a trap; an ambush spot
  --My body wasn't ready for this...
  --Hey, what is it like to have arms?
  --That Red apricorn you have there.  We can use it to recruit a Fire-type Pokemon.
  --Let's find a strong Fire-type Pokemon to give that Red Apricorn to.
  --That Oran Berry we just picked up should help us in a pinch.
  --Those Mankeys are fighting-type Pokemon.  We should hit them with Flying type moves!
  --So why are you in this exploration? [Treasure][Meet Pokemon][Guildmaster][I dunno]
  --To set foot in this dungeon... you're either very brave, or foolhardy.
  --I've gotta hand it to you. Not many Exploration teams make it this far.
  --Too bad I don't have any hands.
  --You know what's weird?  We've been talking all this time and those (visible Pokemon) over there haven't made a single step towards us.  Do you think they're just that polite?
  --I don't like the look that (enemy pokemon) is giving me...
  --But enough talk, we need to get to the next floor.
  --But enough talk, we've got a situation here! (if multiple enemies are in sight)
  --Anyways, we need to keep moving.
  --Finally!  The stairs! (cheer when the stairs come into view, and load this dialogue up in time)
  --sleep
  --"Zzz...[pause=0] another five minutes please..."
  --"Zzz...[pause=10] Zzz..."
  --decoy
  --"...What?"
  --"...What's a \"decoy\"?"
  --"Do I look like I know what a \"decoy\" is?"
  --"Hey Einstein, I'm on your side!"
  --"Is there something on my face?"

  --evolve
  --"Hey, I think I'm ready to evolve now!"
  --"Hey, I think I can evolve into a {0} now!"
  --"I sense something... getting ready to evolve now"
  --"Did you know?  I'm ready to evolve now!"
  --"What should I evolve into?  Any ideas?"
  --"Oh, I just can't wait till I evolve!"
  --"I'm getting excited just thinking about it!"
  --"I swear to god when I evolve, I am going to kill you all!"

  --"Let's make it all the way to the end!"
  --"I wanna be...[pause=0]\nthe very best..."
  --"You teach me, and I'll teach you."
  --"I'll rescue you and if I do you gotta rescue me."
  --"Who should we recruit next?"
  --"Some apricorns can only recruit certain types of Pokémon.[pause=0] You know that, yes?"
  --"Rumor has it that whoever reaches the summit will be given the title of Guildmaster."
  --"So why do they call you the {0} Pokémon?", DataManager.Instance.GetMonster(character.BaseForm.Species).Title.ToLocal()

  --"Press {0} if you want me to lead the team.", (ii + 1).ToString()
  --"press 1 if you feel bad for [fainted mon]"

  
end

function COMMON.ShowTeamStorageMenu()
  UI:ResetSpeaker()
  
  local state = 0
  
  while state > -1 do
    
	local has_items = GAME:GetPlayerBagCount() + GAME:GetPlayerEquippedCount() > 0
	local has_storage = GAME:GetPlayerStorageCount() > 0
	
	
	local storage_choices = { { STRINGS:FormatKey('MENU_STORAGE_STORE'), has_items},
	{ STRINGS:FormatKey('MENU_STORAGE_TAKE_ITEM'), has_storage},
	{ STRINGS:FormatKey('MENU_STORAGE_STORE_ALL'), has_items},
	{ STRINGS:FormatKey("MENU_STORAGE_MONEY"), true},
	{ STRINGS:FormatKey("MENU_CANCEL"), true}}
	UI:BeginChoiceMenu(STRINGS:FormatKey('DLG_WHAT_DO'), storage_choices, 1, 5)
	UI:WaitForChoice()
	local result = UI:ChoiceResult()
	
	if result == 1 then
	  UI:StorageMenu()
	  UI:WaitForChoice()
	elseif result == 2 then
	  UI:WithdrawMenu()
	  UI:WaitForChoice()
    elseif result == 3 then
	    UI:ChoiceMenuYesNo(STRINGS:FormatKey('DLG_STORE_ALL_CONFIRM'), false);
	    UI:WaitForChoice()
	    if UI:ChoiceResult() then
	         GAME:DepositAll()
	    end
	elseif result == 4 then
	  UI:BankMenu()
	  UI:WaitForChoice()
	
	elseif result == 5 then
	  state = -1
	end
	
  end
  
end

function COMMON.GroundInteract(chara, target)
  GROUND:CharTurnToChar(target, chara)
  UI:SetSpeaker(target)
  
  local mon = _DATA:GetMonster(target.CurrentForm.Species)
  local form = mon.Forms[target.CurrentForm.Form]
  
  local personality = form:GetPersonalityType(target.Data.Discriminator)
  
  local personality_group = COMMON.PERSONALITY[personality]
  local pool = personality_group.WAIT
  local key = "TALK_WAIT_%04d"
  
  local running_pool = {table.unpack(pool)}
  local valid_quote = false
  local chosen_quote = ""
  
  while not valid_quote and #running_pool > 0 do
    valid_quote = true
    local chosen_idx = math.random(1, #running_pool)
	local chosen_pool_idx = running_pool[chosen_idx]
    chosen_quote = RogueEssence.StringKey(string.format(key, chosen_pool_idx)):ToLocal()
	
    chosen_quote = string.gsub(chosen_quote, "%[hero%]", chara:GetDisplayName())
    
	if not valid_quote then
      -- PrintInfo("Rejected "..chosen_quote)
	  table.remove(running_pool, chosen_idx)
	  chosen_quote = ""
	end
  end
  -- PrintInfo("Selected "..chosen_quote)
  
  
  UI:WaitShowDialogue(chosen_quote)
end

function COMMON.Rescued(zone, name, mail)
  

  if _DATA.CurrentReplay ~= nil then
    SOUND:PlayBattleSE("EVT_Title_Intro")
    GAME:FadeOut(true, 0)
    GAME:FadeIn(20)
    SOUND:PlayBGM("C05. Rescue.ogg", true)
	_DUNGEON:LogMsg(STRINGS:FormatKey("MSG_RESCUED_BY", name))
  else
                --//spawn the rescuers based on mail
    local leaderLoc = null;

    local team = RogueEssence.Dungeon.ExplorerTeam()
    team.Name = mail.RescuedBy

                --for (int ii = 0; ii < mail.RescuingTeam.Length; ii++)
                --{
                --    CharData character = new CharData();
                --    character.BaseForm = mail.RescuingTeam[ii];
                --    character.Nickname = mail.RescuingNames[ii];
                --    character.Level = 1;

                --    Character new_mob = new Character(character, team);

                --    Loc? destLoc = ZoneManager.Instance.CurrentMap.GetClosestTileForChar(new_mob, leaderLoc.HasValue ? leaderLoc.Value : ActiveTeam.Leader.CharLoc);

                --    if (destLoc == null)
                --        break;

                --    leaderLoc = destLoc;

                --    team.Players.Add(new_mob);
                --    new_mob.CharLoc = destLoc.Value;
                --    new_mob.CharDir = DirExt.ApproximateDir8(ActiveTeam.Leader.CharLoc - destLoc.Value);
                --    AITactic tactic = DataManager.Instance.GetAITactic(0);
                --    new_mob.Tactic = new AITactic(tactic);
                --}
                --ZoneManager.Instance.CurrentMap.MapTeams.Add(team);

                --//foreach (Character member in team.Players)
                --//    member.RefreshTraits();

    SOUND:PlayBattleSE("EVT_Title_Intro")
    GAME:FadeOut(true, 0)
    GAME:FadeIn(20)
                --yield return CoroutineManager.Instance.StartCoroutine(GameManager.Instance.FadeIn());

    SOUND:PlayBGM("C05. Rescue.ogg", true)
    TASK:WaitTask(_MENU:SetDialogue(STRINGS:FormatKey("MSG_RESCUES_LEFT", _DATA.Save.RescuesLeft)))
    GAME:WaitFrames(10)
  


                --//TODO: make the rescuers talk
                --yield return CoroutineManager.Instance.StartCoroutine(MenuManager.Instance.SetDialogue(team.Leader.Appearance, team.Leader:GetDisplayName(true), new EmoteStyle(Emotion.Normal), true, Text.Format("{0}, right?", ActiveTeam:GetDisplayName())));
                --yield return CoroutineManager.Instance.StartCoroutine(MenuManager.Instance.SetDialogue(team.Leader.Appearance, team.Leader:GetDisplayName(true), new EmoteStyle(Emotion.Normal), true, Text.Format("Glad we could make it! We got your SOS just in time!")));
                --yield return CoroutineManager.Instance.StartCoroutine(MenuManager.Instance.SetDialogue(team.Leader.Appearance, team.Leader:GetDisplayName(true), new EmoteStyle(Emotion.Normal), true, Text.Format("It's all in a day's work for {0}!", team:GetDisplayName())));
                --yield return CoroutineManager.Instance.StartCoroutine(MenuManager.Instance.SetDialogue(team.Leader.Appearance, team.Leader:GetDisplayName(true), new EmoteStyle(Emotion.Normal), true, Text.Format("Good luck, the rest is up to you!")));

                --//warp them out

                --for (int ii = team.Players.Count - 1; ii >= 0; ii--)
                --{
                --    GameManager.Instance.BattleSE("DUN_Send_Home");
                --    SingleEmitter emitter = new SingleEmitter(new BeamAnimData("Column_Yellow", 3));
                --    emitter.Layer = DrawLayer.Front;
                --    emitter.SetupEmit(team.Players[ii].MapLoc, team.Players[ii].MapLoc, team.Players[ii].CharDir);
                --    CreateAnim(emitter, DrawLayer.NoDraw);
                --    yield return CoroutineManager.Instance.StartCoroutine(team.Players[ii].DieSilent());
                --    yield return new WaitForFrames(20);
                --}
                --RemoveDeadTeams();
  end
  
  local rescue_idx = "rescued"
  local rescue_status = RogueEssence.Dungeon.MapStatus(rescue_idx)
  rescue_status:LoadFromData()
  TASK:WaitTask(_DUNGEON:AddMapStatus(rescue_status))
end

function COMMON.EndRescue(zone, result, rescue, segmentID)
  COMMON.EndDayCycle()
  local zoneId = 'guildmaster_island'
  local structureId = -1
  local mapId = 12
  local entryId = 1
  GAME:EndDungeonRun(result, zoneId, structureId, mapId, entryId, true, true)
  SV.General.Rescue = result
  GAME:EnterZone(zoneId, structureId, mapId, entryId)
end

function COMMON.BeginDungeon(zoneId, segmentID, mapId)
  COMMON.EnterDungeonMissionCheck(zoneId, segmentID)
end

function COMMON.EnterDungeonMissionCheck(zoneId, segmentID)
    for name, mission in pairs(SV.TakenBoard) do
        if mission.Taken and mission.Completion == COMMON.MISSION_INCOMPLETE and zoneId == mission.Zone and mission.Client ~= "" then
            if mission.Type == COMMON.MISSION_TYPE_ESCORT or mission.Type == COMMON.MISSION_TYPE_EXPLORATION then -- escort
                -- add escort to team
                local player_count = GAME:GetPlayerPartyCount()
                local guest_count = GAME:GetPlayerGuestCount()

                --check to see if an escort is already in the team. If so, stop right here and don't assign him back in.
                for i = 0, guest_count - 1, 1 do
                    local guest_tbl = LTBL(GAME:GetPlayerGuestMember(i))
                    if guest_tbl.Escort ~= nil then return end
                end

                if player_count + guest_count >= 4 then
                    SOUND:StopBGM()
                    local state = 0
                    while state > -1 do
                        UI:ResetSpeaker()
                        UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("MISSION_ESCORT_REPLACE"):ToLocal(), _DATA:GetMonster(mission.Client):GetColoredName()))
                        local MemberReturnMenu = CreateMemberReturnMenu()
                        local menu = MemberReturnMenu:new()
                        UI:SetCustomMenu(menu.menu)
                        UI:WaitForChoice()
                        local member = menu.members[menu.current_item]
                        UI:ChoiceMenuYesNo(STRINGS:Format(RogueEssence.StringKey("MISSION_ESCORT_REPLACE_ASK"):ToLocal(), member:GetDisplayName(true)), false)
                        UI:WaitForChoice()

                        local send_home = UI:ChoiceResult()
                        if send_home then
                            local slot = menu.slots[menu.current_item]
                            GAME:AddPlayerAssembly(member);
                            GAME:RemovePlayerTeam(slot)
                            state = -1
                        end
                    end
                end

                --Set max team size to 3 as the guest is "taking" up a party slot
                RogueEssence.Dungeon.ExplorerTeam.MAX_TEAM_SLOTS = 3

                local mon_id = RogueEssence.Dungeon.MonsterID(mission.Client, 0, "normal", COMMON.NumToGender(mission.ClientGender))
                -- set the escort level 20% less than the expected level
                local level = math.floor(SV.ExpectedLevel[mission.Zone] * 0.80)
                local new_mob = _DATA.Save.ActiveTeam:CreatePlayer(_DATA.Save.Rand, mon_id, level, "", -1)
                local tactic = _DATA:GetAITactic("stick_together")
                new_mob.Tactic = RogueEssence.Data.AITactic(tactic);
                _DATA.Save.ActiveTeam.Guests:Add(new_mob)
                local talk_evt = RogueEssence.Dungeon.BattleScriptEvent("EscortInteract")
                new_mob.ActionEvents:Add(talk_evt)

                local tbl = LTBL(new_mob)
                tbl.Escort = name
                
                UI:ResetSpeaker()
                UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("MISSION_ESCORT_ADD"):ToLocal(), new_mob.Name))
            end
        end
    end
end

function COMMON.NumToGender(num)
    local res = Gender.Unknown
    if num == 0 then
        res = Gender.Genderless
    elseif num == 1 then
        res = Gender.Male
    elseif num == 2 then
        res = Gender.Female
    end
    return res
end

function COMMON.ExitDungeonMissionCheck(zoneId, segmentID)
  for name, mission in pairs(SV.missions.Missions) do
    PrintInfo("Checking Mission: "..tostring(name))
	if mission.Complete == 0 and zoneId == mission.DestZone and segmentID == mission.DestSegment then
	  if mission.Type == 1 then -- escort
	    -- remove the escort from the party
		local escort = COMMON.FindMissionEscort(name)
		if escort then
		  _DUNGEON:RemoveChar(escort)
		end
	  end
	end
  end
end

COMMON.ADAMBOOK_SELECTING = 0
COMMON.ADAMBOOK_READING = 1

function COMMON.FindMissionEscort(missionId)
  local escort = nil
  PrintInfo("Name: "..missionId)
  local party = GAME:GetPlayerGuestTable()
  for i, p in ipairs(party) do
    local e_tbl = LTBL(p)
	PrintInfo("Escort: "..e_tbl.Escort)
	if e_tbl.Escort == missionId then
	  escort = p
	  break
	end
  end
  return escort
end

function COMMON.ResetAnims()
    local player_count = GAME:GetPlayerPartyCount()
    local guest_count = GAME:GetPlayerGuestCount()
    for i = 0, player_count - 1, 1 do
        local player = GAME:GetPlayerPartyMember(i)
        if not player.Dead then
            local anim = RogueEssence.Dungeon.CharAnimAction()
            anim.BaseFrameType = 0 --none
            anim.AnimLoc = player.CharLoc
            anim.CharDir = player.CharDir
            TASK:WaitTask(player:StartAnim(anim))
        end
    end

    for i = 0, guest_count - 1, 1 do
        local guest = GAME:GetPlayerGuestMember(i)
        if not guest.Dead then
            local anim = RogueEssence.Dungeon.CharAnimAction()
            anim.BaseFrameType = 0 --none
            anim.AnimLoc = guest.CharLoc
            anim.CharDir = guest.CharDir
            TASK:WaitTask(guest:StartAnim(anim))
        end
    end
end

function COMMON.InArray(value, array)
    for index = 1, #array do
        if array[index] == value then
            return true
        end
    end

    return false -- We could ommit this part, as nil is like false
end

function COMMON.EndDungeonDay(result, zoneId, structureId, mapId, entryId)
  COMMON.EndDayCycle()
  COMMON.ResetAnims()
  
	if SV.branchwaywoodsentrance.DungeonComplete then
		GAME:EndDungeonRun(result, zoneId, structureId, mapId, entryId, false, false) --This is a stupid way to change this.
	else
		GAME:EndDungeonRun(result, zoneId, structureId, mapId, entryId, true, true)
	end
	
  if GAME:InRogueMode() then
  
  local QuoteRNG = 0
  
  	UI:SetCenter(true)
	UI:SetAutoFinish(true)
  
		QuoteRNG = math.random(1, 3)
		
		if QuoteRNG == 1 then
				UI:WaitShowVoiceOver("You're worried about failing... But...\n\nThat's how everyone becomes stronger.\nThat's how the best explorers get to be that way.", 120)
		elseif QuoteRNG == 2 then
				UI:WaitShowVoiceOver("It's not about how many times you get knocked down.\nIt's about how many times you get back up.", 120)
		else
				UI:WaitShowVoiceOver("...But I sense something about you...\nsomething akin to deja vu, and unpredictability.\nThat's how I know you're special.", 120)
		end
		
	UI:SetCenter(false)
	UI:SetAutoFinish(false)
  
    GAME:RestartToTitle()
  else
	GAME:EnterZone(zoneId, structureId, mapId, entryId)
  end
end

function COMMON.EndSession(result, zoneId, structureId, mapId, entryId)
  GAME:EndDungeonRun(result, zoneId, structureId, mapId, entryId, false, false)
  GAME:EnterZone(zoneId, structureId, mapId, entryId)
end

function COMMON.GenderToNum(gender)
    local res = -1
    if gender == Gender.Genderless then
        res = 0
    elseif gender == Gender.Male then
        res = 1
    elseif gender == Gender.Female then
        res = 2
    end
    return res
end

function COMMON.TableContains(table, val)
    for i=1,#table do
        if table[i] == val then
            return true
        end
    end
    return false
end

function COMMON.WarpOut()
    local player_count = GAME:GetPlayerPartyCount()
    local guest_count = GAME:GetPlayerGuestCount()
    for i = 0, player_count - 1, 1 do
        local player = GAME:GetPlayerPartyMember(i)
        if not player.Dead then
            GAME:WaitFrames(30)
            local anim = RogueEssence.Dungeon.CharAbsentAnim(player.CharLoc, player.CharDir)
            COMMON.RemoveCharEffects(player)
            TASK:WaitTask(_DUNGEON:ProcessBattleFX(player, player, _DATA.SendHomeFX))
            TASK:WaitTask(player:StartAnim(anim))
        end
    end

    for i = 0, guest_count - 1, 1 do
        local guest = GAME:GetPlayerGuestMember(i)
        if not guest.Dead then
            GAME:WaitFrames(30)
            local anim = RogueEssence.Dungeon.CharAbsentAnim(guest.CharLoc, guest.CharDir)
            COMMON.RemoveCharEffects(guest)
            TASK:WaitTask(_DUNGEON:ProcessBattleFX(guest, guest, _DATA.SendHomeFX))
            TASK:WaitTask(guest:StartAnim(anim))
        end
    end
end

function COMMON.ResetPose()
    local player_count = GAME:GetPlayerPartyCount()
    local guest_count = GAME:GetPlayerGuestCount()
    for i = 0, player_count - 1, 1 do
        local player = GAME:GetPlayerPartyMember(i)
        if not player.Dead and player.CharLoc ~= nil and player.CharDir ~= nil then
            local anim = RogueEissionssence.Dungeon.CharAnimIdle(player.CharLoc, player.CharDir)
            TASK:WaitTask(player:StartAnim(anim))
        end
    end

    for i = 0, guest_count - 1, 1 do
        local guest = GAME:GetPlayerGuestMember(i)
        if not guest.Dead and guest.CharLoc ~= nil and guest.CharDir ~= nil then
            local anim = RogueEssence.Dungeon.CharAnimIdle(guest.CharLoc, guest.CharDir)
            TASK:WaitTask(guest:StartAnim(anim))
        end
    end
end

--called whenever a mission is completed
function COMMON.AskMissionWarpOut()
    local function MissionWarpOut()
        COMMON.WarpOut()
        GAME:WaitFrames(80)
        --Set minimap state back to old setting
        _DUNGEON.ShowMap = SV.TemporaryFlags.PriorMapSetting
        SV.TemporaryFlags.PriorMapSetting = nil
        TASK:WaitTask(_GAME:EndSegment(RogueEssence.Data.GameProgress.ResultType.Escaped))
    end

    local function SetMinimap()
        --to prevent accidentally doing something by pressing the button to select yes
        GAME:WaitFrames(10)
        --Set minimap state back to old setting
        _DUNGEON.ShowMap = SV.TemporaryFlags.PriorMapSetting
        SV.TemporaryFlags.PriorMapSetting = nil
    end

    local has_ongoing_mission = false
    local curr_floor = GAME:GetCurrentFloor().ID + 1
    local curr_zone = _ZONE.CurrentZoneID
    local curr_segment = _ZONE.CurrentMapID.Segment

    for _, mission in ipairs(SV.TakenBoard) do
        if mission.Floor > curr_floor and mission.Taken and mission.Completion == COMMON.MISSION_INCOMPLETE and curr_zone == mission.Zone and curr_segment == mission.Segment then
            has_ongoing_mission = true
            break
        end
    end


    UI:ResetSpeaker()
    local state = 0
    while state > -1 do
        if state == 0 then
            if has_ongoing_mission then
                UI:ChoiceMenuYesNo(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_CONTINUE_ONGOING"):ToLocal()), true)
                UI:WaitForChoice()
                local leave_dungeon = UI:ChoiceResult()
                if leave_dungeon then
                    UI:ChoiceMenuYesNo(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_CONTINUE_CONFIRM"):ToLocal()), true)
                    UI:WaitForChoice()
                    local leave_confirm = UI:ChoiceResult()
                    if leave_confirm then
                        state = -1
                        MissionWarpOut()
                    else
                        --pause between textboxes if player de-confirms
                        GAME:WaitFrames(20)
                    end
                else
                    state = -1
                    SetMinimap()
                end
            else
                UI:ChoiceMenuYesNo(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_CONTINUE_NO_ONGOING"):ToLocal()), false)
                UI:WaitForChoice()
                local leave_dungeon = UI:ChoiceResult()
                if leave_dungeon then
                    state = -1
                    MissionWarpOut()
                else
                    state = -1
                    SetMinimap()
                end
            end
        end
    end
end

function COMMON.EndDayCycle()
  --reshuffle items

  SV.adventure.Thief = false
  SV.shopgreen = { }
  SV.shopgreenALT = { }
  SV.shoppurple = { }
  
  math.randomseed(GAME:GetDailySeed())
  --roll a random index from 1 to length of category
  --add the item in that index category to the shop
  --2 essentials, always
  local type_count = 2
	for ii = 1, type_count, 1 do
		local base_data = COMMON.ESSENTIALS[math.random(1, #COMMON.ESSENTIALS)]
		table.insert(SV.shopgreen, base_data)
	end
  
  --1-2 ammo, always
  type_count = math.random(1, 2)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.AMMO[math.random(1, #COMMON.AMMO)]
		table.insert(SV.shopgreen, base_data)
	end
  
  --2-3 utilities, always
  type_count = math.random(3, 4)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.UTILITIES[math.random(1, #COMMON.UTILITIES)]
		table.insert(SV.shopgreen, base_data)
	end
  
  --1-2 orbs, always
  type_count = math.random(1, 2)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.ORBS[math.random(1, #COMMON.ORBS)]
		table.insert(SV.shopgreen, base_data)
	end
  
  --1-2 special item, always
  type_count = math.random(1, 2)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.SPECIAL[math.random(1, #COMMON.SPECIAL)]
		table.insert(SV.shopgreen, base_data)
	end
	
	 type_count = math.random(2, 4)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.ESSENTIALS[math.random(1, #COMMON.ESSENTIALS)]
		table.insert(SV.shopgreenALT, base_data)
	end
  
  --1-2 ammo, always
  type_count = math.random(1, 2)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.AMMO[math.random(1, #COMMON.AMMO)]
		table.insert(SV.shopgreenALT, base_data)
	end
  
  --2-3 utilities, always
  type_count = math.random(2, 4)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.UTILITIES[math.random(1, #COMMON.UTILITIES)]
		table.insert(SV.shopgreenALT, base_data)
	end
  
  --1-2 orbs, always
  type_count = math.random(0, 0)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.ORBS[math.random(1, #COMMON.ORBS)]
		table.insert(SV.shopgreenALT, base_data)
	end
  
  --1-2 special item, always
  type_count = math.random(0, 0)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.SPECIAL[math.random(1, #COMMON.SPECIAL)]
		table.insert(SV.shopgreenALT, base_data)
	end
	
	  local type_count = 0
	for ii = 1, type_count, 1 do
		local base_data = COMMON.ESSENTIALS[math.random(1, #COMMON.ESSENTIALS)] --Apples, Leppa Berries, Reviver Seeds, most likely Apricorns...
		table.insert(SV.shoppurple, base_data)
	end
  
  --1-2 ammo, always
  type_count = math.random(0, 0)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.AMMO[math.random(1, #COMMON.AMMO)] --Rocks, Twigs, wands...
		table.insert(SV.shoppurple, base_data)
	end
  
  --2-3 utilities, always
  type_count = math.random(0, 0)
	for ii = 1, type_count, 1 do
		local base_data = COMMON.UTILITIES[math.random(1, #COMMON.UTILITIES)] --Special Seeds.
		table.insert(SV.shoppurple, base_data)
	end
  
  --1-2 orbs, always
  local type_count = 3
	for ii = 1, type_count, 1 do
		local base_data = COMMON.ORBS[math.random(1, #COMMON.ORBS)] --Orbs, obviously.
		table.insert(SV.shoppurple, base_data)
	end
  
  --1-2 special item, always
  local type_count = 3
	for ii = 1, type_count, 1 do
		local base_data = COMMON.SPECIAL[math.random(1, #COMMON.SPECIAL)] --Specials are keys? I think?
		table.insert(SV.shoppurple, base_data)
	end
  
  
  local catalog = {}
  
  for ii = 1, #COMMON_GEN.TRADES_RANDOM, 1 do
    local base_data = { Item=COMMON_GEN.TRADES_RANDOM[ii].Item, ReqItem=COMMON_GEN.TRADES_RANDOM[ii].ReqItem }
    
    -- check if the item has been acquired before, or if it's a 1* item and dex has been seen
    if SV.unlocked_trades[COMMON_GEN.TRADES_RANDOM[ii].Item] ~= nil then
      table.insert(catalog, base_data)
    elseif #COMMON_GEN.TRADES_RANDOM[ii].ReqItem == 2 then
      if _DATA.Save:GetMonsterUnlock(COMMON_GEN.TRADES_RANDOM[ii].Dex) == RogueEssence.Data.GameProgress.UnlockState.Discovered then
        table.insert(catalog, base_data)
      end
    end
  end

  SV.base_trades = { }
  if #catalog < 25 then
    type_count = 0
  elseif #catalog < 50 then
    type_count = 1
  elseif #catalog < 75 then
    type_count = 2
  elseif #catalog < 100 then
    type_count = 3
  elseif #catalog < 150 then
    type_count = 4
  elseif #catalog < 250 then
    type_count = 5
  elseif #catalog < 350 then
    type_count = 6
  else
    type_count = 7
  end
  
	for ii = 1, type_count, 1 do
		local idx = math.random(1, #catalog)
		local base_data = catalog[idx]
		table.insert(SV.base_trades, base_data)
		table.remove(catalog, idx)
	end
end

function COMMON.RemoveCharEffects(char)
    char.StatusEffects:Clear();
    char.ProxyAtk = -1;
    char.ProxyDef = -1;
    char.ProxyMAtk = -1;
    char.ProxyMDef = -1;
    char.ProxySpeed = -1;
end

function COMMON.MakeCharactersFromList(list, retTable)
    retTable = retTable or false--return a table of chars rather than multiple chars if this is true
    local charTable = {}
    local chara = 0
    local length = 0
    for i = 1, #list, 1 do
        local name = list[i][1]
        length = #list[i]
        if length == 1 then--this case is so we can reference characters that aren't on the map. Put them at 0, 0 and hide them
            local monster = RogueEssence.Dungeon.MonsterID(characters[name].species,
                    characters[name].form,
                    characters[name].skin,
                    characters[name].gender)
            chara = RogueEssence.Ground.GroundChar(monster, RogueElements.Loc(0, 0), Direction.Down, name, characters[name].instance)
            chara:ReloadEvents()
            GAME:GetCurrentGround():AddTempChar(chara)
            GROUND:Hide(chara.EntName)

        elseif length == 2 then --may be inefficient to do a length lookup so often...
            local marker = MRKR(list[i][2])
            local monster = RogueEssence.Dungeon.MonsterID(characters[name].species,
                    characters[name].form,
                    characters[name].skin,
                    characters[name].gender)
            chara = RogueEssence.Ground.GroundChar(monster, RogueElements.Loc(marker.Position.X, marker.Position.Y), marker.Direction, name, characters[name].instance)
            chara:ReloadEvents()
            GAME:GetCurrentGround():AddTempChar(chara)
        else
            local x = list[i][2]
            local y = list[i][3]
            local direction = list[i][4]
            local monster = RogueEssence.Dungeon.MonsterID(characters[name].species,
                    characters[name].form,
                    characters[name].skin,
                    characters[name].gender)
            chara = RogueEssence.Ground.GroundChar(monster, RogueElements.Loc(x, y), direction, name, characters[name].instance)
            chara:ReloadEvents()
            GAME:GetCurrentGround():AddTempChar(chara)

        end
        chara:OnMapInit()
        local result = RogueEssence.Script.TriggerResult()
        TASK:WaitTask(chara:RunEvent(RogueEssence.Script.LuaEngine.EEntLuaEventTypes.EntSpawned, result, chara))
        charTable[i] = chara
    end
    if retTable then
        return charTable
    else
        return table.unpack(charTable)
    end
 end

function COMMON.TeamTurnTo(char)
    local player_count = GAME:GetPlayerPartyCount()
    local guest_count = GAME:GetPlayerGuestCount()
    for i = 0, player_count - 1, 1 do
        local player = GAME:GetPlayerPartyMember(i)
        if not player.Dead then
            DUNGEON:CharTurnToChar(player, char)
        end
    end

    for i = 0, guest_count - 1, 1 do
        local guest = GAME:GetPlayerGuestMember(i)
        if not guest.Dead then
            DUNGEON:CharTurnToChar(guest, char)
        end
    end
end

function COMMON.RewardItem(itemID, money, amount)
    --if money is true, the itemID is instead the amount of money to award
    if money == nil then money = false end

    UI:ResetSpeaker(false)--disable text noise
    UI:SetCenter(true)


    SOUND:PlayFanfare("Fanfare/Item")

    if money then
        UI:WaitShowDialogue("Team " .. GAME:GetTeamName() .. " received " .. "[color=#00FFFF]" .. itemID .. "[color]" .. STRINGS:Format("\\uE024") .. ".[pause=40]")
        GAME:AddToPlayerMoney(itemID)
    else
        local itemEntry = RogueEssence.Data.DataManager.Instance:GetItem(itemID)

        --for stackable items, always give 3 of them as a reward
        
        --give at least 1 item
        if amount == nil then amount = 1 end
        if itemEntry.MaxStack >= 3 then
            --for stackable items, always give 3 of them as a reward
            amount = 3
        end

        local item = RogueEssence.Dungeon.InvItem(itemID, false, amount)

        local article = "a"

        local first_letter = string.upper(string.sub(_DATA:GetItem(item.ID).Name:ToLocal(), 1, 1))

        if first_letter == "A" or first_letter == 'E' or first_letter == 'I' or first_letter == 'O' or first_letter == 'U' then article = 'an' end

        UI:WaitShowDialogue("Team " .. GAME:GetTeamName() .. " received " .. article .. " " .. item:GetDisplayName() ..".[pause=40]")

        --bag is full - equipped count is separate from bag and must be included in the calc
        if GAME:GetPlayerBagCount() + GAME:GetPlayerEquippedCount() >= GAME:GetPlayerBagLimit() then
            UI:WaitShowDialogue("The " .. item:GetDisplayName() .. " was sent to storage.")
            GAME:GivePlayerStorageItem(item.ID, amount)
        else
            GAME:GivePlayerItem(item.ID, amount)
        end

    end
    UI:SetCenter(false)
    UI:ResetSpeaker()


end

function COMMON.CreateColoredSegmentString(segment_name)
    local split_name = {}
    
    local index = 1

    for str in string.gmatch(segment_name, "([^%s]+)") do
        table.insert(split_name, index, str)
        index = index + 1
    end
    
    local final_name = ''

    for i = 1, #split_name, 1 do
        local cur_word = split_name[i]
        
        if i == 1 then
            final_name = cur_word
        elseif i ~= #split_name then
            final_name = final_name .. ' ' .. cur_word
        end
    end
    
    return '[color=#FFC663]'..final_name..'[color]'
end

function COMMON.GetNoMissionFloors(current_segment)
    local no_mission_floors = {}
    local floor_count = current_segment.FloorCount
    for i=0, floor_count - 1, 1 do
        local map_gen = current_segment:GetMapGen(i)
        local type = LUA_ENGINE:TypeOf(map_gen)
        if type:IsAssignableTo(luanet.ctype(LoadGenType)) or type:IsAssignableTo(luanet.ctype(ChanceFloorGenType)) then
            PrintInfo("Type is of "..type.FullName..", "..i.." is a no mission floor!")
            no_mission_floors[i+1] = 1
        end
    end
    return no_mission_floors
end

function COMMON.GenderCheck(chara, form, uppercase)

    local gender = chara.CurrentForm.Gender --Ripped straight from Halcyon / Hey look, I placed it in Common.
    local value = ""
    
    if gender == Gender.Female then
        local female_pronouns = {
            ["them"] = "her",
            ["their"] = "her",
            ["they"] = "she",
            ["they're"] = "she's",
            ["they've"] = "she's",
            ["they'll"] = "she'll",
            ["they are"] = "she is",
            ["they have"] = "she has",
			["they don't"] = "she doesn't",
            ["they were"] = "she was",
        }
        value = female_pronouns[form]
    elseif gender == Gender.Male then
        local male_pronouns = {
            ["them"] = "him", 
            ["their"] = "his", 
            ["they"] = "he", 
            ["they're"] = "he's", 
            ["they've"] = "he's", 
            ["they'll"] = "he'll", 
            ["they are"] = "he is", 
            ["they have"] = "he has", 
			["they don't"] = "he doesn't",
            ["they were"] = "he was", 
        }
        value = male_pronouns[form]
    else -- if neither male or female, use they/them, so just return the form 
        value = form
    end

return uppercase and value:gsub("^%l", string.upper) or value

end

function COMMON.WeatherStatus() --ROLL AT THE START OF THE DAY. / GROUNDMAPS CALL COMMON.WeatherApply() IN OUTDOOR AREAS.
SV.weather.number = 0 --To reset most instances of this script happening when they shouldn't. also it's easier than going through every chapter change and whatever.

	if SV.weather.allow and not SV.weather.rolled then --Allow should be true on Freeplay bits. Only roll if it hasn't been rolled before. RESET ROLLED ON DAY END.

		SV.weather.number =	math.random(1, 5) --These numbers are to be called in the Apply Command. / RESET THE NUMBER TO 0 ON DAY END.
		SV.weather.rolled = true
		print(SV.weather.number)
	
	end

end

function COMMON.WeatherApply() --ONLY CALL FROM OUTSIDE AREAS! / Can be retrofitted to do snow.
	if SV.weather.number <= 2 then -- Zero is the DefaultCase, typically for StoryMode scenarios.
		
		GROUND:RemoveMapStatus("clouds_overhead")
		GROUND:RemoveMapStatus("rain")
		GROUND:RemoveMapStatus("dark")
	
	elseif SV.weather.number <= 4 then
	
		GROUND:AddMapStatus("clouds_overhead")
		GROUND:RemoveMapStatus("rain")
		GROUND:RemoveMapStatus("dark")
		
	else
	
		GROUND:RemoveMapStatus("clouds_overhead")
		GROUND:AddMapStatus("rain")
		GROUND:AddMapStatus("dark")
	
	end
end