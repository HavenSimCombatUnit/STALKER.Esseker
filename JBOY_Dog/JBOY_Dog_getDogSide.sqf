// JBOY_Dog_getDogSide.sqf
// **********************************************
// Determine dog's side.  Used by JBOY_DogEnemyDetectionLoop to determine if near units are enemy or not.
// **********************************************
if (!isServer)  exitwith {};
params["_dog"];

_handler = objNull;
_handler = _dog getVariable ["vHandler",objNull];
_dogSide = civilian;
_pack = objNull;
if (_handler isEqualTo objNull or isNull _handler) then 
//if ( _handler == objNull) then 
{
    _pack = _dog getVariable ["vPack",objNull];
    if (isNull _pack) then 
    {
        _dogSide = civilian;
    } else
    {
        _dogSide = sideEnemy;
    };
} else 
{
    _dogSide = side _handler;
};
//hint format ["_dogSide=%1",_dogSide];
_dogSide
