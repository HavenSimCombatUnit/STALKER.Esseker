params ["_unit", "_thisEventHandler"];

_unit setVariable ["VanD_infected", false, false];

_unit setVariable ["VanD_infected", true, false];


while {_unit getVariable ["VanD_infected", false]} do
{
_unit removeEventHandler ["Dammaged", _thisEventHandler];
_freq = 60;
sleep _freq;
	if (!alive _unit || !(_unit getVariable ["VanD_infected", false])) exitWith {};


	addCamShake [1, 5, 10];
  cutText [selectrandom ["I am sweating like a pig!","'Cough' 'Cough'","I dont feel good!", "I'm so cold...","It is so hot!","I feel feeverish..."], "PLAIN DOWN", 4];


	_dmg = (getdammage _unit) + 0.01;
	_unit setDamage _dmg;
	_unit say2D [selectrandom ["WoundedGuyA_01","WoundedGuyA_02","WoundedGuyA_03","WoundedGuyA_05","WoundedGuyA_06","WoundedGuyA_07","WoundedGuyA_08","WoundedGuyB_01","WoundedGuyB_02","WoundedGuyB_03","WoundedGuyB_04","WoundedGuyB_05","WoundedGuyB_06","WoundedGuyB_07"], 15, 1];
  _stam = getStamina _unit;
  _unit setstamina (_stam*0.30);
	_freq = _freq*0.95;
};
