
--NOTE: This script serves as a basis for unique dialogue on every possible option the player has for their character.
--This is typically the most impractical solution to have many different answers on one simple question.
--The reason is to make each choice feel unique to the player, rewarding them with different dialogue on
--any replays of the game they may have, and this should be referenced some times, at-least once per chapter.

--You may 'copy' off this script, but the template script assumes Project EoN's choices, and you might not need this complexity.
--I don't recommend copying it, but you do you. I can't really stop you.

--If you have any complaints about how I even made the function work at all (including visually), please leave a Dislike. I don't really care.

--Reference: 								CONTINENT > TOWN > JOB
--If the Player Character served in a situation where they cannot have any other job, like the Adventure Squad, then the Job is NIL.
--If you need to reference their special attributes from that particular 'town', read the town first, then the job.

--While the SVs contain Strings, YOU SHOULD NOT USE THEM AS TEXT.  They are created like this in order to make
--script-writing easier, as EoN references these places as 'Regions', not Continents, and it makes no sense referencing a game's name as a region. That's just stupid.

function Template() --USE ACTORS IN SCENE VIA LOCAL-ING!

if SV.playerinfo.continent == 'RescueTeam' or 'Explorers' or 'GatesToInf' or 'Super' or 'Undefined' then --Check if the player's choice is *any* of these regions. Used to check for 'LostSoul' things first, but this is optional. Probably.
	if SV.playerinfo.town ~= 'LostSoul' then

		--Activate some sort of script if the Player's Home Location is known in some way. Not Typically necessary, and you may throw away this 'if' statement. Just don't forget the 'LostSoul' check.

elseif SV.playerinfo.town == 'LostSoul' then
		
		--Activate a script that ONLY plays when the player's Home Location is unknown. You may change the order.
		
end --End the entire script if the PC is a Lost Soul.

end

if SV.playerinfo.continent == 'RescueTeam' then

	--The player character's Continent is PMD1's Continent.

	if SV.playerinfo.town == 'PokemonSquare' then
	
		--The player character's Town is Pokémon Square.
	
		if SV.playerinfo.job == 'Study' then
		
			--The player character studied at Pokémon Square.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character has been exploring around Pokémon Square.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character delivered mail and such for Pokémon Square.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character helped around Pokémon Square.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character enjoyed their life in Pokémon Square.
			
			else
			
			--Typical Error message. Either you cheated through, or the upgrade failed (the first part is more likely, but the second one can also happen.)
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end

	elseif SV.playerinfo.town == 'FriendZone' then
	
	--The player character served in the Legendary Heroes' team. As a result, no job is needed since that's predefined.

	elseif SV.playerinfo.town == 'Unsure' then
	
	--If the player character can't simply recall, or if it's not a real location that would exist in Rescue Team.
	
	if SV.playerinfo.job == 'Study' then
		
		--The player character studied somewhere around the Origin Region.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
		--The player character explored dungeons around the Origin Region somewhere.
			
			elseif SV.playerinfo.job == 'Courier' then
			
		--The player character delivered mail somewhere around the Origin Region.
			
			elseif SV.playerinfo.job == 'Helper' then
			
		--The player character helped around their undefined town in the Origin Region.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
		--The player character simply enjoyed their life at their hometown, located somewhere in the Origin Region.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
	
else

end

