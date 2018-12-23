if (!isserver) exitWith {};
call compile preprocessFileLineNumbers "JBOY_Dog\JBOY_DogInit.sqf";
  //______________add all spawned items including Ravage to ZEUS
    [] spawn {while {true} do {{
    _x addCuratorEditableObjects [allUnits,true];
    _x addCuratorEditableObjects [vehicles,true];
    _x addCuratorEditableObjects [allMissionObjects "All",true];
   } forEach allCurators;sleep 1;};};

  addMissionEventHandler ["EntityKilled",
   {
   	params ["_killed", "_killer"];
   	if (_killed isKindOf "CAManBase" && 10 >= (random 100))
   	 then	{
   		_antivirus = "Land_Antibiotic_F" createVehicle (getpos _killed);
   		_antivirus addAction
   		[
   		    "Pick up Injector",
   		    {
   		        params ["_target", "_caller", "_actionId", "_arguments"];
   		        _target removeaction _actionID;
   		        deletevehicle _target;
   		        _countpills = _caller getVariable ["VanD_CurePill", false];_caller setVariable ["VanD_CurePill", _countpills +1];
   		        _amount = _caller getVariable ["VanD_CurePill", false];
   		systemChat format ["+1 Anti Virus Injector"];
   		    },[], 1.5, true, true, "", "true", 4, false, "", ""];
   };
   }];

execVM "VD_Script_Pack\VD_BC_Composition.sqf";
if (VD_TC_SpawnOnMarker) then {execVM "VD_Script_Pack\VD_TCSpawner.sqf"} else {execVM "VD_Script_Pack\VD_TCSpawnerRnd.sqf"};

waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};

//execVM "VD_Script_Pack\VD_TaskSystem\VD_Task_System.sqf";
if (VD_Plane_AmountOfSpawns >= 1) then {for "_i" from 1 to VD_Plane_AmountOfSpawns do {execvm "VD_Script_Pack\VD_Plane_Spawner.sqf"; sleep 1;};};

if (VD_Boat_AmountOfSpawns >= 1) then {for "_i" from 1 to VD_Boat_AmountOfSpawns do {execvm "VD_Script_Pack\VD_Boat_Spawner.sqf"; sleep 1;};};

if (VD_Heli_AmountOfSpawns >= 1) then {for "_i" from 1 to VD_Heli_AmountOfSpawns do {execvm "VD_Script_Pack\VD_Heli_Spawner.sqf"; sleep 1;};};

if (VD_HO_AmountOfSpawns >= 1) then {for "_i" from 1 to VD_HO_AmountOfSpawns do {execvm "VD_Script_Pack\VD_HO_Spawner.sqf"; sleep 1;};};

if (VD_DBO_Horses_AmountOfSpawns >= 1) then {for "_i" from 1 to VD_DBO_Horses_AmountOfSpawns do {execVM "VD_Script_Pack\VD_HorseSpawner.sqf";sleep 1;};};

if (VD_AS_AmountOfSpawns >= 1) then {for "_i" from 1 to VD_AS_AmountOfSpawns do {execvm "VD_Script_Pack\VD_AnimalSpawner.sqf";};};

if (VD_JBDOG_AmountOfSpawns >= 1) then {call compile preprocessFileLineNumbers "JBOY_Dog\JBOY_DogInit.sqf"; sleep 2;for "_i" from 1 to VD_JBDOG_AmountOfSpawns do {execvm "VD_Script_Pack\VD_JBDOG_FeraldogSpawn.sqf";};};

if (VD_CS_AmountOfSpawns >= 1) then {for "_i" from 1 to VD_CS_AmountOfSpawns do {execvm "VD_Script_Pack\VD_CS_Spawner.sqf"; sleep 1;};};


if (VD_SW_SpawnAmountMrkr >= 1) then {for "_i" from 1 to VD_SW_SpawnAmountMrkr do {execvm "VD_Script_Pack\VD_SW_SpawnerMrkr.sqf"; sleep 1;};};

if (VD_SW_SpawnAmountRnd >= 1) then {for "_i" from 1 to VD_SW_SpawnAmountRnd do {execvm "VD_Script_Pack\VD_SW_Spawner.sqf"; sleep 1;};};


if (VD_BC_CampSpawnAmountMrkr >= 1) then {for "_i" from 1 to VD_BC_CampSpawnAmountMrkr do {execVM "VD_Script_Pack\VD_BC_SpawnerMrkr.sqf";sleep 1;};};

if (VD_BC_CampSpawnAmountRnd >= 1) then {for "_i" from 1 to VD_BC_CampSpawnAmountRnd do {execVM "VD_Script_Pack\VD_BC_Spawner.sqf"; sleep 1;};};
