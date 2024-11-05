--[[
    init.lua
    Created: 06/07/2023 21:58:28
    Description: Autogenerated script file for the map wigglyguildmiddle.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local wigglyguildmiddle = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---wigglyguildmiddle.Init(map)
--Engine callback function
function wigglyguildmiddle.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  

end

---wigglyguildmiddle.Enter(map)
--Engine callback function
function wigglyguildmiddle.Enter(map)
GROUND:Hide("Madilyn")
GROUND:Hide("Kecleon")
GROUND:Hide("Skiddo")
GROUND:Hide("AdamMudkip")
GROUND:Hide("Piks")

if SV.chapter1.apricorn_tutorial and not SV.chapter1.meeting_partB then
GROUND:Unhide("Madilyn")
end

local FadeLess = false

if SV.chapter.number == 1 and SV.chapter1.thieves_defeated then
CutsceneChapter1Closer()
FadeLess = true
end

if FadeLess == true then --This is stupid, but it's better than a whole SV.

else

  GAME:FadeIn(20)

end
  
  wigglyguildmiddle.default_initialize(wanderzoneloc, wanderzonesize, wanderspeed, wanderstepmin, wanderstepmax, idledelaymin, idledelaymax)

end

---wigglyguildmiddle.Exit(map)
--Engine callback function
function wigglyguildmiddle.Exit(map)


end

---wigglyguildmiddle.Update(map)
--Engine callback function
function wigglyguildmiddle.Update(map)


end

---wigglyguildmiddle.GameSave(map)
--Engine callback function
function wigglyguildmiddle.GameSave(map)


end

---wigglyguildmiddle.GameLoad(map)
--Engine callback function
function wigglyguildmiddle.GameLoad(map)

  GAME:FadeIn(20)

end

-------------------------------
-- Entities Callbacks
-------------------------------

function wigglyguildmiddle.LeaveGuild_Touch(obj, activator)

GAME:FadeOut(false, 20)
GAME:EnterGroundMap("wigglyguildtop", "EntranceUp")

end

function wigglyguildmiddle.EnterGuild_Touch(obj, activator)

if SV.chapter.number == 1 and SV.chapter1.thieves_defeated then



else
GAME:FadeOut(false, 20)
GAME:EnterGroundMap("wigglyguildbottom", "Entrance")

end
end

function wigglyguildmiddle.InfoBoard_Action(obj, activator)
local player = CH('PLAYER')

  UI:ResetSpeaker()
  UI:SetCenter(true)
  UI:SetAutoFinish(true)
  UI:WaitShowDialogue("It's an Information Board, it contains all the things you'll ever need to know.")
  
  choices = {STRINGS:Format(STRINGS.MapStrings['Tab1']),
    STRINGS:Format(STRINGS.MapStrings['Tab2']),
	STRINGS:Format(STRINGS.MapStrings['Tab3']),
	STRINGS:Format(STRINGS.MapStrings['Tab4']),
	STRINGS:Format(STRINGS.MapStrings['Tab5']),
	STRINGS:Format(STRINGS.MapStrings['Tab6']),
	STRINGS:Format(STRINGS.MapStrings['Tab7']),
	STRINGS:Format(STRINGS.MapStrings['Tab8']),
    STRINGS:Format(STRINGS.MapStrings['LeaveList'])}

UI:BeginChoiceMenu(STRINGS:Format(STRINGS.MapStrings['Tablist']), choices, 1, 9)
UI:WaitForChoice()
result = UI:ChoiceResult()
if result == 1 then
  UI:SetCenter(false)
  UI:SetAutoFinish(false)
	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(Too boring...)")
elseif result == 2 then
  UI:SetCenter(false)
  UI:SetAutoFinish(false)
  	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(I know what's written here, [pause=10]it's helpful stuff for someone that understands it.)")
	UI:WaitShowDialogue("(Unfortunately, [pause=10]whoever wrote this is insanely cryptic, and out of this world.)")
	elseif result == 3 then
  UI:SetCenter(false)
  UI:SetAutoFinish(false)
  	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(Surely dungeon work isn't so complicated that I'd need a guide on it.)")
	--UI:WaitShowDialogue("(If I just follow [color=#ffb5fd]Electrater[color]'s words, [pause=10]I should be golden.)")
	elseif result == 4 then
	  UI:SetCenter(false)
  UI:SetAutoFinish(false)
  	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(This isn't relevant right now.)")
	elseif result == 5 then
	  UI:SetCenter(false)
  UI:SetAutoFinish(false)
  	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(If I have my own team, [pause=10]this would've been useful.)")
	elseif result == 6 then
	  UI:SetCenter(false)
  UI:SetAutoFinish(false)
  	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(There's some strategy for eating Gummis?)")
	elseif result == 7 then
	  UI:SetCenter(false)
  UI:SetAutoFinish(false)
  	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(I'm by my lonesome, [pause=10]so this wouldn't help.)")
	elseif result == 8 then
	UI:SetCenter(false)
  UI:SetAutoFinish(false)
  	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(I know about Type Advantages already.)")
else
  UI:SetCenter(false)
  UI:SetAutoFinish(false)
	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
    UI:WaitShowDialogue("(I didn't want to read anyways.)")
end
  
  UI:SetCenter(false)
  UI:SetAutoFinish(false)

end

function wigglyguildmiddle.default_initialize(wanderzoneloc, wanderzonesize, wanderspeed, wanderstepmin, wanderstepmax, idledelaymin, idledelaymax)

AI:SetCharacterAI(CH('Bidoof_roamer'), "what_does_n_stand_for.ai.ground_default", RogueElements.Loc(390, 240), RogueElements.Loc(16, 16), 1, 16, 32, 40, 180)
AI:SetCharacterAI(CH('crawdaunt_roamer'), "what_does_n_stand_for.ai.ground_default", RogueElements.Loc(305, 275), RogueElements.Loc(16, 16), 1, 16, 32, 40, 180) --Somehow more confusing to set up than Ariados, wtf.
--389 244 / Bidoof location  / 304 273 Crawdaunt                                                           |                                         |      SPD, STPMIN, STPMAX, IDLMN, IDLMX (Go in order)
                                                                                                           -- LOCATION OF ENTITY         THE BOUNDARY THEY CAN GO                                Useful later to understand this specific command.
end

function wigglyguildmiddle.Bidoof_roamer_Action(chara, activator)
local player =CH('PLAYER')

GROUND:CharTurnToChar(chara, player)

	if SV.chapter.number == 1 and SV.chapter1.meeting_partA then

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("By golly, [pause=10]I hope everything goes back to normal soon.")
UI:WaitShowDialogue("I don't want to see another rude [color=#00FFFF]Skarmory[color] for a really long time...")

	else

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Golly, [pause=10]I wasn't prepared to have an apprentice join during these times.")
UI:WaitShowDialogue("Oh, [pause=10]we haven't introduced each other, [pause=10]have we?")
UI:WaitShowDialogue("I'm [color=#00FFFF]Bidoof[color], [pause=10]I used to be an apprentice like you.")
UI:WaitShowDialogue("I can show you the ropes around here if you ever need help.")
UI:WaitShowDialogue("What's your name?")

GAME:WaitFrames(40)

	GROUND:CharSetEmote(chara, "sweatdrop", 1)
	SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")
	GAME:WaitFrames(40)
	
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("You're... [pause=20]not much of a talker, are you?")
UI:SetSpeakerEmotion("Happy")
UI:WaitShowDialogue("Well, [pause=10]don't worry about it! [pause=0]I'm sure we'll get along together in no time!")
	end
end

function wigglyguildmiddle.Barky_Action(chara, activator)
local player =CH('PLAYER')

GROUND:CharTurnToChar(chara, player)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("A-Rank and higher sounds like it'll be rough.")

GROUND:EntTurn(chara, Direction.Up)
end

function wigglyguildmiddle.Barksalot_Action(chara, activator)
local player =CH('PLAYER')

GROUND:CharTurnToChar(chara, player)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("We can totally handle an S-Rank outlaw, [pause=10]bring it!")

GROUND:EntTurn(chara, Direction.UpRight)
end

function wigglyguildmiddle.Barkingson_Action(chara, activator)
local player =CH('PLAYER')

GROUND:CharTurnToChar(chara, player)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("As long as [color=#00FFFF]Magnazone[color] is happy, [pause=10]I don't really mind taking a harsh job.")

GROUND:EntTurn(chara, Direction.UpLeft)
end

function wigglyguildmiddle.JobBoard_Action(obj, activator)
local player =CH('PLAYER')



UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(I don't remember being told I can take these.)")
end

function wigglyguildmiddle.OutlawBoard_Action(obj, activator)
local player =CH('PLAYER')

UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(I don't feel like chasing around criminals, [pause=10]so no thanks.)")
end

function wigglyguildmiddle.Assembly_Action(obj, activator)
local Chimecho = CH('Chimecho')
local player = CH('PLAYER')
GROUND:CharTurnToChar(Chimecho, player)
GROUND:CharTurnToChar(player, Chimecho)
UI:SetSpeaker(Chimecho)

if not SV.chapter1.chimecho_greeted then --Play this, then never play it again.

UI:SetSpeakerEmotion("Happy")
UI:WaitShowDialogue("Ah, [pause=10]hello there!")
UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['FirstMeeting'], player:GetDisplayName()))
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("I'll help you with getting your team ready for any dungeons you'll need to go into.")
UI:WaitShowDialogue("When you have your team ready, [pause=10]I'll put any members you called into [color=#FFC663]Spinda's Café[color].")
UI:WaitShowDialogue("I'm sure you'll get the hang of it easily.")
UI:WaitShowDialogue("If you need last second changes to your team, [pause=10]there's a sign at the crossroads that'll call me.")
UI:WaitShowDialogue("I'll be there quickly to set your team up for you. [pause=0]Pretty convenient, [pause=10]huh?")
UI:WaitShowDialogue("Anyways, [pause=10]since you're here...")

SV.chapter1.chimecho_greeted = true
end
--assembly menu here.
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Welcome to the Chimecho Assembly!")

COMMON.ShowTeamAssemblyMenu(obj, COMMON.RespawnAllies)
  
UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['TeamReady'], player:GetDisplayName()))

GROUND:EntTurn(Chimecho, Direction.Down)
end

function wigglyguildmiddle.crawdaunt_roamer_Action(chara, activator)
local player =CH('PLAYER')

GROUND:CharTurnToChar(chara, player)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
	if SV.chapter.number == 1 and SV.chapter1.meeting_partA then

UI:WaitShowDialogue("I sure do hope you don't get reckless out there.")
UI:WaitShowDialogue("Because hey hey, [pause=10]a single mess up might hurt you a lot more than usual.")

	else
UI:WaitShowDialogue("Hey hey, [pause=10]a new recruit, [pause=10]yeah?")
UI:WaitShowDialogue("We don't get many of those nowadays.")
UI:WaitShowDialogue("But hey hey, [pause=10]if you have any trouble, [pause=10]just ask us for help.")
	end
end

function wigglyguildmiddle.Sunflora_Action(chara,activator)
local player =CH('PLAYER')

--GROUND:CharTurnToChar(chara, player) --She's not even talking to the player.

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
	if SV.chapter.number == 1 and SV.chapter1.meeting_partA then

UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("The jobs on the board are piled up to the brim...")
UI:WaitShowDialogue("We're gonna need an extra Pokémon or two to help with these things...")

	else
UI:WaitShowDialogue("Gosh, [pause=10]I wonder what job I should do...?")
UI:WaitShowDialogue("There's just so many on the board, [pause=10]I can't stop searching for one...")
	end
end

function wigglyguildmiddle.Madilyn_Action(chara,activator)
local player =CH('PLAYER')

GROUND:CharTurnToChar(chara, player)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("I'm looking for jobs, [pause=10]leave me alone.")

UI:ChoiceMenuYesNo(STRINGS:Format(STRINGS.MapStrings['StoryTimeQuestion']), false)
UI:WaitForChoice()
ch = UI:ChoiceResult()
if ch then
	UI:SetSpeakerEmotion("Pain")
    UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['YesStory']))
	wigglyguildmiddle.madiplupstories()
else
    UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['NoStory']))
	GROUND:EntTurn(chara, Direction.UpRight)
