--[[
    init.lua
    Created: 11/18/2023 21:48:41
    Description: Autogenerated script file for the map roadwalkpathway.
]]--
-- Commonly included lua functions and data
require 'what_does_n_stand_for.common'

-- Package name
local roadwalkpathway = {}

-------------------------------
-- Zone Callbacks
-------------------------------
---roadwalkpathway.Init(zone)
--Engine callback function
function roadwalkpathway.Init(zone)


end

---roadwalkpathway.EnterSegment(zone, rescuing, segmentID, mapID)
--Engine callback function
function roadwalkpathway.EnterSegment(zone, rescuing, segmentID, mapID)

  if rescuing ~= true then
    COMMON.BeginDungeon(zone.ID, segmentID, mapID)
  end

end

---roadwalkpathway.ExitSegment(zone, result, rescue, segmentID, mapID)
--Engine callback function
function roadwalkpathway.ExitSegment(zone, result, rescue, segmentID, mapID)

  PrintInfo("=>> ExitSegment_cacklingquarry result "..tostring(result).." segment "..tostring(segmentID))
  
  --first check for rescue flag; if we're in rescue mode then take a different path
  COMMON.ExitDungeonMissionCheck(zone.ID, segmentID)
  if rescue == true then
    COMMON.EndRescue(zone, result, segmentID)
  elseif result ~= RogueEssence.Data.GameProgress.ResultType.Cleared then
	
	local guestCount = GAME:GetPlayerGuestCount()
		for i = 0, guestCount - 1, 1 do
		
		GAME:RemovePlayerGuest(0)

		end
	
	if not SV.chapter1.thieves_defeated then
	GAME:WaitFrames(10)
	UI:SetSpeaker('[color=#54ebaf]Madilyn[color]',true,'piplup',1,'normal',Gender.Female)
	UI:SetSpeakerEmotion("Pain")
	UI:WaitShowDialogue("Shoot! [pause=0]We have to get out of here, [pause=10]and regroup tomorrow.")
	end
	
    COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
	
  else
  
    if segmentID == 0 then
		SV.dungeons.crumblingcanyonway = true --It wouldn't make sense to say you *haven't* completed the dungeon when you technically did.
			if not SV.chapter1.thieves_defeated then
				SV.branchwaywoodsentrance.DungeonComplete = true
				COMMON.EndDungeonDay(result, 'roadwalkpathway', -1, 1, 0)
			else
				COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry) --Skip that thing entirely. This is a caravan crossing place.
			end
			
	elseif segmentID == 1 then
	
		local guestCount = GAME:GetPlayerGuestCount()
		for i = 0, guestCount - 1, 1 do
		
		GAME:RemovePlayerGuest(0)

		end
	
	SV.chapter1.thieves_defeated = true
	COMMON.EndDungeonDay(result, 'roadwalkpathway', -1, 1, 0)
			
    else
      PrintInfo("No exit procedure found!")
      COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Segment, SV.checkpoint.Map, SV.checkpoint.Entry)
	
  end
 end
GAME:SetCanRecruit(true) --Always disable at the end of the dungeon regardless if it's still off.
end

---roadwalkpathway.Rescued(zone, name, mail)
--Engine callback function
function roadwalkpathway.Rescued(zone, name, mail)


end

return roadwalkpathway

