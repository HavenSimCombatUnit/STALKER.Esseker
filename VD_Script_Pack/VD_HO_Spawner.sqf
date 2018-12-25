/*
Vandeansons Dynamic Spawner Scripts
Heli Crashsite spawner
V1 - 21.09.2018
Settings: Check VD_Settings.sqf for settings!
*/

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

    	_iedR= [_VD_BC_Spawn, 1, 15, 3, 0, 0.4, 0] call BIS_fnc_findSafePos;

    	_ied=selectRandom iedList;
      _junk=selectRandom iedJunk;

    	_ied=createMine[_ied,_iedR,[],8];
    //  _ied setPosATL(_iedR select 2+1);_ied setDir(random 359);

    	if(!iedDmg)then{_ied allowDamage false;};

    	if(round(random 2)==1)then{_iedJunk=createVehicle[_junk,getPosATL _ied,[],0,""];_iedJunk setPosATL(getPosATL _iedJunk select 2+1);_iedJunk enableSimulationGlobal false;};
  	//_jnkR=selectRandom _iedRoad;
      	_jnkR= [_VD_BC_Spawn, 1, 10, 0, 0, 0.9, 0] call BIS_fnc_findSafePos;
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


  _PosFinder = {
                waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};
                _Player = (selectRandom [(allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F"]) select 0;
                _SpawnPos = [getPosATL _Player, VD_SpawnMinDist, VD_SpawnMaxDist, 1, 0, 0.9, 0, VD_Land_Blacklist_Area] call BIS_fnc_findSafePos;
                _NearHideOuts = _SpawnPos nearObjects ["Campfire_burning_F", VD_HO_DistanceCheck];
                _NearTrees = nearestTerrainObjects [_SpawnPos, ["Tree"], 50];
                  if (count _NearTrees >= 75 && count _NearHideOuts == 0)
                  then {call _HideOutSpawner}
                  else {call _PosFinder};
                };

_HideOutSpawner ={

                  //random faction for HO
                  _hscu_faction = west;
                  _hscu_xxx = (random 100);
                  if (50 >= _hscu_xxx) then {
                    _hscu_faction = east;
                  };

                  _Objects = [];
                  _CampFire = "Campfire_burning_F" createVehicle _SpawnPos;
                  _PosTent1 = [(getpos _CampFire select 0) + 5*sin(0), (getpos _CampFire select 1) + 5*cos(0), 0];
                  _PosTent2 = [(getpos _CampFire select 0) + 5*sin(90), (getpos _CampFire select 1) + 5*cos(90), 0];
                  _PosLootcrate = [(getpos _CampFire select 0) + 4*sin(0), (getpos _CampFire select 1) + 4*cos(0), 0];

                  _Tent1 = selectRandom VD_BCtentsSmall createVehicle _PosTent1;
                  _Tent2 = selectRandom VD_BCtentsSmall createVehicle _PosTent2;

                  _Objects append [_CampFire,_Tent1,_Tent2];

                  {_x allowDamage false;_x setDir (random 359);_x setVectorUp surfaceNormal position _x;} foreach _Objects;
                  _AIcount = (random 5);
                    if (15 >= (random 100)) then {for "_i" from 1 to _AIcount do {[_SpawnPos,1,3] call VD_AI_Spawner};};

                  _Tent1 addAction ["Loot tent", {call VD_HO_Loot; if (1 >= (random 10)) then {call VD_AI_Spawn};}, [], 1.5, true, true, "", "true", 3, false, "", ""];
                  _Tent2 addAction ["Loot tent", {call VD_HO_Loot; if (5 >= (random 10)) then {call VD_AI_Spawn};}, [], 1.5, true, true, "", "true", 3, false, "", ""];



                  if (VD_AllowJBDOG && VD_JBDOG_PatrolDogChanceHO >= (random 100)) then {
                  _SpawnPos = [_CampFire, 5, 15, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
                  _Group = createGroup _hscu_faction;
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
                            _dog = [_handler, selectRandom _dogtypes, (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create;
                            _dog setVariable ["vEnemyDetectDistance", 40, true];
                            _dmy = [_dog, _handler, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";
                            sleep 1;
                            _dog setVariable ["vCommand", 'heel', true];
                        };};

                  if (VD_AllowJBDOG && VD_JBDOG_GuardDogChanceHO >= (random 100)) then {
                        _SpawnPos = [_CampFire, 2, 5, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
                        _Group = createGroup _hscu_faction;
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


if (VD_IEDAmountHO >= 1) then {for "_i" from 0 to VD_IEDAmountHO do {if (VD_IEDChanceHO >= (random 100)) then {[_SpawnPos] call VD_IEDSpawn};};};




                  sleep VD_UptimeFix;
                  sleep (random VD_UptimeRnd);

                  waituntil {{_x distance _CampFire > VD_DeletionSaveZone}foreach (allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F"};

                  {deleteVehicle _x} foreach _Objects;

                  call _PosFinder;
                };

waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};
call _PosFinder;