end

end

function wigglyguildmiddle.madiplupstories()
local player = CH('PLAYER')
local Madilyn = CH('Madilyn')

UI:SetSpeaker(Madilyn)

	if SV.repeatable.madilyns_stories_told == 0 then
	
		UI:SetSpeakerEmotion("Normal")
		UI:WaitShowDialogue("...If you're curious how I fainted at [color=#FFC663]Drenched Bluff[color], [pause=10]I don't know.")
		UI:WaitShowDialogue("I saw something, [pause=10]everything went woozy, [pause=10]and I passed out.")
		UI:WaitShowDialogue("That's all there was to it. [pause=0]There was supposed to be an outlaw, [pause=10]but they're long gone.")
		UI:WaitShowDialogue("I have [color=#00FFFF]Magnazone[color] looking into their whereabouts currently.")
		UI:WaitShowDialogue("That's all I wanna talk about today. [pause=0]I want to do my job in peace, [pause=10]please.")
		
		SV.repeatable.madilyns_stories_told = 1

	elseif SV.repeatable.madilyns_stories_told == 1 then
		if SV.chapter1.meeting_partA then
		
		UI:SetSpeakerEmotion("Normal")
		UI:WaitShowDialogue("That [color=#00FFFF]Charmeleon[color] over in [color=#FFC663]Treasure Town[color], [pause=10]y'know, [pause=10]the one cleaning stuff up?")
		UI:WaitShowDialogue("He's a pathetic one, [pause=10]noted as an S ranked criminal.")
		UI:WaitShowDialogue("Nearly set a whole forest on fire while I was fighting him, [pause=10]before I knocked him out.")
		UI:WaitShowDialogue("As his punishment, [pause=10]I told officer [color=#00FFFF]Magnazone[color] that he can clean up [color=#FFC663]Treasure Town[color] from time to time.")
		UI:WaitShowDialogue("If he didn't want that, [pause=10]he shouldn't have robbed a whole town blind.")
		UI:WaitShowDialogue("That last part's not a lie, [pause=10]he actually did rob a whole town. [pause=0]Not a big one, [pause=10]but still.")
		
		elseif SV.chapter.number <= 2 then
		
			UI:SetSpeakerEmotion("Determined")
			UI:WaitShowDialogue("Except I can't. [pause=0]I don't have anything else to tell you. [pause=0]Do something else until then.")
			
		elseif SV.chapter.number == 2 then
		
			UI:WaitShowDialogue("Stop using the Dev Tools, cheater. That's meant to be making things, not cracking the game open.")
			
		end
	end
