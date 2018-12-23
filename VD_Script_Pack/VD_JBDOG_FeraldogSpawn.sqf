if (!isServer) exitwith {};


_VD_JBDOG_FeralDogPackSpawn = {
sleep 600;
sleep (random 500);

_allplayer = (allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F";
_player = selectRandom _allplayer;

_pos = [getPosATL _player, 500, 1000, 2, 0, 100, 0, VD_Land_Blacklist_Area] call BIS_fnc_findSafePos;
_followerDogTypes = ["Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Alsatian_Black_F","Alsatian_Sandblack_F"];
_pack = [_pos, (random 7), "Alsatian_Sand_F", _followerDogTypes, VD_JBDOG_AggroDist] call JBOY_dogPackCreate;

sleep 2000;


sleep (random 1000);

call _VD_JBDOG_FeralDogPackSpawn;
};


waitUntil {count ((allPlayers select {lifeState _x != "DEAD-RESPAWN"}) - entities "HeadlessClient_F") > 0};

call _VD_JBDOG_FeralDogPackSpawn;
