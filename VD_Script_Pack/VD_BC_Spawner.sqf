/*
Vandeansons Dynamic Spawner Scripts
Bandit Camp Spawner
V2 - 04.11.2018
Settings: Check VD_Settings.sqf for settings!
*/
//

if (!isServer) exitwith {};



VD_IEDSpawn ={

_VD_BC_Spawn = _this select 0;

//  iedMkr=[_VD_BC_IED_Spawn];	//List of markers to spawn IEDs in
//  iedNum=5;								//Number of IEDs per marker, defined in iedMkr	[Default: 5]



  //!!DO NOT EDIT BELOW!!


  private["_ieds","_trig"];

  _ieds=[];
//  _iedArea=getpos _VD_BC_Spawn;
//  _iedRoad=(getMarkerPos _x)nearRoads _iedArea;



//  	for "_i" from 1 to iedNum do{
  //	if(count _ieds==iedNum*4)exitWith{};

  	_iedR= [_VD_BC_Spawn, 40, 70, 3, 0, 0.4, 0] call BIS_fnc_findSafePos;

  	_ied=selectRandom iedList;
    _junk=selectRandom iedJunk;

  	_ied=createMine[_ied,_iedR,[],8];
  //  _ied setPosATL(_iedR select 2+1);_ied setDir(random 359);

  	if(!iedDmg)then{_ied allowDamage false;};

  	if(round(random 2)==1)then{_iedJunk=createVehicle[_junk,getPosATL _ied,[],0,""];_iedJunk setPosATL(getPosATL _iedJunk select 2+1);_iedJunk enableSimulationGlobal false;};
	//_jnkR=selectRandom _iedRoad;
    	_jnkR= [_VD_BC_Spawn, 40, 70, 0, 0, 0.4, 0] call BIS_fnc_findSafePos;
  _junk=createVehicle[_junk,_jnkR,[],8,""];
    //_junk setPosATL(getPosATL _junk select 2+1);
  	_junk enableSimulationGlobal false;
  	_trig=createTrigger["EmptyDetector",getPosATL _ied];
  	_trig setTriggerArea[10,10,0,FALSE,10];
  	_trig setTriggerActivation["ANY","PRESENT",false];
  	_trig setTriggerTimeout[1,1,1,true];
  	if(isMultiplayer)then{
  	_trig setTriggerStatements[
  		"{vehicle _x in thisList && speed vehicle _x>4}count playableUnits>0",
  		"{if((typeOf _x)in iedAmmo)then{[_x]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",
  		"deleteVehicle thisTrigger"];}else{
  	_trig setTriggerStatements[
  		"{vehicle _x in thisList && isPlayer vehicle _x && speed vehicle _x>4}count allUnits>0",
  		"{if((typeOf _x)in iedAmmo)then{[_x]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",
  		"deleteVehicle thisTrigger"];};

  	_ieds pushBack _ied;
  /*	if(Dbug)then{
  		iedMkrs=[];
  		_iedPos=getPosWorld _ied;
  		_mkrID=format["m %1",_iedPos];
  		_mkr=createMarker[_mkrID,getPosWorld _ied];
  		_mkr setMarkerShape"ICON";_mkr setMarkerType"mil_dot";_mkr setMarkerBrush"Solid";_mkr setMarkerAlpha 1;_mkr setMarkerColor"ColorEast";
  		iedMkrs pushBack _mkr;};*/
  	//};
  //}forEach iedMkr;
  sleep 5;
  {CIVILIAN revealMine _x;EAST revealMine _x;}forEach allMines;


};





//////////////////////
_VD_BC_Check = {

waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};

_allplayer = (allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F";
_player = selectRandom _allplayer;



_VD_BC_Spawn = [getPosATL _player, VD_SpawnMinDist, VD_SpawnMaxDist, 0, 0, 0.4, 0, VD_Land_Blacklist_Area] call BIS_fnc_findSafePos;

_isFlatEmpty = !(_VD_BC_Spawn isFlatEmpty  [20, -1, 0.2, 20, -1, false] isEqualTo []);

_nearcamps = _VD_BC_Spawn nearObjects ["Campfire_burning_F", VD_BC_DistanceCheck];
_cntfp = count _nearcamps;


if (_isFlatEmpty) then {

  if (_cntfp == 0) then {call _VD_BC_Spawner}

  else {call _VD_BC_Check};

}
 else {call _VD_BC_Check};

};