GROUND:EntTurn(chara, Direction.UpRight)
end

function CutsceneChapter1Closer()
local player = CH('PLAYER')
local Madilyn = CH('Madilyn')
local Skiddo = CH('Skiddo')
local Kecleon = CH('Kecleon')
local AdamMudkip = CH('AdamMudkip')
local Piks = CH('Piks')
GAME:CutsceneMode(true)

SOUND:PlayBGM("None", true)
wigglyguildmiddle.HideScript()
GAME:MoveCamera(350, 250, 1, false)
GROUND:TeleportTo(player, 357, 269, Direction.UpLeft)
GROUND:TeleportTo(Madilyn, 361, 241, Direction.Left)

GAME:FadeIn(20)
GAME:WaitFrames(10)
SOUND:PlayBGM("Heartwarming.ogg", true)

UI:SetSpeaker(Madilyn)
UI:SetSpeakerLoc(264,131)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Here we are... [pause=20]you two should be safe here for a while.")

GAME:WaitFrames(10)

UI:SetSpeaker(Kecleon)
UI:ResetSpeakerLoc()
UI:SetSpeakerEmotion("Happy")
UI:WaitShowDialogue("Why, [pause=10]thank you for helping me get my little friend back.")
UI:WaitShowDialogue("I couldn't have done it without you, [pause=10][color=#54ebaf]Madilyn[color].")
GROUND:CharTurnToChar(Kecleon, player)
GAME:WaitFrames(10)
UI:WaitShowDialogue("And you, [pause=10]".. CH('PLAYER'):GetDisplayName() ..". [pause=0]You did a great job being the leader.")
UI:WaitShowDialogue("Here, [pause=10]you can have this. [pause=0]With [color=#32a852]Leppa Berries[color] being the new elixir, [pause=10]it makes no sense for me to carry this.")
UI:WaitShowDialogue("You might find a very swell situation to use it in.")

