--[[
    init.lua
    Created: 01/21/2024 21:12:56
    Description: Autogenerated script file for the map CrumbleCanyonThieves.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local CrumbleCanyonThieves = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---CrumbleCanyonThieves.Init(map)
--Engine callback function
function CrumbleCanyonThieves.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  

end

---CrumbleCanyonThieves.Enter(map)
--Engine callback function
function CrumbleCanyonThieves.Enter(map)

if not SV.chapter1.thieves_defeated then

	if not SV.chapter1.thieves_cutscene then
CutsceneAlpha()
	elseif SV.chapter1.thieves_cutscene then
CrumbleCanyonThieves.cutscenebeta()
	end
elseif SV.chapter1.thieves_defeated == true then
CutsceneFinal()
end

end

---CrumbleCanyonThieves.Exit(map)
--Engine callback function
function CrumbleCanyonThieves.Exit(map)


end

---CrumbleCanyonThieves.Update(map)
--Engine callback function
function CrumbleCanyonThieves.Update(map)


end

---CrumbleCanyonThieves.GameSave(map)
--Engine callback function
function CrumbleCanyonThieves.GameSave(map)


end

---CrumbleCanyonThieves.GameLoad(map)
--Engine callback function
function CrumbleCanyonThieves.GameLoad(map)

  GAME:FadeIn(20)

end

-------------------------------
-- Entities Callbacks
-------------------------------

function CutsceneAlpha() --No skips.
local player = CH('PLAYER')
local Madilyn = CH('Madilyn')
local Kecleon = CH('Kecleon')
local Skiddo = CH('Skiddo')
local Ziggy1 = CH('Ziggy1')
local Ziggy2 = CH('Ziggy2')
local Ziggy3 = CH('Ziggy3')
local Ziggy4 = CH('Ziggy4')
local ScraftyA = CH('ScraftyA')
local ScraftyB = CH('ScraftyB') --Probably unneccessary.

GAME:CutsceneMode(true)
SOUND:PlayBGM("None", true)

UI:WaitShowTitle("The Pathway of\nCrumble Canyon", 20)
GAME:WaitFrames(60)
UI:WaitHideTitle(20)
GAME:WaitFrames(20)

--GROUND:CharSetAnim(Skiddo, "Shake", true)
GROUND:CharSetEmote(Skiddo, "angry", 0)
--GROUND:CharSetEmote(Ziggy1, "glowing", 0)
--GROUND:CharSetEmote(Ziggy2, "glowing", 0)
GROUND:CharSetEmote(Ziggy3, "glowing", 0)
GROUND:CharSetEmote(Ziggy4, "glowing", 0)
GROUND:CharSetEmote(Kecleon, "angry", 0)
GAME:MoveCamera(300, 174, 1, false)
GAME:FadeIn(20)
SOUND:PlayBGM("In The Dark.ogg", true)
GAME:WaitFrames(30)

UI:SetSpeaker('[color=#00FFFF]Zigzagoons[color]', true, "", -1, "", RogueEssence.Data.Gender.Unknown)
UI:WaitShowDialogue("Food! [pause=20]Food! [pause=20]Give us the food!") --There's no such thing as rat men.

GAME:WaitFrames(10)

UI:SetSpeaker(Skiddo)
UI:SetSpeakerLoc(100,50)
UI:SetSpeakerEmotion("Determined")
UI:WaitShowDialogue("No! [pause=0]I already told you that I'm not carrying any food for you, [pause=10]so leave me alone!")

GAME:WaitFrames(20)
GROUND:EntTurn(ScraftyA, Direction.Left)
GAME:WaitFrames(10)

UI:SetSpeaker(ScraftyA)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Geez, [pause=10]this kid's not giving up easily...")

GROUND:EntTurn(ScraftyB, Direction.Right)
GAME:WaitFrames(10)

UI:SetSpeaker(ScraftyB)
UI:ResetSpeakerLoc()
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("You're not kidding... [pause=20]It's been quite a long while, [pause=10]and the [color=#00FFFF]Zigzagoons[color] still fighting him.")
UI:WaitShowDialogue("Erm, [pause=10]I forgot why we're here. [pause=0]Do you know why?")

GAME:WaitFrames(10)

UI:SetSpeaker(ScraftyA)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Uhmmm... [pause=20][color=#00FFFF]Thievul[color] put us here, [pause=10]I think?")

GAME:WaitFrames(10)

UI:SetSpeaker(ScraftyB)
UI:ResetSpeakerLoc()
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Oh yeah, [pause=10]to catch... [pause=20]some Pokémon he was after. [pause=0]\nI don't know which one...") --Would be better to have this in a new line than be a strange dialogue box.
UI:WaitShowDialogue("I stopped listening after he said he'd pay us nicely.")

GAME:WaitFrames(10)

UI:SetSpeaker(ScraftyA)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Special0", true)
UI:WaitShowDialogue("Ooh, [pause=10]it must be this one, [pause=10]brother! [pause=0]This [color=#00FFFF]Skiddo[color] is carrying valuable supplies on him!")
GROUND:EntTurn(ScraftyA, Direction.UpLeft)
GROUND:EntTurn(ScraftyB, Direction.UpRight)
GAME:WaitFrames(10)

UI:SetSpeaker(ScraftyB)
UI:ResetSpeakerLoc()
UI:SetSpeakerEmotion("Special0")
UI:WaitShowDialogue("You're right, [pause=10]brother. [pause=0]Let's get this over with, [pause=10]and steal his loot for the boss!")

local coro1 = TASK:BranchCoroutine(function()
GROUND:AnimateInDirection(Skiddo, "Shaking", Direction.Down, Direction.Up, 5, 3, 2)
GROUND:CharSetAnim(Skiddo, "Shake", true)
end)

local coro2 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy1, Direction.UpRight, 10, false, 1)
end)

local coro3 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(ScraftyB, Direction.UpRight, 10, false, 1)
end)

