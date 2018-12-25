//////////////////////////////////////////////////////////
// JBOY_AIFightsSnakes.sqf
// Created by: johnnyboy
// nul = [_targetObj,_snake] execvm "JBOY_snake\JBOY_AIFightsSnakes.sqf";
//
//////////////////////////////////////////////////////////
if (!isServer)  exitwith {};
params ["_dude","_snake"];
if (isPlayer _dude) exitwith {};
JBOY_STOP_FUCKING_SHOOTING_SNAKES = false;
//*************************************************
// Execute this on each Unit being attacked by_snake(s)
// First assign unit a "pack attack variable"
// If already has variable, then exit, so script only executing once per unit
//*************************************************
if !(isnil {_dude getvariable "vAttackedBySnakes"} )  exitwith {};
_dude setvariable ["vAttackedBySnakes",true,true];

// delayed reaction to snake attack
_reactionDistance = 5 + random 15;
waituntil {sleep .5; (_snake distance _dude) <= _reactionDistance or !alive _snake or !alive _dude };
//sleep 3+random 10;
// **********************************************
// Get dude ready to fight and reveal all near_snakes to him.
// **********************************************
_dude setUnitPos "UP"; 
_dude setBehaviour "COMBAT"; 

_assignedSnake = _snake;
_nearSnakes = [];
{
   if (alive _x) then
   {
        _nearSnakes pushBack _x;    // add snake to enemy snake list that dude knowsabout
   };
} foreach ((getpos _dude) nearObjects ["Snake_random_F", 200]);  // all near_snakes
_dude setvariable ["vNearSnakes",_nearSnakes,true];

// **********************************************
// Initially target assigned_snake
// **********************************************
_targetSnake = _assignedSnake;
sleep 1;
dostop _dude;
// **********************************************
// Create an invisible target for AI to shoot at (aka bullet magnet). For debugging, attach a sphere so we can see where target is.
// **********************************************
//_bulletMagnetUnitType = "B_Survivor_F";
_bulletMagnetUnitType = "B_TargetSoldier";
_bulletMagnet = createVehicle [_bulletMagnetUnitType, [0,0,0], [], 0, "CAN_COLLIDE"];
//_sphere = createVehicle ['Sign_Sphere25cm_F', [0,0,0], [], 0, "CAN_COLLIDE"];
//_sphere attachTo [_bulletMagnet,[0,0,0]];
//_bulletMagnet setunitPOS "DOWN";
_bulletMagnet lockTurret [[0],true]; // target object has a gunner position, so lock it so player isn't offered "get in gunner" option when near_snake
createVehicleCrew _bulletMagnet;
_bulletMagnet enableCollisionWith _snake;
_bulletMagnet attachTo [_snake,[0,-1,.3]];//[_snake,[0,-1,.3]];

_enemy = _bulletMagnet;
_enemy allowdamage false;

_cnt = 0;
_dude reveal _enemy;
_dude doTarget _enemy;
_dude dofire _enemy;
_dude setVariable ["vTargetSnake", _enemy, true];
 sleep 2;
 // *****************************************************************************
 // Spawn separate loop for targeting with different sleep timing. Less frequent 
 // target changing will hopefully reduce rifle raising/lowering retardation.
 // *****************************************************************************
