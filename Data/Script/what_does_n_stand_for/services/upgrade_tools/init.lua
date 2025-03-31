--[[
    Example Service
    
    This is an example to demonstrate how to use the BaseService class to implement a game service.
    
    **NOTE:** After declaring you service, you have to include your package inside the main.lua file!
]]--
require 'what_does_n_stand_for.common'
require 'origin.services.baseservice'

--Declare class UpgradeTools
local UpgradeTools = Class('UpgradeTools', BaseService)


--[[---------------------------------------------------------------
    UpgradeTools:initialize()
      UpgradeTools class constructor
---------------------------------------------------------------]]
function UpgradeTools:initialize()
  BaseService.initialize(self)
  PrintInfo('UpgradeTools:initialize()')
end

--[[---------------------------------------------------------------
    UpgradeTools:__gc()
      UpgradeTools class gc method
      Essentially called when the garbage collector collects the service.
  ---------------------------------------------------------------]]
function UpgradeTools:__gc()
  PrintInfo('*****************UpgradeTools:__gc()')
end

--[[---------------------------------------------------------------
    UpgradeTools:OnUpgrade()
      When a save file in an old version is loaded this is called!
---------------------------------------------------------------]]
function UpgradeTools:OnUpgrade()
print('Upgrading...')
print(SV.chapter.number)

  assert(self, 'UpgradeTools:OnUpgrade() : self is null!')
  
  PrintInfo("=>> Loading version")
 --_DATA.Save.NextDest = _DATA.Start.Map
  
  if SV.chapter.number == 0 and SV.cutscenepath.DreamDone then
	--SV.checkpoint = 
  --{
    --Zone    = 'treasuretownzone', Segment  = -1,
    --Map  = 0, Entry  = 0
  --} --T.Town entrance, don't call after prologue is done. / Spawns player OOB, do not give Player control while they are OOB.
  
  SV.checkpoint.zone = 'treasuretownzone'
  SV.checkpoint.segment = -1
  SV.checkpoint.map = 0
  SV.checkpoint.entry = 0
  
  elseif SV.chapter.number >= 1 then
	--SV.checkpoint = 
  --{
    --Zone    = 'treasuretownzone', Segment  = -1,
    --Map  = 17, Entry  = 0
  --} --Mess Hall, spawn here after the prologue is done, but not when chapter 2 starts.
  
  SV.checkpoint.zone = 'treasuretownzone'
  SV.checkpoint.segment = -1
  SV.checkpoint.map = 17
  SV.checkpoint.entry = 0
  
end

SV.adventure = 
{
  Thief    = false
}

SV.DestinationFloorNotified = false
SV.MonsterHouseMessageNotified = false
SV.OutlawDefeated = false
SV.OutlawGoonsDefeated = false
SV.MapTurnCounter = -1

if SV.DestinationFloorNotified == nil then
SV.DestinationFloorNotified = false
end

if SV.MonsterHouseMessageNotified == nil then
SV.MonsterHouseMessageNotified = false
end

if SV.OutlawDefeated == nil then
SV.OutlawDefeated = false
end

if SV.OutlawGoonsDefeated == nil then
SV.OutlawGoonsDefeated = false
end

if SV.MapTurnCounter == nil then
SV.MapTurnCounter = -1
end

SV.MissionsEnabled = false

if SV.MissionsEnabled == nil then
SV.MissionsEnabled = false
end

if SV.TemporaryFlags == nil then
SV.TemporaryFlags =
{
    MissionCompleted = false,--used to mark if there are any pending missions to hand in.
    PriorMapSetting = nil,--Used to mark what the player had their minimap setting whenever the game needs to temporarily change it to something else.
}
end

print(SV.checkpoint.zone)
print(SV.checkpoint.segment)
print(SV.checkpoint.map)
print(SV.checkpoint.entry)


SV.TakenBoard =
{
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  }

}

--Needed to save data about dungeons
SV.ExpectedLevel = {}
SV.DungeonOrder = {}
SV.StairType = {}

--jobs on the mission board.
SV.MissionBoard =
{
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  }

}

--Jobs on the outlaw board.
SV.OutlawBoard =
{
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = 1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  }
}

SV.missions =
{
  Missions = { },
  FinishedMissions = { },
}

