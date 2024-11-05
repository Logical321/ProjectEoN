--[[
    init.lua
    Created: 04/05/2023 21:11:54
    Description: Autogenerated script file for the map cutscenebluff.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local cutscenebluff = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---cutscenebluff.Init(map)
--Engine callback function
function cutscenebluff.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  

end

---cutscenebluff.Enter(map)
--Engine callback function
function cutscenebluff.Enter(map)

 GROUND:AddMapStatus("dark")
 cutscenebluff.SingleScene(uno) --you better have a plus 4 or a draw 2 ready.

end

---cutscenebluff.Exit(map)
--Engine callback function
function cutscenebluff.Exit(map)


end

---cutscenebluff.Update(map)
--Engine callback function
function cutscenebluff.Update(map)


end

---cutscenebluff.GameSave(map)
--Engine callback function
function cutscenebluff.GameSave(map)


end

---cutscenebluff.GameLoad(map)
--Engine callback function
function cutscenebluff.GameLoad(map)

  GAME:FadeIn(20)

end

-------------------------------
-- Entities Callbacks
-------------------------------

function cutscenebluff.SingleScene(uno)
local Madilyn = CH("Madilyn")
--GROUND:Hide(player) --probably unnessesary, but you'll never know.
  GAME:MoveCamera(264, 20, 1, false)
  GAME:CutsceneMode(true)
  GAME:FadeIn(30)
			--Cutscene is probably useless, as it gives exposition.
  GROUND:MoveInDirection(Madilyn, Direction.Up, 70, false, 2)
  
  GAME:WaitFrames(40)
  --Top command disabled for Debugging Purposes.
  --UI:SetSpeaker(STRINGS:Format(STRINGS.MapStrings['HideName']), true, Madilyn.CurrentForm.Species, Madilyn.CurrentForm.Form, Madilyn.CurrentForm.Skin, Madilyn.CurrentForm.Gender)
  UI:SetSpeaker(STRINGS:Format("\\uE040"), true, Madilyn.CurrentForm.Species, Madilyn.CurrentForm.Form, Madilyn.CurrentForm.Skin, Madilyn.CurrentForm.Gender) --Setting the speaker name to a text icon works, but not putting them into text itself. What's wrong with my machine?
  UI:WaitShowDialogue("[color=#FFC663]Drenched Bluff[color], [pause=10]huh?")
  UI:WaitShowDialogue("Why this place? [pause=0]Isn't this an easy-peasy dungeon?")
  UI:WaitShowDialogue("I finished it on like my first day of training. [pause=0]Please tell me this is a joke if someone chose to hide here.")
  
  GAME:WaitFrames(30)
  GROUND:EntTurn(Madilyn, Direction.UpRight)
  GAME:WaitFrames(30)
  
  UI:SetSpeakerEmotion("Sigh")
  UI:WaitShowDialogue("Jeesh, [pause=10]just thinking about the first time going here reminds me of the first actual job I took for [color=#ffb5fd]Electrater[color].")
  UI:WaitShowDialogue("Time just flies right on by when you're always working hard... [pause=20]Especially when it's been this long...")
  UI:WaitShowDialogue("I don't remember when I joined, [pause=10]but it was back when we didn't even know the Expedition Society existed.") --Based on the order of when I played these games, PMD RRT came first, then Darkness, then Sky, then Super, then Gates.
  
  GROUND:EntTurn(Madilyn, Direction.Up)
  GAME:WaitFrames(30)
  
  UI:SetSpeakerEmotion("Normal")
  UI:WaitShowDialogue("Agh, [pause=10]nevermind. [pause=0]The outlaw is said to be in this dungeon.")
  UI:WaitShowDialogue("I'll just finish it and then go to bed. [pause=0]It's not gonna take that long.")
  
  GROUND:MoveInDirection(Madilyn, Direction.Up, 70, false, 2)
  GAME:FadeOut(false, 40)
  SOUND:PlayBGM("None", true)
  
  GAME:WaitFrames(40)
  
  SV.cutscenepath.DreamDone = true
  
  GAME:EnterGroundMap("cutscenepath", "Entrance_AfterDream")
  
 GAME:CutsceneMode(false)
end

return cutscenebluff