GROUND:MoveInDirection(Kecleon, Direction.DownRight, 15, false, 1)
--GROUND:EntTurn(Kecleon, Direction.Right)
--GROUND:EntTurn(player, Direction.Left)
GROUND:EntTurn(Madilyn, Direction.DownLeft)

local itemcount = GAME:GetPlayerBagCount() + GAME:GetPlayerEquippedCount()
local bagsize = GAME:GetPlayerBagLimit()

if itemcount >= bagsize then
GAME:GivePlayerStorageItem('medicine_max_elixir', 1)
SOUND:PlayFanfare("Fanfare/Item")

UI:ResetSpeaker(false)
UI:SetCenter(true)
UI:WaitShowDialogue("You received a [color=#32a852]Max Elixir[color] from ".. CH('Kecleon'):GetDisplayName() .."!") --That works?
UI:WaitShowDialogue("Your bag is full, so it was placed in your storage.")
UI:SetCenter(false)

else

GAME:GivePlayerItem('medicine_max_elixir', 1)
SOUND:PlayFanfare("Fanfare/Item")

UI:ResetSpeaker(false)
UI:SetCenter(true)
UI:WaitShowDialogue("You received a [color=#32a852]Max Elixir[color] from ".. CH('Kecleon'):GetDisplayName() .."!") --That works?
UI:SetCenter(false)

end

GROUND:CharAnimateTurn(Kecleon, Direction.UpLeft, 4, true)
GAME:WaitFrames(5)
GROUND:MoveInDirection(Kecleon, Direction.UpLeft, 15, false, 1)
GROUND:CharAnimateTurn(Kecleon, Direction.Right, 4, false)
GROUND:EntTurn(Madilyn, Direction.Left)

