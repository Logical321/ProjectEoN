require 'what_does_n_stand_for.common'

local branchwaywoodsdungeon = {}
--------------------------------------------------
-- Map Callbacks
--------------------------------------------------
function branchwaywoodsdungeon.Init(zone)
   --Enable debugging this coroutine
  PrintInfo("=>> Init_branchwaywoodsdungeon")
  

end

--Rescuing should be impossible, so I hope these scripts are ignored.

function branchwaywoodsdungeon.Rescued(zone, name, mail)
  COMMON.Rescued(zone, name, mail)
end

function branchwaywoodsdungeon.EnterSegment(zone, rescuing, segmentID, mapID)
  if rescuing ~= true then
    COMMON.BeginDungeon(zone.ID, segmentID, mapID)
  end
end

function branchwaywoodsdungeon.ExitSegment(zone, result, rescue, segmentID, mapID)
   --Enable debugging this coroutine
  PrintInfo("=>> ExitSegment_branchwaywoodsdungeon result "..tostring(result).." segment "..tostring(segmentID))
  
  --first check for rescue flag; if we're in rescue mode then take a different path
  COMMON.ExitDungeonMissionCheck(zone.ID, segmentID)
  if rescue == true then
    COMMON.EndRescue(zone, result, segmentID)
  elseif result ~= RogueEssence.Data.GameProgress.ResultType.Cleared then
  
  SV.branchwaywoodsentrance.DungeonFailed = true
    COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry) --works now, change checkpoint later
	--GAME:EnterZone('branchwaywoods', -1, 0, 1) --use to test cutscene, do not enable otherwise.
	--GAME:EnterGroundMap("branchwaywoodsentrance", "entrance_dungeonfail") --don't use, this is for GroundMaps
	
  else
    if segmentID == 0 then
			--GAME:EnterGroundMap("branchwaywoodsexitcutscene", "entrance") --don't use, this is for GroundMaps
			GAME:EnterZone('branchwaywoods', -1, 1, 0)
			--COMMON.EndDungeonDay(result, SV.Checkpoint.Zone, SV.checkpoint.Segment, SV.Checkpoint.Map, SV.checkpoint.Entry) don't use, this ends the day.
    else
      PrintInfo("No exit procedure found!")
      COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
    end
  end
end

return branchwaywoodsdungeon