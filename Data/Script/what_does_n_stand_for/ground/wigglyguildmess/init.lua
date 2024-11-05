--[[
    init.lua
    Created: 06/13/2023 21:35:11
    Description: Autogenerated script file for the map wigglyguildmess.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local wigglyguildmess = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---wigglyguildmess.Init(map)
--Engine callback function
function wigglyguildmess.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  

end

---wigglyguildmess.Enter(map)
--Engine callback function
function wigglyguildmess.Enter(map)

  GAME:FadeIn(20)

end

---wigglyguildmess.Exit(map)
--Engine callback function
function wigglyguildmess.Exit(map)


end

---wigglyguildmess.Update(map)
--Engine callback function
function wigglyguildmess.Update(map)


end

---wigglyguildmess.GameSave(map)
--Engine callback function
function wigglyguildmess.GameSave(map)


end

---wigglyguildmess.GameLoad(map)
--Engine callback function
function wigglyguildmess.GameLoad(map)

  GAME:FadeIn(20)

end

-------------------------------
-- Entities Callbacks
-------------------------------

function wigglyguildmess.Tasty_Action(obj, activator)
local player =CH('PLAYER')

UI:SetSpeaker(player)
UI:SetSpeakerEmotion("Normal")
UI:WaitShowDialogue("(I'll never give up eating these berries if I start, [pause=10]ain't gonna let them down either.)")
UI:WaitShowDialogue("(Then I'll just run around, [pause=10]and eat dessert.)")
UI:SetSpeakerEmotion("Worried")
UI:WaitShowDialogue("(...)")
UI:WaitShowDialogue("(Wait, [pause=10]what in the world am I doing in this spot?)")

end

function wigglyguildmess.InteractiveNear_Touch(obj, activator)
SOUND:PlayBattleSE("EVT_Emote_Confused")
    GROUND:CharSetEmote(activator, "question", 1)
end

function wigglyguildmess.Sign_Action(obj, activator)
  UI:ResetSpeaker()
  UI:SetCenter(true)
  UI:SetAutoFinish(true)
  
  UI:WaitShowDialogue("Welcome to the mess hall! \nPlease clean up after yourselves!")
  
  UI:SetCenter(false)
  UI:SetAutoFinish(false)
end

function wigglyguildmess.LeaveHall_Touch(obj, activator)
GAME:FadeOut(false, 20)
GAME:EnterGroundMap("wigglyguildbottom", "EntranceLeft")
end

return wigglyguildmess

