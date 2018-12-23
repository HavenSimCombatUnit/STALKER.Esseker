// _unit = _this select 0;

// _unit spawn 

// {

//     _unit = _this;

//     sleep 2;

//    _unit call rvg_fnc_equip; 

//   _unit addEventHandler ["Fired", {_this spawn RVG_fnc_Fired}];

// };  


if (VD_AllowRandomPlayerLoadoutRespawn) then {sleep 1; call VD_Player_Equipper};
player addEventHandler ["Fired", {_this spawn MEL_FNC_WE}]; // needed for max melee weapons mod (adds melee swing animation)

//________________what i use, apply if you like (from LSVamont)
/*
player setUnitTrait ["camouflageCoef",0.2];
player setUnitTrait ["audibleCoef", 0.2];
player setUnitTrait ['loadCoef',0.2]; // Your character's stamina and aim won't be affected by current equipment load as much. (we all know you need to carry as much as possible in Ravage)

player setCustomAimCoef 0.30; //Your aim won't move as much but will still be noticeable.
player setUnitRecoilCoefficient 0.30; //Your Recoil won't be as bad as before but still realistic considering you are a survivor who has spend his whole life shooting guns!
player setAnimSpeedCoef 1.20; // You character will run and generally move around 20% faster than the running zombies! They are dead and decaying so you should be faster!

//______________________________what i use for random respawns, place respawn module, call it rnd_respawn and set side to your side (e.g. bluefor), place it in the middle of the map
if(player distance rnd_respawn < 10) then {_VD_PL_Spawn = [getPosATL player, 50, 6000, 1, 0, 0.9, 0] call BIS_fnc_findSafePos;
player setpos _VD_PL_Spawn;};
