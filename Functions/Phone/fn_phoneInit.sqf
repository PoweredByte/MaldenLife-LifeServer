#include "..\..\script_macros.hpp"
/*
	File: fn_phoneInit.sqf
	Author: nflug
	
	# Author bitte nicht entfernen!
	# Veränderungen an dieser Datei sind erlaubt.
	# Diese Datei wurde unter Auftrag erstellt.
*/
private["_maxChannel", "_extraChannel"];

//Channel creation
_maxChannel = getNumber(missionConfigFile >> "CfgPhone" >> "phone_maxChannel");
_extraChannel = getArray(missionConfigFile >> "CfgPhone" >> "phone_extraChannel");

life_phone_extraChannelList = [];

{
	_channelID = radioChannelCreate [
		(_x select 3), 
		format["%1", (_x select 0)], 
		format["%1: %2", (_x select 1), "%UNIT_NAME"], 
		[], 
		false
	];
	if (_channelID != 0) then {
		life_phone_extraChannelList pushBack _channelID;
	};
} forEach _extraChannel;

publicVariable "life_phone_extraChannelList";

_maxChannel = _maxChannel - (count _extraChannel);
life_phone_channelList = [];
life_phone_channelInUse = [];

for "_i" from 1 to _maxChannel do {
	_channelID = radioChannelCreate [
		getArray(missionConfigFile >> "CfgPhone" >> "phone_channelColor"), 
		format["Telefonleitung. %1", _i], 
		"%CHANNEL_LABEL: %UNIT_NAME", 
		[], 
		false
	];
	if (_channelID != 0) then {
		life_phone_channelList pushBack _channelID;
	};
};

publicVariable "life_phone_channelList";
publicVariable "life_phone_channelInUse";

addMissionEventHandler ["HandleDisconnect",{_this call TON_fnc_phoneDisconnect; false;}];