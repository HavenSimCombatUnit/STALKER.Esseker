_unit = _this select 0;

_unit spawn 

{

    _unit = _this;

    sleep 2;

   _unit call rvg_fnc_equip; 

  _unit addEventHandler ["Fired", {_this spawn RVG_fnc_Fired}];

};  