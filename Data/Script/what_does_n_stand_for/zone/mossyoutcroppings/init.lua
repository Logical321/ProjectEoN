--[[
    init.lua
    Created: 07/31/2023 22:32:06
    Description: Autogenerated script file for the map mossyoutcroppings.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local mossyoutcroppings = {}

-------------------------------
-- Zone Callbacks
-------------------------------
---mossyoutcroppings.Init(zone)
--Engine callback function
function mossyoutcroppings.Init(zone)


end

---mossyoutcroppings.EnterSegment(zone, rescuing, segmentID, mapID)
--Engine callback function
function mossyoutcroppings.EnterSegment(zone, rescuing, segmentID, mapID)
  if rescuing ~= true then
    COMMON.BeginDungeon(zone.ID, segmentID, mapID)
  end
end

---mossyoutcroppings.ExitSegment(zone, result, rescue, segmentID, mapID)
--Engine callback function
function mossyoutcroppings.ExitSegment(zone, result, rescue, segmentID, mapID)
   --Enable debugging this coroutine
  PrintInfo("=>> ExitSegment_mossyoutcroppings result "..tostring(result).." segment "..tostring(segmentID))
  
  --first check for rescue flag; if we're in rescue mode then take a different path
  COMMON.ExitDungeonMissionCheck(zone.ID, segmentID)
  if rescue == true then
    COMMON.EndRescue(zone, result, segmentID)
  elseif result ~= RogueEssence.Data.GameProgress.ResultType.Cleared then
  
    COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
	
  else
    if segmentID == 0 then
			SV.dungeons.mossyoutcroppings = true
			COMMON.EndDungeonDay(result, 'mossyoutcroppings', -1, 0, 0)
    else
      PrintInfo("No exit procedure found!")
      COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
    end
  end
end

---mossyoutcroppings.Rescued(zone, name, mail)
--Engine callback function
function mossyoutcroppings.Rescued(zone, name, mail)


end

return mossyoutcroppings