local coro4 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy2, Direction.UpLeft, 10, false, 1)
end)

local coro5 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(ScraftyA, Direction.UpLeft, 10, false, 1)
end)

local coro6 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy3, Direction.Left, 10, false, 1)
end)

local coro7 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy4, Direction.Right, 10, false, 1)
end)

GROUND:CharSetEmote(Skiddo, "", 0)

GAME:WaitFrames(30)

UI:SetSpeaker(Skiddo)
UI:SetSpeakerLoc(100,50)
UI:SetSpeakerEmotion("Pain")
UI:WaitShowDialogue("Oh crud! [pause=0]There's too many of them around me...!")

GAME:WaitFrames(20)

GROUND:CharSetEmote(Ziggy1, "exclaim", 1)
GROUND:CharSetEmote(Ziggy2, "exclaim", 1)
GROUND:CharSetEmote(Ziggy3, "exclaim", 1)
GROUND:CharSetEmote(Ziggy4, "exclaim", 1)
GROUND:CharSetEmote(Skiddo, "exclaim", 1)
GROUND:CharSetEmote(ScraftyA, "exclaim", 1)
GROUND:CharSetEmote(ScraftyB, "exclaim", 1)
SOUND:PlayBattleSE("EVT_Emote_Exclaim")

SOUND:PlayBGM("None", true)

UI:SetSpeaker(STRINGS:Format("\\uE040"), true, "", -1, "", RogueEssence.Data.Gender.Unknown)
UI:ResetSpeakerLoc()
UI:WaitShowDialogue("You [color=#00FFFF]Skunktank[color]-smelling thieves!")

coro1 = TASK:BranchCoroutine(function()
GAME:WaitFrames(6)
CrumbleCanyonThieves.TurnLeft_Sequence(ScraftyA)
end)

coro2 = TASK:BranchCoroutine(function()
GAME:WaitFrames(4)
CrumbleCanyonThieves.TurnLeft_Sequence(ScraftyB)
end)

coro3 = TASK:BranchCoroutine(function()
GAME:WaitFrames(7)
CrumbleCanyonThieves.TurnLeft_Sequence(Ziggy1)
end)

coro4 = TASK:BranchCoroutine(function()
GAME:WaitFrames(6)
CrumbleCanyonThieves.TurnLeft_Sequence(Ziggy2)
end)

coro5 = TASK:BranchCoroutine(function()
GAME:WaitFrames(5)
CrumbleCanyonThieves.TurnLeft_Sequence(Ziggy3)
end)

coro6 = TASK:BranchCoroutine(function()
GAME:WaitFrames(2)
CrumbleCanyonThieves.TurnLeft_Sequence(Ziggy4)
end)

TASK:JoinCoroutines({coro1,coro2,coro3,coro4,coro5,coro6}) --What the f*** is this, this should not work.

coro1 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Kecleon, Direction.Right, 70, true, 3)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(player, Direction.Right, 80, false, 2)
end)

coro3 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Madilyn, Direction.Right, 80, false, 2)
end)

GAME:WaitFrames(70)

