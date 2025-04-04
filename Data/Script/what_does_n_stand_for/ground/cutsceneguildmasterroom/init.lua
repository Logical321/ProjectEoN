--[[
    init.lua
    Created: 07/16/2023 12:51:18
    Description: Autogenerated script file for the map cutsceneguildmasterroom.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local cutsceneguildmasterroom = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---cutsceneguildmasterroom.Init(map)
--Engine callback function
function cutsceneguildmasterroom.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  

end

---cutsceneguildmasterroom.Enter(map)
--Engine callback function
function cutsceneguildmasterroom.Enter(map)

  cutsceneguildmasterroom.SingleScene(whocares)

end

---cutsceneguildmasterroom.Exit(map)
--Engine callback function
function cutsceneguildmasterroom.Exit(map)


end

---cutsceneguildmasterroom.Update(map)
--Engine callback function
function cutsceneguildmasterroom.Update(map)


end

---cutsceneguildmasterroom.GameSave(map)
--Engine callback function
function cutsceneguildmasterroom.GameSave(map)


end

---cutsceneguildmasterroom.GameLoad(map)
--Engine callback function
function cutsceneguildmasterroom.GameLoad(map)

  GAME:FadeIn(20)

end

-------------------------------
-- Entities Callbacks
-------------------------------

function cutsceneguildmasterroom.SingleScene(whocares)
local player =CH('PLAYER')
local AdamMudkip =CH('AdamMudkip')
local Piks =CH('Piks')
local Chatot =CH('Chatot')
local Wigglytuff =CH('Wigglytuff')

GAME:MoveCamera(196, 224, 1, false)--196 224
GAME:CutsceneMode(true)
GAME:FadeIn(20)

UI:SetSpeaker(Chatot)
UI:SetSpeakerLoc(225,100)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Guildmaster, [pause=10]Team [color=#ffb5fd]Electrater[color] needs a place for their new trainee to stay in for a while.")

GAME:WaitFrames(40)

UI:SetSpeakerEmotion("Worried", true)
UI:WaitShowDialogue("Erm... [pause=20]Guildmaster [color=#00FFFF]Wigglytuff[color], [pause=10]ma'am?")

GAME:WaitFrames(20)

GROUND:CharAnimateTurn(Wigglytuff, Direction.Down, 1, true)
SOUND:PlayBattleSE("EVT_Emote_Startled")
GROUND:CharSetEmote(Chatot, "shock", 1)
GROUND:CharSetEmote(player, "shock", 1)

local coro1 = TASK:BranchCoroutine(function() cutsceneguildmasterroom.WigglytuffScare_Sequence(player) end)
local coro2 = TASK:BranchCoroutine(function() cutsceneguildmasterroom.WigglytuffScare_Sequence(Chatot) end)

TASK:JoinCoroutines({coro1,coro2})
SOUND:PlayBGM("Guildmaster Wigglytuff.ogg", true)

UI:SetSpeaker(Wigglytuff)
UI:SetSpeakerLoc(100,065)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("Heya! ♪")
GAME:WaitFrames(10)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("*Yawn*... [pause=20]I wasn't expecting friends at this time, [pause=10]I fell asleep... [br]Why'd you wake me up, [pause=10][color=#00FFFF]Chatot[color]?")

GROUND:CharSetEmote(Chatot, "sweatdrop", 1)
GROUND:EntTurn(Chatot, Direction.Left)
GAME:WaitFrames(50)
GROUND:EntTurn(Chatot, Direction.UpLeft)

UI:SetSpeaker(Piks)
UI:SetSpeakerLoc(234,131)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Sorry Miss [color=#69edff]Wigglytuff[color], [pause=10]but we haven't prepared for ".. CH('PLAYER'):GetDisplayName() .." here. [br]We're wondering if ".. GenderCheck(player, "they", false) .." could stay in our old room for the time being?")

GAME:WaitFrames(10)

UI:SetSpeaker(Wigglytuff)
UI:SetSpeakerLoc(100,065)
UI:SetSpeakerEmotion("Happy")
UI:WaitShowDialogue("Ooo, [pause=10]new friendly friends!~ [pause=0]You two always have nice friends!~ ♪")

GROUND:CharSetEmote(Chatot, "sweatdrop", 1)
SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")
GAME:WaitFrames(40)

UI:SetSpeaker(Chatot, false)
UI:SetSpeakerLoc(225,100)
UI:SetSpeakerEmotion("Pain", true)
UI:WaitShowDialogue("(I wouldn't exactly call [color=#54ebaf]Madilyn[color] friendly...)")
UI:WaitShowDialogue("(She scares everyone in the guild... [pause=20]especially [color=#00FFFF]Loudred[color]...)")
UI:SetSpeaker(Chatot)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Erm... [pause=20]So Guildmaster, [pause=10]would that be alright with you?")

GROUND:CharSetEmote(Wigglytuff, "happy", 0)
GAME:WaitFrames(10)

UI:SetSpeaker(Wigglytuff)
UI:SetSpeakerLoc(100,065)
UI:SetSpeakerEmotion("Happy")
GROUND:EntTurn(Wigglytuff, Direction.DownRight)
UI:WaitShowDialogue("I would be very delighted!~ ♪")
GROUND:CharSetEmote(Wigglytuff, "", 0)
UI:SetSpeakerEmotion("Normal")
GROUND:EntTurn(Wigglytuff, Direction.Down)
UI:WaitShowDialogue("But we should probably make sure ".. GenderCheck(player, "they're", false) .." super duper ready for ".. GenderCheck(player, "their", false) .." new job!")
UI:WaitShowDialogue(GenderCheck(player, "do they", true) .." have a map, [pause=10]and an explorer's badge?")

GROUND:EntTurn(player, Direction.UpLeft)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.Up)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.UpRight)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.Up)
GROUND:EntTurn(AdamMudkip, Direction.UpRight)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.UpLeft)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.Up)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.UpRight)
GAME:WaitFrames(3)
GROUND:EntTurn(player, Direction.Up)

