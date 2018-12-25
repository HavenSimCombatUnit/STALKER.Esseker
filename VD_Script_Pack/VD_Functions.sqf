

PushBoat = {
  params ["_target", "_caller", "_actionId"];
  _target = _this select 0;
  _caller = _this select 1;

_target setPos (_caller modelToWorld [0,5,0]);
};

MoveBoat = {
  params ["_target", "_caller", "_actionId"];
  _target = _this select 0;
  _caller = _this select 1;

_target attachto [_caller];
removeallactions _target;
_caller playAction "GrabDrag";
_caller forceWalk true;
[_target, "Drop","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call DropBoat;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;


  DropBoat = {
    params ["_target", "_caller", "_actionId"];
    _target = _this select 0;
    _caller = _this select 1;
  detach _target;
  _caller forceWalk false;
  _caller switchmove "";
  removeallactions _target;
  [_target, "Drag","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call MoveBoat;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
  };

};

Movebox = {
  params ["_target", "_caller", "_actionId"];
  _target = _this select 0;
  _caller = _this select 1;

_target attachto [_caller];
removeallactions _target;
_caller playAction "GrabDrag";
_caller forceWalk true;
[_target, "Drop","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call Dropbox;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;

};

Dropbox = {
  params ["_target", "_caller", "_actionId"];
  _target = _this select 0;
  _caller = _this select 1;
detach _target;
_caller forceWalk false;
_caller switchmove "";
removeallactions _target;
[_target, "Drag","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call Movebox;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
[_target, "Load In","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call LoadIn;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
//[_target, "Destroy this Box","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call deleteMatbox},{},[],7,0,false,false] call bis_fnc_holdActionAdd;
};


LoadIn = {
  params ["_target", "_caller", "_actionId"];
  _target = _this select 0;
  _caller = _this select 1;

removeallactions _target;
_loadableCar = nearestObject [_caller, "Car"];
if (_target distance _loadableCar < 5) then {
_loadableCar setVectorUp surfaceNormal position _loadableCar;
_pos = getPos _loadableCar;
_target setpos _pos;
_target attachto [_loadableCar,[0,-2,0.7]];
[_target, "Loud Out","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 10","_caller distance _target < 10",{},{},{call unLoad;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
} else {hint "Get closer to your Vehicle!";
[_target, "Drag","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call Movebox;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
[_target, "Load In","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call LoadIn;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
};
};


unLoad = {
  params ["_target", "_caller","_actionId"];
  _target = _this select 0;
  _caller = _this select 1;
detach _target;
_target setpos ([getPosATL _target, 4, 4, 1, 0, 0.9, 0] call BIS_fnc_findSafePos);
removeallactions _target;

[_target, "Drag","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call Movebox;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
[_target, "Load In","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call LoadIn;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
};

deleteMatbox = {
params ["_target"];
_target = _this select 0;
removeallactions _target;
deletevehicle _target;
};

disabledmg = {
  params ["_target"];
    params ["_caller"];
  _target = _this select 0;
    _caller = _this select 1;
  removeallactions _target;
_houses = _caller nearObjects ["Static", 30];
{_x allowDamage false} foreach _houses;

[_target, "Drag","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call Movebox;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
[_target, "Load In","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call LoadIn;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;

};

VD_EDN_BPMover = {
  _allplayer = allplayers - entities [["allplayers"], ["HeadlessClient_F"], true, true];
  _player = selectRandom _allplayer;

_BPfile = selectRandom VD_EDN_BP_Array;
_houses = _player nearObjects ["House", 300];
_cnth = count _houses;
if (_cnth >= 1) then {
_objhouse = selectRandom _houses;
_allpositions = _objhouse buildingPos -1;
_cnt = count _allpositions;

if (_cnt > 0) then {
  _buildPos = selectRandom _allpositions;
  _BPfile setPos _buildPos;

sleep 1800;

waituntil {{_x distance _buildPos > 900}foreach allplayers - entities [["allplayers"], ["HeadlessClient_F"], true, true]};
_cntBP2 = count VD_EDN_BP_Array;
  if (_cntBP2 > 0) then {sleep 1800; call VD_EDN_BPMover;} else {};
}
else {call VD_EDN_BPMover;};
}
 else {call VD_EDN_BPMover};
};

VD_AI_Hunter_Spawner ={



_VD_AI_HuntFnc = {
    if (_VD_AI_bandit1 distance VD_AI_player > 200)

  then {
  {deleteVehicle _x}forEach units _VD_AI_bandits;}

   else {

     _VD_AI_Playerpos2 = getpos _caller;
        _VD_AI_wp2 = _VD_AI_bandits addWaypoint [_VD_AI_Playerpos2, 1];
            _VD_AI_wp2 setWaypointType "MOVE";
            _VD_AI_wp2 setWaypointSpeed "FULL";
            _VD_AI_wp2 setWaypointBehaviour "SAFE";
            _VD_AI_wp2 setWaypointFormation "COLUMN";
      waituntil {
        _VD_AI_bandit1 distance _VD_AI_Playerpos2 < 10 || {!alive _x}foreach units _VD_AI_Bandits;};
        deleteWaypoint [_VD_AI_bandits, 1];
        if ({!alive _x}foreach units _VD_AI_Bandits) then {} else  {call _VD_AI_HuntFnc;};



    };};

    params ["_target", "_caller","_actionId"];
    _target = _this select 0;
    _caller = _this select 1;

_VD_AI_AISpawn = [_caller, 250, 350, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
_VD_AI_Playerpos1 = getPos _caller;
_VD_AI_bandits = createGroup east;
_VD_AI_bandit1 = _VD_AI_bandits createUnit ["O_G_Survivor_F", _VD_AI_AISpawn, [], 1, "NONE"];
if (100 >= (random 100)) then {_VD_AI_VD_AI_bandit2 = _VD_AI_bandits createUnit ["O_G_Survivor_F", _VD_AI_AISpawn, [], 1, "NONE"];};
if (100 >= (random 100)) then {_VD_AI_bandit3 = _VD_AI_bandits createUnit ["O_G_Survivor_F", _VD_AI_AISpawn, [], 1, "NONE"];};
if (90 >= (random 100)) then {_VD_AI_bandit4 = _VD_AI_bandits createUnit ["O_G_Survivor_F", _VD_AI_AISpawn, [], 1, "NONE"];};
if (50 >= (random 100)) then {_VD_AI_bandit5 = _VD_AI_bandits createUnit ["O_G_Survivor_F", _VD_AI_AISpawn, [], 1, "NONE"];};
if (10 >= (random 100)) then {_VD_AI_bandit6 = _VD_AI_bandits createUnit ["O_G_Survivor_F", _VD_AI_AISpawn, [], 1, "NONE"];};

{[_x] call VD_equipper;} foreach units _VD_AI_bandits;


_VD_AI_wp1 = _VD_AI_bandits addWaypoint [_VD_AI_Playerpos1, 0];
    _VD_AI_wp1 setWaypointType "MOVE";
    _VD_AI_wp1 setWaypointSpeed "FULL";
    _VD_AI_wp1 setWaypointBehaviour "SAFE";
    _VD_AI_wp1 setWaypointFormation "COLUMN";

    waituntil {
      _VD_AI_bandit1 distance _caller < 10 || {!alive _x}foreach units _VD_AI_Bandits;};
    deleteWaypoint [_VD_AI_bandits, 0];

    if ({!alive _x}foreach units _VD_AI_Bandits) then {} else  {call _VD_AI_HuntFnc;};
};



  VD_HuntFnc = {

    params ["_target", "_caller","_actionId"];
    _target = _this select 0;
    _caller = _this select 1;
    if ({!alive _x}foreach units _bandits1) then {}
else{
      if (_bandit1 distance _caller > 200)
    then {
    {deleteVehicle _x}forEach units _bandits1;}
     else {
       _Playerpos2 = getpos _caller;
          _wp2 = _bandits1 addWaypoint [_Playerpos2, 1];
              _wp2 setWaypointType "MOVE";
              _wp2 setWaypointSpeed "FULL";
              _wp2 setWaypointBehaviour "SAFE";
              _wp2 setWaypointFormation "COLUMN";
        waituntil {
          _bandit1 distance _Playerpos2 < 10};
              deleteWaypoint [_bandits1, 1];
        call VD_HuntFnc;
      };};};


VD_AI_Spawner ={
                  _SpawnPos = [_this select 0, _this select 1, _this select 2, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
                  _Group = createGroup east;
                  _Unit1 = _Group createUnit ["O_G_Survivor_F", _SpawnPos, [], 1, "NONE"];
                  {[_x] call VD_equipper} foreach units _Group;
                  [_Group, _SpawnPos] call BIS_fnc_taskDefend;
                  _Group enableDynamicSimulation true;
                };




VD_AI_Spawn = {
  params ["_target","_caller"];
        _AISpawn = [getPosATL _caller, 100, 250, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
        _bandits1 = createGroup east;
        _bandit1 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];
        if (50 >= (random 100)) then {_bandit2 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
        if (50 >= (random 100)) then {_bandit3 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
        if (5 >= (random 100)) then {_bandit4 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
        if (5 >= (random 100)) then {_bandit5 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
        if (5 >= (random 100)) then {_bandit6 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};

        {[_x] call VD_equipper} foreach units _bandits1;



        _wp1 = _bandits1 addWaypoint [_target, 0];
            _wp1 setWaypointType "MOVE";
            _wp1 setWaypointSpeed "FULL";
            _wp1 setWaypointBehaviour "SAFE";
            _wp1 setWaypointFormation "COLUMN";

            waituntil {
              _bandit1 distance _target < 10};
            deleteWaypoint [_bandits1, 0];
          call VD_HuntFnc;

      };

VD_HO_Loot =

{
  params ["_target","_caller"];

  _target = _this select 0;
  _caller = _this select 1;

  _caller switchMove "AinvPknlMstpSnonWrflDr_medic5",1;
  sleep 9.090;

  _lootspot1 = "Groundweaponholder" createVehicle (getpos _target);
  removeallactions _target;

  _weapon = selectrandom VD_WeaponArrayRifles;
  _magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
  waituntil {(count _magazines) > 0};
  _mag = selectRandom _magazines;
  _lootspot1 addMagazineCargoGlobal [_mag, 2 +random 4];
 _lootspot1 addWeaponCargo [_weapon,1];

 _weapon1 = selectrandom VD_WeaponArrayPistols;
 _magazines1 = getArray (configFile >> "CfgWeapons" >> _weapon1 >> "magazines");
 waituntil {(count _magazines1) > 0};
 _mag1 = selectRandom _magazines1;
 _lootspot1 addMagazineCargoGlobal [_mag1, 2 +random 4];
_lootspot1 addWeaponCargo [_weapon1,1];

  _lootspot1 addItemCargoGlobal [selectrandom VD_itemArray1, 1];
  _lootspot1 addItemCargoGlobal [selectrandom VD_itemArray1, 1];
  _lootspot1 addItemCargoGlobal [selectrandom VD_itemArray1, 1];
 _lootspot1 addItemCargoGlobal [_weapon call BIS_fnc_compatibleItems, 1];
 _lootspot1 addItemCargoGlobal [_weapon call BIS_fnc_compatibleItems, 1];




};

VD_lootCrateT1 =
{

  clearMagazineCargoGlobal (_this select 0);
  clearWeaponCargoGlobal (_this select 0);
  clearItemCargoGlobal (_this select 0);
  clearBackpackCargoGlobal (_this select 0);
  _weapon = selectrandom VD_WeaponArrayRifles;
  _weapon1 = selectrandom VD_WeaponArrayRifles;
  (_this select 0) additemCargoGlobal [selectRandom VD_currencyArray, 50 +random 50];
  (_this select 0) additemCargoGlobal [selectRandom VD_itemArray1, 1 +random 1];
  (_this select 0) additemCargoGlobal [selectRandom VD_itemArray1, 1 +random 1];
  (_this select 0) additemCargoGlobal [selectRandom VD_EquipmentVests, 1 +random 1];
  (_this select 0) additemCargoGlobal [selectRandom VD_EquipmentUniforms, 1 +random 1];
  (_this select 0) additemCargoGlobal [selectRandom VD_EquipmentHeadgears, 1 +random 1];
  (_this select 0) addBackpackCargoGlobal [selectRandom VD_EquipmentBackpacks, 1 +random 1];
  (_this select 0) addMagazineCargoGlobal [selectRandom VD_explosivesArray, 1 +random 2];
  (_this select 0) addMagazineCargoGlobal [selectRandom VD_GrenadesArray, 1 +random 2];
  (_this select 0) additemCargoGlobal [selectRandom VD_itemArray1, 1 +random 1];
  (_this select 0) additemCargoGlobal [selectRandom VD_medicalArray, 1 +random 1];
  (_this select 0) addItemCargoGlobal [_weapon call BIS_fnc_compatibleItems, 1];
  (_this select 0) addItemCargoGlobal [_weapon1 call BIS_fnc_compatibleItems, 1];
    (_this select 0) addItemCargoGlobal [_weapon call BIS_fnc_compatibleItems, 1];
  (_this select 0) addItemCargoGlobal [_weapon1 call BIS_fnc_compatibleItems, 1];
  (_this select 0) addWeaponCargo [_weapon,1 +random 1];
  _magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
  waituntil {(count _magazines) > 0};
  _mag = selectRandom _magazines;
  (_this select 0) addMagazineCargoGlobal [_mag, 2 +random 4];
  (_this select 0) addWeaponCargo [_weapon1,1 +random 1];
  _magazines1 = getArray (configFile >> "CfgWeapons" >> _weapon1 >> "magazines");
    waituntil {(count _magazines1) > 0};
  _mag1 = selectRandom _magazines1;
  (_this select 0) addMagazineCargoGlobal [_mag1, 2 +random 4];

};
VD_lootCrateT3 =
{
clearMagazineCargoGlobal _x;
clearWeaponCargoGlobal _x;
clearItemCargoGlobal _x;
clearBackpackCargoGlobal _x;
  _weapon = selectrandom VD_WeaponArrayRifles;
  _x addWeaponCargo [_weapon,1 +random 1];
  _magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
  waituntil {(count _magazines) > 0};
  _mag = selectRandom _magazines;
    _x addMagazineCargoGlobal [_mag, 2 +random 4];
    _x addItemCargoGlobal [_weapon call BIS_fnc_compatibleItems, 1];
if (4 >= (random 10)) then {_x addweaponCargoGlobal [selectrandom VD_WeaponArrayRifles,1];};
if (4 >= (random 10)) then {_x additemCargoGlobal [selectrandom VD_itemArray1,1];};
if (4 >= (random 10)) then {_x additemCargoGlobal [selectrandom VD_itemArray1,1];};
if (4 >= (random 10)) then {_x additemCargoGlobal [selectrandom VD_medicalArray,1];};
if (4 >= (random 10)) then {_x addweaponCargoGlobal [selectrandom VD_WeaponArrayRifles,1];};
if (4 >= (random 10)) then {_x additemCargoGlobal [selectrandom VD_itemArray1,1];};
if (4 >= (random 10)) then {_x additemCargoGlobal [selectrandom VD_itemArray1,1];};
if (4 >= (random 10)) then {_x additemCargoGlobal [selectrandom VD_medicalArray,1];};
if (4 >= (random 10)) then {_x additemCargoGlobal [selectRandom VD_EquipmentVests, 1 +random 1];};
if (2 >= (random 10)) then {_x additemCargoGlobal [selectRandom VD_EquipmentUniforms, 1 +random 1];};
if (2 >= (random 10)) then {_x additemCargoGlobal [selectRandom VD_EquipmentHeadgears, 1 +random 1];};
if (2 >= (random 10)) then {_x addBackpackCargoGlobal [selectRandom VD_EquipmentBackpacks, 1 +random 1];};
if (2 >= (random 10)) then {_x addMagazineCargoGlobal [selectRandom VD_explosivesArray, 1 +random 2];};
if (2 >= (random 10)) then {_x addMagazineCargoGlobal [selectRandom VD_GrenadesArray, 1 +random 2];};
};

VD_Player_Equipper = {
  removeUniform player;
  player forceAddUniform selectRandom VD_EquipmentUniforms;
if(VD_PLMapChance>=random 100) then{player linkitem "itemMap"};
if(VD_PLRadioChance>=random 100) then{player linkitem "itemRadio"};
if(VD_PLBinocularChance>=random 100) then{player addweapon "binocular"};

if(floor (random 100) <= VD_PLVestChance && VD_PLVestChance >=1) then{
player addVest selectRandom VD_EquipmentVests;
};

if(floor (random 100) <= VD_PLBackpackChance && VD_PLBackpackChance >=1) then{
  player addBackpack selectRandom VD_EquipmentBackpacks};

if (floor (random 100) <= VD_PLHeadgearChance && VD_PLHeadgearChance >=1) then {player addHeadgear selectRandom VD_EquipmentHeadgears;};


if (floor (random 100) <= VD_PLRifleChance && VD_PLRifleChance >=1) then {
_rifle =  selectRandom VD_WeaponArrayRifles;
[player, _rifle, VD_PLRifleAmmo + VD_PLRifleAmmoAdd, 0] call BIS_fnc_addWeapon;

if (floor (random 100) <= VD_PLRifleMuzzleChance && VD_PLRifleMuzzleChance >=1) then {_MuzzleSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
if (count _MuzzleSlot >=1) then {
 player addPrimaryWeaponItem selectRandom _MuzzleSlot;};};


if (floor (random 100) <= VD_PLRifleOpticChance && VD_PLRifleOpticChance >=1) then {_OpticsSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "OpticsSlot" >> "compatibleItems");
if (count _OpticsSlot >=1) then {
 player addPrimaryWeaponItem selectRandom _OpticsSlot;};};


if (floor (random 100) <= VD_PLRiflePointerChance && VD_PLRiflePointerChance >=1) then {_PointerSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
if (count _PointerSlot >=1) then {
 player addPrimaryWeaponItem selectRandom _PointerSlot;};};



if (floor (random 100) <= VD_PLRifleUnderbarrelChance && VD_PLRifleUnderbarrelChance >=1) then {_UnderBarrelSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
if (count _UnderBarrelSlot >=1) then {
 player addPrimaryWeaponItem selectRandom _UnderBarrelSlot;};};
   };


//pistol
if (floor (random 100) <= VD_PLPistolChance && VD_PLPistolChance >=1) then {
   _pistol = selectRandom VD_WeaponArrayPistols;
  [player, _pistol, VD_PLPistolAmmo + VD_PLPistolAmmoAdd, 0] call BIS_fnc_addWeapon;


if (floor (random 100) <= VD_PLPistolMuzzleChance && VD_PLPistolMuzzleChance >=1) then {_PMuzzleSlot = getArray (configFile / "CfgWeapons" >> _pistol >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
if (count _PMuzzleSlot >=1) then {
 player addHandgunItem selectRandom _PMuzzleSlot};};


if (floor (random 100) <= VD_PLPistolOpticChance && VD_PLPistolOpticChance >=1) then {_POpticSlot = getArray (configFile / "CfgWeapons" >> _pistol >> "WeaponSlotsInfo" >> "OpticSlot" >> "compatibleItems");
if (count _POpticSlot >=1) then {
 player addHandgunItem selectRandom _PMuzzleSlot};};


if (floor (random 100) <= VD_PLPistolPointerChance && VD_PLPistolPointerChance >=1) then {_PPointerSlot = getArray (configFile / "CfgWeapons" >> _pistol >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
if (count _PPointerSlot >=1) then {
 player addHandgunItem selectRandom _PPointerSlot};};
};


 if (VD_PLItemChance >=1) then {if (floor (random 100) <= VD_PLItemChance) then{for "_i" from 1 to VD_PLItemsCount do {player addItem selectRandom VD_itemArray1;};};};


 if (count VD_PLCustomItems >=1) then {if (floor (random 100) <= VD_PLCustomItemChance) then{for "_i" from 1 to VD_PLCustomItemsCount do {player addItem selectRandom VD_PLCustomItems;};};};



 if (floor (random 100) <= VD_PLMoneyChance && VD_PLMoneyChance >=1) then {for "_i" from 1 to VD_PLMoneyAmount do {player addItem selectRandom VD_currencyArray;};};

 if (floor (random 100) <= VD_PLGrenadeChance && VD_PLGrenadeChance >=1) then {for "_i" from 1 to VD_PLGrenadeAmount do {player addItem selectRandom VD_GrenadesArray;};};

if (floor (random 100) <= VD_PLExplosiveChance && VD_PLExplosiveChance >=1) then {for "_i" from 1 to VD_PLExplosiveAmount do {player addItem selectRandom VD_ExplosivesArray;};};};


VD_Player_Equipper1 = {
  removeUniform player;
  player forceAddUniform selectRandom VD_EquipmentUniforms;

  if(9>=random 10) then{
  player addVest selectRandom VD_EquipmentVests;};

if (VD_Player_EquipperMapChance>= random 100) then{  player linkitem "itemMap";};
if (VD_Player_EquipperRadioChance>= random 100) then{  player linkitem "itemRadio";};
  if (VD_Player_EquipperBinocularChance>= random 100) then{player addweapon "binocular";};
  if(4>=random 10) then{player addBackpack selectRandom VD_EquipmentBackpacks;};

  if(7>=random 10) then{player addHeadgear selectRandom VD_EquipmentHeadgears;};


if (VD_Player_EquipperRifleChance>= random 100) then{
  _rifle = selectRandom VD_WeaponArrayRifles;
  [player, _rifle, 1 +(random 3), 0] call BIS_fnc_addWeapon;
  _MuzzleSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
  if (count _MuzzleSlot >= 1) then {_Muzzle = selectRandom _MuzzleSlot;
  if (floor (random 10) < 2) then {player addPrimaryWeaponItem _Muzzle;};
  };

  _CowsSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
  if (count _CowsSlot >= 1) then {_Optic = selectRandom _CowsSlot;
  if (floor (random 10) < 2) then {player addPrimaryWeaponItem _Optic;};
  };

  _PointerSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
  if (count _pointerslot >= 1) then {_Pointer = selectRandom _PointerSlot;
  if (floor (random 10) < 2) then {player addPrimaryWeaponItem _Pointer;};
  };

  _UnderBarrelSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
  if (count _UnderBarrelSlot >= 1) then {  _UnderBarrel = selectRandom _UnderBarrelSlot;
  if (floor (random 10) < 2) then {player addPrimaryWeaponItem _UnderBarrel;};
   };
};

if (VD_Player_EquipperPistolChance>= random 100) then{
_pistol = selectRandom VD_WeaponArrayPistols;
[player, _pistol, 2 +random 3, 0] call BIS_fnc_addWeapon;
  _Side_Weapon_MuzzleSlot = getArray (configFile / "CfgWeapons" >> _pistol >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
  if (count _Side_Weapon_MuzzleSlot >= 1) then { _Side_Weapon_Muzzle = selectRandom _Side_Weapon_MuzzleSlot;
  if (floor (random 10) < 2) then {player addHandgunItem _Side_Weapon_Muzzle;};
  };
  _Side_Weapon_CowsSlot = getArray (configFile / "CfgWeapons" >> _pistol >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
  if (count _Side_Weapon_CowsSlot >= 1) then {_Side_Weapon_Optic = selectRandom _Side_Weapon_CowsSlot;
  if (floor (random 10) < 2) then {player addHandgunItem _Side_Weapon_Optic;};
  };
  _Side_Weapon_PointerSlot = getArray (configFile / "CfgWeapons" >> _pistol >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
    if (count _Side_Weapon_PointerSlot >= 1) then {_Side_Weapon_Pointer = selectRandom _Side_Weapon_PointerSlot;
  if (floor (random 10) < 2) then {player addHandgunItem _Side_Weapon_Pointer;};
  };
  for "_i" from 1 to (random 20) do {player addItemToUniform selectRandom VD_currencyArray;};
  if(9>=random 10) then{  player additem selectRandom VD_medicalArray;};
  if(1>=random 10) then{  player additem selectRandom VD_medicalArray;};
  player addItem selectRandom VD_itemArray1;
  player addItem selectRandom VD_itemArray1;
  player addItem selectRandom VD_GrenadesArray;
};};


VD_CS_CargoLoot =

{
  params ["_target","_caller"];

  _target = _this select 0;
  _caller = _this select 1;

  _caller switchMove "AinvPknlMstpSnonWrflDr_medic5",1;
  sleep 9.090;
if (5 >= 10) then {hint "Empty...";} else {hint "Something dropped to the ground!";
_lootspot1 = "Box_IND_Ammo_F" createVehicle getpos _caller;
clearMagazineCargoGlobal _lootspot1;
clearWeaponCargoGlobal _lootspot1;
clearItemCargoGlobal _lootspot1;
clearBackpackCargoGlobal _lootspot1;
_lootspot1 allowDamage false;
  _weapon = selectrandom VD_WeaponArrayRifles;
    _weapon1 = selectrandom VD_WeaponArrayRifles;
  _magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
  waituntil {(count _magazines) > 0};
  _mag = selectRandom _magazines;
  _magazines1 = getArray (configFile >> "CfgWeapons" >> _weapon1 >> "magazines");
  waituntil {(count _magazines1) > 0};
  _mag1 = selectRandom _magazines1;
    if (10 >= 10) then { _lootspot1 addItemCargoGlobal [selectrandom VD_itemArray1, 1];};
if (10 >= 10) then { _lootspot1 addItemCargoGlobal [selectrandom VD_itemArray1, 1];};
if (10 >= 10) then {   _lootspot1 addItemCargoGlobal [selectrandom VD_currencyArray, (random 100)];};
  if (10 >= 10) then {
    _lootspot1 addWeaponCargoGlobal [_weapon, 1];
    _lootspot1 addItemCargoGlobal [_weapon call BIS_fnc_compatibleItems, 1];
  _lootspot1 addItemCargoGlobal [selectrandom VD_WeaponArrayRifles call BIS_fnc_compatibleItems, 1];
  _lootspot1 addMagazineCargoGlobal [_mag, 2 +random 4];};
  if (10 >= 10) then {   _lootspot1 addMagazineCargoGlobal [_mag1, 2 +random 4];};
  if (10 >= 10) then {  _lootspot1 addMagazineCargoGlobal [selectrandom VD_explosivesArray, (random 4)];};
  if (10 >= 10) then {  _lootspot1 addMagazineCargoGlobal [selectrandom VD_explosivesArray, (random 4)];};
  if (10 >= 10) then {  _lootspot1 addMagazineCargoGlobal [selectrandom VD_GrenadesArray, (random 4)];};
    if (10 >= 10) then {  _lootspot1 addMagazineCargoGlobal [selectrandom VD_GrenadesArray, (random 4)];};
};
};

VD_TC_Equipper = {
  removeUniform _x;
  _x forceAddUniform selectRandom VD_EquipmentUniforms;
  _x addVest selectRandom VD_EquipmentVests;

};

VD_AI_SpawnerScav = {

_VD_wpFnc = {
if (_unit distance _player > 1000)
  then {
  {deleteVehicle _x}forEach units _group;}
   else {
     _nextarea = [_unit, 50, 300, 1, 0, 0.3, 0] call BIS_fnc_findSafePos;
     _nearhouse = nearestBuilding _nextarea buildingPos -1;

if (count _nearhouse < 1) then {call _VD_wpFnc;} else {
     _nextpos = selectrandom _nearhouse;
          _wp = _group addWaypoint [_nextpos, 0,2];
            _wp setWaypointType "MOVE";
            _wp setWaypointSpeed "FULL";
            _wp setWaypointBehaviour "CARELESS";

         waituntil {
           _unit distance _nextpos < 20 || {!alive _x}foreach units _group || _unit distance _player > 1000};
           sleep 10;
           if (_unit distance _nextpos > 2) then {sleep 5};
         deleteWaypoint [_group, 2];

         if ({!alive _x}foreach units _group || _unit distance player > 1000) then {
           if (_unit distance _player > 300) then {{deleteVehicle _x}forEach units _group;};

           } else  {call _VD_wpFnc;};
    };};
  };

  _player = _this select 0;


  _PosList = selectbestplaces [position player,500,"houses",10,1];
  _PosSelect = _PosList select (floor random (count _PosList));
  _Pos =  _PosSelect select 0;
  _spawnposgroup = [_Pos, 1, 5, 1, 0, 0.9, 0] call BIS_fnc_findSafePos;
    _group = creategroup east;
    _unit = _group createUnit ["O_G_Soldier_lite_F", _spawnposgroup, [], 3, "FORM"];
    {[_x] call VD_equipper}foreach units _group;
call _VD_wpFnc;
};



VD_AI_Spawner ={
// call with: [CenterForposFinder,minDistance,MaxDistance] call VD_AI_Spawner;
                  _SpawnPos = [_this select 0, _this select 1, _this select 2, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
                  _Group = createGroup east;
                  _Unit1 = _Group createUnit ["O_G_Survivor_F", _SpawnPos, [], 1, "NONE"];
                  {[_x] call VD_equipper} foreach units _Group;
                  _Group enableDynamicSimulation true;
                [_Group, _SpawnPos] call BIS_fnc_taskDefend;
                };

VD_AI_DoghandlerPatr ={
// call with: [CenterForposFinder,minDistance,MaxDistance] call VD_AI_DoghandlerPatr;
                  _SpawnPos = [_this select 0, _this select 1, _this select 2, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
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
                            _dog = [_handler, "Fin_blackwhite_F", (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create;
                            _dog setVariable ["vEnemyDetectDistance", 40, true];
                            _dmy = [_dog, _handler, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";
                            sleep 1;
                            _dog setVariable ["vCommand", 'heel', true];
                        };
                };

VD_AI_DoghandlerNoMove ={
// call with: [CenterForposFinder,minDistance,MaxDistance] call VD_AI_DoghandlerNoMove;
                  _SpawnPos = [_this select 0, _this select 1, _this select 2, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
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
                            _dog = [_handler, "Fin_blackwhite_F", (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create;
                            _dog setVariable ["vEnemyDetectDistance", 40, true];
                            _dmy = [_dog, _handler, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";
                            sleep 1;
                            _dog setVariable ["vCommand", 'stay', true];
                        };
                };



  VD_AI_SpawnerGroupTaskDef = {
// call with: [CenterForposFinder,minDistance,MaxDistance] call VD_AI_SpawnerGroupTaskDef;
        _AISpawn = [_this select 0, _this select 1, _this select 2, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
          _bandits1 = createGroup east;
          _bandit1 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];
          if (100 >= (random 100)) then {_bandit2 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
          if (100 >= (random 100)) then {_bandit3 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
          if (50 >= (random 100)) then {_bandit4 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
          if (50 >= (random 100)) then {_bandit5 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
          if (50 >= (random 100)) then {_bandit6 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};

          [_bandits1, _AISpawn] call BIS_fnc_taskDefend;
          {[_x] call VD_equipper} foreach units _bandits1;

          _Group = createGroup east;
          _Unit1 = _Group createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];
          {[_x] call VD_equipper} foreach units _Group;
          [_Unit1,selectrandom ["STAND","STAND_IA","SIT_LOW","KNEEL","LEAN","WATCH","WATCH1","WATCH2"]] call BIS_fnc_ambientAnimCombat;
          _Group enableDynamicSimulation true;
          _dmy= [_Unit1] spawn
                {
                    params["_handler"];
                    [_handler, speaker _handler] remoteExecCall ["setSpeaker", 0];
                    sleep 1;
                    _dog = [_handler, "Fin_blackwhite_F", (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create;
                    _dog setVariable ["vEnemyDetectDistance", 40, true];
                    _dmy = [_dog, _handler, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";
                    sleep 1;
                    _dog setVariable ["vCommand", 'stay', true];
                };

        };

VD_AI_SpawnerGroupTaskPatr= {
// call with: [CenterForposFinder,minDistance,MaxDistance,DistBetwWaypoints] call VD_AI_SpawnerGroupTaskPatr;
      _AISpawn = [_this select 0, _this select 1, _this select 2, 0.9, 0, 0.9, 0] call BIS_fnc_findSafePos;
        _bandits1 = createGroup east;
        _bandit1 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];
        if (50 >= (random 100)) then {_bandit2 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
        if (50 >= (random 100)) then {_bandit3 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
        if (5 >= (random 100)) then {_bandit4 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
        if (5 >= (random 100)) then {_bandit5 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};
        if (5 >= (random 100)) then {_bandit6 = _bandits1 createUnit ["O_G_Survivor_F", _AISpawn, [], 1, "NONE"];};


        {[_x] call VD_equipper} foreach units _bandits1;
        [_bandits1, _this select 0, _this select 3] call BIS_fnc_taskPatrol;
        _dmy= [_bandit1] spawn
              {
                  params["_handler"];
                  [_handler, speaker _handler] remoteExecCall ["setSpeaker", 0];
                  sleep 1;
                  _dog = [_handler, "Fin_blackwhite_F", (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create;
                  _dog setVariable ["vEnemyDetectDistance", 40, true];
                  _dmy = [_dog, _handler, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";
                  sleep 1;
                  _dog setVariable ["vCommand", 'heel', true];
              };
      };



      VD_Equipper = {
        removeUniform _x;
        _x forceAddUniform selectRandom VD_EquipmentUniforms;
      if(VD_AIMapChance>=random 100) then{_x linkitem "itemMap"};
      if(VD_AIRadioChance>=random 100) then{_x linkitem "itemRadio"};
      if(VD_AIBinocularChance>=random 100) then{_x addweapon "binocular"};

      if(floor (random 100) <= VD_AIVestChance && VD_AIVestChance >=1) then{
      _x addVest selectRandom VD_EquipmentVests;
      };

      if(floor (random 100) <= VD_AIBackpackChance && VD_AIBackpackChance >=1) then{
        _x addBackpack selectRandom VD_EquipmentBackpacks};

      if (floor (random 100) <= VD_AIHeadgearChance && VD_AIHeadgearChance >=1) then {_x addHeadgear selectRandom VD_EquipmentHeadgears;};


      if (floor (random 100) <= VD_AIRifleChance && VD_AIRifleChance >=1) then {
      _rifle =  selectRandom VD_WeaponArrayRifles;
      [_x, _rifle, VD_AIRifleAmmo + VD_AIRifleAmmoAdd, 0] call BIS_fnc_addWeapon;

      if (floor (random 100) <= VD_AIRifleMuzzleChance && VD_AIRifleMuzzleChance >=1) then {_MuzzleSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
      if (count _MuzzleSlot >=1) then {
       _x addPrimaryWeaponItem selectRandom _MuzzleSlot;};};


      if (floor (random 100) <= VD_AIRifleOpticChance && VD_AIRifleOpticChance >=1) then {_OpticsSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "OpticsSlot" >> "compatibleItems");
      if (count _OpticsSlot >=1) then {
       _x addPrimaryWeaponItem selectRandom _OpticsSlot;};};


      if (floor (random 100) <= VD_AIRiflePointerChance && VD_AIRiflePointerChance >=1) then {_PointerSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
      if (count _PointerSlot >=1) then {
       _x addPrimaryWeaponItem selectRandom _PointerSlot;};};



      if (floor (random 100) <= VD_AIRifleUnderbarrelChance && VD_AIRifleUnderbarrelChance >=1) then {_UnderBarrelSlot = getArray (configFile / "CfgWeapons" >> _rifle >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
      if (count _UnderBarrelSlot >=1) then {
       _x addPrimaryWeaponItem selectRandom _UnderBarrelSlot;};};
         };


      //pistol
      if (floor (random 100) <= VD_AIPistolChance && VD_AIPistolChance >=1) then {
         _pistol = selectRandom VD_WeaponArrayPistolsAI;
        [_x, _pistol, VD_AIPistolAmmo + VD_AIPistolAmmoAdd, 0] call BIS_fnc_addWeapon;


      if (floor (random 100) <= VD_AIPistolMuzzleChance && VD_AIPistolMuzzleChance >=1) then {_PMuzzleSlot = getArray (configFile / "CfgWeapons" >> _pistol >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
      if (count _PMuzzleSlot >=1) then {
       _x addHandgunItem selectRandom _PMuzzleSlot};};


      if (floor (random 100) <= VD_AIPistolOpticChance && VD_AIPistolOpticChance >=1) then {_POpticSlot = getArray (configFile / "CfgWeapons" >> _pistol >> "WeaponSlotsInfo" >> "OpticSlot" >> "compatibleItems");
      if (count _POpticSlot >=1) then {
       _x addHandgunItem selectRandom _PMuzzleSlot};};


      if (floor (random 100) <= VD_AIPistolPointerChance && VD_AIPistolPointerChance >=1) then {_PPointerSlot = getArray (configFile / "CfgWeapons" >> _pistol >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
      if (count _PPointerSlot >=1) then {
       _x addHandgunItem selectRandom _PPointerSlot};};
      };


       if (VD_AIItemChance >=1) then {if (floor (random 100) <= VD_AIItemChance) then{for "_i" from 1 to VD_AIItemsCount do {_x addItem selectRandom VD_itemArray1;};};};


       if (count VD_AICustomItems >=1) then {if (floor (random 100) <= VD_AICustomItemChance) then{for "_i" from 1 to VD_AICustomItemsCount do {_x addItem selectRandom VD_AICustomItems;};};};



       if (floor (random 100) <= VD_AIMoneyChance && VD_AIMoneyChance >=1) then {for "_i" from 1 to VD_AIMoneyAmount do {_x addItem selectRandom VD_currencyArray;};};

       if (floor (random 100) <= VD_AIGrenadeChance && VD_AIGrenadeChance >=1) then {for "_i" from 1 to VD_AIGrenadeAmount do {_x addItem selectRandom VD_GrenadesArray;};};

      if (floor (random 100) <= VD_AIExplosiveChance && VD_AIExplosiveChance >=1) then {for "_i" from 1 to VD_AIExplosiveAmount do {_x addItem selectRandom VD_ExplosivesArray;};};};


      iedDmg=true;							//Can the IED be killed with weapons?			[Default: false] TRUE = Yes | FALSE = Can only be disarmed
      Dbug=true;								//Show IED markers on map?						[Default: false]

      iedBlast=["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","HelicopterExploSmall"];
      iedList=["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"];
      iedAmmo=["IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo"];
      iedJunk=["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];
      if(!Dbug)then{{_x setMarkerAlpha 0;}forEach iedMkr;};


      iedAct={_iedObj=_this select 0;
      if(mineActive _iedObj)then{
      _iedBlast=selectRandom iedBlast;
      createVehicle[_iedBlast,(getPosATL _iedObj),[],0,""];
      createVehicle["Crater",(getPosATL _iedObj),[],0,""];
      {deleteVehicle _x}forEach nearestObjects[getPosATL _iedObj,iedJunk,4];
      deleteVehicle _iedObj;};};


///////////////////
execVM "VD_init.sqf";