GROUND:CharSetEmote(Ziggy1, "shock", 1)
GROUND:CharSetEmote(Ziggy2, "shock", 1)
GROUND:CharSetEmote(Ziggy3, "shock", 1)
GROUND:CharSetEmote(Ziggy4, "shock", 1)
GROUND:CharSetEmote(Skiddo, "shock", 1)
GROUND:CharSetEmote(ScraftyA, "shock", 1)
GROUND:CharSetEmote(ScraftyB, "shock", 1)
SOUND:PlayBattleSE("EVT_Emote_Shock")
GROUND:AnimateInDirection(ScraftyB, "Walk", Direction.Left, Direction.Right, 5, 3, 2)

GAME:WaitFrames(40)

UI:SetSpeaker(ScraftyB)
UI:SetSpeakerEmotion("Surprised", true)
UI:WaitShowDialogue("Waaahh! [pause=0]It's an angry [color=#00FFFF]Kecleon[color]!")

GAME:WaitFrames(10)

UI:SetSpeaker(ScraftyA)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Surprised", true)
UI:WaitShowDialogue("A whaaaat!? [pause=0]Let's get out of here before he catches us!")

SOUND:PlayBattleSE("_UNK_EVT_086")

coro1 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Kecleon, Direction.Right, 60, true, 2)
GROUND:CharWaitAnim(Kecleon, "Hop")
GAME:WaitFrames(5)
GROUND:CharWaitAnim(Kecleon, "Hop")
end)

 coro2 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy1, Direction.Right, 100, true, 3)
end)

 coro3 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(ScraftyB, Direction.Right, 100, true, 3)
end)

 coro4 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy2, Direction.Right, 100, true, 3)
end)

 coro5 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(ScraftyA, Direction.Right, 100, true, 3)
end)

 coro6 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy3, Direction.Right, 100, true, 3)
end)

 coro7 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy4, Direction.Right, 100, true, 3)
end)

local coro8 = TASK:BranchCoroutine(function()
GROUND:MoveToPosition(player, 292, 200, true, 2)
GAME:WaitFrames(40)
GROUND:CharAnimateTurnTo(player, Direction.Up, 4)
end)

local coro9 = TASK:BranchCoroutine(function()
GROUND:MoveToPosition(Madilyn, 273, 178, false, 2)
GROUND:EntTurn(Madilyn, Direction.UpRight)
end)

GAME:WaitFrames(10)
UI:SetSpeaker(Kecleon)
UI:SetSpeakerEmotion("Angry")
UI:WaitShowTimedDialogue("Go on, [pause=10]get out of here! [pause=30]I don't want to see your faces near my worker ever again!", 60)

GROUND:CharSetEmote(Kecleon, "sweatdrop", 1)
SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")

UI:SetSpeakerEmotion("Pain")
UI:WaitShowDialogue("Whew...[pause=30]") --273 178 madi / 292 200 player

GROUND:MoveToPosition(Kecleon, 311, 178, false, 2)
GROUND:EntTurn(Kecleon, Direction.UpLeft)

SOUND:PlayBGM("A05. Cave Camp.ogg", true)

UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Are you okay, [pause=10][color=#00FFFF]Skiddo[color]? [pause=0]Did they hurt you?")

GROUND:CharSetEmote(Skiddo, "notice", 1)
SOUND:PlayBattleSE("EVT_Emote_Exclaim_2")
GAME:WaitFrames(20)
GROUND:CharSetAnim(Skiddo, "None", true)
GAME:WaitFrames(15)
GROUND:EntTurn(Skiddo, Direction.DownRight)
GAME:WaitFrames(10)

UI:SetSpeaker(Skiddo)
UI:SetSpeakerLoc(100,50)
UI:SetSpeakerEmotion("Surprised")
UI:WaitShowDialogue("Mister [color=#00FFFF]Kecleon[color]?! [pause=0]How did you find me?")

GROUND:CharSetEmote(Kecleon, "sweatdrop", 1)
SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")
GAME:WaitFrames(40)

UI:SetSpeaker(Kecleon)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("[color=#54ebaf]Madilyn[color] here found a job on the board saying you were in danger.")
UI:SetSpeakerEmotion("Happy", true)
UI:WaitShowDialogue("You can thank her for the most part, [pause=10]eh heh...")

GAME:WaitFrames(10)

UI:SetSpeaker(Skiddo)
UI:SetSpeakerLoc(100,50)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Thank [color=#00FFFF]Arceus[color] for that, [pause=10]those bandits would've knocked me out...")
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("...But why'd you bring the explorers with you? [pause=0]Aren't you very strong on your own?")

	SOUND:PlayBattleSE("EVT_Emote_Sweating")
	GROUND:CharSetEmote(Kecleon, "sweating", 1)
	GAME:WaitFrames(40)
	
UI:SetSpeaker(Kecleon)
UI:SetSpeakerEmotion("Worried", true)
UI:SetSpeakerLoc(264, 131)
UI:WaitShowDialogue("W-[pause=10]What do you mean? [pause=0]I'm not *that* weak, [pause=10]eh heh...")

GROUND:EntTurn(Madilyn, Direction.Right)
GROUND:EntTurn(player, Direction.UpRight)

GAME:WaitFrames(30)
GROUND:EntTurn(Kecleon, Direction.Left)
GAME:WaitFrames(30)

SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")
GROUND:CharSetEmote(Kecleon, "sweatdrop", 1)
		GAME:WaitFrames(40)
		
		UI:SetSpeakerEmotion("Pain", true)
		UI:WaitShowDialogue("Okay, [pause=10]okay... [pause=20]I'm completely useless in dungeons... [br]I'm just too weak to traverse through them!")
		
		GAME:WaitFrames(10)
		
UI:SetSpeaker(STRINGS:Format("\\uE040"), true, "", -1, "", RogueEssence.Data.Gender.Unknown)
UI:ResetSpeakerLoc()
SOUND:PlayBGM("None", true)
		UI:WaitShowDialogue("WEAK!?!?")
		
coro1 = TASK:BranchCoroutine(function()

GAME:WaitFrames(4)

GROUND:CharSetEmote(Madilyn, "question", 1)
GAME:WaitFrames(40)

GROUND:CharAnimateTurn(Madilyn, Direction.DownLeft, 4, true)
GAME:WaitFrames(11)
GROUND:CharAnimateTurn(Madilyn, Direction.UpLeft, 4, false)
GAME:WaitFrames(8)
GROUND:EntTurn(Madilyn, Direction.Left)

end)

coro2 = TASK:BranchCoroutine(function()

GAME:WaitFrames(7)

GROUND:CharSetEmote(Kecleon, "question", 1)
GAME:WaitFrames(40)

GROUND:CharAnimateTurn(Kecleon, Direction.DownRight, 4, true)
GAME:WaitFrames(6)
GROUND:CharAnimateTurn(Kecleon, Direction.Right, 4, true)
GAME:WaitFrames(12)
GROUND:EntTurn(Kecleon, Direction.UpRight)

end)

coro3 = TASK:BranchCoroutine(function()

GAME:WaitFrames(5)

GROUND:CharSetEmote(player, "question", 1)
GAME:WaitFrames(40)

GROUND:CharAnimateTurn(player, Direction.Right, 4, false)
GAME:WaitFrames(15)
GROUND:CharAnimateTurn(player, Direction.Left, 4, true)
GAME:WaitFrames(15)
GROUND:CharAnimateTurn(player, Direction.Right, 4, false)

end)

coro4 = TASK:BranchCoroutine(function()

GAME:WaitFrames(6)

GROUND:CharSetEmote(Skiddo, "question", 1)
GAME:WaitFrames(40)

GROUND:CharAnimateTurn(Skiddo, Direction.DownLeft, 4, false)
GAME:WaitFrames(11)
GROUND:CharAnimateTurn(Skiddo, Direction.DownRight, 4, true)
GAME:WaitFrames(10)
GROUND:EntTurn(Skiddo, Direction.Down)

end)

SOUND:PlayBattleSE("EVT_Emote_Confused")
GAME:WaitFrames(40)
SOUND:PlayBattleSE("EVT_Emote_Confused")
GAME:WaitFrames(20)
SOUND:PlayBattleSE("EVT_Emote_Confused")
GAME:WaitFrames(90)

UI:SetSpeaker(player, false)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(What the...? [pause=0]Who was speaking just now?)")

GAME:WaitFrames(20)

GROUND:CharAnimateTurn(Madilyn, Direction.Right, 4, false)
GAME:WaitFrames(10)

UI:SetSpeaker(Madilyn)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("That's odd, [pause=10]did one of you talk?")

GROUND:EntTurn(player, Direction.UpLeft)

coro1 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Kecleon, Direction.Left, 4, false)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(player, Direction.UpLeft, 4, false)
end)

coro3 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Skiddo, Direction.DownLeft, 4, false)
end)

GAME:WaitFrames(30)

