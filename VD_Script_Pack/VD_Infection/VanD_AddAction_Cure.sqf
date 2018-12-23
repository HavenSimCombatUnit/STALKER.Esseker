
player addAction
[
    "Inject Cure",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

_caller setVariable ["VanD_infected", false, false];

_amount = _caller getVariable ["VanD_CurePill", false];
_caller setVariable ["VanD_CurePill", _amount-1];
cutText ["That will make me feel better.", "PLAIN DOWN", 4];
_caller removeaction _actionId;
execVM "VD_Script_Pack\VD_Infection\VanD_AddAction_Cure.sqf";

_caller addEventHandler ["Dammaged",
{
	params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];
if (_shooter isKindOf "zombie" && {!(_unit getVariable ["VanD_infected", false])}) then
	{
		[_unit, _thisEventHandler] execVM "VD_Script_Pack\VD_Infection\VanD_Infection.sqf";
    		[_unit, _thisEventHandler] execVM "VD_Script_Pack\VD_Infection\VanD_Shaking.sqf";
	};
}];
    }, [], 1.5, false, true, "", "(player getVariable ['VanD_CurePill', false] >= 1 && player getVariable ['VanD_infected', false])",
    1, false, "", ""
];
