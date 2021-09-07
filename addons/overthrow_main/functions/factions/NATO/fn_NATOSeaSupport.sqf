params ["_frompos","_attackpos","_delay"];
sleep _delay;

private _dir = [_frompos,_attackpos] call BIS_fnc_dirTo;
_vehtype = OT_NATO_Vehicle_Boat call BIS_fnc_selectRandom;
_pos = _frompos findEmptyPosition [50,200,_vehtype];

_group = creategroup blufor;
_veh = createVehicle [_vehtype, _pos, [], 0,""];
_veh setVariable ["garrison","HQ",false];
_veh setDir (_dir);
_group addVehicle _veh;
createVehicleCrew _veh;
{
    [_x] joinSilent _group;
    _x setVariable ["garrison","HQ",false];
    _x setVariable ["NOAI",true,false];
}foreach(crew _veh);
_allunits = (units _group);
sleep 1;

_wp = _group addWaypoint [asltoatl _attackpos,20];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [600,600,600];

_wp = _group addWaypoint [_frompos,2000];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","[vehicle this] call OT_fnc_cleanup"];