UI:SetSpeaker(Kecleon)
UI:SetSpeakerEmotion("Worried", true)
UI:SetSpeakerLoc(264, 131)
UI:WaitShowDialogue("That voice wasn't mine... [pause=20]who's could it be?")

GAME:WaitFrames(20)

UI:SetSpeaker(STRINGS:Format("\\uE040"), true, "", -1, "", RogueEssence.Data.Gender.Unknown)
UI:ResetSpeakerLoc()
UI:WaitShowDialogue("You thought you could bluff your way past us?!")

	local emitter = RogueEssence.Content.SingleEmitter(RogueEssence.Content.AnimData("Dig", 3))
	emitter.LocHeight = 5
	
	coro1 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 424, 184)
	GROUND:TeleportTo(ScraftyA, 424, 184, Direction.Left)
	end)
	
	coro2 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 160, 184)
	GROUND:TeleportTo(ScraftyB, 160, 184, Direction.Right)
	end)
	
	coro3 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 225, 169)
	GROUND:TeleportTo(Ziggy1, 225, 169, Direction.Right)
	end)
	
	coro4 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 201, 201) --I swear this is accidental.
	GROUND:TeleportTo(Ziggy2, 201, 201, Direction.Right)
	end)
	
	coro5 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 382, 169)
	GROUND:TeleportTo(Ziggy3, 382, 169, Direction.Left)
	end)
	
	coro6 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 359, 209)
	GROUND:TeleportTo(Ziggy4, 359, 201, Direction.Left)
	end)
	
	SOUND:PlayBattleSE("DUN_Dig")
	
	GAME:WaitFrames(20)
	
	GROUND:CharSetEmote(player, "shock", 1)
	GROUND:CharSetEmote(Skiddo, "shock", 1)
	GROUND:CharSetEmote(Madilyn, "exclaim", 1) --intentional
	GROUND:CharSetEmote(Kecleon, "shock", 1)
	
SOUND:PlayBattleSE("EVT_Emote_Shock")
SOUND:PlayBGM("Rising Fear.ogg", true)

coro1 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Kecleon, Direction.Right, 2, false)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(player, Direction.Left, 2, true)
end)

coro3 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Skiddo, Direction.DownRight, 2, true)
end)

coro4 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Madilyn, Direction.Left, 2, false)
end)

GAME:WaitFrames(40)

UI:SetSpeaker(Madilyn)
UI:SetSpeakerEmotion("Determined")
UI:WaitShowDialogue("".. CH('PLAYER'):GetDisplayName() ..", [pause=10]get the other side! [pause=0]I can handle these ones by myself!")

coro1 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(player, Direction.Right, 20, false, 2)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Skiddo, Direction.DownRight, 10, false, 2)
GROUND:MoveInDirection(Skiddo, Direction.Right, 10, false, 2)
end)

coro3 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Kecleon, Direction.DownLeft, 10, false, 2)
GROUND:CharAnimateTurn(Kecleon, Direction.Right, 3, true)
end)

GAME:WaitFrames(30)

UI:SetSpeaker(Skiddo)
UI:SetSpeakerEmotion("Determined")
UI:WaitShowDialogue("Don't worry, [pause=10]I'll help you out! [pause=0]I don't wanna sit back and do nothing!")
UI:WaitShowDialogue("These bullies need to be put in their place!")

	local mon_id = RogueEssence.Dungeon.MonsterID("skiddo", 0, "normal", Gender.Male)
	local skiddo = _DATA.Save.ActiveTeam:CreatePlayer(_DATA.Save.Rand, mon_id, 5, "sap_sipper", 0)
	skiddo.Discriminator = _DATA.Save.Rand:Next()--tbh idk what this is lol
	skiddo.Level = 15
	skiddo.Nickname = 'Skiddo'
	skiddo.IsPartner = true-- if they somehow manage to die, end the run / Thanks Palika.
	
	skiddo.MaxHPBonus = 10
	skiddo.AtkBonus = 0
	skiddo.DefBonus = 0
	skiddo.MDefBonus = 0
	skiddo.SpeedBonus = 0

	skiddo:ReplaceSkill("leech_seed", 0, true)
	skiddo:ReplaceSkill("razor_leaf", 1, true)
	skiddo:ReplaceSkill("rock_climb", 2, false)
	skiddo:ReplaceSkill("helping_hand", 3, false)
	
	GAME:AddPlayerGuest(skiddo)
	skiddo:FullRestore()
    local talk_evt = RogueEssence.Dungeon.BattleScriptEvent("SkiddoInteract")
    skiddo.ActionEvents:Add(talk_evt)
	skiddo:RefreshTraits()
	