_nul= [_dude, _nearSnakes, _bulletMagnet]
spawn
{
    params["_dude", "_nearSnakes","_bulletMagnet"];
  
    // **********************************************
    // Loop until all_snakes dead, or dude dead, or no_snakes left with an assigned target (i.e., attack called off)
    // **********************************************
    _prevTarget = objNull;
    while {alive _dude and ({alive _x and (_x distance _dude)<100} count _nearSnakes) > 0 and !JBOY_STOP_FUCKING_SHOOTING_SNAKES} do
    {
        //_nearSnakes deleteAt (_nearSnakes find _targetSnake);
        _deadSnakes = [];
        {
            if (!alive _x or !(simulationEnabled _x) ) then
            {
                _deadSnakes pushback _x;
            };
        } foreach _nearSnakes;
        _nearSnakes = _nearSnakes - _deadSnakes;
        _dude setvariable ["vNearSnakes",_nearSnakes,true];
//systemchat format ["count _nearSnakes=%1", count _nearSnakes];
        _targetSnake = [_dude, _nearSnakes] call JBOY_getClosestObjFromArray; // target closest_snake
        _enemy = _targetSnake;
        if (_prevTarget != _targetSnake) then  // assign new target.
        {
        _prevTarget = _targetSnake;
             _dude dowatch objnull;
            _enemy = _bulletMagnet;
            _dude setVariable ["vSnake", _targetSnake, true];
            _dude setVariable ["vTargetSnake", _enemy, true];
            //_enemy = (_targetSnake getVariable "vBulletMagnet");
            _bulletMagnet enableCollisionWith _targetSnake;
            _dude reveal _enemy;
            if ((_dude distance _targetSnake) > 15) then
            {
                detach _bulletMagnet;
                _bulletMagnet attachTo [_targetSnake,[0,-1.5,.5]]; //[_targetSnake,[0,-1.5,.5]];
                _dude reveal _bulletMagnet;
                // watch only when far
                //_dude doWatch  _targetSnake;
            _dude doTarget _enemy;
            _dude dofire _enemy;
            } else
            {
               detach _bulletMagnet;
               _bulletMagnet attachTo [_targetSnake,[0,-.3,.5]]; // set target back further so shooter adjusts shooting angle
               _dude reveal _bulletMagnet;
               // target and fire when close
            _dude doTarget _enemy;
            _dude dofire _enemy;
            };
            /*
            _dude doWatch  _targetSnake;
            _dude doTarget _enemy;
            _dude dofire _enemy;
            */
       };
        //_dude doWatch ([_dude, (_dude distance _targetSnake)-4, ([_dude, _targetSnake] call BIS_fnc_dirTo)] call BIS_fnc_relPos);
        sleep .5;
        if (_targetSnake distance _dude > 10) then {_dude moveTo getpos _targetSnake}; // chase snakes
    };
};  // End spawn.
// *****************************************************************************
// This loop for firing.  It sleeps less to fire more often.
// *****************************************************************************
while {alive _dude and ({alive _x and (_x distance _dude)<100} count (_dude getvariable "vNearSnakes")) > 0 and !JBOY_STOP_FUCKING_SHOOTING_SNAKES} do
{
    if (isPlayer _dude) exitwith {}; // In case player spawns into AI during group respawn.
    _cnt = _cnt + 1;
    if (count _nearSnakes >0) then
    {        
       //if (abs(getdir _dude - ([_dude, _enemy] call BIS_fnc_dirTo)) < 80 and ((_dude distance _enemy)) <100) then
       if (abs(getdir _dude - ([_dude, (_dude getVariable "vTargetSnake")] call BIS_fnc_dirTo)) < 45 and ((_dude distance (_dude getVariable "vTargetSnake"))) <100) then
       {
            for "_i" from 0 to (3+random 5) do
            {
                 JBOYDogGameLogic action ["useWeapon",_dude,_dude,0];
                 // _dude forceWeaponFire [ weaponState _dude select 1, weaponState _dude select 2];
                 sleep .01;
            };
        };
        if (random 100 > 85) then 
        {
//valdez sidechat "snake killed!";
            (_dude getVariable "vSnake") setDamage 1;
            _blood = createVehicle [selectRandom ["BloodSpray_01_New_F","BloodSplatter_01_Small_New_F"], [0,0,0], [], 0, "CAN_COLLIDE"];
            _blood setpos getposatl (_dude getVariable "vSnake");
            _blood setdir (random 360);
            (_dude getVariable "vSnake") enableSimulation false;
        }; // its hard to hit snakes, so we kill them here.
        sleep .5; // changed from .3 on 3/17/18
    };
}; // End While
_dude setvariable ["vAttackedBySnakes",false,true];

if (alive _dude) then
{
    _dude setUnitPos "AUTO"; 
    _dude doWatch objNull;
    _dude setBehaviour "SAFE";
} else 
{
    deleteVehicle _bulletMagnet;
};


// Building Cam Rotate script:  https://forums.bistudio.com/topic/165631-release-gom-cb-carpet-bombing-script/?p=2650449