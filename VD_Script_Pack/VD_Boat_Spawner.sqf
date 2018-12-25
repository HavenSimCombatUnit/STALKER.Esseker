

if (!isServer) exitwith {};

_PosCheck ={
  waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};
  _allplayer = (allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F";
  _player = selectRandom _allplayer;
  _BoatPos = [getpos _Player, 500, VD_SW_MaxDistance, 0, 0, 0.1, 0,VD_Coast_Blacklist_Area,[]] call BIS_fnc_findSafePos;
_overShore = !(_BoatPos isFlatEmpty  [-1, -1, -1, -1, 0, true] isEqualTo []);
_overWater = !(_BoatPos isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);

if (_overShore) then {call _SiteSpawner} else {call _PosCheck};

};
_SiteSpawner ={
_BoatPosf = [_BoatPos, 1, 50, 0, 2, 0, 0,VD_Coast_Blacklist_Area,[]] call BIS_fnc_findSafePos;
_Boat = selectRandom VD_Boats createVehicle _BoatPosf;

_boat setFuel selectrandom [1,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9];
_boat setDamage selectrandom [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7];
[_boat, "Push","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 7","_caller distance _target < 7",{},{},{call PushBoat;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
_boat enableDynamicSimulation true;
waituntil {!alive _Boat};

sleep 500;
call _PosCheck;
};
waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};
call _PosCheck;
