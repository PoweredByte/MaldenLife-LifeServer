#include "\life_server\script_macros.hpp"
/*
    File: fn_phoneDisconnect.sqf
    Author: nflug
*/
private ["_unit", "_id", "_uid", "_name"];

_unit 	= _this select 0;
if (isNull _unit) exitWith {};

_id 	= _this select 1;
_uid 	= _this select 2;
_name 	= _this select 3;

_channelID = _unit getVariable "phone_channelId";
_channelID radioChannelRemove allPlayers;

if(!(_unit getVariable "phone_extraChannel")) then {
	life_phone_channelInUse deleteAt (life_phone_channelInUse find _channelID);
	life_phone_channelList pushBack _channelID;
	publicVariable "life_phone_channelList";
	publicVariable "life_phone_channelInUse";
};