SOUND:PlayBGM("None", true)
COMMON.BossTransition()
GAME:FadeOut(true, 0)
SV.chapter1.thieves_cutscene = true

GAME:CutsceneMode(false)

GAME:EnterZone('roadwalkpathway', 1, 0, 0) --Should work / Yeah, it does.

end

function CutsceneFinal()
local player = CH('PLAYER')
local Madilyn = CH('Madilyn')
local Kecleon = CH('Kecleon')
local Skiddo = CH('Skiddo')
local Ziggy1 = CH('Ziggy1')
local Ziggy2 = CH('Ziggy2')
local Ziggy3 = CH('Ziggy3')
local Ziggy4 = CH('Ziggy4')
local ScraftyA = CH('ScraftyA')
local ScraftyB = CH('ScraftyB')

GAME:CutsceneMode(true)
SOUND:PlayBGM("None", true)
GAME:MoveCamera(300, 174, 1, false)

	GROUND:TeleportTo(ScraftyA, 424, 184, Direction.Left)
	GROUND:TeleportTo(ScraftyB, 160, 184, Direction.Right)
	GROUND:TeleportTo(Ziggy1, 225, 169, Direction.Right)
	GROUND:TeleportTo(Ziggy2, 201, 201, Direction.Right)
	GROUND:TeleportTo(Ziggy3, 382, 169, Direction.Left)
	GROUND:TeleportTo(Ziggy4, 359, 201, Direction.Left)
	GROUND:TeleportTo(player, 332, 200, Direction.Right)
	GROUND:TeleportTo(Skiddo, 332, 176, Direction.Right)
	GROUND:TeleportTo(Kecleon, 291, 198, Direction.Right)
	GROUND:TeleportTo(Madilyn, 273, 178, Direction.Left)

GAME:FadeIn(20)

GROUND:CharSetAnim(Skiddo, "Attack", false)
GROUND:CharSetAnim(player, "Attack", false)
GROUND:CharSetAnim(Madilyn, "Attack", false)

GAME:WaitFrames(5)
GAME:FadeOut(true, 1)
GAME:FadeIn(1)
SOUND:PlayBattleSE("EVT_Battle_Flash")

local coro1 = TASK:BranchCoroutine(function()
GROUND:AnimateInDirection(Ziggy1, "Walk", Direction.Right, Direction.Left, 10, 3, 2)
end)

local coro2 = TASK:BranchCoroutine(function()
GROUND:AnimateInDirection(ScraftyB, "Walk", Direction.Right, Direction.Left, 10, 3, 2)
end)

local coro3 = TASK:BranchCoroutine(function()
GROUND:AnimateInDirection(Ziggy2, "Walk", Direction.Right, Direction.Left, 10, 3, 2)
end)

local coro4 = TASK:BranchCoroutine(function()
GROUND:AnimateInDirection(ScraftyA, "Walk", Direction.Left, Direction.Right, 10, 3, 2)
end)

local coro5 = TASK:BranchCoroutine(function()
GROUND:AnimateInDirection(Ziggy3, "Walk", Direction.Left, Direction.Right, 10, 3, 2)
end)

local coro6 = TASK:BranchCoroutine(function()
GROUND:AnimateInDirection(Ziggy4, "Walk", Direction.Left, Direction.Right, 10, 3, 2)
end)

GAME:WaitFrames(30)

UI:SetSpeaker(ScraftyB)
UI:SetSpeakerEmotion("Angry")
UI:WaitShowDialogue("Nnf, [pause=10]no fair! [pause=0]We had numbers, [pause=10]and everything...!")

GAME:WaitFrames(10)

UI:SetSpeaker(ScraftyA)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Worried", true)
UI:WaitShowDialogue("Brother, [pause=10]let's just get out of here.")
UI:WaitShowDialogue("They won fair and square...")

	SOUND:PlayBattleSE("EVT_Emote_Sweating")
	GROUND:CharSetEmote(ScraftyB, "sweating", 1)
	GAME:WaitFrames(40)
	UI:ResetSpeakerLoc()
	
UI:SetSpeaker(ScraftyB)
UI:SetSpeakerEmotion("Determined")
UI:WaitShowDialogue("Grr, [pause=10]fine... [pause=20]They can't catch us both!")
UI:WaitShowDialogue("Let's scramble out'a here!")

 coro1 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy1, Direction.Left, 100, true, 3)
