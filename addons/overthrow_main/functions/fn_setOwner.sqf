params ["_obj","_owner"];
if(typename _obj isEqualTo "SCALAR") exitWith {
    owners setVariable [str _obj,_owner,true];
};
if(typename _obj isEqualTo "STRING") exitWith {
    owners setVariable [_obj,_owner,true];
};
if(typename _obj != "OBJECT") exitWith {};
if((getObjectType _obj) != 8 && (_obj isKindOf "Building")) exitWith {
    _id = [_obj] call OT_fnc_getBuildID;
    owners setVariable [_id,_owner,true];
};
_obj setVariable ["owner",_owner,true];