SV.MissionPrereq =
{
  DungeonsCompleted = {}, --Uses a bitmap to determine which sections are complete (
  NumDungeonsCompleted = 0
}

-----------------------------------------------
-- Level Specific Defaults
-----------------------------------------------
if SV.shopgreen == nil then
SV.shopgreen = {
	{ Index = "food_apple", Amount = 0, Price = 50},
	{ Index = "food_apple_big", Amount = 0, Price = 150},
	{ Index = "food_banana", Amount = 0, Price = 500},
	{ Index = "food_chestnut", Amount = 0, Price = 80},
	{ Index = "berry_leppa", Amount = 0, Price = 80}
}
end

if SV.shopgreenALT == nil then
SV.shopgreenALT = { --Specific for Treasure Town's Kecleon.
	{ Index = "food_apple", Amount = 0, Price = 50},
	{ Index = "food_apple_big", Amount = 0, Price = 150},
	{ Index = "food_banana", Amount = 0, Price = 500},
	{ Index = "food_chestnut", Amount = 0, Price = 80},
	{ Index = "berry_leppa", Amount = 0, Price = 80}
}
end

if SV.shoppurple == nil then
SV.shoppurple = {
	{ Index = "orb_escape", Amount = 0, Price = 150}
}
end

if SV.missions == nil then
SV.missions =
{
  Missions = { },
  FinishedMissions = { },
}
end

if SV.tutorial == nil then
SV.tutorial =
{
  Progress = 0
}
end

if SV.weather == nil then
SV.weather =
{
  allow = false, --Allow Weather Rolling?
  rolled = false, --Has the weather been rolled?
  number = 0, --What weather should be applied to the Hubs?
}
end

if SV.branchwaywoodsentrance == nil then
SV.branchwaywoodsentrance =
{
  DungeonFailed = false,
  DungeonComplete = false, --literally used to make sure the Results Screen never appears. Turn to True when you want the results off. Turn False to keep the Results on.
  BossDefeated = false,
  flower_inspect = false,
}
end

if SV.cutscenepath == nil then
SV.cutscenepath =
{
  DreamDone = false,
}
end

if SV.prologue == nil then
SV.prologue =
{
  dont_cutscene = true,
  cant_do_that_yet = true,
  has_spindas_shaker = false, --Spinda's Mixer. Triggers cutscenes and progression. (PROLOGUE)
  spindas_shaker_given = false,
  crossroads_cs1 = false,
  crossroads_cs2 = false,
  reached_main_cutscene = false,
}
end

if SV.repeatable == nil then
SV.repeatable =
{
  pots = true,
  cameo_times_talked_to_bolt = 0,
  day_finished = false,
  daily_chant = false,
  madilyns_stories_told = 0,
  asked_adam_for_help = 0,
}
end

if SV.prologue_alts == nil then
SV.prologue_alts =
{
  chatot_greeted = false,
  spinda_greeted = false, --Going to him first would mean he knows you. Extra Dialogue!
  blissy_declined = false,
  learned_adams_name = false,
  talked_to_adam_at_cafe = 0, --Feels too long.
  learned_piks_name = false,
  learned_madilyns_name = false,
  d_bluff_no_counter = 0,
  maproam_tutorial = false,
  demodone = false,
}
end

if SV.dungeons == nil then
SV.dungeons = --Used for completions sake later. Would be a waste of time to do a float addition every dungeon.
{
  drenchedbluff = false,
  drenchedbluff_fail = false,
  mpr_drenched = false, --Makes Drenched Bluff appear on the Roam Map - I think.
  mossyoutcroppings = false,
  mpr_mosscrop = false,
  seasideserenade = false,
  mpr_seasong = false,
  cacklingquarry = false,
  mpr_cackle = false,
  crumblingcanyonway = false,
  mpr_crumbcanyon = false,
}
end

if SV.chapter1 == nil then
SV.chapter1= --For use in Chapter 1's story bits only.
{
  chatot_quest1 = false,
  chimecho_greeted = false,
  piks_reminder = false,
  sbfadein = false, --AKA the dumbest way to stop a fadein.
  mission_brief = false,
  apricorn_tutorial = false,
  meeting_partA = false,
  meeting_partB = false,
  greenkecleon_dialogue = false,
  purplekecleon_dialogue = false,
  road_to_crumble_cutscene = false, --Use to skip the cutscene, and head to the dungeon.
  crumble_rest_cutscene = false, --Use to skip the cutscene, and head to the dungeon.
  thieves_cutscene = false,
  thieves_defeated = false,
  spinda_promise = false,
}
end

if SV.chapter2 == nil then
SV.chapter2=
{
chatot_reminder = false,
}
end

if SV.chapter == nil then
SV.chapter = --SHOULD Change WHEN CHAPTERS ARE FINISHED, NOT STARTED!
{
number = 0,
}
end

if SV.playerinfo == nil then
SV.playerinfo =
{
continent = nil,
town = nil,
job = nil
}
end

SV.eontestroom =
{
  Starter = { Species="piplup", Form=1, Skin="normal", Gender=1 },
  Song    = "Welcome to the World of Pokémon!.ogg",
}

SV.unlocked_trades = {

}
--Check all current Values, used for Debug purposes.

print(SV.branchwaywoodsentrance.DungeonComplete)
print(SV.branchwaywoodsentrance.BossDefeated)
print(SV.chapter1.piks_reminder)
print(SV.chapter.number)

--Initialize these values.

  if SV.tutorial == nil then
  SV.tutorial = {}
  end

  if SV.branchwaywoodsentrance.flower_inspect == nil then
  SV.branchwaywoodsentrance.flower_inspect = SV.repeatable.flowers
  end
  
  if SV.prologue == nil then
  SV.prologue = {}
  end
  
    if SV.prologue_alts == nil then
  SV.prologue_alts = {}
  end
  
   if SV.dungeons == nil then
  SV.dungeons = {}
  end
  
   if SV.repeatable == nil then
  SV.repeatable = {}
  end
  
   if SV.chapter1 == nil then
  SV.chapter1 = {}
  end
  
if SV.playerinfo == nil then
	SV.playerinfo = {}
end

  if SV.prologue.dont_cutscene == nil then
  SV.prologue.dont_cutscene = SV.donotallowyet.nocutscene or SV.prologue.dont_cutscene
  end
  
  if SV.prologue.cant_do_that_yet == nil then
  SV.prologue.cant_do_that_yet = SV.donotallowyet.notrightnow or SV.prologue.cant_do_that_yet
  end
  
  if SV.prologue.has_spindas_shaker == nil then
  SV.prologue.has_spindas_shaker = SV.donotallowyet.importantitem1 or SV.prologue.has_spindas_shaker
  end
  
  if SV.prologue.spindas_shaker_given == nil then
  SV.prologue.spindas_shaker_given = SV.donotallowyet.spindagiven or SV.prologue.spindas_shaker_given
  end
  
  if SV.prologue.crossroads_cs1 == nil then
  SV.prologue.crossroads_cs1 = SV.donotallowyet.crossroadscs1 or SV.prologue.crossroads_cs1
  end
  
  if SV.prologue.crossroads_cs2 == nil then
  SV.prologue.crossroads_cs2 = SV.donotallowyet.crossroadscs2 or SV.prologue.crossroads_cs2
  end
  
  if SV.prologue.reached_main_cutscene == nil then
  SV.prologue.reached_main_cutscene = SV.donotallowyet.reachedmaincutscene or SV.prologue.reached_main_cutscene
  end

  if SV.repeatable.cameo_times_talked_to_bolt == nil then
  SV.repeatable.cameo_times_talked_to_bolt = SV.repeatable.boltlevel or SV.repeatable.cameo_times_talked_to_bolt or 0
  end
  
  if SV.repeatable.day_finished == nil then
  SV.repeatable.day_finished = SV.repeatable.dayfinished or SV.repeatable.day_finished
  end
  
  if SV.repeatable.daily_chant == nil then
  SV.repeatable.daily_chant = SV.repeatable.dailychant or SV.repeatable.daily_chant
  end
  
  if SV.repeatable.madilyns_stories_told == nil then
  SV.repeatable.madilyns_stories_told = SV.repeatable.madilynstorycounter or SV.repeatable.madilyns_stories_told or 0
  end
  
  if SV.repeatable.asked_adam_for_help == nil then
  SV.repeatable.asked_adam_for_help = SV.repeatable.adamhelpcounter or SV.repeatable.asked_adam_for_help or 0
  end

  if SV.prologue_alts.chatot_greeted == nil then
  SV.prologue_alts.chatot_greeted = SV.knowledge.chatotknowledge or SV.prologue_alts.chatot_greeted
  end
  
  if SV.prologue_alts.spinda_greeted == nil then
  SV.prologue_alts.spinda_greeted = SV.knowledge.spindaknowledge or SV.prologue_alts.spinda_greeted
  end
  
  if SV.prologue_alts.blissy_declined == nil then
  SV.prologue_alts.blissy_declined = SV.knowledge.blissydeclined or SV.prologue_alts.blissy_declined
  end
  
  if SV.prologue_alts.learned_adams_name == nil then
  SV.prologue_alts.learned_adams_name = SV.knowledge.adamname or SV.prologue_alts.learned_adams_name
  end
  
  if SV.prologue_alts.talked_to_adam_at_cafe == nil then
  SV.prologue_alts.talked_to_adam_at_cafe = SV.knowledge.adamknowledge or SV.prologue_alts.talked_to_adam_at_cafe or 0
  end
  
  if SV.prologue_alts.learned_piks_name == nil then
  SV.prologue_alts.learned_piks_name = SV.knowledge.piksname or SV.prologue_alts.learned_piks_name
  end
  
  if SV.prologue_alts.learned_madilyns_name == nil then
  SV.prologue_alts.learned_madilyns_name = SV.knowledge.madilynname or SV.prologue_alts.learned_madilyns_name
  end
  
  if SV.prologue_alts.d_bluff_no_counter == nil then
  SV.prologue_alts.d_bluff_no_counter = SV.repeatable.confusingmon or 0
  end
  
  if SV.prologue_alts.maproam_tutorial == nil then
  SV.prologue_alts.maproam_tutorial = SV.repeatable.maproamtutorial or SV.prologue_alts.maproam_tutorial
  end
  
  if SV.prologue_alts.demodone == nil then
  SV.prologue_alts.demodone = false
  end

  if SV.dungeons.drenchedbluff_fail == nil then
  SV.dungeons.drenchedbluff_fail = SV.dungeons.drenchedblufffail or SV.dungeons.drenchedbluff_fail
  end
  
  if SV.dungeons.crumblingcanyonway == nil then
  SV.dungeons.crumblingcanyonway = false
  end
  
  if SV.dungeons.mpr_drenched == nil then
  SV.dungeons.mpr_drenched = SV.dungeons.mprdrenched or SV.dungeons.mpr_drenched
  end
  
  if SV.dungeons.mpr_mosscrop == nil then
  SV.dungeons.mpr_mosscrop = SV.dungeons.mprmosscrop or SV.dungeons.mpr_mosscrop
  end
  
  if SV.dungeons.mpr_seasong == nil then
  SV.dungeons.mpr_seasong = SV.dungeons.mrpseasong or SV.dungeons.mpr_seasong
  end
  
  if SV.dungeons.mpr_cackle == nil then
  SV.dungeons.mpr_cackle = SV.dungeons.mprcackle or SV.dungeons.mpr_cackle
  end
  
  if SV.dungeons.mpr_crumbcanyon == nil then
  SV.dungeons.mpr_crumbcanyon = false
  end

  if SV.chapter1.chatot_quest1 == nil then
  SV.chapter1.chatot_quest1 = SV.chapter1.chatotquest1 or SV.chapter1.chatot_quest1
  end
  
  if SV.chapter1.chimecho_greeted == nil then
  SV.chapter1.chimecho_greeted = SV.knowledge.chimechoknowledge or SV.chapter1.chimecho_greeted
  end
  
  if SV.chapter1.piks_reminder == nil then
  SV.chapter1.piks_reminder = SV.chapter1.piksreminder or SV.chapter1.piks_reminder
  end
  
  if SV.chapter1.sbfadein == nil then
  SV.chapter1.sbfadein = false
  end
  
  if SV.chapter1.mission_brief == nil then
  SV.chapter1.mission_brief = SV.chapter1.missionbrief or SV.chapter1.mission_brief
  end
  
  if SV.chapter1.apricorn_tutorial == nil then
  SV.chapter1.apricorn_tutorial = SV.chapter1.apricorntutorial or SV.chapter1.apricorn_tutorial
  end
  
  if SV.chapter1.meeting_partA == nil then
  SV.chapter1.meeting_partA = SV.chapter1.meetingquestA or SV.chapter1.meeting_partA
  end
  
  if SV.chapter1.meeting_partB == nil then
  SV.chapter1.meeting_partB = SV.chapter1.meetingquestB or SV.chapter1.meeting_partB
  end
  
  if SV.chapter1.greenkecleon_dialogue == nil then
  SV.chapter1.greenkecleon_dialogue = false
  end
  
  if SV.chapter1.purplekecleon_dialogue == nil then
  SV.chapter1.purplekecleon_dialogue = false
  end
  
  if SV.chapter1.road_to_crumble_cutscene == nil then
  SV.chapter1.road_to_crumble_cutscene = false
  end
  
  if SV.chapter1.crumble_rest_cutscene == nil then
 SV.chapter1.crumble_rest_cutscene = false
  end
  
  if SV.chapter1.thieves_cutscene == nil then
  SV.chapter1.thieves_cutscene = false
  end
  
  if SV.playerinfo.continent == nil then
  SV.playerinfo.continent = nil
  end
  
  if SV.playerinfo.town == nil then
  SV.playerinfo.town = nil
  end --This is stupid, but I'd rather not let the game 'beep' after an update.
  
  if SV.playerinfo.job == nil then
  SV.playerinfo.job = nil
  end --This shouldn't affect any of the 'Special Choices', because they're nil anyways.
  
  if SV.chapter2.chatot_reminder == nil then
  SV.chapter2.chatot_reminder = nil
  end
  
  if SV.weather.allow == nil then
  SV.weather.allow = true
  end
  
  if SV.weather.rolled == nil then
  SV.weather.rolled = true
  end
  
  if SV.weather.number == nil then
  SV.weather.number = 0
  end
 
if SV.MissionPrereq == nil then 
  SV.MissionPrereq =
{
  DungeonsCompleted = {}, --Uses a bitmap to determine which sections are complete (
  NumDungeonsCompleted = 0
}
end

if SV.TakenBoard == nil then
SV.TakenBoard =
{
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = "",
    BackReference = -1
  }

}
end

--Needed to save data about dungeons
if SV.ExpectedLevel == nil then
SV.ExpectedLevel = {}
end
if SV.DungeonOrder == nil then
SV.DungeonOrder = {}
end
if SV.StairType == nil then
SV.StairType = {}
end

--jobs on the mission board.
if SV.MissionBoard == nil then
SV.MissionBoard =
{
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  }

}
end

