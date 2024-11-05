require 'what_does_n_stand_for.common'

ListType = luanet.import_type('System.Collections.Generic.List`1')
MobSpawnType = luanet.import_type('RogueEssence.LevelGen.MobSpawn')



function SINGLE_CHAR_SCRIPT.Test(owner, ownerChar, context, args)
  PrintInfo("Test")
end


ShopSecurityType = luanet.import_type('PMDC.Dungeon.ShopSecurityState')
MapIndexType = luanet.import_type('RogueEssence.Dungeon.MapIndexState')


function SINGLE_CHAR_SCRIPT.ThiefCheck(owner, ownerChar, context, args)
  local baseLoc = _DUNGEON.ActiveTeam.Leader.CharLoc
  local tile = _ZONE.CurrentMap.Tiles[baseLoc.X][baseLoc.Y]
  
  local thief_idx = "thief"
  
  local price = COMMON.GetDungeonCartPrice()
  local security_price = COMMON.GetShopPriceState()
  if price < 0 then
    --lost merchandise was placed back in shop, readjust the security price and clear the current price
    security_price.Amount = security_price.Amount - price
  elseif price < security_price.Cart then
    --merchandise was returned.  doesn't matter who did it.
    security_price.Cart = price
  elseif price > security_price.Cart then
    local char_index = _ZONE.CurrentMap:GetCharIndex(context.User)
    if char_index.Faction ~= RogueEssence.Dungeon.Faction.Player then
      --non-player was responsible for taking/destroying merchandise, just readjust the security price and clear the current price
      security_price.Amount = security_price.Amount - price + security_price.Cart
	else
	  --player was responsible for taking/destroying merchandise, add to the cart
      security_price.Cart = price
    end
  end

  
  if tile.Effect.ID ~= "area_shop" then
	if security_price.Cart > 0 then
	  _GAME:BGM("", false)
      COMMON.ClearAllPrices()
	  
	  SV.adventure.Thief = true
	  local index_from = owner.StatusStates:Get(luanet.ctype(MapIndexType))
	  _DUNGEON:LogMsg(RogueEssence.StringKey(string.format("TALK_SHOP_THIEF_%04d", index_from.Index)):ToLocal())
		
	  -- create thief status
	  local thief_status = RogueEssence.Dungeon.MapStatus(thief_idx)
      thief_status:LoadFromData()
	  -- put spawner from security status in thief status
	  local security_to = thief_status.StatusStates:Get(luanet.ctype(ShopSecurityType))
	  local security_from = owner.StatusStates:Get(luanet.ctype(ShopSecurityType))
	  security_to.Security = security_from.Security
      TASK:WaitTask(_DUNGEON:RemoveMapStatus(owner.ID))
      TASK:WaitTask(_DUNGEON:AddMapStatus(thief_status))
	  GAME:WaitFrames(60)
	end
  else
    local shop_idx = "shopping"
	if not _ZONE.CurrentMap.Status:ContainsKey(thief_idx) and not _ZONE.CurrentMap.Status:ContainsKey(shop_idx) then
	  
	  local shop_status = RogueEssence.Dungeon.MapStatus(shop_idx)
      shop_status:LoadFromData()
      TASK:WaitTask(_DUNGEON:AddMapStatus(shop_status))
	end
  end
end

function SINGLE_CHAR_SCRIPT.ExplorationReached(owner, ownerChar, context, args)
	local index = args.Mission
	local mission = SV.TakenBoard[index]
	local escort = COMMON.FindMissionEscort(index)
	local escortName = _DATA:GetMonster(mission.Client):GetColoredName()
	PrintInfo("Exploration reached at index "..index.." !")
	if escort ~= nil and escortName ~= nil then
		UI:ResetSpeaker()
		SV.TemporaryFlags.MissionCompleted = true
		UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("MISSION_EXPLORATION_REACHED"):ToLocal(), escortName))
		SV.TemporaryFlags.PriorMapSetting = _DUNGEON.ShowMap
		_DUNGEON.ShowMap = _DUNGEON.MinimapState.None
		GAME:WaitFrames(20)
		UI:SetSpeaker(escort)
		UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("MISSION_EXPLORATION_THANKS"):ToLocal()))
		GAME:WaitFrames(20)
		UI:ResetSpeaker()
		UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("MISSION_EXPLORATION_DEPART"):ToLocal(), escortName))
		GAME:WaitFrames(20)

		--Set max team size to 4 as the guest is no longer "taking" up a party slot
		RogueEssence.Dungeon.ExplorerTeam.MAX_TEAM_SLOTS = 4

		-- warp out
		TASK:WaitTask(_DUNGEON:ProcessBattleFX(escort, escort, _DATA.SendHomeFX))
		_DUNGEON:RemoveChar(escort)
		_ZONE.CurrentMap.DisplacedChars:Remove(escort)

		GAME:WaitFrames(50)
		COMMON.AskMissionWarpOut()
	end
