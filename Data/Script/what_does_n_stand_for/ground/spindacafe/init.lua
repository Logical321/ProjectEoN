--[[
    init.lua
    Created: 02/07/2023 11:47:40
    Description: Autogenerated script file for the map spindacafe.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local spindacafe = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---spindacafe.Init
--Engine callback function
function spindacafe.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  

end

---spindacafe.Enter
--Engine callback function
function spindacafe.Enter(map)

COMMON.RespawnAllies()

	if SV.prologue.crossroads_cs1 == true then
		GROUND:Hide('AdamMudkip')
	end

  spindacafe.chapterhidescript()
  GAME:FadeIn(20)

end

---spindacafe.Exit
--Engine callback function
function spindacafe.Exit(map)


end

---spindacafe.Update
--Engine callback function
function spindacafe.Update(map)


end

---spindacafe.GameSave
--Engine callback function
function spindacafe.GameSave(map)


end

---spindacafe.GameLoad
--Engine callback function
function spindacafe.GameLoad(map)

  GAME:FadeIn(20)

end

-------------------------------
-- Entities Callbacks
-------------------------------
function spindacafe.InteractiveNearby_Touch(obj, activator)

SOUND:PlayBattleSE("EVT_Emote_Confused")
    GROUND:CharSetEmote(activator, "question", 1)

end

function spindacafe.FunnyWall_Action(obj, activator)
local player = CH('PLAYER')

	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("(What in the-? [pause=0]This wall seems out of place, [pause=10]like it's fake or something.)")
	
end

function spindacafe.BartenderActivate_Action(obj, activator)
local spindabar = CH("spindabar")
local thatsright = CH("thatsright")
local player = CH("PLAYER")

GROUND:CharTurnToChar(spindabar, player)
GROUND:CharTurnToChar(player, spindabar)

	if SV.chapter.number == 0 then

	if SV.prologue.has_spindas_shaker then
		if SV.prologue.spindas_shaker_given == false then

	UI:SetSpeaker(spindabar)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("Hello there, [pause=10]how can I...")
	UI:SetSpeakerEmotion("Stunned")
	UI:WaitShowDialogue("Oh! [pause=0]You're handing something to me?")
	UI:WaitShowDialogue("...")
	UI:SetSpeakerEmotion("Inspired")
	GROUND:CharSetEmote(spindabar, "glowing", 0)
	UI:WaitShowDialogue("Oooh! [pause=0]It's my new shaker!")
	UI:WaitShowDialogue("I can get back to business now!")
		if SV.prologue_alts.spinda_greeted == true then
			UI:SetSpeakerEmotion("Worried")
			GROUND:CharSetEmote(spindabar, "", 0)
			UI:WaitShowDialogue("Now... [pause=20]it could just be me, [pause=10]but if you have it now, [pause=10]where did it even go...?")
			UI:WaitShowDialogue("...")
			UI:WaitShowDialogue("Guess I'll just have to ask around later.")
		end
	UI:SetSpeakerEmotion("Normal")
	GROUND:CharSetEmote(spindabar, "", 0) --necessary to have both of these for emote removal.
	UI:WaitShowDialogue("You look like you need a little reward. [pause=0]How about I give you some juice?")
	--UI:WaitShowDialogue("You can't do a very good job if you're parched.")
	UI:WaitShowDialogue("I have some leftover berries I can make into juice real quick if you want to see if this shaker works.")
	
	GAME:CutsceneMode(true)
	
	GROUND:CharAnimateTurn(spindabar, Direction.Right, 4, true)
	
	UI:WaitShowDialogue("Add the berries...")
	
	GAME:WaitFrames(30)
	
	UI:SetSpeaker(thatsright)
	UI:SetSpeakerLoc(264,131)
	UI:SetSpeakerEmotion("Happy", true)
	UI:WaitShowDialogue("That's right!") --that's right.
	
	GROUND:CharAnimateTurn(spindabar, Direction.Down, 4, false)
	GAME:WaitFrames(10)
	
	UI:SetSpeaker(spindabar)
	UI:ResetSpeakerLoc()
	UI:SetSpeakerEmotion("Inspired")
	GROUND:CharSetAnim(spindabar, "Special0", false) --No Spinda Shaking the Mixer noises because I can't find them in PMDO's massive list of Sound Effects. / Probably not even in there, thinking about it since Origin never uses it. / PMDO doesn't have dinner noises, it won't have this.
	UI:WaitShowTimedDialogue("Shake it this way...", 50)
	UI:WaitShowTimedDialogue("Shake it that way...", 50) --Trying to find the correct frames to do the next textbox is kinda hard, F3 seems oddly inconsistent.
	GROUND:CharSetAnim(spindabar, "Special1", false)
	UI:WaitShowTimedDialogue("Spin it all around...", 38)
	--GROUND:CharSetAnim(spindabar, "Special2", false)
	GROUND:CharSetAction(spindabar, RogueEssence.Ground.PoseGroundAction(spindabar.Position, spindabar.Direction, RogueEssence.Content.GraphicsManager.GetAnimIndex("Special2"))) --Made this much better.
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowTimedDialogue("Tada!~", 40) --weirdly poses, not sure what that's about, but if I make the frames any shorter, nobody can see the dialogue. / Fixed.
	GAME:WaitFrames(20)
	GROUND:CharSetAnim(spindabar, "Idle", true) --Completely shot animation sequence. / Fixed
	
	GAME:CutsceneMode(false)
		
	UI:WaitShowDialogue("Here you go, [pause=10]blended [color=#32a852]Tamato[color] and [color=#32a852]Nomel Berry[color] juice, [pause=10]freshly made!") 
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("I don't know how well it tastes though, [pause=10]so be aware of that.")
	
	GAME:WaitFrames(30)
	
	UI:SetSpeaker(player, false)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("(It looks pretty average, [pause=10]but I can't exactly turn it down.)")
	
	SOUND:PlaySE("Battle/DUN_Drink")
	local emitter = RogueEssence.Content.SingleEmitter(RogueEssence.Content.AnimData("Wave_Circle_White", 3))
	emitter.LocHeight = 8
	GROUND:PlayVFX(emitter, player.Bounds.Center.X, player.Bounds.Center.Y)
	
	GAME:WaitFrames(40)
	
	SOUND:PlayBattleSE("EVT_Emote_Shock_Bad")
    GROUND:CharSetEmote(player, "shock", 1)
	GAME:WaitFrames(20)
	
	UI:SetSpeakerEmotion("Surprised")
	UI:WaitShowDialogue("...!")
	UI:WaitShowDialogue("(It's way too sour and spicy!)")
	UI:WaitShowDialogue("(I can't even taste any other flavors in it...)")
	UI:WaitShowDialogue("(It's not bad, [pause=10]but whatever this is, [pause=10]it's not juice to drink.)")
	
	--GROUND:CharSetEmote(spindabar, "glowing", 0)
	GAME:WaitFrames(20)
	UI:SetSpeaker(spindabar)
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Hm... [pause=20]I guess those combinations of berries don't work.")
	UI:WaitShowDialogue("I'm sorry... [pause=20]those were the last bunch of berries I had with me.")
	GROUND:CharSetEmote(spindabar, "", 0)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("Now's a good time to remind you that you should always bring your own berries.")
	UI:WaitShowDialogue("We do take \u{E024}, [pause=10]but I insist you bring your own for better quality.") --if this causes issues, turn it into a string.
	--UI:WaitShowDialogue(STRINGS:Format(STRINGS.MapStrings['Poke']))
	
	GROUND:CharAnimateTurn(player, Direction.Down, 4, true)
	
	UI:SetSpeaker(player)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("(Well, [pause=10]I guess the drink woke me up a bit. [pause=0]That's a bit of a plus.)")
	UI:WaitShowDialogue("(Too bad I can't really stay for a bit longer. [pause=10]I have to head to the next town.)")
	
	SV.prologue.spindas_shaker_given = true
	
	if SV.prologue_alts.talked_to_adam_at_cafe >= 1 then
	UI:SetSpeakerEmotion("Worried")
	GAME:WaitFrames(20)
	UI:WaitShowDialogue("(...)")
	UI:WaitShowDialogue("(Wait a minute. [pause=0]There was an explorer in this town.)")
	UI:WaitShowDialogue("(Maybe I should try and find him first before leaving.)")
	end
	elseif SV.prologue.spindas_shaker_given == true then
	
UI:SetSpeaker(spindabar)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Y'know, [pause=10]I'm just realizing you never spoke a word.")
UI:WaitShowDialogue("Not a very talkative Pokémon, [pause=10]are you?")
end

	elseif not SV.prologue.has_spindas_shaker then
		if SV.chapter.number == 0 then

UI:SetSpeaker(spindabar)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Hello, [pause=10]and welcome to [color=#FFC663]Spinda's Café[color].~")

UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("Unfortunately, [pause=10]I do have some bad news.")
UI:WaitShowDialogue("My shaker *just* broke, [pause=10]and I'm waiting for a new one to arrive.")
UI:WaitShowDialogue("It's supposed to arrive today, [pause=10]but I don't even know when it'll come.")
UI:WaitShowDialogue("Maybe check back later when I do have it, [pause=10]ok?")

GROUND:EntTurn(spindabar, Direction.Down)

SV.prologue_alts.spinda_greeted = true

GAME:WaitFrames(20)

UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(I should check around if someone gotten it by mistake...)")

else

UI:SetSpeaker(spindabar) --temporary dialogue.
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Y'know, [pause=10]I'm just realizing you never spoke a word.")
UI:WaitShowDialogue("Not a very talkative Pokémon, [pause=10]are you?")

		end
	end
	
	elseif SV.chapter.number == 1 then
	
		if not SV.chapter1.spinda_promise then
	UI:SetSpeaker(spindabar)
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowDialogue("Welcome back! [pause=0]Did you want to make you a drink?")
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("No? [pause=0]That's alright.")
	UI:WaitShowDialogue("Though, [pause=10]if I may talk to you for a while...")
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Project P has been halted recently...")
	UI:WaitShowDialogue("Not because we have nowhere to go, [pause=10]that isn't the case here.")
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("We have other regions helping the project out, [pause=10]from [color=#FFC663]Pokémon Square[color] to [color=#FFC663]Lively Town[color]!")
	UI:WaitShowDialogue("It's quite remarkable how much everyone has helped!")
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("The problem is... [pause=20]well, [pause=10]whatever these dungeons are going through.")
	UI:WaitShowDialogue("Project P does have some expert explorers, [pause=10]but newer teams can't make a foothold in the dungeons...")
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("You, [pause=10]however, [pause=10]look like you know a thing or two about exploration.")
	UI:WaitShowDialogue("So please help Team [color=#ffb5fd]Electrater[color] with figuring out this confusing mess.")
	UI:WaitShowDialogue("I would like it if things went back to normal in those places, [pause=10]since it's freaking everyone out.")
	
	SV.chapter1.spinda_promise = true
	
		else
		
		UI:SetSpeaker(spindabar)
		UI:SetSpeakerEmotion("Normal")
		UI:WaitShowDialogue("I hope things go back to normal again.")
		UI:WaitShowDialogue("Project P really needs it.")
	
		end
	
	end
	
end

function spindacafe.NoThatsWrong_Action(obj, activator) --the danganronpa
local thatsright = CH("thatsright")
local wynautrecycle = CH("wynautrecycle")
local player = CH("PLAYER")

GROUND:CharSetAction(thatsright, RogueEssence.Ground.PoseGroundAction(thatsright.Position, thatsright.Direction, RogueEssence.Content.GraphicsManager.GetAnimIndex("Pose")))
GROUND:CharSetEmote(thatsright, "happy", 0)

UI:SetSpeaker(thatsright)
UI:SetSpeakerEmotion("Happy")
UI:WaitShowDialogue("That's right!")

GROUND:CharSetAnim(thatsright, "Idle", true)
GROUND:CharSetEmote(thatsright, "", 0)

	GAME:WaitFrames(20)
	GROUND:CharTurnToChar(wynautrecycle, player)
	GAME:WaitFrames(20)
	SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")
	GROUND:CharSetEmote(wynautrecycle, "sweatdrop", 1)

GAME:WaitFrames(35)

UI:SetSpeaker(wynautrecycle)
UI:SetSpeakerEmotion("Sad")
UI:WaitShowDialogue("Er, [pause=10]don't try to talk to her... [pause=20]you're not gonna get much else than that...")

	GROUND:EntTurn(wynautrecycle, Direction.Down)
	GAME:WaitFrames(20)
	SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")
	GROUND:CharSetEmote(player, "sweatdrop", 1)
	GAME:WaitFrames(35)
	
UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(I'm not sure what's worse. [pause=0]Being completely mute, [pause=10]or only saying that...)")
end

function spindacafe.RecycleActivate_Action(obj, activator) --I am not scripting a recycle shop, because I dunno how.
local wynautrecycle = CH('wynautrecycle')
local player = CH('PLAYER')

GROUND:CharTurnToChar(wynautrecycle, player)
GROUND:CharTurnToChar(player, wynautrecycle)

UI:SetSpeaker(wynautrecycle)
UI:SetSpeakerEmotion("Normal") --wynaut has no other emotions, so no need to change this at all. / This aged well.

UI:WaitShowDialogue("Welcome, [pause=10]this is the Recycle Shop!~ [pause=0]How can I help you?")
UI:WaitShowDialogue(".[pause=15].[pause=15]. [pause=15].[pause=15].[pause=15]. [pause=15].[pause=15].[pause=15].")
UI:WaitShowDialogue("Wow, [pause=10]you're very quiet. [pause=0]Would you like a ticket instead?")
UI:WaitShowDialogue("No? [pause=0]Huh, [pause=10]ok then. [pause=0]Have a good day.~")


end

function spindacafe.CafeLeave_Touch(obj, activator)

GAME:FadeOut(false, 20)
GAME:EnterGroundMap("treasuretowncrossroads", "EntranceCafe")

end

function spindacafe.Bolt_Action(chara, activator) --friend cameo, yes, I asked them. / Did you know that they wrote their own dialogue?
local player = CH('PLAYER')

GROUND:CharTurnToChar(chara, player)
UI:SetSpeaker(chara)

if SV.repeatable.cameo_times_talked_to_bolt == 0 then
	
	UI:SetSpeakerEmotion("Sigh")
	UI:WaitShowDialogue("Man... [pause=20]getting berries in the forest sure is hard work...")
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("Hm? [pause=0]Surprised to see a wild Pokémon here?")
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowDialogue("Well, [pause=10]not all wilds live in a dungeon, [pause=10]you know. [pause=0]Why not drop by in the forest sometime?")
	
	SV.repeatable.cameo_times_talked_to_bolt = 1 --He's gonna need more dialogue at some point.
	
	elseif SV.repeatable.cameo_times_talked_to_bolt == 1 then

		if SV.chapter.number == 0 then --else checks do not carry if the Script Var is filled. Only way to make sure the 'go away' part of the dialogue happens is by making the game judge if a chapter went by or not.
	
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Erm, [pause=10]I don't want to be rude or anything, [pause=10]but don't you have somewhere to be?")
	
		elseif SV.chapter.number >= 1 then
	
		UI:SetSpeakerEmotion("Normal")
		UI:WaitShowDialogue("Oh? [pause=0]Do you want to know why I've got blue cheeks and the like?")
		UI:SetSpeakerEmotion("Worried")
		UI:WaitShowDialogue("That's... [pause=20]unfortunately something I don't know myself. [pause=0]Been that way ever since I was a [color=#00FFFF]Pichu[color]. [br]I wonder if it makes me weird at times...")
		
		SV.repeatable.cameo_times_talked_to_bolt = 2
		
		end
		
	elseif SV.repeatable.cameo_times_talked_to_bolt == 2 then

		if SV.chapter.number >= 2 then
		
		UI:SetSpeakerEmotion("Normal") --temp
		UI:WaitShowDialogue("Dialogue broken, plz fix")
		
		elseif SV.chapter.number == 1 then
	
		UI:SetSpeakerEmotion("Worried")
		UI:WaitShowDialogue("Uh... [pause=20]don't mind me asking but... [br]Why are you still just looking at me while standing there? [br]It's... [pause=20]a little bit weird.")
		
		end
	
	end
	
end

function spindacafe.Octillery_Action(chara, activator)
local player = CH('PLAYER')

GROUND:CharTurnToChar(chara, player)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("[color=#FFC663]Spinda's Café[color] never seems to age with time, [pause=10]and it's been opened for a while now.") --I don't remember the regulars. / Some of them are just random mons. Change with each chapter?
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("I wonder if he has anything special planned?")

GROUND:EntTurn(chara, Direction.Up)

end

function spindacafe.AdamMudkip_Action(chara, activator)
local player = CH('PLAYER')

GROUND:CharTurnToChar(chara,player)

if not SV.prologue_alts.learned_adams_name then
	UI:SetSpeaker(STRINGS:Format("\\uE040"), true, chara.CurrentForm.Species, chara.CurrentForm.Form, chara.CurrentForm.Skin, chara.CurrentForm.Gender) --Trying to do this is annoying. Dang you, Logic Gates... Wait, is it Logic Gates I'm working with? I haven't the slightest clue.
	else
	UI:SetSpeaker(chara)
end

if SV.prologue_alts.talked_to_adam_at_cafe == 0 then

UI:SetSpeakerEmotion("Pain")
	UI:WaitShowDialogue("Hm.")
	UI:WaitShowDialogue("Hm...")
UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Hm?")
UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("Oh, [pause=10]hey there. [pause=0]You look like you're not from around here.")
	UI:WaitShowDialogue("My name's [color=#54ebaf]Adam[color]. [pause=0]I'm the leader and founder of Team [color=#ffb5fd]Electrater[color].")
SV.prologue_alts.learned_adams_name = true
SV.prologue_alts.talked_to_adam_at_cafe = 1

elseif SV.prologue_alts.talked_to_adam_at_cafe == 1 then --Remember, MASSIVE DIFFERENCE in 'elseif', and 'else if'. One keeps going from the last IF, the other makes a new one.

UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("If you're having trouble spelling it, [pause=10]don't worry about it. [pause=0][color=#54ebaf]Piks[color]' name often gets mispelled too.")
	UI:WaitShowDialogue("Literacy doesn't really ever seem kind with our team, [pause=10]and I'm not sure why.")
UI:SetSpeakerEmotion("Pain")
	UI:WaitShowDialogue("...")
UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Eh, [pause=10]nevermind that tiny rant.")
		SV.prologue_alts.talked_to_adam_at_cafe = 2
		
elseif SV.prologue_alts.talked_to_adam_at_cafe == 2 then
	
UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Today just seems a little strange, [pause=10]and I can't explain it.")
	UI:WaitShowDialogue("Maybe it's just my imagination or something, [pause=10]but it's been bothering me since I woke up.")
UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("So I'm just gonna stay here for a while.")
		SV.prologue_alts.talked_to_adam_at_cafe = 3

elseif SV.prologue_alts.talked_to_adam_at_cafe == 3 then
	
	UI:WaitShowDialogue("...")
	UI:WaitShowDialogue("Uhm...")
UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Don't you have something you should be doing besides listening to me...?")

	SV.prologue_alts.talked_to_adam_at_cafe = 4 --true means done in this context. Nobody said I had to stick with X, Y or Z. / Logic, you're a dummy, because you tried to compare TRUE to a NUMBER. You almost made a black hole in the Computer. (changed from true to 4)

	else

	UI:WaitShowDialogue("I kind of want to drink my [color=#32a852]Oran Berry[color] juice if that's ok with you.")

	end
	
	GROUND:EntTurn(chara, Direction.UpRight)

end

function spindacafe.Linoone_Action(chara, activator)
local player = CH('PLAYER')

GROUND:CharTurnToChar(chara, player)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("I collected way too many things as a [color=#00F8F8]Zigzagoon[color]. [pause=0]I'm lucky I can recycle most of it.")

GROUND:EntTurn(chara, Direction.Up)
end

function spindacafe.Teammate1_Action(chara, activator)
   --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function spindacafe.Teammate2_Action(chara, activator)
   --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function spindacafe.Teammate3_Action(chara, activator)
   --Enable debugging this coroutine
  COMMON.GroundInteract(activator, chara, true)
end

function spindacafe.Scyther_Action(chara, activator)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Pain")
UI:WaitShowDialogue("It's been *how* long, [pause=10]and I still can't grab these cups??")
UI:SetSpeakerEmotion("Angry")
UI:WaitShowDialogue("I just want to know what [color=#32a852]Salac Berry[color] in juice form tastes like!")

end

function spindacafe.Zangoose_Action(chara, activator)
GROUND:CharTurnToChar(chara, activator)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("It's hard to beat the way [color=#00FFFF]Spinda[color] mixes his drinks.")
UI:WaitShowDialogue("Me and the team come here just to chat, [pause=10]though.")
UI:WaitShowDialogue("And not to strangers, [pause=10]so scram.")

GROUND:EntTurn(chara, Direction.Left)

end

function spindacafe.Sandslash_Action(chara, activator)

GROUND:CharTurnToChar(chara, activator)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Did you know there's [color=#00FFFF]Sandslash[color] that live in the snow?")
UI:WaitShowDialogue("How does something like that happen?")
UI:WaitShowDialogue("Would be pretty helpful to know, [pause=10]so I won't get pelted with hail in a snowstorm like last time.")

GROUND:EntTurn(chara, Direction.DownRight)

end

function spindacafe.Porygon_Action(chara, activator) --More like Starbound's Glitch race lol

GROUND:CharTurnToChar(chara, activator)

UI:SetSpeaker(chara)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Enigmatic. [pause=0]Who are you?")
UI:WaitShowDialogue("...")
UI:WaitShowDialogue("Curious. [pause=0]You heard me, [pause=10]but no response.")
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("Confused. [pause=0]Is broken?")

end

function spindacafe.chapterhidescript()

if SV.chapter.number == 0 then

GROUND:Hide("Scyther")
GROUND:Hide("Sandslash")
GROUND:Hide("Zangoose")
GROUND:Hide("Porygon")

elseif SV.chapter.number == 1 then --This is completely unprofessional, stupid, and probably bloating to the script, and Groundmap file,
															--But I want to keep everything tidey so ***I*** know what went wrong, and not jumble through several files.
GROUND:Hide("Linoone")
GROUND:Hide("Octillery")

end

end

return spindacafe

