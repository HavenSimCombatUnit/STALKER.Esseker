

if (!isServer) exitwith {};




//////////////////////
_PosCheck = {

waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};
_allplayer = (allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F";
_player = selectRandom _allplayer;

_SiteSpawn = [getPosATL _player, VD_SpawnMinDist, VD_SpawnMaxDist, 0, 0, 0.3, 0, VD_Land_Blacklist_Area] call BIS_fnc_findSafePos;
_isFlatEmpty = !(_SiteSpawn isFlatEmpty  [30, -1, 0.3, 30, -1, false] isEqualTo []);

  if (_isFlatEmpty)
    then {call _SiteSpawner}
    else {call _PosCheck};
};

_SiteSpawner ={

[_SiteSpawn, 0, call VD_Heli_compo] call BIS_fnc_ObjectsMapper;


_objects = _SiteSpawn nearobjects 40;
{_x allowDamage false;_x setVectorUp surfaceNormal position _x;} foreach _objects;

_Helicopter = selectrandom VD_Helicopters createVehicle _SiteSpawn;
_Helicopter setFuel selectrandom [1,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9];
_Helicopter setDamage selectrandom [0,0.1,0.2,0.3,0.4,0.5,0.6];
_Helicopter enableDynamicSimulation true;

waituntil {!alive _Helicopter && {_x distance _SiteSpawn > VD_DeletionSaveZone}foreach (allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F"};
sleep 2;
{deleteVehicle _x}foreach _objects;
sleep 500;
call _PosCheck;
};
waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};
call _PosCheck;
