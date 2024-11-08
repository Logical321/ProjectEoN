--[[
    init.lua
    Created: 08/16/2024 20:50:27
    Description: Autogenerated script file for the map prologueEX.
]]--
-- Commonly included lua functions and data
require 'origin.common'

-- Package name
local prologueEX = {}

-------------------------------
-- Zone Callbacks
-------------------------------
---prologueEX.Init(zone)
--Engine callback function
function prologueEX.Init(zone)


end

---prologueEX.EnterSegment(zone, rescuing, segmentID, mapID)
--Engine callback function
function prologueEX.EnterSegment(zone, rescuing, segmentID, mapID)


end

---prologueEX.ExitSegment(zone, result, rescue, segmentID, mapID)
--Engine callback function
function prologueEX.ExitSegment(zone, result, rescue, segmentID, mapID)
   --Enable debugging this coroutine
  PrintInfo("=>> ExitSegment_prologueEX result "..tostring(result).." segment "..tostring(segmentID))
  
  --first check for rescue flag; if we're in rescue mode then take a different path
  COMMON.ExitDungeonMissionCheck(zone.ID, segmentID)
  if rescue == true then
  
    COMMON.EndRescue(zone, result, segmentID)
	
  elseif result ~= RogueEssence.Data.GameProgress.ResultType.Cleared then
  
    COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
	
  else
    if segmentID == 0 then
	
			COMMON.EndDungeonDay(result, SV.Checkpoint.Zone, SV.checkpoint.Segment, SV.Checkpoint.Map, SV.checkpoint.Entry)
			
    else
	
      PrintInfo("No exit procedure found!")
      COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
	  
    end
  end
end

---prologueEX.Rescued(zone, name, mail)
--Engine callback function
function prologueEX.Rescued(zone, name, mail)


end

return prologueEX

