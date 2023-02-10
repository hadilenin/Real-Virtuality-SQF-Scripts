private["_markers","_maxEnemyUnits","_enemyClassName"];

_markers = _this select 0;
_maxEnemyUnits = _this select 1;
_enemyClassName = _this select 2;

hint format ["incoming enemy count per round: %1",_maxEnemyUnits];
{
	systemChat str _x;
} forEach _markers;
{
	systemChat str _x;
} forEach _enemyClassName;

_i = count _enemyClassName;
_j = count _markers;

_center = createCenter east;
_group  = createGroup _center;

while {alive player} do {
	_enemyCount = player countEnemy allUnits;
	while {!isNull _group && _enemyCount < _maxEnemyUnits} do {
		_enemyClassName select floor random _i createUnit [getMarkerPos (_markers select floor random _j),_group];
		_enemyCount = _enemyCount + 1;
		sleep 0.1;
	};
	_wp = _group addWaypoint [getPos player,20];
	systemChat "new wave spawned!!";
	sleep 200;

	{
		deleteVehicle _x;
	} forEach allDead;
	
};