SOUND:PlayBattleSE("EVT_Emote_Exclaim_2")
GROUND:CharSetEmote(Skiddo, "exclaim", 1)
GAME:WaitFrames(30)

UI:SetSpeaker(Skiddo)
UI:SetSpeakerEmotion("Happy")
GROUND:EntTurn(Madilyn, Direction.DownLeft)
GROUND:EntTurn(player, Direction.Left)
GROUND:CharAnimateTurn(Kecleon, Direction.DownLeft, 4, false)
UI:WaitShowDialogue("I almost forgot! [pause=0]Here's the payment for helping me out of trouble.")

coro1 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Kecleon, Direction.DownRight, 4, true)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(Skiddo, Direction.DownRight, 15, false, 1)
GROUND:MoveInDirection(Skiddo, Direction.Right, 15, false, 1)
end)

GAME:AddToPlayerMoney(100)

local coro1 = TASK:BranchCoroutine(function()
GAME:WaitFrames(30)
SOUND:PlayBattleSE("DUN_Money")
GROUND:MoveInDirection(Madilyn, Direction.DownLeft, 10, false, 1)
GROUND:CharAnimateTurn(Madilyn, Direction.Down, 4, true)
GAME:WaitFrames(30)
SOUND:PlayBattleSE("DUN_Money")
end)

local coro2 = TASK:BranchCoroutine(function()
GAME:WaitFrames(100)
SOUND:PlayBGM("None", true)
GROUND:CharSetEmote(player, "shock", 1)
GROUND:CharSetEmote(Skiddo, "shock", 1)
SOUND:PlayBattleSE("EVT_Emote_Shock")
end)

UI:ResetSpeaker(false)
UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['CashYoinked']))
GROUND:CharAnimateTurn(Madilyn, Direction.Up, 4, true)
GAME:WaitFrames(5)

if SV.playerinfo.town == 'FriendZone' or SV.playerinfo.town == 'AdventureSquad' then --The PC knows these rules, and can't get upset.
--364 157
coro1 = TASK:BranchCoroutine(function()
GROUND:MoveToPosition(Madilyn, 360, 157, false, 2)
GROUND:Hide("Madilyn")
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(player, Direction.Up, 4, false)
end)

local coro3 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Skiddo, Direction.Up, 4, true)
end)

local coro4 = TASK:BranchCoroutine(function()
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(Kecleon, Direction.UpRight, 6, true)
end)

GAME:WaitFrames(30)
UI:SetSpeaker(Skiddo)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("Oh, [pause=10]right...")
UI:WaitShowDialogue("I forgot that most profits explorers make is taken by the guild...")

GAME:WaitFrames(10)

UI:SetSpeaker(Kecleon)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Only for the job payouts. [pause=0]It doesn't seem like a fair rule to me though.")
GROUND:CharAnimateTurn(Kecleon, Direction.DownRight, 4, false)
UI:WaitShowDialogue(CH('PLAYER'):GetDisplayName() .." doesn't seem too overly bothered by it...")

GROUND:CharAnimateTurn(Skiddo, Direction.Right, 4, false)
GAME:WaitFrames(10)

UI:SetSpeaker(player, false)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(I can't really argue back. [pause=0]I've worked with low payouts before.)")
UI:WaitShowDialogue("(And I do feel a little annoyed...)")
UI:SetSpeakerEmotion("Determined")
UI:WaitShowDialogue("(But I'm not here to turn a profit! [pause=0]I'm here to solve mysteries, [pause=10]and to help others!)")

else --The PC doesn't know these rules, and gets upset.

		if SV.playerinfo.job == 'Helper' then
		
coro1 = TASK:BranchCoroutine(function()
GROUND:MoveToPosition(Madilyn, 364, 157, false, 2)
GROUND:Hide("Madilyn")
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(player, Direction.Up, 4, false)
end)

local coro3 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Skiddo, Direction.Up, 4, true)
end)

local coro4 = TASK:BranchCoroutine(function()
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(Kecleon, Direction.UpRight, 6, true)
end)

GAME:WaitFrames(30)
UI:SetSpeaker(Skiddo)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("Oh, [pause=10]right...")
UI:WaitShowDialogue("I forgot that most profits explorers make is taken by the guild...")

GAME:WaitFrames(10)

UI:SetSpeaker(Kecleon)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Only for the job payouts. [pause=0]It doesn't seem like a fair rule to me though.")
GROUND:CharAnimateTurn(Kecleon, Direction.DownRight, 4, false)
UI:WaitShowDialogue(CH('PLAYER'):GetDisplayName() .." doesn't seem too overly bothered by it...")