elseif SV.playerinfo.continent == 'Explorers' then

	--The player character's Continent is the Explorers' Region from PMD2.

	if SV.playerinfo.town == 'TreasureTown' then
	
		--The player character's Town is Treasure Town.
	
			if SV.playerinfo.job == 'Study' then
		
			--The player character studied at a school (somehow) in Treasure Town.
			
			elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character explored the heaps of dungeons around Treasure Town.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character delivered mail and packages around Treasure Town.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character helped around Treasure Town.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character simply enjoyed their life in Treasure Town.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
			end
			
		elseif SV.playerinfo.town == 'AdventureSquad' then
			
		--The player character was teamed up with the Adventure Squad. As a result, the job they had is predefined.

	elseif SV.playerinfo.town == 'ShayminVillage' then
	
		--The player character managed to somehow live among the Shaymins in their village.
	
		if SV.playerinfo.job == 'Study' then
		
			--The player character took up education in the Shaymin Village.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character explored to the peak and back in Shaymin Village.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character delivered mail around the small Shaymin Village.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character helped around Shaymin Village, usually taking visitors up the mountain.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character sat around Shaymin Village. How spoiled.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
	
	elseif SV.playerinfo.town == 'Unsure' then
	
		--The player character's town is undefined, meaning it might not even exist in any games.
	
		if SV.playerinfo.job == 'Study' then
		
			--The player character studied somewhere around the Sky Region.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character explored dungeons around their unknown town in the Sky Region.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character delivered mail in their unknown town that's located in the Sky Region.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character helped their unmarked town in the Sky Region.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character simply enjoyed life at their unnamed town in the Sky Region.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end

end

