//////////////////////////////////////////////////////////
// JBOY_AddActionControlDog.sqf
// Created by: johnnyboy
// nul = [player] execvm "JBOY_Dog\JBOY_AddActionControlDog.sqf";
//////////////////////////////////////////////////////////

params["_handler"];
// Add action to handler so he can take control of a dog.
if (_handler getVariable ["vTakeControlOfDogActionID", -1] == -1) then 
{
    _ControlAction = _handler addAction ["Take control of Dog", 
    {   _handler   =_this select 3 select 0;
        _id        =_this select 2;
             // assign actions to player taking control
            //_obj = cursorObject;   
            _obj = objNull;
            _nearDogs = nearestObjects [ _handler,["Dog_Base_F"],4];  //hard to cursor target small animals directly...this makes it easier
       _y = 0;
 // systemchat format ["_nearDogs=%1, %2, %3",_nearDogs, typeOf (_nearDogs select 0), (_nearDogs select 0) isKindOf "Dog_Base_F"];
       _objFound = false;
        while {(_y < count _nearDogs) and not _objFound} do
        {
//systemchat format ["near dude=%1, dirto _x=%2", _handler, (abs(getdir _handler - ([_handler, ( _nearDogs select _y)] call BIS_fnc_dirTo)))];
            _nearDog = _nearDogs select _y;
            _prevHandler = _nearDog getVariable "vHandler";
   //systemchat format ["_nearDog=%1, _prevHandler=%2, %3",_nearDog, _prevHandler, _nearDog isKindOf "Dog_Base_F"];
            if (_prevHandler == objNull or !alive _prevHandler) then  
            {
                _objFound = True;
                _obj = _nearDog;
            };
            _y = _y +1;
        };
  // systemchat format ["_obj=%1, %2, %3",_obj, typeOf _obj , _obj isKindOf "Dog_Base_F"];
          
            if (!isnull _obj) then  
            {
                 if (_obj isKindOf "Dog_Base_F" and alive _obj) then 
                 {
                     _dog = _obj;
                     _language = [_handler,false] call JBOY_getSpeakerLanguage;     // need to remember this!  add variable to handler for this.
                     _dog setVariable ["vHandlerLanguageAbbrev", _language, true];  // language commands will be spoken in.
                      _dog setVariable ["vHandler", _handler, true];  // assign dog handler
                     _handler setVariable ["vDogAssigned", _dog,true];
                     // Now that I'm using soolie's menu dialog, I don't call this action menu dialog
                     //_nul = [_dog, _handler] execVM "JBOY_Dog\JBOY_dog_assign_actions.sqf";
                     //_dog setVariable ["vCommand", 'heel', true];
                     _dogMenu = [] spawn {_d=[player] call JBOY_fnc_DogDisplayEH;};  // Add dog menu to player
                     _dog setVariable ["vCommand", 'heel', true];
                     hint "Use 'T' key for Dog Menu";
                     _handler removeAction _id;
                     _otherHandlers = _dog getVariable "vOtherHandlers";
                     _otherHandlers deleteAt (_otherHandlers find _handler);
                     _dog setVariable ["vOtherHandlers",_otherHandlers,true];
                     {
                        _x removeAction (_x getVariable "vTakeControlOfDogActionID");
                        _x setVariable ["vTakeControlOfDogActionID",-1,true]; 
                     } foreach (_dog getVariable "vOtherHandlers");
                     
                 } else {
                   hint "Move close to dog to take control.";
                 };
            } else {
                hint "Move close to dog to take control.";
            };
    }, [_handler], 10, false, true, '', '',4, false];
    _handler setVariable ["vTakeControlOfDogActionID",_ControlAction,true];
};