GROUND:CharAnimateTurn(Skiddo, Direction.Right, 4, false)
GAME:WaitFrames(10)

UI:SetSpeaker(player, false)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(This *is* a very weak amount of money to be earning...)")
UI:WaitShowDialogue("(And I do feel a little upset...)")
UI:SetSpeakerEmotion("Determined")
UI:WaitShowDialogue("(But I'm not here to turn a profit! [pause=0]I'm here to help others, [pause=10]and to solve mysteries!)")
		
		else

GROUND:MoveInDirection(Madilyn, Direction.Up, 10, false, 2)

		SOUND:PlayBattleSE("EVT_Emote_Complain_2")
		GROUND:CharSetEmote(player, "angry", 0)
		GROUND:CharSetEmote(Skiddo, "exclaim", 1)
		GROUND:CharSetEmote(Madilyn, "exclaim", 1)
		GROUND:CharSetEmote(Kecleon, "exclaim", 1)
		GAME:WaitFrames(60)
		
coro1 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Madilyn, Direction.Down, 4, false)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(player, Direction.Up, 4, false)
end)

local coro3 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Skiddo, Direction.Up, 4, true)
end)

local coro4 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Kecleon, Direction.Right, 4, true)
end)

GAME:WaitFrames(10)
GROUND:EntTurn(Kecleon, Direction.DownRight)

		GROUND:CharSetAnim(player, "Sound", false)
		SOUND:PlayBattleSE("EVT_Emote_Complain_2")
		GAME:WaitFrames(40)

UI:SetSpeaker(Madilyn)
UI:SetSpeakerEmotion("Normal")
GROUND:EntTurn(Kecleon, Direction.Right)
UI:WaitShowDialogue("What are you getting angry at me for?")
		if SV.playerinfo.job == 'Study' then
			UI:WaitShowDialogue("Didn't you learn about this kinda thing in school?")
		elseif SV.playerinfo.job == 'Prepared' then
			UI:WaitShowDialogue("Don't you make enough money in dungeons alone?")
			else
			UI:WaitShowDialogue("What I have in my flippers isn't yours.")
			end

			UI:WaitShowDialogue("What I have is the guild's share of the profit. [pause=0]Most of a job's payout is given to the headmaster.")
			UI:WaitShowDialogue("What she does with it, [pause=10]I can't even begin to wonder.")
			UI:WaitShowDialogue("And ".. CH('PLAYER'):GetDisplayName() ..", [pause=10]even I think the amount they take is kinda dumb.")
			UI:WaitShowDialogue("But for now, [pause=10]keep whatever's in your paws. [pause=0]I got enough for myself.")
			
			GROUND:CharSetEmote(player, "", 0)
			GROUND:CharAnimateTurn(Madilyn, Direction.Up, 4, true)
			
	coro1 = TASK:BranchCoroutine(function()
		GROUND:MoveToPosition(Madilyn, 354, 168, false, 1)
		GROUND:Hide("Madilyn")
	end)
	
	GAME:WaitFrames(40)
GROUND:CharSetEmote(player, "sweatdrop", 1)
GROUND:CharSetEmote(Skiddo, "sweatdrop", 1)
SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")
GAME:WaitFrames(40)

UI:SetSpeaker(player, false)
UI:SetSpeakerEmotion("Pain")
UI:WaitShowDialogue("(Nnf... I know [color=#54ebaf]Madilyn[color] told me why...)")
UI:WaitShowDialogue("(But what ".. CH('Skiddo'):GetDisplayName() .." gave me versus how much is left feels so cheap...)")
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(On the bright side, [pause=10]I got this bottle from ".. CH('Kecleon'):GetDisplayName() ..".)")

if SV.playerinfo.job == 'Study' then
UI:WaitShowDialogue("(I'm glad items aren't considered as payment.)")
elseif SV.playerinfo.job == 'Prepared' then
UI:WaitShowDialogue("(I'll be sure to use it for later in a tight spot.)")
else
UI:WaitShowDialogue("(So that's something...)")
end

	end
end

GAME:WaitFrames(30)

coro1 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Kecleon, Direction.DownRight, 4, false)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Skiddo, Direction.Right, 4, false)
end)

GROUND:EntTurn(player, Direction.UpLeft)
GAME:WaitFrames(20)

UI:SetSpeaker(Kecleon)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Well... [pause=20]it's best that me and ".. CH('Skiddo'):GetDisplayName() .." get out of the guild for now.")
UI:WaitShowDialogue("Don't be too upset, [pause=10]".. CH('PLAYER'):GetDisplayName() ..". [pause=0]Tomorrow will be a better day, [pause=10]I'm sure of it.")

