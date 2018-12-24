
/*
L O B B Y
Adjust your personal settings
*/



/*Section 1: General*/

VD_Debug_Hints_Allowed = true; //for mission making - throws hint at you if something is not right - WIP, currently applicable for VD_SW_SpawnerMrkr.sqf

VD_SpawnMinDist = 700; //the closest any site will spawn to any player

VD_SpawnMaxDist = 8000;//the furhest away from a player any site will spawn

VD_UptimeFix = 2500; // fix time before a site is despawned and respawned

VD_UptimeRnd = 1000; // random time added after fix time has expired until site despawn and respawn. e.g. additional time would be between 0 and 1000 seconds.

VD_DeletionSaveZone = 900; //a site will not despawn as long as any player is XYZ meters close

/*Section 1.1: Random Player Loadouts*/
//Random Player Equipment
VD_AllowRandomPlayerLoadout = true; // randomly equips every player using VD_Player_Equipper form VD_Functions.sqf. at mission start: TRUE = activated, false = not activated
VD_AllowRandomPlayerLoadoutRespawn = true; // randomly equips every player using VD_Player_Equipper form VD_Functions.sqf. at respawn: TRUE = activated, false = not activated


VD_PLMapChance = 100;
VD_PLRadioChance = 100;
VD_PLBinocularChance = 100;

VD_PLVestChance = 100;
VD_PLBackpackChance = 100;
VD_PLHeadgearChance = 100;

VD_PLRifleChance = 100;
VD_PLRifleAmmo = 1;
VD_PLRifleAmmoAdd= 3; // as a fix amount of additional mags or a random amount up to 3; (random 3)

VD_PLRifleMuzzleChance = 100;
VD_PLRifleOpticChance = 100;
VD_PLRiflePointerChance = 100;
VD_PLRifleUnderbarrelChance = 100;

VD_PLPistolChance = 100;

VD_PLPistolAmmo = 1;
VD_PLPistolAmmoAdd = 3; // as a fix amount of additional mags or a random amount up to 3; (random 3)

VD_PLPistolMuzzleChance = 100;
VD_PLPistolOpticChance = 100;
VD_PLPistolPointerChance = 100;

VD_PLItemChance = 100;
VD_PLItemsCount = 3;

VD_PLCustomItems = [];
VD_PLCustomItemChance = 100;
VD_PLCustomItemsCount = 1; // as a fix amount to spawn or a random amount up to 3 if you enter it like this: (random 3)

VD_PLMoneyChance = 100;
VD_PLMoneyAmount = 15; // as a fix amount of money to spawn or a random amount up to 15 if you enter it like this: (random 15)

VD_PLGrenadeChance = 100;
VD_PLGrenadeAmount = 1;// as a fix amount to spawn or a random amount up to 3 if you enter it like this: (random 3)


VD_PLExplosiveChance = 100;
VD_PLExplosiveAmount = 1;//
/*Section 1.2: Black list areas (IMPORTANT)*/
//exclude areas from automated placement of sites on land (Bandit Camp, Crashsites, Hideouts, Animalspawner, feral dog spawner, horse spawner)
//Place markers area markers F6/Markers -> Areas: both shapes are ok. Cover the area on LAND where you want no Bandit Camp, Crashsites, Hideouts, Animalspawner, feral dog spawner, horse spawner to spawn and use one of the below marker names (!!)
//for maps like chernarus, where a lot of land is empty, cover that land in order to avoid that sites spawn there, see picture:
VD_Land_Blacklist_Area = [];
//... = []; empty brackets means that you want to place NO marker
//
//exclude areas from automated placement of Ship Wrecks at shores. not that even the smalles lake inland is considered a valid place for the shipwreck placement, hence you need to cover that area with below blacklist markers!
//Place markers area markers F6/Markers -> Areas: both shapes are ok. Cover the area on LAND where you want no Bandit Camp, Crashsites, Hideouts to spawn and use one of the below marker names (!!)
VD_Coast_Blacklist_Area = [];
//... = []; empty brackets means that you want to place NO marker
//
// DO NOT FORGET TO TURN DOWN THE MARKERS "ALPHA" TO 0% - else the markers are visible on the map. Also you best place these markers LAST when making a mission, else they might disturb you when navigating on a map.
//IF YOU PLACE LESS MARKERS THEN THE 10 ABOVE, that is a PROBLEM since last patch - only list markers here that are also placed on the map!!!!. If you place more than the  markers listed here, or name them wrong - the sites will spawn in the unwanted areas anyway!
// leave empty, if you need no blacklist areas