GAME:WaitFrames(20)

UI:SetSpeaker(AdamMudkip)
UI:ResetSpeakerLoc()
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("I guess not...")
GROUND:EntTurn(AdamMudkip, Direction.Up)
GAME:WaitFrames(10)
UI:WaitShowDialogue("Do you not have any new explorer gear?")

GROUND:CharAnimateTurn(Chatot, Direction.DownLeft, 4, true)
GAME:WaitFrames(10)

UI:SetSpeaker(Chatot)
UI:SetSpeakerLoc(225,100)
UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Nope. [pause=0]We don't have a lick of new gear for any new recruits.")

GROUND:EntTurn(Piks, Direction.UpRight)
GROUND:EntTurn(AdamMudkip, Direction.UpRight)
GROUND:EntTurn(player, Direction.UpRight)
GROUND:EntTurn(Wigglytuff, Direction.DownRight)

SOUND:PlayBattleSE("EVT_Emote_Confused")
GROUND:CharSetEmote(Piks, "question", 1)
GAME:WaitFrames(40)

UI:SetSpeaker(Piks)
UI:SetSpeakerLoc(234,131)
UI:SetSpeakerEmotion("Worried", false)
UI:WaitShowDialogue("Huh? [pause=0]What happened to all the surplus of new apprentice equipment?")

SOUND:PlayBattleSE("EVT_Chatot_Flutter")
GROUND:CharWaitAnim(Chatot, "Special0")

UI:SetSpeaker(Chatot)
UI:SetSpeakerLoc(225,100)
UI:SetSpeakerEmotion("Determined", true)
UI:WaitShowDialogue("We just ran out, [pause=10]okay?")
UI:WaitShowTimedDialogue("I didn't get a chance to order new equipment from the Exploration Tea-!", 10)
--UI:WaitShowDialogue("We don't get that many apprentices anyways, [pause=10]so restocking equipment seemed like a waste of time!")
--GROUND:CharAnimateTurn(Chatot, Direction.Right, 2, true)
GROUND:CharSetEmote(Chatot, "shock", 1)
SOUND:PlayBattleSE("EVT_Emote_Shock_2")
GAME:WaitFrames(40)
GROUND:CharSetAnim(Chatot, "Charge", true)
UI:SetSpeakerEmotion("Surprised", true)
UI:WaitShowDialogue("Eeek!")
GAME:WaitFrames(10)
GROUND:CharSetAction(Chatot, RogueEssence.Ground.PoseGroundAction(Chatot.Position, Chatot.Direction, RogueEssence.Content.GraphicsManager.GetAnimIndex("Pain")))
GAME:WaitFrames(20)
UI:SetSpeakerEmotion("Sad", true)
UI:WaitShowDialogue("Ow ow ow... [pause=20]My head aches...")

SOUND:PlayBattleSE("EVT_Emote_Confused")
GROUND:CharSetEmote(Wigglytuff, "question", 1)
GAME:WaitFrames(40)

UI:SetSpeaker(Wigglytuff)
UI:SetSpeakerLoc(100,065)
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("Why is [color=#00FFFF]Chatot[color] acting so weird today?")

GROUND:CharSetEmote(AdamMudkip, "sweatdrop", 1)
SOUND:PlayBattleSE("EVT_Emote_Sweatdrop")
GAME:WaitFrames(40)

UI:SetSpeaker(AdamMudkip)
UI:ResetSpeakerLoc()
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("[color=#00FFFF]Chatot[color], [pause=10]are you feeling alright? [pause=0]I can take you home if you'd like.")

SOUND:PlayBattleSE("EVT_Emote_Sweating")
GROUND:CharSetEmote(Chatot, "sweating", 1)
GAME:WaitFrames(40)