elseif SV.playerinfo.continent == 'GatesToInf' then

	--The player character lives in the Gates to Infinity Continent, or PMD3.

	if SV.playerinfo.town == 'PostTown' then
		
		--The player character lives in Post Town.
		
		if SV.playerinfo.job == 'Study' then
		
			--The player character took every bit of education they could while living in Post Town.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character went out to explore the interesting dungeons around Post Town.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character delivered mail around Post Town, and it's probable affiliate.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character helped around the struggling Post Town.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character lived their boring life in Post Town.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
		
		elseif SV.playerinfo.town == 'Unsure' then
		
	--The player character lives somewhere around the Magna Region.
	--The only reason the lovely Pokémon Paradise isn't here is because it has not happened yet in this timeline.
		
			if SV.playerinfo.job == 'Study' then
		
			--The player character studied somewhere in the Magna Region.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character roamed the dungeons in the Magna Region.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character served to deliver packages in the Magna Region's isolated towns.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character picked up the slack in their undefined town in the lonely Magna Region.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character easily enjoyed their home life in the somewhat-empty Magna Region.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
		
	end
	
	elseif SV.playerinfo.continent == 'Super' then
	
	--The player character was raised in Super's continent.
	
			if SV.playerinfo.town == 'SereneVillage' then
			
		--The player character's town was the Serene Village.	
		
				if SV.playerinfo.job == 'Study' then
		
			--The player character was schooled with Serene Village's own school.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character, despite the warnings of how dangerous dungeoneering is, explored the dungeons around.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character delivered all sorts of mail for Serene Village's residents.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character helped around Serene Village's minor problems.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character had a relatively simple life in Serene Village.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
		
	elseif SV.playerinfo.town == 'LivelyTown' then
	
	--The player character's home was located in the busy town for the lively... you know, Lively Town.
	
			if SV.playerinfo.job == 'Study' then
		
			--The player character earned their education smarts at Lively Town.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character prospered with Dungeoneering at Lively Town.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character was extra busy with delivering mail around Lively Town.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character was a good Pokémon for Lively Town's residents.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--Despite all the social calls, the player character simply enjoyed their time in Lively Town.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
		
	elseif SV.playerinfo.town == 'Unsure' then
	
	--The player character's town is not defined, so chances are, it's not something I can write about.
	
		if SV.playerinfo.job == 'Study' then
		
			--The player character earned prospect in their Prospect Region Education.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character explored around the Prospect Region's dungeons.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character delivered mail around the Prospect Region.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--Sometimes, even unmarked towns have trouble, and the player character helped make sure they had none.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character prospected in lonliness.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
	
	end
	
	elseif SV.playerinfo.continent == 'Undefined' then
	
	--If a location is not defined, like Super's continental towns, then they go here.
	--NOTE: Cameo Towns are NOT CANON in EoN. They don't really exist unless the player chooses to do so.
	--Cameo Towns are to be labeled as 'rumored' or in a sort of readable text, like a newspaper or flyer. If a Cameo Town has an interesting gimmick, mention it.
	
			if SV.playerinfo.town == 'BaseCamp' then
			
		--CAMEO: The player character based at Guildmaster Island.
			
				if SV.playerinfo.job == 'Study' then
		
			--The player character studied at the (cut) school in Base Camp.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character used the island's dungeons to prepare themselves for Dungeoneering.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character delivered mail around Guildmaster Island.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character helped around Base Camp with the tourists, and such.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character had a summer's vacation.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
		
		elseif SV.playerinfo.town == 'MetanoTown' then
		
			--CAMEO: The player character's old life was in Metano Town.
		
			if SV.playerinfo.job == 'Study' then
		
			--Simply put, the player character based their education in the Halcyon-embedded town.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character braved themselves for dungeoneering around Metano Town.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character was in charge of courier service in Metano Town.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character helped around Metano Town.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--Halcyon, the player character was in. (idk what Halcyon means here, because whatever I said before was wrong).
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
		
		elseif SV.playerinfo.town == 'BaramTown' then
		
			--The player character aired from the windy town of Baram Town.
		
			if SV.playerinfo.job == 'Study' then --boo hoo if all of this isn't aligned correctly. If it works, then who cares. (It *shouldn't* be the player, for they don't need to read any of this. They are highly-trained professionals)
		
			--The player character soared through their education in Barem Town.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character made their debute exploring around Baram Town's dungeons.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character lent a wing/paw/claw/whatever to Barem Town's mail service.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character braved the windiness of Barem Town, and helped out.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character was not bothered by the wind, and kept vibing in Barem Town.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end

		elseif SV.playerinfo.town == 'CapimTown' then
		
		--The player character kept themselves lush with flora in Capim Town.
		
					if SV.playerinfo.job == 'Study' then
		
			--The density of the forests did not interfere with the player character's education.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character used the dense forestry of Capim Town as inspiration for exploring.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character handed out mail in Capim Town.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character made sure the foilage did not ruin anyone's day.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character was basically tarzan, minding their own business in Capim Town.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
		
		elseif SV.playerinfo.town == 'NoeTown' then
		
			--The player character floated from Noe Town.
		
					if SV.playerinfo.job == 'Study' then
		
			--Sunny or not, that didn't discourage the player character from getting their education in Noe Town.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character took the oppertunities to see the dungeons around Noe Town.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--Rain or shine, the player character delivered the mail around Noe Town.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character made sure the quaint town had no pesky bad days.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--The player character just did what they did best in Noe Town.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
		
		elseif SV.playerinfo.town == 'RamleTown' then
		
		--The player character served their early beginnings in Ramle Town.
		
					if SV.playerinfo.job == 'Study' then
		
			--The player character just coped with the sand, and studied on.
			
		elseif SV.playerinfo.job == 'Prepared' then
		
			--The player character explored the desert-y lands of Ramle Town's dungeons.
			
			elseif SV.playerinfo.job == 'Courier' then
			
			--The player character braved the sands of time to deliver mail.
			
			elseif SV.playerinfo.job == 'Helper' then
			
			--The player character helped their poor town out.
			
			elseif SV.playerinfo.job == 'Vibed' then
			
			--Somehow, the player character just dealt with the sandy town.
			
			else
			
			UI:ResetSpeaker(false)
			UI:WaitShowDialogue("First off, [pause=10]you're a massive cheater and this is unacceptable.")
			UI:WaitShowDialogue("Second off, [pause=10]power the game off and try the cutscene again.")
		
		end
		
		elseif SV.playerinfo.town == 'Nomad' then
		
			--The player character simply wandered around the world.
		
		--If you've removed the 'if' statement at the start of the script to check if the player character IS/IS NOT a LOST SOUL, add an 'elseif' statement for that here.
		
		end
		
end
end