/*Section 1.3: AI*/


VD_AIMapChance = 100;
VD_AIRadioChance = 100;
VD_AIBinocularChance = 100;

VD_AIVestChance = 100;
VD_AIBackpackChance = 100;
VD_AIHeadgearChance = 100;

VD_AIRifleChance = 0;
VD_AIRifleAmmo = 1;
VD_AIRifleAmmoAdd= 3; // as a fix amount of additional mags or a random amount up to 3; (random 3)

VD_AIRifleMuzzleChance = 100;
VD_AIRifleOpticChance = 100;
VD_AIRiflePointerChance = 100;
VD_AIRifleUnderbarrelChance = 100;

VD_AIPistolChance = 100;

VD_AIPistolAmmo = 1;
VD_AIPistolAmmoAdd = 3; // as a fix amount of additional mags or a random amount up to 3; (random 3)

VD_AIPistolMuzzleChance = 100;
VD_AIPistolOpticChance = 100;
VD_AIPistolPointerChance = 100;

VD_AIItemChance = 100;
VD_AIItemsCount = 3;

VD_AICustomItems = [];
VD_AICustomItemChance = 100;
VD_AICustomItemsCount = 1; // as a fix amount to spawn or a random amount up to 3 if you enter it like this: (random 3)

VD_AIMoneyChance = 100;
VD_AIMoneyAmount = 15; // as a fix amount of money to spawn or a random amount up to 15 if you enter it like this: (random 15)

VD_AIGrenadeChance = 100;
VD_AIGrenadeAmount = 1;// as a fix amount to spawn or a random amount up to 3 if you enter it like this: (random 3)


VD_AIExplosiveChance = 100;
VD_AIExplosiveAmount = 1;// as a fix amount to spawn or a random amount up to 3 if you enter it like this: (random 3)



/*Section 2: Site specific settings*/



/*Section 2.1: Hideouts*/
VD_HO_AmountOfSpawns = 8; //amount of sites to spawn, set to 0 to disable
VD_HO_Spawn_Array = [];
//VD_HO_Spawn_Array = ["VD_HO_Spawn_1", "VD_HO_Spawn_2", "VD_HO_Spawn_3", "VD_HO_Spawn_4", "VD_HO_Spawn_5", "VD_HO_Spawn_6", "VD_HO_Spawn_7", "VD_HO_Spawn_8", "VD_HO_Spawn_9","VD_HO_Spawn_10","VD_HO_Spawn_11","VD_HO_Spawn_12","VD_HO_Spawn_13","VD_HO_Spawn_14","VD_HO_Spawn_15","VD_HO_Spawn_16","VD_HO_Spawn_17","VD_HO_Spawn_18","VD_HO_Spawn_19","VD_HO_Spawn_20"];
VD_HO_DistanceCheck = 700;
VD_JBDOG_PatrolDogChanceHO = 0;
VD_JBDOG_GuardDogChanceHO = 40;
VD_IEDAmountHO = 3;
VD_IEDChanceHO = 50;