end

function SINGLE_CHAR_SCRIPT.ShopCheckout(owner, ownerChar, context, args)
  local baseLoc = _DUNGEON.ActiveTeam.Leader.CharLoc
  local tile = _ZONE.CurrentMap.Tiles[baseLoc.X][baseLoc.Y]

  if tile.Effect.ID ~= "area_shop" then
	local found_shopkeep = COMMON.FindNpcWithTable(false, "Role", "Shopkeeper")
    if found_shopkeep and COMMON.CanTalk(found_shopkeep) then
	  local security_state = COMMON.GetShopPriceState()
      local price = security_state.Cart
	  local sell_price = COMMON.GetDungeonSellPrice()
  
      if price > 0 or sell_price > 0 then
	    local is_near = false
		local loc_diff = _DUNGEON.ActiveTeam.Leader.CharLoc - found_shopkeep.CharLoc
		if loc_diff:Dist8() > 1 then
		  -- check to see if the shopkeeper can see the player and warp there
		  local near_mat = false
		  local dirs = { Direction.Down, Direction.DownLeft, Direction.Left, Direction.UpLeft, Direction.Up, Direction.UpRight, Direction.Right, Direction.DownRight }
		  for idx, dir in ipairs(dirs) do
            if COMMON.ShopTileCheck(baseLoc, dir) then
		      near_mat = true
		    end
		  end
		  
		  if (near_mat or found_shopkeep:CanSeeCharacter(_DUNGEON.ActiveTeam.Leader)) then
	        -- attempt to warp the shopkeeper next to the player
		    local cand_locs = _ZONE.CurrentMap:FindNearLocs(found_shopkeep, baseLoc, 1)
		    if cand_locs.Count > 0 then
		      TASK:WaitTask(_DUNGEON:PointWarp(found_shopkeep, cand_locs[0], false))
			  is_near = true
		    end
		  end
		else
		  is_near = true
		end

		-- if it can't, fall through
		if is_near then
		  DUNGEON:CharTurnToChar(found_shopkeep, _DUNGEON.ActiveTeam.Leader)
		  DUNGEON:CharTurnToChar(_DUNGEON.ActiveTeam.Leader, found_shopkeep)
          UI:SetSpeaker(found_shopkeep)
		  
		  if sell_price > 0 then
		    UI:ChoiceMenuYesNo(STRINGS:Format(RogueEssence.StringKey(string.format("TALK_SHOP_SELL_%04d", found_shopkeep.Discriminator)):ToLocal(), STRINGS:FormatKey("MONEY_AMOUNT", sell_price)), false)
		    UI:WaitForChoice()
		    result = UI:ChoiceResult()
		  
		    if SV.adventure.Thief then
			  COMMON.ThiefReturn()
		    elseif result then
			  -- iterate player inventory prices and remove total price
			  COMMON.PayDungeonSellPrice(sell_price)
			  SOUND:PlayBattleSE("DUN_Money")
			  UI:WaitShowDialogue(RogueEssence.StringKey(string.format("TALK_SHOP_SELL_DONE_%04d", found_shopkeep.Discriminator)):ToLocal())
		    else
			  -- nothing
		    end
		  end
		  
		  if price > 0 then
	        UI:ChoiceMenuYesNo(STRINGS:Format(RogueEssence.StringKey(string.format("TALK_SHOP_PAY_%04d", found_shopkeep.Discriminator)):ToLocal(), STRINGS:FormatKey("MONEY_AMOUNT", price)), false)
	        UI:WaitForChoice()
	        result = UI:ChoiceResult()
	        if SV.adventure.Thief then
			  COMMON.ThiefReturn()
		    elseif result then
	          if price > GAME:GetPlayerMoney() then
                UI:WaitShowDialogue(RogueEssence.StringKey(string.format("TALK_SHOP_PAY_SHORT_%04d", found_shopkeep.Discriminator)):ToLocal())
	          else
	            -- iterate player inventory prices and remove total price
                COMMON.PayDungeonCartPrice(price)
		        SOUND:PlayBattleSE("DUN_Money")
	            UI:WaitShowDialogue(RogueEssence.StringKey(string.format("TALK_SHOP_PAY_DONE_%04d", found_shopkeep.Discriminator)):ToLocal())
	          end
	        end
		  end
		end
      else
        UI:SetSpeaker(found_shopkeep)
        UI:WaitShowDialogue(RogueEssence.StringKey(string.format("TALK_SHOP_END_%04d", found_shopkeep.Discriminator)):ToLocal())
      end
	end
  end
end