end)

 coro2 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(ScraftyB, Direction.Left, 100, true, 3)
end)

 coro3 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy2, Direction.Left, 100, true, 3)
end)

 coro4 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(ScraftyA, Direction.Right, 100, true, 3)
end)

 coro5 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy3, Direction.Right, 100, true, 3)
end)

 coro6 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Ziggy4, Direction.Right, 100, true, 3)
end)

SOUND:PlayBattleSE("_UNK_EVT_086")
GAME:WaitFrames(120)
SOUND:PlayBGM("In the Depths of the Pit.ogg", true)

UI:SetSpeaker(Madilyn)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("I have a feeling that's not the last time we'll see them...")

coro1 = TASK:BranchCoroutine(function()
GROUND:CharTurnToCharAnimated(Kecleon, Madilyn, 4)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:CharTurnToCharAnimated(player, Madilyn, 4)
end)

coro3 = TASK:BranchCoroutine(function()
GROUND:CharTurnToCharAnimated(Skiddo, Madilyn, 4)
end)

coro4 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Madilyn, Direction.Right, 4, true)
end)

GAME:WaitFrames(10)
UI:SetSpeakerEmotion("Normal")

UI:WaitShowDialogue("I'll get those two later...")
UI:WaitShowDialogue("But for right now, [pause=10]we still have to get [color=#00FFFF]Skiddo[color] home.")
UI:WaitShowDialogue("Let's head back to [color=#FFC663]Treasure Town[color], [pause=10]we'll talk more there.")

GAME:WaitFrames(10)
GROUND:EntTurn(Madilyn, Direction.DownRight)

UI:SetSpeaker(Kecleon)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Please lead the way, [pause=10]then. [pause=0]This day's been exhausting.")

GROUND:CharAnimateTurn(Madilyn, Direction.Left, 4, false)

coro1 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Skiddo, Direction.Left, 100, false, 1)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Madilyn, Direction.Left, 100, false, 1)
end)

coro3 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(player, Direction.Left, 100, false, 1)
end)

coro4 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Kecleon, Direction.Left, 100, false, 1)
end)

coro5 = TASK:BranchCoroutine(function()
GAME:FadeOut(false, 40)
end)

SOUND:PlayBGM("None", true)

GAME:WaitFrames(80)

UI:WaitShowVoiceOver("Meanwhile...", -1)
GAME:WaitFrames(20)

GAME:EnterZone('cutscenezone', -1, 5, 0)

GAME:CutsceneMode(false)
end

function CrumbleCanyonThieves.cutscenebeta()
local player = CH('PLAYER')
local Madilyn = CH('Madilyn')
local Kecleon = CH('Kecleon')
local Skiddo = CH('Skiddo')
local Ziggy1 = CH('Ziggy1')
local Ziggy2 = CH('Ziggy2')
local Ziggy3 = CH('Ziggy3')
local Ziggy4 = CH('Ziggy4')
local ScraftyA = CH('ScraftyA')
local ScraftyB = CH('ScraftyB') --Probably unneccessary.

GAME:CutsceneMode(true)
SOUND:PlayBGM("None", true)

UI:WaitShowTitle("The Pathway of\nCrumble Canyon", 20)
GAME:WaitFrames(60)
UI:WaitHideTitle(20)
GAME:WaitFrames(20)