/*Section 2.2: Crashsites*/
VD_CS_AmountOfSpawns = 8; //amount of sites to spawn, set to 0 to disable
VD_CS_spawnDistToOtherCS = 1000; // set mimimum distance in meters required between sites
//VD_CS_Spawn_Array = ["VD_CS_Spawn_1", "VD_CS_Spawn_2", "VD_CS_Spawn_3", "VD_CS_Spawn_4", "VD_CS_Spawn_5", "VD_CS_Spawn_6", "VD_CS_Spawn_7", "VD_CS_Spawn_8", "VD_CS_Spawn_9","VD_CS_Spawn_10","VD_CS_Spawn_11","VD_CS_Spawn_12","VD_CS_Spawn_13","VD_CS_Spawn_14","VD_CS_Spawn_15","VD_CS_Spawn_16","VD_CS_Spawn_17","VD_CS_Spawn_18","VD_CS_Spawn_19","VD_CS_Spawn_20"];
VD_CS_Spawn_Array = [];


/*Section 2.3: Basebuilding EDN Fortification*/
//removed, to be preplaced

/* Section2.4: Bandit Camp:*/
//VD_BC_MrkrArray = ["VD_BC_Mrkr_1","VD_BC_Mrkr_2","VD_BC_Mrkr_3","VD_BC_Mrkr_4","VD_BC_Mrkr_5","VD_BC_Mrkr_6","VD_BC_Mrkr_7","VD_BC_Mrkr_8","VD_BC_Mrkr_9","VD_BC_Mrkr_10","VD_BC_Mrkr_11"];
VD_BC_MrkrArray = [];
VD_BC_CampSpawnAmountRnd = 8; //amount of sites to spawn at random positions (no markers), set to 0 to disable
VD_BC_CampSpawnAmountMrkr = 0; //amount of sites to spawn at preplaced markers, set to 0 to disable
VD_BC_DistanceCheck = 800;
VD_IEDAmountBC = 5;
VD_IEDChanceBC = 50;
VD_JBDOG_PatrolDogChanceBC = 40;
VD_JBDOG_GuardDogChanceBC = 0;

/*Section2.5: Ship Wrecks*/
/*note that SW spawn even in the smallest puddle, not only on the coast where it makes sense, depending on your map, you might want to use markers only instead*/
/*place ALL markers below at the coast of your map, add more markers in this array (following the format) if you want to spawn more wrecks - amount of markers should always be double of spawned wrecks! The script finds suitable places near the marker, hence marker placement must not be 100% exact*/

//VD_SW_MrkrArray = ["VD_SW_Mrkr_1","VD_SW_Mrkr_2","VD_SW_Mrkr_3","VD_SW_Mrkr_4","VD_SW_Mrkr_5","VD_SW_Mrkr_6","VD_SW_Mrkr_7","VD_SW_Mrkr_8","VD_SW_Mrkr_9","VD_SW_Mrkr_10","VD_SW_Mrkr_11","VD_SW_Mrkr_12","VD_SW_Mrkr_13","VD_SW_Mrkr_14","VD_SW_Mrkr_15","VD_SW_Mrkr_16","VD_SW_Mrkr_17","VD_SW_Mrkr_18","VD_SW_Mrkr_19","VD_SW_Mrkr_20"];
VD_SW_MrkrArray = [];
VD_SW_SpawnAmountRnd = 0;// set number: amount of Shipwrecks that should spawn randomly
VD_SW_MaxDistance = 20000; //
VD_SW_DistanceCheck = 1000; //minumum distances between each wreck (if set too high, wrecks might not be able to spawn)
VD_SW_SpawnAmountMrkr = 0;// set number: amount of Shipwrecks that should spawn at placed markers - I recommend to always place double amount of markers as desired shipwrecks, to ensure changing spawnpositions at respawn. Hence, if you have more than or nearly 20 wrecks spawning, you should add additional markers to the array "VD_SW_MrkrArray" above and place the additional markers in your map

/*Section 2.6: Trader Camp*/
VD_TC_SpawnOnMarker = false; //set to false if TC should spawn on a random position without marker placement, set to TRUE to spawn on markers. REQUIRES marker placement!
VD_TC_DistanceCheck = 700; // minimum distance to any other camps, specially BC and Hidouts, required for automated TC placmenet without markers

