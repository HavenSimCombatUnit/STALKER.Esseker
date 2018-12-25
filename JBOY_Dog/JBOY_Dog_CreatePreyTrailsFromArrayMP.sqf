//////////////////////////////////////////////////////////
// JBOY_Dog_CreatePreyTrailsFromArrayMP.sqf 
// By: johnnyboy
// dmy = [dude1] execvm JBOY_Dog\JBOY_Dog_CreatePreyTrailsFromArrayMP.sqf;
//
// Creates map markers showing scent trails.
//////////////////////////////////////////////////////////
if (!isServer)  exitwith {};
params ["_objToTrack"];

// populate this array recorded in arma.rpt log file by script JBOY_Dog_CreatePreyTrailArrayInLog
_trailArray = [
[[2150.33,7653.9,0.012352],0,2.831,false,false,6],
//[[2160.08,7642.6,0.0119829],143.065,12.88,false,false,11],
[[2167.09,7633.06,0.0127697],169.086,27.921,false,false,1],
//[[2172.93,7624.48,0.0118408],162.961,32.964,false,false,6],
[[2181.19,7610.32,0.0110111],183.508,43.004,false,false,6],
//[[2190.89,7595.03,0.00891781],189.639,53.049,false,false,1],
[[2193.39,7582.93,0.0131226],207.201,58.063,false,false,1],
//[[2198.98,7573.17,0.0204897],141.608,63.084,false,false,1],
[[2201.11,7557.15,0.00400448],156.319,68.11,false,false,6],
[[2206.99,7545.89,0.00626373],178.777,78.153,false,false,11],
//[[2215.09,7539.37,0.0279951],192.678,93.208,false,false,6],
[[2209.37,7542.33,0],191.468,103.258,false,true,6]
//[ mpFatherDead modelToWorld [0,2,0],191.468,109,false,true,6]
];

_quarry = _objToTrack;
_prey =  "Land_CanOpener_F" createVehicle [0,0,1];
mpFatherPreyObj = _prey; // hardcoded for this missing person mission
mpFatherPreyObj setVariable ["trailIsActive",true,true ];
_prey setVariable ["trailIsActive",true,true ];
//_prey enableSimulation false;
if (_objToTrack isKindOf "Man") then
{
    _prey setVariable ["quarry",leader _objToTrack];
    _quarry = leader _objToTrack;
    _prey setVariable ["side",side _objToTrack,true];
} else
{
    _prey setVariable ["quarry", _objToTrack];
    _prey setVariable ["side",civilian];
};
_prey setVariable ["trail",[] ];             // Array of scent markers dropped by prey
JBOY_preyArray pushBack _prey;
_prey setVariable ["lastScentPos",[0,0,0]];  // Last scent position created
// predefine and shuffle types of objects tracked prey will drop.
_droppedObjTypes =  [
//"Land_WaterBottle_01_cap_F","Land_Can_Dented_F","Land_Can_V3_F","Land_PencilBlue_F","Land_CanOpener_F",
//                     "Land_PencilRed_F","Land_Canteen_F","Land_BottlePlastic_V2_F","Land_Bandage_F","Land_Matches_F","Land_Compass_F",
                     "FxCartridge_slug","FxCartridge_762","FxCartridge_556", "FxCartridge_slug","FxCartridge_762","FxCartridge_556",
                     "FxCartridge_slug","FxCartridge_slug","FxCartridge_slug","FxCartridge_762","FxCartridge_556", "FxCartridge_slug","FxCartridge_762","FxCartridge_556",
//                     "Land_DuctTape_F","Land_Screwdriver_V1_F","Land_PenBlack_F","Land_PowderedMilk_F",
                     "Land_WaterBottle_01_compressed_F", "Land_WaterBottle_01_compressed_F",
                     "BloodSplatter_01_Small_New_F","MedicalGarbage_01_FirstAidKit_F","MedicalGarbage_01_Injector_F","MedicalGarbage_01_Packaging_F"] call BIS_fnc_arrayShuffle;

_p = 1;
_lastDropPos = [0,0,0];
_lastScentPos = [0,100,0];
_droppedObjIndex = 0;
_firstPos = true;
{
    _scentMarker = "Sign_Arrow_Large_Cyan_F" createVehicle [0,0,0];
    if (!JBOY_DEBUG) then {hideObjectGlobal _scentMarker;};  // if in debug mode, scentMarker is visible
    _scentMarker setVariable ["prey",_prey,true];
    _scentMarker enableSimulation false;
    _scentMarker setPos (_x select 0);
    _lastScentPos = (_x select 0);
    _scentMarker setDir (_x select 1);
    _scentMarker setVariable ["dropTime",       (_x select 2),true];
    _scentMarker setVariable ["trailEndWater",  (_x select 3),true];
    _scentMarker setVariable ["trailEndVehicle",(_x select 4),true];
    _durationAtPos = (_x select 5);
    _scentMarker setVariable ["durationAtPos",  (_x select 5),true];
    // Add scent marker to current trail
    _trail = _prey getVariable "trail";
    _trail pushBack _scentMarker;
    _prey setVariable ["trail",_trail,true];
    // ****************************************************************
    // Occasionally unit drops something
    // ****************************************************************
    if (_quarry isKindOf "Man" and _durationAtPos > 10 or (random 100) > 70 or _firstPos) then
    {

        if ((_lastDropPos distance _lastScentPos)>5 or _firstPos) then 
        {
            _firstPos = false;
            // Todo: Also drop hats, glasses, shemags, bandanas, face scarf, mags
            _droppedObjType = _droppedObjTypes select _droppedObjIndex;
            _droppedObj = _droppedObjType createVehicle _lastScentPos;
            if (_droppedObjIndex == (count _droppedObjTypes) - 1) then
            {
                _droppedObjIndex = 0;
            } else
            {
                _droppedObjIndex = _droppedObjIndex + 1;
            };
            _z = .2;
            if (_droppedObjType in ["FxCartridge_slug","FxCartridge_762","FxCartridge_556"]) then 
            {
                _droppedObj enableSimulation false;
                _z = .01;
            };
            _scentMarker setVariable ["droppedObject",_droppedObj,true];
//systemChat format ["dropped %1",(_scentMarker getVariable "droppedObject")];
            _droppedObj setpos [(_lastScentPos select 0)+.3, (_lastScentPos select 1)-.4, _z];
            _droppedObj setDir (random 360);
            if (!(_droppedObj in ["Land_DuctTape_F","Land_Can_Dented_F","Land_WaterPurificationTablets_F","Land_Bandage_F","Land_PowderedMilk_F"])) 
            then {_droppedObj setVectorUp [0,.7,0];};
            
            //_dmy = [_droppedObj] spawn {params["_droppedObj"];sleep 2; _droppedObj enablesimulation false;}; // disable sim so engine doesn't waste resources on it
            
            _lastDropPos = _lastScentPos;
            // cut the grass
            //_grassCutter = "Land_ClutterCutter_medium_F" createVehicle [(_currPos select 0)+1, (_currPos select 1)+1, 0];
       };
    };

} forEach _trailArray;
