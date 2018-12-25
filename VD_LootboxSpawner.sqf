
_VD_EDN_Lootbox1 = "Box_FIA_Support_F" createVehicle getPos player;
_VD_EDN_Lootbox1 setVehicleVarName "VD_EDN_Lootbox1"; VD_EDN_Lootbox1 = _VD_EDN_Lootbox1;
clearMagazineCargoGlobal _VD_EDN_Lootbox1;
clearWeaponCargoGlobal _VD_EDN_Lootbox1;
clearItemCargoGlobal _VD_EDN_Lootbox1;
clearBackpackCargoGlobal _VD_EDN_Lootbox1;
_VD_EDN_Lootbox1 allowDamage false;

[_VD_EDN_Lootbox1, "Drag","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call VD_BB_Movebox;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;
[_VD_EDN_Lootbox1, "Load In","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 3","_caller distance _target < 3",{},{},{call VD_BB_LoadIn;},{},[],1,0,false,false] call bis_fnc_holdActionAdd;

_VD_EDN_Lootbox1 addAction[ "Create Workbench", {

  params ["_target", "_caller", "_actionId", "_arguments"];

    _target removeAction _actionId;
    _pos = [getPosATL _target, 4,6,2,0,0.9,0] call BIS_fnc_findSafePos;

    _Workbench = "Land_Workbench_01_F" createVehicle _pos;
    _Workbench addAction[ "Building Menue", { params ["_target", "_caller", "_actionId", "_arguments"];
     removeAllActions _target;
     call VD_detectDel;
     call VD_Back;
     [_target] call VD_CraftingSUBMenue;
      [_target] call VD_BB_CraftWoodenBoard;
     }, [],1.5,  true,  true, "", "true",3, false, "", ""];




  }, [],1.5,  true,  true, "", "true",2, false, "", ""];
