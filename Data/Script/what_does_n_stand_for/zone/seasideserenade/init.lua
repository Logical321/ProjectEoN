--[[
    init.lua
    Created: 08/06/2023 19:53:21
    Description: Autogenerated script file for the map seasideserenade.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local seasideserenade = {}

-------------------------------
-- Zone Callbacks
-------------------------------
---seasideserenade.Init(zone)
--Engine callback function
function seasideserenade.Init(zone)


end

---seasideserenade.EnterSegment(zone, rescuing, segmentID, mapID)
--Engine callback function
function seasideserenade.EnterSegment(zone, rescuing, segmentID, mapID)
  if rescuing ~= true then
    COMMON.BeginDungeon(zone.ID, segmentID, mapID)
  end
end

---seasideserenade.ExitSegment(zone, result, rescue, segmentID, mapID)
--Engine callback function
function seasideserenade.ExitSegment(zone, result, rescue, segmentID, mapID)
   --Enable debugging this coroutine
  PrintInfo("=>> ExitSegment_seasideserenade result "..tostring(result).." segment "..tostring(segmentID))
  
  --first check for rescue flag; if we're in rescue mode then take a different path
  COMMON.ExitDungeonMissionCheck(zone.ID, segmentID)
  if rescue == true then
    COMMON.EndRescue(zone, result, segmentID)
  elseif result ~= RogueEssence.Data.GameProgress.ResultType.Cleared then
  
    COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
	
  else
    if segmentID == 0 then
			SV.dungeons.seasideserenade = true
			COMMON.EndDungeonDay(result, 'seasideserenade', -1, 0, 0)
    else
      PrintInfo("No exit procedure found!")
      COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
    end
  end
end

---seasideserenade.Rescued(zone, name, mail)
--Engine callback function
function seasideserenade.Rescued(zone, name, mail)


end

return seasideserenade