//add or remove markers here (one marker = TC refreshes at the same place). multiple Markers will make the site change position from time to time
//VD_TC_MarkerArray = ["VD_TC_Mrkr_1","VD_TC_Mrkr_2","VD_TC_Mrkr_3","VD_TC_Mrkr_4","VD_TC_Mrkr_5","VD_TC_Mrkr_6","VD_TC_Mrkr_7"];
VD_TC_MarkerArray = [];

/*Section 2.7: Huntable Animals*/
VD_AS_AmountOfSpawns = 4;

/*Section 2.8: Rideable Horses*/
/*Requirements:
Scripts: VD_DBO_Horse_Spawner.sqf
Mods: DBO_Horses on steam
*/
VD_DBO_Horses_AmountOfSpawns = 0; //amount of horses to spawn, set to 0 to disable

/*Section 2.9: Feral dog pack by JBDOG*/
VD_AllowJBDOG = false; // enable jbdog scripts
VD_JBDOG_AmountOfSpawns = 1;
VD_JBDOG_AggroDist = 300; // range from which dogs can aggro and start chasing you could also be 50+ random 300 or so

/*Section 2.20: Helicopter Spawns*/
VD_Heli_AmountOfSpawns = 4;
//VD_Helicopters = ["I_Heli_light_03_unarmed_F","B_Heli_Transport_01_F","B_Heli_Attack_01_dynamicLoadout_F","B_Heli_Light_01_F","B_Heli_Light_01_dynamicLoadout_F","B_Heli_Transport_03_F"];
VD_Helicopters = [];

/*Section 2.21: Boat Spawns*/
VD_Boat_AmountOfSpawns = 0;
//VD_Boats = ["I_Boat_Armed_01_minigun_F","C_Boat_Civil_01_F","C_Scooter_Transport_01_F","C_Boat_Transport_02_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_police_F"];
VD_Boats = [];

/*Section 2.22: Plane Spawns*/
VD_Plane_AmountOfSpawns = 0;
VD_Planes = ["C_Plane_Civil_01_F"];
//VD_PlaneMarkers = ["VD_PlaneMrkr_1","VD_PlaneMrkr_2","VD_PlaneMrkr_3","VD_PlaneMrkr_4","VD_PlaneMrkr_5","VD_PlaneMrkr_6","VD_PlaneMrkr_7","VD_PlaneMrkr_8","VD_PlaneMrkr_9","VD_PlaneMrkr_10"];
VD_PlaneMarkers = [];

/*Section 3: blacklist weapons or items or equipment from the loot arrays, enter as = ["classnameofitem","lastclassname"]; MIND THE COMMA!
Or exclude defined groups of items, e.g. Vanilla items or Mod specific items*/

//Remove Vanilla Weapons:
VD_NoVanillaPistols = true; //set to true to not spawn vanilla weapons
VD_NoVanillaRifles = true; //set to true to not spawn vanilla weapons
VD_NoVanillaLaunchers = true; //set to true to not spawn vanilla weapons

VD_NoVanillaVests = true;
VD_NoVanillaBackpacks = true;
VD_NoVanillaHeadgears = true;
VD_NoVanillaGoggles = true;
VD_NoVanillaUniforms = true;

//remove Ravaged Vanilla weaponState
VD_NoRavagedRifles = false; //set to true to not spawn ravaged vanilla equipment (sorry EO...;)
VD_NoRavageVests = false;
VD_NoRavageBackpacks = false;
VD_NoRavageHeadgears = false;
VD_NoRavageGoggles = false;
VD_NoRavageUniforms = false;

//IFA3
VD_NoLIBRifles = false;
VD_NoLIBPistols = false;
VD_NoLIBLaunchers = false;

VD_NoLIBGoggles = false;
VD_NoLIBUniforms = false;
VD_NoLIBBackpacks = false;
VD_NoLIBHeadgears = false;
VD_NoLIBVests = false;

//CUP
VD_NoCUPLaunchers = false;
VD_NoCUPRifles = false;
VD_NoCUPPistols = false;

VD_NoCUPVests = false;
VD_NoCUPBackpacks = false;
VD_NoCUPHeadgears = false;
VD_NoCUPGoggles = false;
VD_NoCUPUniforms = false;


