--[[
    scriptvars.lua
      This file contains all the default values for the script variables. AKA on a new game this file is loaded!
      Script variables are stored in a table  that gets saved when the game is saved.
      Its meant to be used for scripters to add data to be saved and loaded during a playthrough.
      
      You can simply refer to the "SV" global table like any other table in any scripts!
      You don't need to write a default value in this lua script to add a new value.
      However its good practice to set a default value when you can!
      
    --Examples:
    SV.SomeVariable = "Smiles go for miles!"
    SV.AnotherVariable = 2526
    SV.AnotherVariable = { something={somethingelse={} } }
    SV.AnotherVariable = function() PrintInfo('lmao') end
]]--

-----------------------------------------------
-- Services Defaults
-----------------------------------------------
SV.Services =
{
  --Anything that applies to services should be put in here, or assigned to this or a subtable of this in the service's definition script
}

-----------------------------------------------
-- General Defaults
-----------------------------------------------
SV.General =
{
  Rescue = nil,
  Starter = MonsterID("missingno", 0, "normal", Gender.Genderless)
  --Anything that applies to more than a single level, and that is too small to make a sub-table for, should be put in here ideally, or a sub-table of this
}

SV.checkpoint = 
  {
    Zone    = 'branchwaywoods', Segment  = -1,
    Map  = 0, Entry  = 1
  }

SV.MissionsEnabled = false

SV.MissionPrereq =
{
  DungeonsCompleted = {}, --Uses a bitmap to determine which sections are complete (
  NumDungeonsCompleted = 0
}

SV.adventure = 
{
  Thief    = false,
  Tutors = { }
}

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

-----------------------------------------------
-- Level Specific Defaults
-----------------------------------------------
SV.shopgreen = {
	{ Index = "food_apple", Amount = 0, Price = 50},
	{ Index = "food_apple_big", Amount = 0, Price = 150},
	{ Index = "food_banana", Amount = 0, Price = 500},
	{ Index = "food_chestnut", Amount = 0, Price = 80},
	{ Index = "berry_leppa", Amount = 0, Price = 80}
}

SV.shopgreenALT = { --Specific for Treasure Town's Kecleon.
	{ Index = "food_apple", Amount = 0, Price = 50},
	{ Index = "food_apple_big", Amount = 0, Price = 150},
	{ Index = "food_banana", Amount = 0, Price = 500},
	{ Index = "food_chestnut", Amount = 0, Price = 80},
	{ Index = "berry_leppa", Amount = 0, Price = 80}
}

SV.shoppurple = {
	{ Index = "orb_escape", Amount = 0, Price = 150}
}

SV.missions =
{
  Missions = { },
  FinishedMissions = { },
}

SV.tutorial =
{
  Progress = 0
}

SV.weather =
{
  allow = false, --Allow Weather Rolling?
  rolled = false, --Has the weather been rolled?
  number = 0, --What weather should be applied to the Hubs?
}

SV.branchwaywoodsentrance =
{
  DungeonFailed = false,
  DungeonComplete = false, --literally used to make sure the Results Screen never appears. Turn to True when you want the results off. Turn False to keep the Results on.
  BossDefeated = false,
  flower_inspect = false,
}

SV.cutscenepath =
{
  DreamDone = false,
}

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

SV.repeatable =
{
  pots = true,
  cameo_times_talked_to_bolt = 0,
  day_finished = false,
  daily_chant = false,
  madilyns_stories_told = 0,
  asked_adam_for_help = 0,
}

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

SV.chapter2=
{
chatot_reminder = false,
}

SV.chapter = --SHOULD Change WHEN CHAPTERS ARE FINISHED, NOT STARTED!
{
number = 0,
}

SV.playerinfo =
{
continent = nil,
town = nil,
job = nil
}

SV.eontestroom =
{
  Starter = { Species="piplup", Form=1, Skin="normal", Gender=1 },
  Song    = "Welcome to the World of Pokémon!.ogg",
}

SV.unlocked_trades = {

}
----------------------------------------------