_VD_BC_Spawner ={
_itemboxes = [];
_VD_BC_Fireplace = "Campfire_burning_F" createVehicle _VD_BC_Spawn;

_composition = selectrandom VD_BC_Comp_Array;

[getpos _VD_BC_Fireplace, 0, call _composition] call BIS_fnc_ObjectsMapper;

_alignpos = getpos _VD_BC_Fireplace;
_objects = _alignpos nearobjects 40;
{_x allowDamage false;_x setVectorUp surfaceNormal position _x;} foreach _objects;

_nearBuildings = _alignpos nearObjects ["CampEast", 40];

_nearBuilding1 = _nearBuildings select 0;
_buildpositions1 = _nearBuilding1 buildingPos -1;
_buildpos1 = _buildpositions1 select 3;
_itemBox2 = "Box_IND_Ammo_F" createVehicle selectRandom _buildpositions1;
_itemBox2 allowDamage false;
_itemboxes append [_itemBox2];
{[_x] call VD_lootCrateT1} foreach [_itembox2];


if (count _nearbuildings >= 2) then {
_nearBuilding2 = _nearBuildings select 1;
_buildpositions2 = _nearBuilding2 buildingPos -1;
_buildpos2 = _buildpositions2 select 3;
_itemBox3 = "Box_IND_Ammo_F" createVehicle _buildpos2;
_itemBox3 allowDamage false;
_itemboxes append [_itemBox3];
{[_x] call VD_lootCrateT1} foreach [_itembox3];

};
sleep 1;

_bandits1 = createGroup east;
_bandits2 = createGroup east;
_bandits3 = createGroup east;
_bandits4 = createGroup east;


{if (3 >= (random 10)) then {"B_G_Survivor_F" createUnit [([getPosATL _VD_BC_Fireplace, 5, 15, 0, 0, 100, 0] call BIS_fnc_findSafePos), _x, "", 1, "private"];};"B_G_Survivor_F" createUnit [([getPosATL _VD_BC_Fireplace, 2, 15, 0, 0, 100, 0] call BIS_fnc_findSafePos), _x, "", 1, "private"];} foreach [_bandits1, _bandits2,_bandits3,_bandits4];

{[_x] call VD_equipper;}forEach units _bandits1;
{[_x] call VD_equipper;}forEach units _bandits2;
{[_x] call VD_equipper;}forEach units _bandits3;
{[_x] call VD_equipper;}forEach units _bandits4;

{[_x,getpos _VD_BC_Fireplace,1] call BIS_fnc_taskPatrol;}foreach [_bandits1, _bandits2];
{[_x, getPos _VD_BC_Fireplace] call BIS_fnc_taskDefend;}foreach [_bandits3, _bandits4];

_bandits1 enableDynamicSimulation true;
_bandits2 enableDynamicSimulation true;
_bandits3 enableDynamicSimulation true;
_bandits4 enableDynamicSimulation true;
{_x enableDynamicSimulation true}foreach _objects;

if (VD_AllowJBDOG && VD_JBDOG_PatrolDogChanceBC >= (random 100)) then {
_SpawnPos = [_VD_BC_Fireplace, 20, 40, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
_Group = createGroup east;
_Unit1 = _Group createUnit ["O_G_Survivor_F", _SpawnPos, [], 1, "NONE"];
{[_x] call VD_equipper} foreach units _Group;
_Group enableDynamicSimulation true;
[_Group,_SpawnPos,5] call BIS_fnc_taskPatrol;


  _dmy= [_Unit1] spawn
      {
          params["_handler"];
          [_handler, speaker _handler] remoteExecCall ["setSpeaker", 0];
          sleep 1;
          _dogtypes = ["Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Alsatian_Black_F","Alsatian_Sandblack_F"];
          _dog = [_handler, selectrandom _dogtypes, (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create;
          _dog setVariable ["vEnemyDetectDistance", 40, true];
          _dmy = [_dog, _handler, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";
          sleep 1;
          _dog setVariable ["vCommand", 'heel', true];
      };};

if (VD_AllowJBDOG && VD_JBDOG_GuardDogChanceBC >= (random 100)) then {
      _SpawnPos = [_VD_BC_Fireplace, 2, 5, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
      _Group = createGroup east;
      _Unit1 = _Group createUnit ["O_G_Survivor_F", _SpawnPos, [], 1, "NONE"];
      {[_x] call VD_equipper} foreach units _Group;
      [_Unit1,selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","LEAN","WATCH","WATCH1","WATCH2"]] call BIS_fnc_ambientAnimCombat;
      _Group enableDynamicSimulation true;

      _dmy= [_Unit1] spawn
            {
                params["_handler"];
                [_handler, speaker _handler] remoteExecCall ["setSpeaker", 0];
                sleep 1;
                  _dogtypes = ["Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Alsatian_Black_F","Alsatian_Sandblack_F"];
                _dog = [_handler, selectrandom _dogtypes, (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create;
                _dog setVariable ["vEnemyDetectDistance", 40, true];
                _dmy = [_dog, _handler, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";
                sleep 1;
                _dog setVariable ["vCommand", 'stay', true];
            };};

if (VD_IEDAmountBC >= 1) then {for "_i" from 0 to VD_IEDAmountBC do {if (VD_IEDChanceBC >= (random 100)) then{[_VD_BC_Spawn] call VD_IEDSpawn;};};};


sleep VD_UptimeFix;
sleep (random VD_UptimeRnd);

waituntil {{_x distance _VD_BC_Fireplace > VD_DeletionSaveZone}foreach (allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F"};


{deleteVehicle _x}forEach units _bandits1;
{deleteVehicle _x}forEach units _bandits2;
{deleteVehicle _x}forEach units _bandits3;
{deleteVehicle _x}forEach units _bandits4;
{deleteVehicle _x}forEach _itemboxes;

deleteVehicle _VD_BC_Fireplace;
{deleteVehicle _x}foreach _objects;
sleep 5;
call _VD_BC_Check;
};
waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};
call _VD_BC_Check;