GAME:WaitFrames(10)
GROUND:EntTurn(player, Direction.Left)

UI:SetSpeaker(Skiddo)
UI:SetSpeakerEmotion("Happy")
UI:WaitShowDialogue("See you later, [pause=10]buddy!")

coro1 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Kecleon, Direction.Up, 4, true)
GAME:WaitFrames(6) --323 176
GROUND:MoveToPosition(Kecleon, 323, 176, false, 1)
GROUND:MoveInDirection(Kecleon, Direction.Up, 150, false, 1)
GROUND:Hide('Kecleon')
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:CharAnimateTurn(Skiddo, Direction.Up, 4, true)
GAME:WaitFrames(9)
GROUND:MoveToPosition(Skiddo, 323, 176, false, 1)
GROUND:MoveInDirection(Skiddo, Direction.Up, 100, false, 1)
GROUND:Hide('Skiddo')
end)

local coro3 = TASK:BranchCoroutine(function()
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(player, Direction.Up, 4, false)
GAME:WaitFrames(120) --343 248
GROUND:MoveToPosition(player, 343, 248, false, 1)
GROUND:EntTurn(player, Direction.Up)
end)

GAME:WaitFrames(150)

UI:SetSpeaker(player, false)
UI:SetSpeakerEmotion("Sigh")
UI:WaitShowDialogue("(Training in this guild must be pretty harsh...)")
if SV.playerinfo == 'FriendZone' or 'AdventureSquad' then
UI:WaitShowDialogue("(Much harsher than how I used to train.)")
end
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("(But I know I can do this.)")

coro1 = TASK:BranchCoroutine(function()
GROUND:AnimateInDirection(AdamMudkip, "Walk", Direction.Up, Direction.Down, 30, 4, 2)
GROUND:MoveToPosition(AdamMudkip, 341, 198, false, 1)
GROUND:EntTurn(AdamMudkip, Direction.Down)
	SOUND:PlayBattleSE("EVT_Emote_Exclaim")
    GROUND:CharSetEmote(AdamMudkip, "exclaim", 1)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:AnimateInDirection(Piks, "Walk", Direction.Up, Direction.Down, 30, 4, 2)
GROUND:MoveToPosition(Piks, 316, 201, false, 1)
GROUND:EntTurn(Piks, Direction.DownRight)
end)

coro3 = TASK:BranchCoroutine(function()
GROUND:MoveInDirection(player, Direction.Up, 20, false, 1)
	SOUND:PlayBattleSE("EVT_Emote_Exclaim_2")
    GROUND:CharSetEmote(player, "exclaim", 1)
end)

UI:WaitShowTimedDialogue("(I think I'll take a little-)", 10)
GAME:WaitFrames(100)
SOUND:PlayBGM("Wigglytuff's Guild Remix.ogg", true)

UI:SetSpeaker(AdamMudkip)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Oh, [pause=10]hey ".. CH('PLAYER'):GetDisplayName() ..". [pause=0]Looks like you did a good job helping ".. CH('Kecleon'):GetDisplayName() .." out.")
UI:WaitShowDialogue("Not just because we saw him with his worker friend, [pause=10]but because of your face.")

GAME:WaitFrames(10)
GROUND:EntTurn(player, Direction.UpLeft)

UI:SetSpeaker(Piks)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("I would know that look anywhere.")
UI:WaitShowDialogue("It's best that we don't talk about it for now.")

GAME:WaitFrames(10)

UI:SetSpeaker(AdamMudkip)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("It's too touchy of a subject...")
GROUND:EntTurn(player, Direction.Up)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("I don't want to keep anymore of your time, [pause=10]but there is one thing I must speak with you about.")
UI:WaitShowDialogue("You know how I was talking about letting you take extra credit?")
UI:WaitShowDialogue("What I mean by that is taking jobs off the Job and Outlaw Board.")

local NeededRefresh = false

UI:ChoiceMenuYesNo("Now this might be a stupid question, [pause=10]but do you know how jobs work?", false)
UI:WaitForChoice()
ch = UI:ChoiceResult()
if ch then

else
    JobBoardRefreshment()
	NeededRefresh = true
end

UI:WaitShowDialogue("Alrighty then! [pause=0]So you know what you're doing tomorrow.")

if NeededRefresh == true then
UI:WaitShowDialogue("I'm not sure if this is your first time doing this, [pause=10]but I know you got the spirit.")
end

GAME:WaitFrames(10)

UI:SetSpeaker(Piks)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("We should let you get some rest, [pause=10]".. CH('PLAYER'):GetDisplayName() ..".")
UI:WaitShowDialogue("Remember, [pause=10]this stuff isn't necessary, [pause=10]but if you're looking for work, [pause=10]try doing some jobs.")
UI:WaitShowDialogue("Get some rest now. [pause=0]We'll see you tomorrow.")

