#include "..\..\script_macros.hpp"
/*
	File: fn_phoneManager.sqf
	Author: nflug
	
	# Author bitte nicht entfernen!
	# Veränderungen an dieser Datei sind erlaubt.
	# Diese Datei wurde unter Auftrag erstellt.
*/
private["_bool"];

_bool = _this select 0;

if(_bool) then {

	_player1 = _this select 1;
	_player2 = _this select 2;
	_channelID = (life_phone_channelList select 0);

	_channelID radioChannelAdd [_player1, _player2];

	life_phone_channelInUse pushBack _channelID;
	life_phone_channelList deleteAt 0;

	publicVariable "life_phone_channelList";
	publicVariable "life_phone_channelInUse";
	
	_player1 setVariable ["phone_channelId", _channelID, true];
	_player2 setVariable ["phone_channelId", _channelID, true];

	true remoteExec ["life_fnc_phoneChannel", _player1];
	true remoteExec ["life_fnc_phoneChannel", _player2];

} else {

	_player1 = _this select 1;
	_player2 = _this select 2;
	_channelID = _this select 3;

	_channelID radioChannelRemove [_player1, _player2];

	life_phone_channelInUse deleteAt (life_phone_channelInUse find _channelID);
	life_phone_channelList pushBack _channelID;

	publicVariable "life_phone_channelList";
	publicVariable "life_phone_channelInUse";

	false remoteExec ["life_fnc_phoneChannel", _player1];
	false remoteExec ["life_fnc_phoneChannel", _player2];

};