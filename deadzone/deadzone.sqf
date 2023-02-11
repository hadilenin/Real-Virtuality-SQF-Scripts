//in trigger, this script must be precompiled and then spawned. like _handler = [input here] spawn compile preprocessFile "script.sqf";
// otherwise all suspending commands like sleep,waitUntil,... will be ignored (because trigger executes in non-scheduled environment)

private["_markerList","_soundClassname","_trigger","_i","_soundSrcLst","_unit","_detectedUnits"];
_markerList = _this select 0;
_soundClassname = _this select 1;
_trigger = _this select 2;
_detectedUnits = [];

{
	systemChat _x;
} forEach _markerList;
systemChat _soundClassname;
systemChat str _trigger;
//----------------------------------------------creating sound source ------------------------------------------------------------------
_soundSrcLst = [];
{
	_unit = "Land_IED_v1_PMC" createVehicle getMarkerPos _x;
	hideObject _unit;
	_soundSrcLst = _soundSrcLst + [_unit];
} forEach _markerList;
_i = count _soundSrcLst;
//----------------------------------------------waiting a little bit to make sure all units are in -------------------------------------
sleep 5;
//----------------------------------------------detecting all units in trigger area ----------------------------------------------------

{
	if (side _x == playerSide && [_trigger,getPos _x] call BIS_fnc_inTrigger) then {
		_detectedUnits = _detectedUnits + [_x];
	}
} forEach allUnits;
//------------------------------- killing units in trigger area and playing sound (as if they were shot) :) ----------------------------
{
	(_soundSrcLst select floor random _i) say3D _soundClassname;
	_x setDamage 1;
	sleep 1;
} forEach _detectedUnits;