function SINGLE_CHAR_SCRIPT.DestinationFloor(owner, ownerChar, context, args)
  if context.User ~= nil then
    return
  end
  SOUND:PlayFanfare("Fanfare/Note")
  UI:ResetSpeaker()
  UI:WaitShowDialogue("You've reached a destination floor!")
end


function SINGLE_CHAR_SCRIPT.OutlawFloor(owner, ownerChar, context, args)
  if context.User ~= nil then
    return
  end
  SOUND:PlayBGM("C07. Outlaw.ogg", false)
  UI:ResetSpeaker()
  UI:WaitShowDialogue("Wanted outlaw spotted!")
  
  -- add a map status for outlaw clear check
  local checkClearStatus = "outlaw_clear_check" -- outlaw clear check
  local status = RogueEssence.Dungeon.MapStatus(checkClearStatus)
  status:LoadFromData()
  TASK:WaitTask(_DUNGEON:AddMapStatus(status))
end

function SINGLE_CHAR_SCRIPT.OutlawClearCheck(owner, ownerChar, context, args)
  -- check for no outlaw in the mission list
  remaining_outlaw = false
  for _, name in ipairs(COMMON.GetSortedKeys(SV.missions.Missions)) do
    mission = SV.missions.Missions[name]
    PrintInfo("Checking Mission: "..tostring(name))
    if mission.Complete == COMMON.MISSION_INCOMPLETE and _ZONE.CurrentZoneID == mission.DestZone
	  and _ZONE.CurrentMapID.Segment == mission.DestSegment and _ZONE.CurrentMapID.ID == mission.DestFloor then
	  local found_outlaw = COMMON.FindNpcWithTable(true, "Mission", name)
      if found_outlaw then
	    remaining_outlaw = true
	  else
	    -- if no outlaws of the mission list, mark quest as complete
		mission.Complete = 1
		UI:ResetSpeaker()
        UI:WaitShowDialogue("Mission status set to complete. Return to quest giver for reward.")
	  end
    end
  end
  if not remaining_outlaw then
    -- if no outlaws are found in the map, return music to normal and remove this status from the map
    SOUND:PlayBGM(_ZONE.CurrentMap.Music, true)
    local checkClearStatus = "outlaw_clear_check" -- outlaw clear check
	TASK:WaitTask(_DUNGEON:RemoveMapStatus(checkClearStatus))
  end
end

