--[[
    init.lua
    Created: 12/05/2022 16:30:53
    Description: Autogenerated script file for the map BranchwayWoodsEntrance.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local BranchwayWoodsEntrance = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---BranchwayWoodsEntrance.Init
--Engine callback function
function BranchwayWoodsEntrance.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  

end

---BranchwayWoodsEntrance.Enter
--Engine callback function
function BranchwayWoodsEntrance.Enter(map)
_DATA.Save.NoSwitching = true --Disable this at your own peril, cutscenes will stop making sense if the 'founder' Pokémon is not the leader. / I also don't know how to reference the Founder Pokémon in any way shape or form when they are NOT the leader.
_DATA.Save.ActiveTeam.Bank = 0 --No free cash for you.
_DATA.Save.ActiveTeam:SetRank("none") --This command is going to be common when the PC earns better Bag upgrades throughout the story. 8 Blocks of Inventory Space is all you should need for Branchway and Drenched.
SV.prologue_alts.talked_to_adam_at_cafe = 0 --Nil is not a number, therefore, it is a boolean. Don't touch unless you want Errors in other zones.
SV.repeatable.cameo_times_talked_to_bolt = 0 -- So the game doesn't bite my a-- later when I add more dialogue for him in other chapters, if they want him to have more dialogue.
SV.repeatable.madilyns_stories_told = 0
SV.repeatable.asked_adam_for_help = 0
SV.chapter.number = 0 --I feel like a secondary script that runs all these processes is more effective than continuously adding to one single script, but I don't even know if I'll even continue making this. / How did I miss this being wrong?
SV.prologue_alts.d_bluff_no_counter = 0

SV.checkpoint = 
  {
    Zone    = 'branchwaywoods', Segment  = -1,
    Map  = 0, Entry  = 1
  } --spawn right on top of DungeonFail. / This is intentional, and I will not change it.

--GROUND:Hide("NoReturn")

GAME:MoveCamera(252, 150, 1, false)

if not SV.branchwaywoodsentrance.DungeonFailed then 
  GROUND:Unhide("DungeonFail") --Wouldn't want the player activating this, I'm also too lazy to use a script to do the whole sequence without bludgeoning levels that worked before. / This comment aged well, but I'm tired of this place, so I'm not gonna fix it.
end

end

---BranchwayWoodsEntrance.Exit
--Engine callback function
function BranchwayWoodsEntrance.Exit(map)

GAME:FadeOut(false, 20)

end

---BranchwayWoodsEntrance.Update
--Engine callback function
function BranchwayWoodsEntrance.Update(map)


end

---BranchwayWoodsEntrance.GameSave
--Engine callback function
function BranchwayWoodsEntrance.GameSave(map)


end

---BranchwayWoodsEntrance.GameLoad
--Engine callback function
function BranchwayWoodsEntrance.GameLoad(map)

  GAME:FadeIn(20)

end

-------------------------------
-- Entities Callbacks
-------------------------------

function BranchwayWoodsEntrance.NoReturn_Touch(obj,activator)

local player = CH('PLAYER')

GAME:CutsceneMode(true)

UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['NoGoingBack']))

UI:ResetSpeaker()
UI:SetSpeakerEmotion("Normal")

GAME:CutsceneMode(false)
end

function BranchwayWoodsEntrance.Flowers_Action(obj, activator)

local player = CH('PLAYER')

GAME:CutsceneMode(true)

	if not SV.branchwaywoodsentrance.flower_inspect then

UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['FlowerInteract']))

SV.branchwaywoodsentrance.flower_inspect = true

	else

UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(They're just flowers, [pause=10]I have nothing else to say about them.)")

end

UI:ResetSpeaker()

GAME:CutsceneMode(false)

end

function BranchwayWoodsEntrance.BerryBasket_Action(obj, activator)

local player = CH('PLAYER')

GAME:CutsceneMode(true)

UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['BerryBasket']))
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(How unfortunate...)")

UI:ResetSpeaker()
UI:SetSpeakerEmotion("Normal")

GAME:CutsceneMode(false)

end

function BranchwayWoodsEntrance.SouthExit_Touch(obj, activator)

local player = CH('PLAYER')
UI:SetSpeaker(player)

UI:ChoiceMenuYesNo(STRINGS:Format(STRINGS.MapStrings['DungeonReady']), false)
UI:WaitForChoice()
ch = UI:ChoiceResult()
if ch then
    UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['DungeonStarting']))
	GAME:FadeOut(false, 20)
	GROUND:MoveInDirection(player, Direction.Down, 50, false, 3)
		
	GAME:EnterDungeon('branchwaywoodsdungeon', 0, 0, 0, RogueEssence.Data.GameProgress.DungeonStakes.Risk, true, true)
