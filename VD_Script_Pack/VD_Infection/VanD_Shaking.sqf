
params ["_unit", "_thisEventHandler"];
while {_unit getVariable ["VanD_infected", false]} do {
    if (!alive _unit || !(_unit  getVariable ["VanD_infected", false])) exitWith {};
sleep 15 + (random 30);
cutText [selectrandom ["I am sweating like a pig","'Cough' 'Cough'","I dont feel good", "I'm so cold...","It is so hot!","I feel feeverish"], "PLAIN DOWN", 4];
addCamShake [1, 5, 10];

};
