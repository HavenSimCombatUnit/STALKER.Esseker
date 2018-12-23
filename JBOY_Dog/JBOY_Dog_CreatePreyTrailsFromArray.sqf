//////////////////////////////////////////////////////////
// JBOY_Dog_CreatePreyTrailsFromArray.sqf 
// By: johnnyboy
// dmy = [dude1] execvm JBOY_Dog\JBOY_Dog_CreatePreyTrailsFromArray.sqf;
//
// Creates map markers showing scent trails.
//////////////////////////////////////////////////////////
if (!isServer)  exitwith {};
params ["_objToTrack"];

// populate this array recorded in arma.rpt log file by script JBOY_Dog_CreatePreyTrailArrayInLog
_trailArray = [
[[6075.5,7918.43,0.0194788],136.849,20.863,false,false,11],
[[6062.53,7906.12,0.00613689],226.031,35.901,false,false,1],
[[6052.66,7895.88,0.00327682],12.054,40.901,false,false,11],
[[6028.55,7883.06,0.00486755],261.496,55.956,false,false,1],
[[6018.85,7885.43,0.00521564],247.71,60.988,false,false,26],
[[6004.96,7877.47,0.0034976],41.6144,91.08,false,false,11],
[[5988.29,7880.02,0.0050168],46.3038,106.133,false,false,1],
[[5982.57,7870.72,0.00150061],57.7537,111.141,false,false,21],
[[5962.44,7864.66,0.00397015],93.258,136.228,false,false,1],
[[5951.88,7865.24,0.0103855],93.2167,141.258,false,false,1],
[[5943.55,7852.95,0.0304828],196.079,146.278,false,false,1],
[[5944.49,7827.72,0.00785208],167.025,151.32,false,false,1],
[[5940.58,7809.71,0.00726986],56.2981,156.352,false,false,6],
[[5948.42,7791.14,0.000884533],102.041,166.385,false,false,6]
];

_quarry = _objToTrack;
_prey =  "Land_CanOpener_F" createVehicle [0,0,1];
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
