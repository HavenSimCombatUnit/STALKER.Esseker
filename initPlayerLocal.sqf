
/*________________ GF Ravage Status Bar Scripts ________________*/

[] execVM "GF_Ravage_Status_Bar\Credits.sqf";	// Please keep the Credits or add them to your Diary
[] execVM "GF_Ravage_Status_Bar\GF_Ravage_Status_Bar.sqf";


//___________Infection script
player setVariable ["VanD_CurePill", 0];
execVM "VD_Script_Pack\VD_Infection\VanD_AddAction_Cure.sqf";

player addEventHandler ["Dammaged",
{
	params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];
if (_shooter isKindOf "zombie" && {!(_unit getVariable ["VanD_infected", false])}) then
	{
		[_unit, _thisEventHandler] execVM "VD_Script_Pack\VD_Infection\VanD_Infection.sqf";
		[_unit, _thisEventHandler] execVM "VD_Script_Pack\VD_Infection\VanD_Shaking.sqf";
	};
}];

player addEventHandler ["Respawn",
{
	params ["_unit"];
	player setVariable ["VanD_infected", false, false];
		execVM "\VD_Script_Pack\VD_Infection\VanD_AddAction_Cure.sqf";

	_unit addEventHandler ["Dammaged",
	{
		params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];
	if (_shooter isKindOf "zombie" && {!(_unit getVariable ["VanD_infected", false])}) then
		{
			[_unit, _thisEventHandler] execVM "VD_Script_Pack\VD_Infection\VanD_Infection.sqf";
					[_unit, _thisEventHandler] execVM "VD_Script_Pack\VD_Infection\VanD_Shaking.sqf";
		};
	}];

}];


if (VD_AllowRandomPlayerLoadout) then {call VD_Player_Equipper};

//___________spawns a lootbox at first spawn that can be carried around and loaded into vehicles
//execVM "VD_LootboxSpawner.sqf";

 //____________needed for max melee weapons mod (adds melee swing animation)
player addEventHandler ["Fired", {_this spawn MEL_FNC_WE}];

//___________No Rest! Spawn loop per player
while {alive player} do {
execVM "VD_Script_Pack\VD_NR_Spawner.sqf";
sleep 600;
sleep (random 600);
};
