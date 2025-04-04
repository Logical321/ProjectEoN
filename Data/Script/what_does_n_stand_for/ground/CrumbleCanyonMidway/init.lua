--[[
    init.lua
    Created: 02/20/2024 23:26:16
    Description: Autogenerated script file for the map CrumbleCanyonMidway.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local CrumbleCanyonMidway = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---CrumbleCanyonMidway.Init(map)
--Engine callback function
function CrumbleCanyonMidway.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  

end

---CrumbleCanyonMidway.Enter(map)
--Engine callback function
function CrumbleCanyonMidway.Enter(map)
local GuestsNumber = GAME:GetPlayerGuestCount()

if SV.chapter.number < 2 then

SV.checkpoint = 
  {
    Zone    = 'roadwalkpathway', Segment  = -1,
    Map  = 2, Entry  = 0
  }

	if GuestsNumber < 2 then
	
		for i = 0, GuestsNumber - 1, 1 do
		
		GAME:RemovePlayerGuest(0) --To prevent accidental duplicating, remove all guests before adding more. This CANNOT run when doing missions, so it should be fine.

		end
	
	local mon_id = RogueEssence.Dungeon.MonsterID("kecleon", 0, "normal", Gender.Male)
	local kecleon = _DATA.Save.ActiveTeam:CreatePlayer(_DATA.Save.Rand, mon_id, 5, "color_change", 0)
	kecleon.Discriminator = _DATA.Save.Rand:Next()--tbh idk what this is lol
	kecleon.Level = 15
	kecleon.Nickname = 'Kecleon'
	kecleon.IsPartner = true-- if they somehow manage to die, end the run / Thanks Palika.
	
	kecleon.MaxHPBonus = 10
	kecleon.AtkBonus = 0
	kecleon.DefBonus = 0
	kecleon.MDefBonus = 0
	kecleon.SpeedBonus = 0

	kecleon:ReplaceSkill("feint", 0, false)
	kecleon:ReplaceSkill("fury_swipes", 1, true)
	kecleon:ReplaceSkill("shadow_sneak", 2, true) --Causes problems because he's too aggressive lol / Feint and Shadow Sneak act the exact same, his aggressiveness has not changed.
	kecleon:ReplaceSkill("bind", 3, true) --Despite everything, this move is actually useful.
	
	GAME:AddPlayerGuest(kecleon)
	kecleon:FullRestore()
	--kecleon.Tactic = _DATA:GetAITactic("escortee") --Avoid Trouble causes Trouble. You already know this. / Since modding in a custom tactic is kinda impossible, I will have to hold off on this.
	
    local talk_evt = RogueEssence.Dungeon.BattleScriptEvent("EscortInteract")
    kecleon.ActionEvents:Add(talk_evt)
	kecleon:RefreshTraits()

	local mon_id = RogueEssence.Dungeon.MonsterID("piplup", 1, "normal", Gender.Female)
	local madilyn = _DATA.Save.ActiveTeam:CreatePlayer(_DATA.Save.Rand, mon_id, 5, "defiant", 0) --This is a real Ability Piplup has, look it up.
	madilyn.Discriminator = _DATA.Save.Rand:Next()--tbh idk what this is lol
	madilyn.Level = 30 --NOT CANON NUMBER. She's much stronger than the Player is, and always will be. This is the only thing I can think of for balancing reasons.
	madilyn.Nickname = 'Madilyn'
	madilyn.IsPartner = true -- if they somehow manage to die, end the run / Thanks Palika.
	
	madilyn.MaxHPBonus = 0
	madilyn.AtkBonus = 0
	madilyn.DefBonus = 0
	madilyn.MDefBonus = 0
	madilyn.SpeedBonus = 0

	madilyn:ReplaceSkill("brick_break", 0, true)
	madilyn:ReplaceSkill("aerial_ace", 1, true)
	madilyn:ReplaceSkill("bubble", 2, true)
	madilyn:ReplaceSkill("protect", 3, false)
	
	GAME:AddPlayerGuest(madilyn)
	madilyn:FullRestore() --What does this function do...? / Restores their Stats so they don't appear with 0 HP.
	
	madilyn.Tactic = _DATA:GetAITactic("go_after_foes") -- Sunkern helped here. / Apparently, she's too OP. / No bloody idea what I'm doing.
     
	local talk_evt = RogueEssence.Dungeon.BattleScriptEvent("MadilynInteract")
    madilyn.ActionEvents:Add(talk_evt)
	--madilyn.SilentEquipItem(seed_reviver) --No idea how I make this work.
	madilyn:RefreshTraits()
	
	end
  
end

if SV.chapter1.thieves_defeated then
GROUND:Hide("Madilyn")
GROUND:Hide("Kecleon")
end

if not SV.chapter1.crumble_rest_cutscene then
DepositBoxCutscene()
end

  GAME:WaitFrames(20)
  GAME:FadeIn(20)

end

---CrumbleCanyonMidway.Exit(map)
--Engine callback function
function CrumbleCanyonMidway.Exit(map)


end

---CrumbleCanyonMidway.Update(map)
--Engine callback function
function CrumbleCanyonMidway.Update(map)


end

---CrumbleCanyonMidway.GameSave(map)
--Engine callback function
function CrumbleCanyonMidway.GameSave(map)


end

---CrumbleCanyonMidway.GameLoad(map)
--Engine callback function
function CrumbleCanyonMidway.GameLoad(map)

  GAME:FadeIn(20)

end

-------------------------------
-- Entities Callbacks
-------------------------------

function DepositBoxCutscene()
local player = CH('PLAYER')
local Madilyn = CH('Madilyn')
local Kecleon = CH('Kecleon')

GAME:CutsceneMode(true)
GAME:MoveCamera(228, 248, 1, false)

GROUND:TeleportTo(player, 220, 344, Direction.Up)
GROUND:TeleportTo(Madilyn, 195, 355, Direction.Up)
GROUND:TeleportTo(Kecleon, 245, 355, Direction.Up)

GAME:WaitFrames(60)

local coro1 = TASK:BranchCoroutine(function() GROUND:MoveInDirection(player, Direction.Up, 44, false, 2) end)
local coro2 = TASK:BranchCoroutine(function() GROUND:MoveInDirection(Madilyn, Direction.Up, 44, false, 2) end)
local coro3 = TASK:BranchCoroutine(function() GROUND:MoveInDirection(Kecleon, Direction.Up, 44, false, 2) end)
local coro4 = TASK:BranchCoroutine(function() GAME:FadeIn(20) end)

GAME:WaitFrames(80)

UI:SetSpeaker(Madilyn)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Hm, [pause=10]looks like we've reached a rest point.")

coro1 = TASK:BranchCoroutine(function() GROUND:CharAnimateTurn(player, Direction.Left, 4, true) end)
coro2 = TASK:BranchCoroutine(function() GROUND:CharAnimateTurn(Madilyn, Direction.Right, 4, false) end)
coro3 = TASK:BranchCoroutine(function() GROUND:CharAnimateTurn(Kecleon, Direction.Left, 4, true) end)

GAME:WaitFrames(20)

UI:WaitShowDialogue("Take this time to rest a bit, [pause=10]there might be a few more floors ahead.")

GAME:WaitFrames(10)

UI:SetSpeaker(Kecleon)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("I know I will, [pause=10]but uhm...")

GROUND:EntTurn(Kecleon, Direction.UpLeft)
GAME:WaitFrames(10)

UI:WaitShowDialogue("What's that thing right there?")

coro1 = TASK:BranchCoroutine(function() GROUND:CharAnimateTurn(player, Direction.Up, 4, false) end)
coro2 = TASK:BranchCoroutine(function() GROUND:CharAnimateTurn(Madilyn, Direction.UpRight, 4, true) end)

GAME:WaitFrames(10)
UI:SetSpeaker(Madilyn)
UI:ResetSpeakerLoc()
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Oh, [pause=10]that thing. [pause=0]I've seen those around, [pause=10]but they're not popular in [color=#FFC663]Treasure Town[color].")
UI:WaitShowDialogue("They're called [color=#32a852]Deposit Boxes[color]. [pause=0]It combines storage and banking in one convenient place.")
UI:WaitShowDialogue("I'm not sure who made them, [pause=10]and I don't know how the items move between boxes...")

SOUND:PlayBattleSE("EVT_Emote_Confused")
GROUND:CharSetEmote(Kecleon, "question", 1)
GROUND:EntTurn(Kecleon, Direction.Left)
GAME:WaitFrames(40)

UI:SetSpeaker(Kecleon)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("That does sound useful...")
UI:WaitShowDialogue("But why don't we have one in [color=#FFC663]Treasure Town[color]? [pause=0]It'd save a lot of time.")

coro1 = TASK:BranchCoroutine(function() GROUND:CharAnimateTurn(player, Direction.DownRight, 4, false) end)
coro2 = TASK:BranchCoroutine(function() GROUND:CharAnimateTurn(Madilyn, Direction.Right, 4, false) end)

		SOUND:PlayBattleSE("EVT_Emote_Complain_2")
		GROUND:CharSetEmote(Madilyn, "angry", 0)
		GAME:WaitFrames(20)
		
		UI:SetSpeaker(Madilyn)
		UI:ResetSpeakerLoc()
		UI:SetSpeakerEmotion("Determined")
		UI:WaitShowDialogue(CH('Kecleon'):GetDisplayName() .."! [pause=0]Did you forget about miss [color=#00FFFF]Kangaskhan[color] and [color=#00FFFF]Duskull[color]?!")
		UI:WaitShowDialogue("They need jobs too!")
		
SOUND:PlayBattleSE("EVT_Emote_Shock")
GROUND:CharSetEmote(Kecleon, "shock", 1)
GAME:WaitFrames(30)

UI:SetSpeaker(Kecleon)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Surprised", true)
UI:WaitShowDialogue("Wahh! [pause=0]I'm sorry!")
UI:SetSpeakerEmotion("Pain", true)
UI:WaitShowDialogue("I didn't think it'd put those two out of business just by having one around...")
GROUND:CharSetEmote(Madilyn, "", 0)

SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")
GROUND:CharSetEmote(Madilyn, "sweatdrop", 1)
GAME:WaitFrames(40)

UI:SetSpeaker(Madilyn)
UI:ResetSpeakerLoc()
UI:SetSpeakerEmotion("Sigh")
UI:WaitShowDialogue("...I guess you wouldn't know any better.")

GROUND:EntTurn(Madilyn, Direction.UpRight)
GROUND:CharAnimateTurn(player, Direction.DownLeft, 4, false)

GAME:WaitFrames(10)

UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue(CH('PLAYER'):GetDisplayName() ..", [pause=10]use this [color=#32a852]Deposit Box[color] to store \u{E024}, [pause=10]and supplies you don't need.")

if SV.playerinfo.continent == 'GatesToInf' then
UI:WaitShowDialogue("The [color=#FFC663]Magna Region[color] was the first region where this kinda thing was used often, [pause=10]so you should know your way around it.")
elseif SV.playerinfo.continent == 'Super' then

	if SV.playerinfo.town == 'SereneVillage' then
		UI:WaitShowDialogue("[color=#FFC663]Serene Village[color] has one of these...")
	elseif SV.playerinfo.town == 'LivelyTown' then
		UI:WaitShowDialogue("[color=#FFC663]Lively Town[color] has one of these...")
	else
		UI:WaitShowDialogue("The [color=#FFC663]Prospect Region[color] should have a few around...")
end
	UI:WaitShowDialogue("You should have no issues trying to use it.")

else
	
	UI:WaitShowDialogue("If you don't know what they are... [pause=20]imagine a stone [color=#00FFFF]Kangaskhan[color], [pause=10]these [color=#32a852]Deposit Boxes[color] are like those things.")
	UI:WaitShowDialogue("It should be easy to grasp after a while.")
	
end

UI:WaitShowDialogue("We'll be hanging around out here for a bit while you get ready.")

GAME:MoveCamera(0, 0, 20, true)
GAME:CutsceneMode(false)
SV.chapter1.crumble_rest_cutscene = true
end

function CrumbleCanyonMidway.Madilyn_Action(chara, activator)
GROUND:CharTurnToChar(chara, activator)

		UI:SetSpeaker(chara)
		UI:SetSpeakerEmotion("Normal")
		UI:WaitShowDialogue("Ready when you are.")
		
GROUND:EntTurn(chara, Direction.UpRight)
end

function CrumbleCanyonMidway.Kecleon_Action(chara, activator)
GROUND:CharTurnToChar(chara, activator)

		UI:SetSpeaker(chara)
		UI:SetSpeakerEmotion("Normal")
		UI:WaitShowDialogue("I think we're close to the end...")
		
GROUND:EntTurn(chara, Direction.UpLeft)
end

function CrumbleCanyonMidway.Teammate1_Action(chara, activator)
   --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function CrumbleCanyonMidway.Teammate2_Action(chara, activator)
   --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function CrumbleCanyonMidway.Teammate3_Action(chara, activator)
   --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function CrumbleCanyonMidway.Leave_Touch(obj, activator)

UI:ResetSpeaker()
UI:ChoiceMenuYesNo("Do you want to leave the dungeon?", false)
UI:WaitForChoice()
ch = UI:ChoiceResult()
if ch then

GAME:FadeOut(false, 30)
GAME:WaitFrames(30)

local guestCount = GAME:GetPlayerGuestCount()

if SV.chapter.number < 2 then

		for i = 0, guestCount - 1, 1 do
		
		GAME:RemovePlayerGuest(0)

		end

end

GAME:EnterZone('treasuretownzone', -1, 17, 0) --Temporary fix. I can't tell why it's doing this.
COMMON.EndDayCycle()

else

end

end

function CrumbleCanyonMidway.Continue_Touch(obj, activator)

UI:ResetSpeaker()
UI:ChoiceMenuYesNo("Travel further into the dungeon?", false)
UI:WaitForChoice()
ch = UI:ChoiceResult()

if ch then
GAME:FadeOut(false, 30)
GAME:ContinueDungeon('roadwalkpathway', 1, 0, 0)
else

end

end

function CrumbleCanyonMidway.DepositBox_Action(obj, activator)

COMMON:ShowTeamStorageMenu()

end

return CrumbleCanyonMidway

