--[[
    init.lua
    Created: 09/28/2023 20:52:22
    Description: Autogenerated script file for the map mossyoutcropsfinal.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local mossyoutcropsfinal = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---mossyoutcropsfinal.Init(map)
--Engine callback function
function mossyoutcropsfinal.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  

end

---mossyoutcropsfinal.Enter(map)
--Engine callback function
function mossyoutcropsfinal.Enter(map)

COMMON.RespawnAllies()

mossyoutcropsfinal.cutscene()

end

---mossyoutcropsfinal.Exit(map)
--Engine callback function
function mossyoutcropsfinal.Exit(map)


end

---mossyoutcropsfinal.Update(map)
--Engine callback function
function mossyoutcropsfinal.Update(map)


end

---mossyoutcropsfinal.GameSave(map)
--Engine callback function
function mossyoutcropsfinal.GameSave(map)


end

---mossyoutcropsfinal.GameLoad(map)
--Engine callback function
function mossyoutcropsfinal.GameLoad(map)

  GAME:FadeIn(20)

end

-------------------------------
-- Entities Callbacks
-------------------------------

function mossyoutcropsfinal.cutscene()
local player = CH('PLAYER')
local Teammate_1 = CH('Teammate_1')
local Teammate_2 = CH('Teammate_2')
local Teammate_3 = CH('Teammate_3')

GAME:CutsceneMode(true)
GAME:MoveCamera(190, 144, 1, false)

UI:WaitShowTitle("At the end of\nMossy Outcroppings", 20)
GAME:WaitFrames(60)
UI:WaitHideTitle(20)
GAME:WaitFrames(30)

local coro1 = TASK:BranchCoroutine(function() mossyoutcropsfinal.walkin_Sequence(player) end)
local coro2 = TASK:BranchCoroutine(function() --This is not what an Anonymous Function is for, I can tell.

SOUND:PlayBGM("Cave Camp.ogg", true)
GAME:FadeIn(20)
 
 end)
local coro3 = TASK:BranchCoroutine(function() mossyoutcropsfinal.TeamateA_Sequence(Teammate_1) end)
local coro4 = TASK:BranchCoroutine(function() mossyoutcropsfinal.TeamateB_Sequence(Teammate_2) end)
local coro5 = TASK:BranchCoroutine(function() mossyoutcropsfinal.TeamateC_Sequence(Teammate_3) end)
 
TASK:JoinCoroutines({coro1,coro2,coro3,coro4,coro5})

GROUND:CharSetEmote(player, "question", 1)

GAME:WaitFrames(40)

UI:ResetSpeaker(false)

coro1 = TASK:BranchCoroutine(function() --Gets ignored once coro2 is finished, so I have to put the transition in here.

UI:SetCenter(true)
UI:WaitShowDialogue("Huh? [pause=0]This is the pit of [color=#FFC663]Mossy Outcroppings[color]?")
UI:WaitShowDialogue("But this is the outside of the dungeon...")
UI:WaitShowDialogue("It's probably best to head back for now.")
UI:SetCenter(false)

GAME:FadeOut(false, 20)
GAME:CutsceneMode(false)
GAME:EnterZone('treasuretownzone', -1, 17, 0)

end)
coro2 = TASK:BranchCoroutine(function()

GROUND:CharAnimateTurn(player, Direction.Up, 4, true)
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(player, Direction.Down, 4, false)
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(player, Direction.Right, 4, true)

end)

coro3 = TASK:BranchCoroutine(function() mossyoutcropsfinal.TeamateA2_Sequence(Teammate_1) end)
coro4 = TASK:BranchCoroutine(function() mossyoutcropsfinal.TeamateB2_Sequence(Teammate_2) end)
coro5 = TASK:BranchCoroutine(function() mossyoutcropsfinal.TeamateC2_Sequence(Teammate_3) end)

TASK:JoinCoroutines({coro1,coro2,coro3,coro4,coro5})

end

function mossyoutcropsfinal.walkin_Sequence(character)
GROUND:MoveInDirection(character, Direction.Right, 60, false, 1)
end

function mossyoutcropsfinal.TeamateA_Sequence(character)
GROUND:MoveInDirection(character, Direction.Right, 58, false, 1)
end

function mossyoutcropsfinal.TeamateB_Sequence(character)
GROUND:MoveInDirection(character, Direction.Right, 56, false, 1)
end

function mossyoutcropsfinal.TeamateC_Sequence(character)
GROUND:MoveInDirection(character, Direction.Right, 57, false, 1)
end

function mossyoutcropsfinal.TeamateA2_Sequence(character)

GROUND:EntTurn(character, Direction.DownRight)
GAME:WaitFrames(20)
GROUND:CharAnimateTurn(character, Direction.UpLeft, 4, true)
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(character, Direction.UpRight, 4, false)
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(character, Direction.Down, 4, false)
GAME:WaitFrames(30)
GROUND:CharSetEmote(character, "question", 1)

end

function mossyoutcropsfinal.TeamateB2_Sequence(character)

GROUND:EntTurn(character, Direction.UpRight)
GAME:WaitFrames(20)
GROUND:CharAnimateTurn(character, Direction.DownRight, 4, false)
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(character, Direction.DownLeft, 4, false)
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(character, Direction.Up, 4, true)
GAME:WaitFrames(15)
GROUND:CharSetEmote(character, "question", 1)

end

function mossyoutcropsfinal.TeamateC2_Sequence(character)

GROUND:EntTurn(character, Direction.UpRight)
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(character, Direction.DownRight, 4, false)
GROUND:CharSetEmote(character, "question", 1)
GAME:WaitFrames(40)
GROUND:CharAnimateTurn(character, Direction.Left, 4, true)
GAME:WaitFrames(10)
GROUND:EntTurn(character, Direction.UpLeft)
GAME:WaitFrames(10)
GROUND:CharAnimateTurn(character, Direction.DownLeft, 4, true)
GAME:WaitFrames(10)
GROUND:EntTurn(character, Direction.Left)
GAME:WaitFrames(20)
GROUND:CharSetEmote(character, "sweatdrop", 1)
GAME:WaitFrames(30)
GROUND:CharAnimateTurn(character, Direction.Right, 4, true)

end

return mossyoutcropsfinal