else
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(I don't have much time left... [pause=20]I need to hurry up before they catch up to me.)")
	end

end

function BranchwayWoodsEntrance.WalkDown_3_Touch(obj, activator) --The player spawns outside the map, there is an object that triggers this function. There should be ABSOLUTELY no way for a player to spawn, and not get to Branchway. Inefficient, but I'm tired.
--

GAME:CutsceneMode(true)
GROUND:Hide("NoReturn")
GROUND:Hide("DungeonFail")
SV.branchwaywoodsentrance.DungeonComplete = false

GAME:MoveCamera(252, 150, 1, false)

local player = CH('PLAYER')

GAME:FadeOut(false, 1)

UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Determined")

UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['Exposition2'])) --These are backwards for some reason but whatever.
UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['Exposition1']))

GAME:FadeIn(30)

GROUND:MoveInDirection(player, Direction.Down, 60, false, 2)
GROUND:CharSetEmote(player, "worried", 1)
GAME:WaitFrames(30)

UI:SetSpeakerEmotion("Sigh")
UI:WaitShowDialogue("(Whew, [pause=10]I made it back on the right path.)")
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(Something about this medallion I have is special to those two thieves...)")
UI:WaitShowDialogue("(I doubt it'll be worth much. [pause=0]It's covered in grime, [pause=10]and it doesn't look very special either.)")

GROUND:CharAnimateTurn(player, Direction.Up, 4, true)
GAME:WaitFrames(15)
--I should probably switch this to CharAnimateTurn, but it isn't so bad right now, so it works. / Ha, jokes on you, me. I just made it better. / Saved 4 frames. Not really sure if that's an improvement, or an annoyance.

UI:WaitShowDialogue("(Of course, [pause=10]those two might be interested in this thing...)")
UI:WaitShowDialogue("(But at the same time, [pause=10]I doubt I should just let them have it.)")
UI:WaitShowDialogue("(They just don't look very trustworthy...)")

GROUND:CharAnimateTurn(player, Direction.Down, 4, false)

GAME:WaitFrames(20)

SOUND:PlaySE("Fanfare/Note")

UI:ResetSpeaker()
UI:SetSpeakerEmotion("Normal")

UI:SetCenter(true)
UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['AdviceBulletin1']))
UI:SetCenter(false)
UI:WaitShowDialogue("When you get close to something interesting that is in tangible reach, you will emit a Question Mark.")
UI:WaitShowDialogue("Like so:")

	SOUND:PlayBattleSE("EVT_Emote_Confused")
    GROUND:CharSetEmote(player, "question", 1)
	
GAME:WaitFrames(40)

UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['ButtonPrompt'], STRINGS:LocalKeyString(0))) --LocalKeyString for getting Button Prompts, ex: 0 = Confirm, 1 = Cancel, etc.
UI:WaitShowDialogue("If you need some practice, there's a few things in an area that can be interacted with.[br]Practice to your heart's content!")

GAME:MoveCamera(0, 0, 20, true)

GAME:CutsceneMode(false)
  
  GROUND:Unhide("NoReturn")

end

function BranchwayWoodsEntrance.InteractiveNearby_Touch(obj, activator)

SOUND:PlayBattleSE("EVT_Emote_Confused")
    GROUND:CharSetEmote(activator, "question", 1)

end

function BranchwayWoodsEntrance.DungeonFail_Touch(obj, activator)

local player = CH('PLAYER')
GAME:CutsceneMode(true)

GAME:MoveCamera(0, 0, 20, true)
GAME:FadeIn(20)
GAME:WaitFrames(30)

UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Normal")

UI:WaitShowDialogue("...")

SOUND:PlayBattleSE("EVT_Emote_Confused")
    GROUND:CharSetEmote(activator, "question", 1)
	
GAME:WaitFrames(40)

UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(Hold on, [pause=10]was I just day-dreaming? [pause=0]Weird, [pause=10]it felt like it all really happened too...)")

GROUND:EntTurn(player, Direction.DownRight)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.Down)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.DownLeft)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.Down)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.DownRight)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.Down)
GAME:WaitFrames(8)

UI:SetSpeakerEmotion("Pain")
UI:WaitShowDialogue("(Nevermind, [pause=10]I should stop hesitating before they catch up to me.)")

GROUND:Hide("DungeonFail")
GAME:CutsceneMode(false)

SV.branchwaywoodsentrance.DungeonFailed = false
GROUND:Unhide("NoReturn")

end

return BranchwayWoodsEntrance
