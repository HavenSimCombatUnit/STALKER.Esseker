

if (!isServer) exitwith {};


_SiteSpawner ={

  waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};

  _PlanePosMrkr = selectRandom VD_PlaneMarkers;
  VD_PlaneMarkers = VD_PlaneMarkers - [_PlanePosMrkr];
sleep 1;
  _PlanePos = [getmarkerpos _PlanePosMrkr, 1, 20, 1, 0, 0.4, 0] call BIS_fnc_findSafePos;


_Plane = selectRandom VD_Planes createVehicle _PlanePos;

_Plane setFuel selectrandom [1,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9];
_Plane setDamage selectrandom [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7];
_Plane enableDynamicSimulation true;
sleep VD_UptimeFix;
sleep (random VD_UptimeRnd);

waituntil {!alive _Plane};
VD_PlaneMarkers = VD_PlaneMarkers + [_PlanePosMrkr];
sleep 500;
call _SiteSpawner;
};
waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};
call _SiteSpawner;