//weaponS
VD_WeaponArrayRiflesBlacklist = [];
VD_WeaponArrayPistolsBlacklist = ["hgun_Pistol_Signal_F","CHR_FlashLight","CHR_FlashLight_Night"];
VD_WeaponArrayLaunchersBlacklist = [];

//Equipment
VD_EquipmentVestsBlacklist = [];
VD_EquipmentUniformsBlacklist = [];
VD_EquipmentBackpacksBlacklist = ["Horse_bergen","Horse_bergenru","horse_tack"];
VD_EquipmentHeadgearsBlacklist = [];
VD_EquipmentGogglesBlacklist = [];

//weapon attachments
VD_EquipmentMuzzlesBlacklist = [];
VD_EquipmentOpticsBlacklist = [];
VD_EquipmentFlashlightsBlacklist = [];
VD_EquipmentBipodsBlacklist = [];

/*Section 4: manually add classnames to Arrays*/
//Weapons
VD_WeaponArrayRiflesAdditional = [];
VD_WeaponArrayPistolsAdditional = [];
VD_WeaponArrayLaunchersAdditional = [];

//Equipment
VD_EquipmentVestsAdditional = [];
VD_EquipmentUniformsAdditional = [];
VD_EquipmentBackpacksAdditional = [];
VD_EquipmentHeadgearsAdditional = [];
VD_EquipmentGogglesAdditional = [];
//weapon attachments
VD_EquipmentMuzzlesAdditional = [];
VD_EquipmentOpticsAdditional = [];
VD_EquipmentFlashlightsAdditional = [];
VD_EquipmentBipodsAdditional = [];

/*Section 5: overwrite Arrays*/
//Weapons
VD_WeaponArrayRiflesReplace = [];
VD_WeaponArrayPistolsReplace = [];
VD_WeaponArrayLaunchersReplace = [];

//Equipment
VD_EquipmentVestsReplace = [];
VD_EquipmentUniformsReplace = [];
VD_EquipmentBackpacksReplace = [];
VD_EquipmentHeadgearsReplace = [];
VD_EquipmentGogglesReplace = [];
//weapon attachments
VD_EquipmentMuzzlesReplace = [];
VD_EquipmentOpticsReplace = [];
VD_EquipmentFlashlightsReplace = [];
VD_EquipmentBipodsReplace = [];


execVM "VD_Script_Pack\VD_Arrays.sqf";

/*Dynamic Simulation: FPS saver, AI units will only become active if player is XYZ meters close or within view distance (scoped and non scoped)*/
enableDynamicSimulationSystem true; // dont change, FPS saver
DynSimDistManual = false; // set true if you want to define the distance from AI to player for dynamic simulation enabling yourself below
                          // set false if you want AI to become active in view distance, considers if you are looking through a scope and if there is fog)
DynSimDistManualRange = 2000; // if DynSimDistManual = true, this number is the distance to the player where the AI becomes active (in meters)

/*dont change*/
if (DynSimDistManual) then {"Group" setDynamicSimulationDistance DynSimDistManualRange;};

if (!DynSimDistManual) then {while {true} do {
		if (cameraView isEqualTo "GUNNER") then {
	            "Group" setDynamicSimulationDistance (viewDistance - (viewDistance * fog));
                     // Scoped
		} else {
		    "Group" setDynamicSimulationDistance ((viewDistance * 0.8) - (viewDistance * fog));
                    // Not scoped
		};
		uiSleep 0.25;
	};};

	if (DynSimDistManual) then {"Prop" setDynamicSimulationDistance DynSimDistManualRange;};

	if (!DynSimDistManual) then {while {true} do {
			if (cameraView isEqualTo "GUNNER") then {
		            "Prop" setDynamicSimulationDistance (viewDistance - (viewDistance * fog));
	                     // Scoped
			} else {
			    "Prop" setDynamicSimulationDistance ((viewDistance * 0.8) - (viewDistance * fog));
	                    // Not scoped
			};
			uiSleep 0.25;
		};};