UI:SetSpeaker(Chatot)
UI:SetSpeakerLoc(225,100)
UI:SetSpeakerEmotion("Sad", true)
UI:WaitShowDialogue("*Sigh*... [pause=20]Yeah, [pause=10]that would be much appreciated, [pause=10][color=#54ebaf]Adam[color]. [pause=0]Thank you...")

GROUND:MoveInDirection(AdamMudkip, Direction.Up, 20, false, 2)
GROUND:CharAnimateTurn(AdamMudkip, Direction.Right, 4, false)
GROUND:MoveInDirection(AdamMudkip, Direction.Right, 25, false, 2)
GROUND:CharAnimateTurn(AdamMudkip, Direction.Down, 4, false)
GROUND:EntTurn(Wigglytuff, Direction.Down)
local coro1 = TASK:BranchCoroutine(function() cutsceneguildmasterroom.ChatotEscort2_Sequence(AdamMudkip) end)
local coro2 = TASK:BranchCoroutine(function() cutsceneguildmasterroom.ChatotEscort2_Sequence(Chatot) end)
local coro3 = TASK:BranchCoroutine(function() cutsceneguildmasterroom.ChatotEscort_Sequence(Piks) end)
local coro4 = TASK:BranchCoroutine(function() cutsceneguildmasterroom.ChatotEscort_Sequence(player) end)

TASK:JoinCoroutines({coro1,coro2,coro3})

GAME:WaitFrames(20)

UI:SetSpeaker(Piks)
UI:SetSpeakerLoc(234,131)
UI:SetSpeakerEmotion("Worried", true)
UI:WaitShowDialogue("Huh... [pause=20]That's strange.")
UI:WaitShowDialogue("Was that a...?")

GAME:WaitFrames(10)
GROUND:CharTurnToCharAnimated(Piks, player, 4)
GROUND:CharTurnToCharAnimated(player, Piks, 4)
GAME:WaitFrames(10)

UI:SetSpeakerEmotion("Normal", true)
UI:WaitShowDialogue("Ahh, [pause=10]nevermind my ramblings. [pause=0]It's getting quite late, [pause=10]and I thought I saw something.")
UI:WaitShowDialogue("I think it's about time to head to sleep. [pause=10]You don't want to have a sleepy first day, [pause=10]trust me.")

GROUND:CharAnimateTurn(Piks, Direction.Up, 4, false)
GAME:WaitFrames(10)

UI:WaitShowDialogue("Alright [color=#00FFFF]Wigglytuff[color], [pause=10]we'll see you tomorrow. [pause=0]Have a good night's rest!")

GROUND:CharAnimateTurn(player, Direction.Up, 4, true)
GROUND:CharSetEmote(Wigglytuff, "happy", 0)
UI:SetSpeaker(Wigglytuff)
UI:SetSpeakerLoc(100,065)
UI:SetSpeakerEmotion("Happy")
UI:WaitShowDialogue("You too, [pause=10][color=#54ebaf]Piks[color]! [pause=0]Nighty night!~ ♪")

SOUND:PlayBGM("None", true)
GAME:FadeOut(false, 30)
GAME:WaitFrames(40)

GAME:EnterZone('treasuretownzone', -1, 18, 0)

GAME:CutsceneMode(false)
end

function cutsceneguildmasterroom.WigglytuffScare_Sequence(character)
GROUND:CharWaitAnim(character, "Hurt")
GROUND:CharSetAnim(character, "None", true)
end

function cutsceneguildmasterroom.ChatotEscort_Sequence(character) --piks 
GROUND:MoveInDirection(character, Direction.Left, 10, false, 1)
--GROUND:CharAnimateTurn(character, Direction.UpLeft, 4, true)
GAME:WaitFrames(10)
GROUND:CharAnimateTurnTo(character, Direction.Down, 10)
end

function cutsceneguildmasterroom.ChatotEscort2_Sequence(character) --chatot adam
GROUND:MoveInDirection(character, Direction.Down, 140, false, 1)
end

function GenderCheck(chara, form, uppercase) --Uppercase?

    local gender = chara.CurrentForm.Gender
    local value = ""
    
    if gender == Gender.Female then
        local female_pronouns = {
            ["they"] = "she",
            ["their"] = "her",
            ["they're"] = "she's",
            ["do they"] = "does she",
        }
        value = female_pronouns[form]
    elseif gender == Gender.Male then
        local male_pronouns = {
            ["they"] = "he", 
            ["their"] = "his", 
            ["they're"] = "he's", 
            ["do they"] = "does he", 
        }
        value = male_pronouns[form]
    else -- if neither male or female, use they/them, so just return the form 
        value = form
    end

return uppercase and value:gsub("^%l", string.upper) or value

end

return cutsceneguildmasterroom