GAME:MoveCamera(300, 174, 1, false)
GAME:FadeIn(20)

	GROUND:TeleportTo(player, 292, 200, Direction.Right)
	GROUND:TeleportTo(Skiddo, 292, 156, Direction.Down)
	GROUND:TeleportTo(Kecleon, 311, 198, Direction.UpLeft)
	GROUND:TeleportTo(Madilyn, 273, 178, Direction.UpRight)
	
	GROUND:Hide("Ziggy1")
	GROUND:Hide("Ziggy2")
	GROUND:Hide("Ziggy3")
	GROUND:Hide("Ziggy4")
	GROUND:Hide("ScraftyA")
	GROUND:Hide("ScraftyB")
	
	UI:SetSpeaker(Madilyn)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("Looks like you're still here...")
	
	UI:SetSpeaker(Skiddo)
	UI:SetSpeakerEmotion("Surprised")
	UI:WaitShowDialogue("W-wait! [pause=0]The thieves also didn't leave!")
	UI:WaitShowTimedDialogue("They're...",15)
	
		local emitter = RogueEssence.Content.SingleEmitter(RogueEssence.Content.AnimData("Dig", 3))
	emitter.LocHeight = 5
	
	coro1 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 424, 184)
	GROUND:TeleportTo(ScraftyA, 424, 184, Direction.Left)
	end)
	
	coro2 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 160, 184)
	GROUND:TeleportTo(ScraftyB, 160, 184, Direction.Right)
	end)
	
	coro3 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 225, 169)
	GROUND:TeleportTo(Ziggy1, 225, 169, Direction.Right)
	end)
	
	coro4 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 201, 201) --I swear this is accidental.
	GROUND:TeleportTo(Ziggy2, 201, 201, Direction.Right)
	end)
	
	coro5 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 382, 169)
	GROUND:TeleportTo(Ziggy3, 382, 169, Direction.Left)
	end)
	
	coro6 = TASK:BranchCoroutine(function()
	GROUND:PlayVFX(emitter, 359, 209)
	GROUND:TeleportTo(Ziggy4, 359, 201, Direction.Left)
	end)
	
	SOUND:PlayBattleSE("DUN_Dig")
	
	GAME:WaitFrames(20)
	
	GROUND:CharSetEmote(player, "shock", 1)
	GROUND:CharSetEmote(Skiddo, "shock", 1)
	GROUND:CharSetEmote(Madilyn, "exclaim", 1) --intentional
	GROUND:CharSetEmote(Kecleon, "shock", 1)
	
SOUND:PlayBattleSE("EVT_Emote_Shock")
SOUND:PlayBGM("Rising Fear.ogg", true)

coro1 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Kecleon, Direction.Right, 2, false)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(player, Direction.Left, 2, true)
end)

coro3 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Skiddo, Direction.DownRight, 2, true)
end)

coro4 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Madilyn, Direction.Left, 2, false)
end)

UI:SetSpeaker(ScraftyB)
UI:SetSpeakerEmotion("Happy")
UI:WaitShowDialogue("Haha! [pause=0]Thanks for your stuff!~")
UI:WaitShowDialogue("You want it back? [pause=0]Too bad! ♪")

GAME:WaitFrames(10)

coro1 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(player, Direction.Right, 20, false, 2)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Skiddo, Direction.DownRight, 10, false, 2)
GROUND:MoveInDirection(Skiddo, Direction.Right, 10, false, 2)
end)

coro3 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Kecleon, Direction.DownLeft, 10, false, 2)
GROUND:CharAnimateTurn(Kecleon, Direction.Right, 3, true)
end)

GAME:WaitFrames(30)

UI:SetSpeaker(Skiddo)
UI:SetSpeakerEmotion("Determined")
UI:WaitShowDialogue("Grr, [pause=10]they make me so angry!")
UI:WaitShowDialogue("Come on, [pause=10]let's show them who's boss!")

	local mon_id = RogueEssence.Dungeon.MonsterID("skiddo", 0, "normal", Gender.Male)
	local skiddo = _DATA.Save.ActiveTeam:CreatePlayer(_DATA.Save.Rand, mon_id, 5, "sap_sipper", 0)
	skiddo.Discriminator = _DATA.Save.Rand:Next()--tbh idk what this is lol
	skiddo.Level = 15
	skiddo.Nickname = 'Skiddo'
	skiddo.IsPartner = true-- if they somehow manage to die, end the run / Thanks Palika.
	
	skiddo.MaxHPBonus = 10
	skiddo.AtkBonus = 0
	skiddo.DefBonus = 0
	skiddo.MDefBonus = 0
	skiddo.SpeedBonus = 0

	skiddo:ReplaceSkill("leech_seed", 0, true)
	skiddo:ReplaceSkill("razor_leaf", 1, true)
	skiddo:ReplaceSkill("rock_climb", 2, false)
	skiddo:ReplaceSkill("helping_hand", 3, false)
	
	GAME:AddPlayerGuest(skiddo)
	skiddo:FullRestore()
    local talk_evt = RogueEssence.Dungeon.BattleScriptEvent("SkiddoInteract")
    skiddo.ActionEvents:Add(talk_evt)
	skiddo:RefreshTraits()
	
SOUND:PlayBGM("None", true)
COMMON.BossTransition()
GAME:FadeOut(true, 0)

GAME:CutsceneMode(false)

GAME:EnterZone('roadwalkpathway', 1, 0, 0) --Should work / Yeah, it does.

end

function CrumbleCanyonThieves.TurnLeft_Sequence(character)

GROUND:CharAnimateTurnTo(character, Direction.Left, 4)

end

return CrumbleCanyonThieves