--Jobs on the outlaw board.
if SV.OutlawBoard == nil then
SV.OutlawBoard =
{
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = 1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  },
  {
    Client = "",
    Target = "",
    Flavor = "",
    Title = "",
    Zone = "",
    Segment = -1,
    Floor = -1,
    Reward = "",
    Type = -1,
    Completion = -1,
    Taken = false,
    Difficulty = "",
    Item = "",
    Special = "",
    ClientGender = -1,
    TargetGender = -1,
    BonusReward = ""
  }
}
end
  
  SV.eontestroom.Starter = { Species="piplup", Form=1, Skin="normal", Gender=1 }
  
  PrintInfo("=>> Loaded version")
end

--[[---------------------------------------------------------------
    UpgradeTools:OnLossPenalty()
      Called when the player fails a dungeon in main progress
  ---------------------------------------------------------------]]
function UpgradeTools:OnLossPenalty(save) 
  assert(self, 'UpgradeTools:OnLossPenalty() : self is null!')
 
  --remove money
  save.ActiveTeam.Money = 0
  local inv_count = save.ActiveTeam:GetInvCount() - 1

  --remove bag items
  for i = inv_count, 0, -1 do
    local entry = _DATA:GetItem(save.ActiveTeam:GetInv(i).ID)
    if not entry.CannotDrop then
      save.ActiveTeam:RemoveFromInv(i)
    end
  end
  
  --remove equips
  local player_count = save.ActiveTeam.Players.Count
  for i = 0, player_count - 1, 1 do 
    local player = save.ActiveTeam.Players[i]
    if player.EquippedItem.ID ~= '' and player.EquippedItem.ID ~= nil then 
      local entry = _DATA:GetItem(player.EquippedItem.ID)
      if not entry.CannotDrop then
         player:SilentDequipItem()
      end
    end
  end
end

---Summary
-- Subscribe to all channels this service wants callbacks from
function UpgradeTools:Subscribe(med)
  med:Subscribe("UpgradeTools", EngineServiceEvents.UpgradeSave,        function() self.OnUpgrade(self) end )
end

---Summary
-- un-subscribe to all channels this service subscribed to
function UpgradeTools:UnSubscribe(med)
end

---Summary
-- The update method is run as a coroutine for each services.
function UpgradeTools:Update(gtime)
--  while(true)
--    coroutine.yield()
--  end
end

--Add our service
SCRIPT:AddService("UpgradeTools", UpgradeTools:new())
return UpgradeTools