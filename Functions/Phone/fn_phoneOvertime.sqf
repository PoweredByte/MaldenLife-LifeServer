#include "..\..\script_macros.hpp"
/*
	File: fn_phoneOvertime.sqf
	Author: nflug
	
	# Author bitte nicht entfernen!
	# Veränderungen an dieser Datei sind erlaubt.
	# Diese Datei wurde unter Auftrag erstellt.
*/
private["_playerUID", "_overtime", "_overtimeDivisor", "_sec", "_time"];

_playerUID = _this select 0;
_overtime = _this select 1;

missionNamespace setVariable [format["phone_overtime_%1", _playerUID], true, true];
missionNamespace setVariable [format["phone_overtimeSecs_%1", _playerUID], 0, true];

_overtimeDivisor = getNumber(missionConfigFile >> "CfgPhone" >> "phone_overTimeDivisor");
_overtime = _overtime / _overtimeDivisor;
	
//diag_log format["SLEEP: %1- %2", _playerUID, _overtime];

_time = _overtime;

for "_i" from 1 to _overtime do {
	_time = _time - 1;
	diag_log format["TIME: %1, %2", _time, missionNamespace getVariable [format["phone_overtimeSecs_%1", _playerUID], 0]];	
	missionNamespace setVariable [format["phone_overtimeSecs_%1", _playerUID], _time, true];
	sleep 1;
};

missionNamespace setVariable [format["phone_overtime_%1", _playerUID], nil, true];
missionNamespace setVariable [format["phone_overtimeSecs_%1", _playerUID], nil, true];