coro1 = TASK:BranchCoroutine(function()
GROUND:MoveToPosition(AdamMudkip, 323, 156, false, 1)
GROUND:MoveInDirection(AdamMudkip, Direction.Up, 50, false, 1)
end)

coro2 = TASK:BranchCoroutine(function()
GROUND:MoveToPosition(Piks, 323, 156, false, 1)
GROUND:MoveInDirection(Piks, Direction.Up, 50, false, 1)
end)

coro3 = TASK:BranchCoroutine(function()
GAME:FadeOut(false, 30)
end)

GAME:WaitFrames(80)
GAME:EnterGroundMap("wigglyguildeatcutscene", "Entrance")

GAME:CutsceneMode(false)
end

function JobBoardRefreshment()
local player = CH('PLAYER')
local Madilyn = CH('Madilyn')
local Skiddo = CH('Skiddo')
local Kecleon = CH('Kecleon')
local AdamMudkip = CH('AdamMudkip')
local Piks = CH('Piks')

local state = 0

while state > -1 do

UI:SetSpeaker(AdamMudkip)
UI:SetSpeakerEmotion("Normal")

choices = {"How does it work?",
    "What's the Job Board?",
    "What's the Outlaw Board?",
	"I'm all caught up."}

	local msg = "That's fine.[br]Anything in particular you need to be reminded of?"
			if repeated == true then
				msg = "Now...[br]Do you think you need anything else reminded?"
			end

UI:BeginChoiceMenu(msg, choices, 1, 4)
UI:WaitForChoice()
result = UI:ChoiceResult()
repeated = true
if result == 1 then
    
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Uh, [pause=10]alright.")
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("You see, [pause=10]every explorer has a Rank that's associated with them.")
	UI:WaitShowDialogue("The one you have is 'normal' quality, [pause=10]despite it's appearance.")
	UI:WaitShowDialogue("Better quality badges means you're very respectible.")
	UI:WaitShowDialogue("To get to that point, [pause=10]you must finish jobs on the Job and Outlaw Boards.")
	UI:WaitShowDialogue("Take any job off the board, [pause=10]accept it, [pause=10]and head off to that dungeon.")
	UI:WaitShowDialogue("If you don't want to do it, [pause=10]suspend it. [pause=0]Want to replace the job? [pause=0]Discard it.")
	UI:WaitShowDialogue("Finish enough jobs though, [pause=10]and your Rank increases.")
	UI:WaitShowDialogue("When your Rank increases, [pause=10]you'll be given harder jobs and outlaws.")
	UI:WaitShowDialogue("Harder jobs might be difficult, [pause=10]but they are quite rewarding.")
	UI:WaitShowDialogue("Those are the basics in a nutshell.")
	
elseif result == 2 then

	GAME:WaitFrames(10)
	UI:SetSpeaker(Piks)
	UI:SetSpeakerEmotion("Normal")
    UI:WaitShowDialogue("The Job Board has jobs that aim to help other Pokémon with various things.")
	UI:WaitShowDialogue("Rescues, [pause=10]lost and found, [pause=10]item deliveries, [pause=10]and escorts, [pause=10]that's what you'll find on the board.")
	UI:WaitShowDialogue("These jobs are usually less dangerous, [pause=10]but they're abundant.")
	GAME:WaitFrames(10)

elseif result == 3 then
    
	GAME:WaitFrames(10)
	UI:SetSpeaker(Piks)
	UI:SetSpeakerEmotion("Normal")
    UI:WaitShowDialogue("Outlaw Missions consist of defeating known bad guys.")
	UI:WaitShowDialogue("More specifically, [pause=10]runaway thieves, [pause=10]known criminals, [pause=10]and whatnot.")
	UI:WaitShowDialogue("It's best to prepare accordingly, [pause=10]especially if you took multiple Outlaw Jobs.")
	GAME:WaitFrames(10)
	
elseif result == 4 then
  state = -1
end

end

end

function wigglyguildmiddle.HideScript()

GROUND:Hide("Sunflora")
GROUND:Hide("Bidoof_roamer")
GROUND:Hide("crawdaunt_roamer")
GROUND:Hide("Chimecho")
GROUND:Hide("Barky")
GROUND:Hide("Barksalot")
GROUND:Hide("Barkingson")
GROUND:Unhide("Madilyn")
GROUND:Unhide("Kecleon")
GROUND:Unhide("Skiddo")
GROUND:Unhide("AdamMudkip")
GROUND:Unhide("Piks")

end

return wigglyguildmiddle