function SpawnOutlaw(origin, radius, mission_num)
	local mission = SV.TakenBoard[mission_num]
	local max_boost = 128
	local top_left = RogueElements.Loc(origin.X - radius, origin.Y - radius)
	local bottom_right =  RogueElements.Loc(origin.X + radius, origin.Y + radius)

	local rect_area = RogueElements.Loc(1)
	local rect_area2 = RogueElements.Loc(3)
	function checkBlock(loc)

		local result = _ZONE.CurrentMap:TileBlocked(loc)
		return result
	end

	function checkDiagBlock(loc)
		return true
	end

	local spawn_candidates = {}
	for x = top_left.X, bottom_right.X, 1 do
		for y = top_left.Y, bottom_right.Y, 1 do
			local testLoc = RogueElements.Loc(x, y)
			--local is_choke_point = RogueElements.Grid.IsChokePoint(testLoc - rect_area, rect_area2, testLoc, checkBlock, checkDiagBlock)
			local tile_block = _ZONE.CurrentMap:TileBlocked(testLoc)
			local char_at = _ZONE.CurrentMap:GetCharAtLoc(testLoc)

			--don't spawn the outlaw directly next to the player or their teammates
			local next_to_player_units = false
			for i = 1, GAME:GetPlayerPartyCount(), 1 do
				local party_member = GAME:GetPlayerPartyMember(i-1)
				if math.abs(party_member.CharLoc.X - x) <= 1 and math.abs(party_member.CharLoc.Y - y) <= 1 then
					next_to_player_units = true
					break
				end
			end

			--guests too!
			for i = 1, GAME:GetPlayerGuestCount(), 1 do
				local party_member = GAME:GetPlayerGuestMember(i-1)
				if math.abs(party_member.CharLoc.X - x) <= 1 and math.abs(party_member.CharLoc.Y - y) <= 1 then
					next_to_player_units = true
					break
				end
			end

			if tile_block == false and char_at == nil and not next_to_player_units then
				table.insert(spawn_candidates, testLoc)
			end
		end
	end

	if #spawn_candidates < 1 then
		PrintInfo("Error: Outlaw couldn't spawn for current floor, not enough spawn candidates.")
		return
	end

	local spawn_loc = spawn_candidates[_DATA.Save.Rand:Next(1, #spawn_candidates)]
	local new_team = RogueEssence.Dungeon.MonsterTeam()
	local mob_data = RogueEssence.Dungeon.CharData(true)
	local base_form_idx = 0
	local form = _DATA:GetMonster(mission.Target).Forms[base_form_idx]
	-- local gender = form:RollGender(RogueElements.MathUtils.Rand)
	mob_data.BaseForm = RogueEssence.Dungeon.MonsterID(mission.Target, base_form_idx, "normal", COMMON.NumToGender(mission.TargetGender))
	mob_data.Level = math.floor(SV.ExpectedLevel[mission.Zone] * 1.15)
	local ability = form:RollIntrinsic(RogueElements.MathUtils.Rand, 3)
	mob_data.BaseIntrinsics[0] = ability
	local new_mob = RogueEssence.Dungeon.Character(mob_data)
	--Old move learning logic
	--StringType = luanet.import_type('System.String')
	--local extra_moves = LUA_ENGINE:MakeGenericType(ListType, { StringType }, { })
	--local final_skills = form:RollLatestSkills(new_mob.Level, extra_moves)

	--for i = 0, final_skills.Count - 1, 1 do
	--	local skill = final_skills[i]
	--	new_mob:LearnSkill(skill, true)
	--end


	--TODO: Add logic to make sure outlaw has at least one decent attacking move based on their level.
	--<skilldata>.Data.Category == RogueEssence.Data.BattleData.SkillCategory.Physical
	--Pick 4 moves at random in the mon's level up table at that point. 
	--certain moves are blacklisted due to snaids.
	local skill_candidates = {}
	local skill_blacklist = {'teleport', 'gullotine', 'sheer_cold', 'horn_drill', 'fissure', 'memento',
							 'healing_wish', 'lunar_dance', 'self_destruct', 'explosion', 'final_gambit', 'perish_song',
							 'dragon_rage'}

	--print("Outlaw level is!: " .. tostring(mob_data.Level))
	--generate the skill candidate list based on level and the blacklist
	for i = 0,  _DATA:GetMonster(new_mob.BaseForm.Species).Forms[new_mob.BaseForm.Form].LevelSkills.Count - 1, 1 do
		local skill =_DATA:GetMonster(new_mob.BaseForm.Species).Forms[new_mob.BaseForm.Form].LevelSkills[i].Skill
		if _DATA:GetMonster(new_mob.BaseForm.Species).Forms[new_mob.BaseForm.Form].LevelSkills[i].Level <= new_mob.Level and not COMMON.InArray(skill, skill_blacklist) then
			--print("new skill candidate!: " .. skill)
			table.insert(skill_candidates, skill)
		end
	end

	--learn as many skills as we can from the candidate list.
	local learn_count = 0
	while learn_count < 4 and #skill_candidates > 0 do
		local randval = _DATA.Save.Rand:Next(1, #skill_candidates)
		local learned_skill = skill_candidates[randval]
		new_mob:LearnSkill(learned_skill, true)
		learn_count = learn_count + 1
		--print("Outlaw learned " .. learned_skill)
		table.remove(skill_candidates, randval)
	end


	local tactic = nil
	if mission.Type == COMMON.MISSION_TYPE_OUTLAW_FLEE then
		local speedMin = math.floor(SV.ExpectedLevel[mission.Zone] / 1.5)
		local speedMax = math.floor(SV.ExpectedLevel[mission.Zone] * 1.5)
		new_mob.SpeedBonus = math.min(_DATA.Save.Rand:Next(speedMin, speedMax), 50)
		tactic = _DATA:GetAITactic("super_flee_stairs")
	else
		tactic = _DATA:GetAITactic("boss")
	end

	if mission.Type == COMMON.MISSION_TYPE_OUTLAW_ITEM then
		new_mob.EquippedItem = RogueEssence.Dungeon.InvItem(mission.Item)
	end

	new_mob.MaxHPBonus = math.min(SV.ExpectedLevel[mission.Zone] * 2, max_boost);
	new_mob.HP = new_mob.MaxHP;
	new_mob.Unrecruitable = true
	new_mob.Tactic = tactic
	new_mob.CharLoc = spawn_loc
	new_team.Players:Add(new_mob)

	tbl = LTBL(new_mob)
	tbl.Mission = mission_num

	_ZONE.CurrentMap.MapTeams:Add(new_team)
	new_mob:RefreshTraits()
	_ZONE.CurrentMap:UpdateExploration(new_mob)

	local base_name = RogueEssence.Data.DataManager.Instance.DataIndices[RogueEssence.Data.DataManager.DataType.Monster]:Get(new_mob.BaseForm.Species).Name:ToLocal()
	GAME:SetCharacterNickname(new_mob, base_name)
	return new_mob
end

function SINGLE_CHAR_SCRIPT.OutlawFloor(owner, ownerChar, context, args)
	local outlaw = context.User
	local tbl = LTBL(outlaw)
	if tbl ~= nil and tbl.Mission then
		local mission_num = args.Mission
		local mission = SV.TakenBoard[mission_num]
		outlaw.Nickname = RogueEssence.Dungeon.CharData.GetFullFormName( RogueEssence.Dungeon.MonsterID(mission.Target, 0, "normal", COMMON.NumToGender(mission.TargetGender)))
		SOUND:PlayBGM("C07. Outlaw.ogg", true, 20)
		UI:ResetSpeaker()
		DUNGEON:CharTurnToChar(outlaw, GAME:GetPlayerPartyMember(0))
		COMMON.TeamTurnTo(outlaw)
		UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_OUTLAW"):ToLocal()))

		if mission.Type == COMMON.MISSION_TYPE_OUTLAW_FLEE then
			GAME:WaitFrames(20)
			UI:SetSpeaker(outlaw)
			UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_OUTLAW_FLEE"):ToLocal()))
			local leaderDir = _DUNGEON.ActiveTeam.Leader.CharDir
			outlaw.CharDir = leaderDir
		elseif mission.Type == COMMON.MISSION_TYPE_OUTLAW_MONSTER_HOUSE then
			GAME:WaitFrames(20)
			UI:SetSpeaker(outlaw)
			UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_OUTLAW_TRAP"):ToLocal()))
			SOUND:FadeOutBGM(20)
			GAME:WaitFrames(20)

			-- ===========Monster house spawning logic============
			local rect_area = RogueElements.Loc(1)
			local rect_area2 = RogueElements.Loc(3)

			function checkBlock(loc)
				local result = _ZONE.CurrentMap:TileBlocked(loc)
				return result
			end

			function checkDiagBlock(loc)
				return true
			end
			
			local goon_spawn_radius = 5

			local origin = _DUNGEON.ActiveTeam.Leader.CharLoc

			local leftmost_x = math.maxinteger
			local rightmost_x = math.mininteger

			local downmost_y = math.mininteger
			local upmost_y = math.maxinteger


			local topLeft = RogueElements.Loc(origin.X - goon_spawn_radius, origin.Y - goon_spawn_radius)
			local bottomRight =  RogueElements.Loc(origin.X + goon_spawn_radius, origin.Y + goon_spawn_radius)

			PrintInfo("Spawning monster house with top left "..topLeft.X..", "..topLeft.Y.." and bottom right "..bottomRight.X..", "..bottomRight.Y)
			
			local valid_tile_total = 0
			for x = math.max(topLeft.X, 0), math.min(bottomRight.X, _ZONE.CurrentMap.Width - 1), 1 do
				for y = math.max(topLeft.Y, 0), math.min(bottomRight.Y, _ZONE.CurrentMap.Height - 1), 1 do
					local testLoc = RogueElements.Loc(x,y)
					--local is_choke_point = RogueElements.Grid.IsChokePoint(testLoc - rect_area, rect_area2, testLoc, checkBlock, checkDiagBlock)
					local tile_block = _ZONE.CurrentMap:TileBlocked(testLoc)
					local char_at = _ZONE.CurrentMap:GetCharAtLoc(testLoc)

					if tile_block == false and char_at == nil then
						valid_tile_total = valid_tile_total + 1
						leftmost_x = math.min(testLoc.X, leftmost_x)
						rightmost_x = math.max(testLoc.X, rightmost_x)
						downmost_y = math.max(testLoc.Y, downmost_y)
						upmost_y = math.min(testLoc.Y, upmost_y)
					end
				end
			end

			local house_event = PMDC.Dungeon.MonsterHouseMapEvent();
			
			local tl = RogueElements.Loc(leftmost_x - 1, upmost_y - 1)
			local br =  RogueElements.Loc(rightmost_x + 1, downmost_y + 1)

			local bounds = RogueElements.Rect.FromPoints(tl, br)
			house_event.Bounds = bounds

			local min_goons = math.floor(valid_tile_total / 5)
			local max_goons = math.floor(valid_tile_total / 4)
			local total_goons = _DATA.Save.Rand:Next(min_goons, max_goons)

			local all_spawns = LUA_ENGINE:MakeGenericType( ListType, { MobSpawnType }, { })
			for i = 0,  _ZONE.CurrentMap.TeamSpawns.Count - 1, 1 do
				local possible_spawns = _ZONE.CurrentMap.TeamSpawns:GetSpawn(i):GetPossibleSpawns()
				for j = 0, possible_spawns.Count - 1, 1 do
					local spawn = possible_spawns:GetSpawn(j):Copy()
					all_spawns:Add(spawn)
				end
			end

			for _ = 1, total_goons, 1 do
				local randint = _DATA.Save.Rand:Next(0, all_spawns.Count)
				local spawn = all_spawns[randint]
				spawn.SpawnFeatures:Add(PMDC.LevelGen.MobSpawnLuaTable('{ Goon = '..mission_num..' }'))
				spawn.SpawnFeatures:Add(PMDC.LevelGen.MobSpawnUnrecruitable())
				house_event.Mobs:Add(spawn)
			end
			local charaContext = RogueEssence.Dungeon.SingleCharContext(_DUNGEON.ActiveTeam.Leader)
			TASK:WaitTask(house_event:Apply(owner, ownerChar, charaContext))
			GAME:WaitFrames(20)
		else
			--to prevent accidental button mashing making you waste your turn
			GAME:WaitFrames(20)
		end
	end
end

function SINGLE_CHAR_SCRIPT.OnOutlawDeath(owner, ownerChar, context, args)
	local mission_num = args.Mission
	local tbl = LTBL(context.User)
	if tbl.Mission then
		SV.OutlawDefeated = true
		local curr_mission = SV.TakenBoard[mission_num]
		if curr_mission.Type == COMMON.MISSION_TYPE_OUTLAW_ITEM then
			SOUND:PlayBGM(_ZONE.CurrentMap.Music, true)
		end
	end

	tbl.Mission = nil
	tbl.Goon = nil

	local found_goon = COMMON.FindNpcWithTable(true, "Goon", mission_num)
	if not found_goon then
		SV.OutlawGoonsDefeated = true
	end
end

function SINGLE_CHAR_SCRIPT.OnMonsterHouseOutlawCheck(owner, ownerChar, context, args)
	local mission_number = args.Mission
	local curr_mission = SV.TakenBoard[mission_number]
	local outlaw_name = _DATA:GetMonster(curr_mission.Target):GetColoredName()

	if curr_mission.Completion == COMMON.MISSION_INCOMPLETE then
		local found_outlaw = COMMON.FindNpcWithTable(true, "Mission", mission_number)
		local found_goon = COMMON.FindNpcWithTable(true, "Goon", mission_number)
		--print("found outlaw = " .. tostring(found_outlaw) .. ", found_goon = " .. tostring(found_goon))
		if not SV.MonsterHouseMessageNotified then
			if found_goon and not found_outlaw then
				GAME:WaitFrames(20)
				UI:ResetSpeaker()
				UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_OUTLAW_BOSS_DEFEATED"):ToLocal(), outlaw_name))
				SV.MonsterHouseMessageNotified = true
			end
			if not found_goon and found_outlaw then
				GAME:WaitFrames(40)
				UI:SetSpeaker(found_outlaw)
				UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_OUTLAW_MINIONS_DEFEATED"):ToLocal()))
				SV.MonsterHouseMessageNotified = true
			end
		end

		if not (found_goon or found_outlaw) then
			SOUND:PlayBGM(_ZONE.CurrentMap.Music, true)
			SV.TemporaryFlags.MissionCompleted = true
			curr_mission.Completion = 1
			GAME:WaitFrames(20)
			UI:ResetSpeaker()
			UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_OUTLAW_HOUSE_DEFEATED"):ToLocal(), outlaw_name))
			SV.TemporaryFlags.PriorMapSetting = _DUNGEON.ShowMap
			_DUNGEON.ShowMap = _DUNGEON.MinimapState.None
			COMMON.AskMissionWarpOut()
		end
	end
end

function SINGLE_CHAR_SCRIPT.SpawnOutlaw(owner, ownerChar, context, args)
	if context.User == GAME:GetPlayerPartyMember(0) then
		local mission_num = args.Mission
		local curr_mission = SV.TakenBoard[mission_num]
		if curr_mission.Completion == COMMON.MISSION_INCOMPLETE then
			local origin = _DATA.Save.ActiveTeam.Leader.CharLoc
			local radius = 3
			SpawnOutlaw(origin, radius, mission_num)
		end
	end
end

function SINGLE_CHAR_SCRIPT.OutlawCheck(owner, ownerChar, context, args)
	local mission_num = args.Mission
	local curr_mission = SV.TakenBoard[mission_num]
	if curr_mission.Completion == COMMON.MISSION_INCOMPLETE then
		if SV.OutlawDefeated then
			local curr_mission = SV.TakenBoard[mission_num]
			local outlaw_name = _DATA:GetMonster(curr_mission.Target):GetColoredName()
			SOUND:PlayBGM(_ZONE.CurrentMap.Music, true)
			SV.TemporaryFlags.MissionCompleted = true
			curr_mission.Completion = 1
			GAME:WaitFrames(50)
			UI:ResetSpeaker()
			UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_OUTLAW_DEFEATED"):ToLocal(), outlaw_name))
			--Clear but remember minimap state
			SV.TemporaryFlags.PriorMapSetting = _DUNGEON.ShowMap
			_DUNGEON.ShowMap = _DUNGEON.MinimapState.None
			COMMON.AskMissionWarpOut()
		end
	end
end

function SINGLE_CHAR_SCRIPT.OutlawItemCheck(owner, ownerChar, context, args)
	local mission_num = args.Mission
	local curr_mission = SV.TakenBoard[mission_num]
	if curr_mission.Completion == COMMON.MISSION_INCOMPLETE then
		if SV.OutlawDefeated and SV.OutlawItemPickedUp then
			SV.TemporaryFlags.MissionCompleted = true
			curr_mission.Completion = 1
			local item_name =  RogueEssence.Dungeon.InvItem(curr_mission.Item):GetDisplayName()
			SOUND:PlayBGM(_ZONE.CurrentMap.Music, true)
			GAME:WaitFrames(50)
			UI:ResetSpeaker()
			UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("DLG_MISSION_OUTLAW_ITEM_RETRIEVED"):ToLocal(), item_name))
			--Clear but remember minimap state
			SV.TemporaryFlags.PriorMapSetting = _DUNGEON.ShowMap
			_DUNGEON.ShowMap = _DUNGEON.MinimapState.None
			COMMON.AskMissionWarpOut()
		end
	end
end

function SINGLE_CHAR_SCRIPT.OutlawFleeStairsCheck(owner, ownerChar, context, args)
	local stairs_arr = {
		"stairs_back_down", "stairs_back_up", "stairs_exit_down",
		"stairs_exit_up", "stairs_go_up", "stairs_go_down"
	}

	local mission_num = args.Mission
	local curr_mission = SV.TakenBoard[mission_num]
	local found_outlaw = COMMON.FindNpcWithTable(true, "Mission", mission_num)

	if found_outlaw then
		local targetName = found_outlaw:GetDisplayName(true)
		local map = _ZONE.CurrentMap;
		local charLoc = found_outlaw.CharLoc
		local tile = map:GetTile(charLoc)
		local tile_effect_id = tile.Effect.ID
		if tile and COMMON.TableContains(stairs_arr, tile_effect_id) then
			GAME:WaitFrames(20)
			_DUNGEON:RemoveChar(found_outlaw)
			GAME:WaitFrames(20)
			UI:ResetSpeaker()
			UI:WaitShowDialogue(targetName .. " escaped...")
			curr_mission.BackReference = COMMON.FLEE_BACKREFERENCE
			SOUND:PlayBGM(_ZONE.CurrentMap.Music, true)
			GAME:WaitFrames(20)
		end
	end
end




function SINGLE_CHAR_SCRIPT.MissionGuestCheck(owner, ownerChar, context, args)

	if not context.User.Dead then
		return
	end

	local tbl = LTBL(context.User)

	if tbl ~= nil and tbl.Escort ~= nil then
		local targetName = _DATA:GetMonster(context.User.BaseForm.Species):GetColoredName()
		UI:ResetSpeaker()
		UI:WaitShowDialogue(STRINGS:Format(RogueEssence.StringKey("MISSION_ESCORT_FAINTED"):ToLocal(), targetName))
		GAME:WaitFrames(40)
		--Set max team size to 4 as the guest is no longer "taking" up a party slot
		RogueEssence.Dungeon.ExplorerTeam.MAX_TEAM_SLOTS = 4
		COMMON.WarpOut()
		GAME:WaitFrames(80)
		TASK:WaitTask(_GAME:EndSegment(RogueEssence.Data.GameProgress.ResultType.Failed))
	end
end

function SINGLE_CHAR_SCRIPT.HeroPartnerCheck(owner, ownerChar, context, args) --script goes to Palika. If you're reading this, hello and thanks.
	local player_count = GAME:GetPlayerPartyCount()
	local guest_count = GAME:GetPlayerGuestCount()
	if player_count < 1 then return end--If there's no party members then dont do anything
	for i = 0, player_count - 1, 1 do 
		local player = GAME:GetPlayerPartyMember(i)
		if player.Dead and player.IsFounder then --Player Character has Fainted.
			for i = 0, player_count - 1, 1 do --beam everyone else out
				player = GAME:GetPlayerPartyMember(i)
				if not player.Dead then--dont beam out whoever died
					--delay between beam outs
					GAME:WaitFrames(60)
					TASK:WaitTask(_DUNGEON:ProcessBattleFX(player, player, _DATA.SendHomeFX))
					player.Dead = true
				end
			end
			--beam out guests
			for i = 0, guest_count - 1, 1 do --beam everyone else out
				guest = GAME:GetPlayerGuestMember(i)
				if not guest.Dead then--dont beam out whoever died
					--delay between beam outs
					GAME:WaitFrames(60)
					TASK:WaitTask(_DUNGEON:ProcessBattleFX(guest, guest, _DATA.SendHomeFX))
					guest.Dead = true
				end
			end
			--TASK:WaitTask(_GAME:EndSegment(RogueEssence.Data.GameProgress.ResultType.Failed))
			return--cut the script short here if someone died, no need to check guests
		end
	end
	
	--check guests as well / Might be useful later for any important NPCs.
	if guest_count < 1 then return end--If there's no guest members then we dont need to do anything
	for i = 0, guest_count - 1, 1 do 
		local guest = GAME:GetPlayerGuestMember(i)
		if guest.Dead and guest.IsPartner then --someone important fainted. 
			--beam player's team out first
			for i = 0, player_count - 1, 1 do --beam everyone else out
				player = GAME:GetPlayerPartyMember(i)
				if not player.Dead then--dont beam out whoever died
					TASK:WaitTask(_DUNGEON:ProcessBattleFX(player, player, _DATA.SendHomeFX))
					player.Dead = true
					GAME:WaitFrames(60)
				end
			end
			for i = 0, guest_count - 1, 1 do --beam everyone else out
				guest = GAME:GetPlayerGuestMember(i)
				if not guest.Dead then--dont beam out whoever died
					TASK:WaitTask(_DUNGEON:ProcessBattleFX(guest, guest, _DATA.SendHomeFX))
					guest.Dead = true
					GAME:WaitFrames(60)
				end
			end
			--TASK:WaitTask(_GAME:EndSegment(RogueEssence.Data.GameProgress.ResultType.Failed))
		end
	end
			
end

function SINGLE_CHAR_SCRIPT.ControlCheck(owner, ownerChar, context, args)

if context.User ~= nil then
    return
  end

local chara = GAME:GetPlayerPartyMember(0)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Worried")
UI:ChoiceMenuYesNo("(My head's still spinning... [pause=20]Should I remember the basics of dungeoneering first before moving on?)", false)
UI:WaitForChoice()
ch = UI:ChoiceResult()

if ch then

UI:WaitShowDialogue("(Better safe than sorry... [pause=20]Let's see... [pause=20]I remember being told about these things...)")
GAME:WaitFrames(10)
SOUND:PlaySE("Menu/Select")

UI:ResetSpeaker()
--UI:SetCenter(true)
UI:SetAutoFinish(true)

UI:SetBounds(10,50,300,140)

UI:WaitShowDialogue(STRINGS:Format("---------------------Basic Controls---------------------\nRegular Attack! {0}                                 {5} Pause!\nSprint! {1}                                   {4} Toggle Map!\nMove Wheel! {2}                            {6} Message Log!\nLook around! {3}                          {7} Move Diagonally!\n\n---------------Enter Team Mode with {8}!---------------[pause=60]", STRINGS:LocalKeyString(0), STRINGS:LocalKeyString(1), STRINGS:LocalKeyString(4), STRINGS:LocalKeyString(5), STRINGS:LocalKeyString(8), STRINGS:LocalKeyString(9), STRINGS:LocalKeyString(10), STRINGS:LocalKeyString(6), STRINGS:LocalKeyString(7)))
SOUND:PlaySE("Menu/Confirm")
GAME:WaitFrames(10)

UI:SetAutoFinish(false)
UI:ResetBounds()
UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("(I should practice these basics a bit before moving on.)")

GAME:WaitFrames(10)
else

UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("(Eh, [pause=10]I'll be fine. [pause=0]I've been doing this long enough to know them by heart.)")

GAME:WaitFrames(10)
	end
	
SOUND:PlaySE("Fanfare/Note")
UI:ResetSpeaker()
UI:WaitShowDialogue("Your controls will be in the 'Others' Menu if you need a refresher, or want to change them.")
GAME:WaitFrames(15)
	
end

function SINGLE_CHAR_SCRIPT.TrapsStatusesTutorial(owner, ownerChar, context, args)

if context.User ~= nil then
    return
  end

local chara = GAME:GetPlayerPartyMember(0)

GAME:WaitFrames(10)

SOUND:PlayBattleSE("EVT_Emote_Shock")
DUNGEON:CharSetEmote(chara, "shock", 1)
GAME:WaitFrames(40)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Surprised")
UI:WaitShowDialogue("(Gah! [pause=0]I'm surrounded by [color=#cc0058]Spike Traps[color]!)")
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(Hm... [pause=20]They're spread out. [pause=0]I can get in-between them if I walk carefully...)")
UI:WaitShowDialogue("(They're not really dangerous though, [pause=10]they should go away if I accidentally step on them.)")
UI:SetSpeakerEmotion("Pain")
UI:WaitShowDialogue("(...But I shouldn't do that, [pause=10]I'll be knocked out before I know it.)")

GAME:WaitFrames(15)

end

function SINGLE_CHAR_SCRIPT.StatusEffectsTutorial(owner, ownerChar, context, args)

local chara = GAME:GetPlayerPartyMember(0)

GAME:WaitFrames(20)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Pain")
UI:WaitShowDialogue("(Nnf, [pause=10]I'm poisoned...)")

end
